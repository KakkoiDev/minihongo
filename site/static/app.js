// Minihongo app logic

// Guard: if critical DOM is missing, force clean reload
if (!document.querySelector('base') || !document.getElementById('content')) {
  location.reload()
}

const base = document.querySelector('base').href
const basePath = new URL(base).pathname
const rootPath = basePath.replace(/^(\/(?:ja|mh)\/)/, '/')

// -- SPA navigation -----------------------------------------------------

const navLinks = document.querySelectorAll('nav:not(.lesson-nav):not(.toc) a')

// Server-rendered <title> is "<page> - <site name>" (localized, furigana-free).
// Capture the " - <site name>" suffix once; SPA navigation replaces only the page part.
const TITLE_SUFFIX = document.title.includes(' - ')
  ? document.title.slice(document.title.indexOf(' - '))
  : ` - ${document.title}`

const updateTitle = () => {
  const h1 = document.querySelector('#content h1')
  if (!h1) return
  // h1.textContent folds in <rt> furigana (言葉 + ことば -> 言葉ことば); strip rt first.
  const clone = h1.cloneNode(true)
  clone.querySelectorAll('rt').forEach(rt => rt.remove())
  document.title = `${clone.textContent.trim()}${TITLE_SUFFIX}`
}

const updateActiveNav = () => {
  const path = location.pathname
  for (const a of navLinks) {
    const href = new URL(a.href).pathname
    a.classList.toggle('active', path === href || path === href.replace(/\.html$/, '/'))
  }
}

// Prefetch cache: path -> Promise<Document>
const prefetchCache = new Map()

const fetchPage = (path) => {
  if (prefetchCache.has(path)) return prefetchCache.get(path)
  const promise = fetch(`${base}_f/${path}`)
    .then(r => { if (!r.ok) throw new Error(r.status); return r.text() })
    .then(html => new DOMParser().parseFromString(html, 'text/html'))
  prefetchCache.set(path, promise)
  return promise
}

const navigate = async (path) => {
  try {
    const doc = await fetchPage(path)
    prefetchCache.delete(path)
    const newContent = doc.querySelector('#content')
    if (!newContent) throw new Error('no #content')
    document.querySelector('#content').replaceWith(newContent)
    updateTitle()
    updateActiveNav()
    scrollTo(0, 0)
    bindContentLinks()
    // SPA swap: count.js only sees the initial load
    window.goatcounter?.count({ path: location.pathname })
    return true
  } catch {
    return false
  }
}

const hrefToPath = (href) => new URL(href, base).pathname.replace(basePath, '') || 'index.html'

const handleNavClick = async (e, href) => {
  e.preventDefault()
  const path = hrefToPath(href)
  history.pushState({ path }, '', `${base}${path}`)
  if (!await navigate(path)) location.reload()
}

const handleNavHover = (href) => {
  fetchPage(hrefToPath(href))
}

const bindLink = (a) => {
  a.onclick = (e) => handleNavClick(e, a.href)
  a.onmouseenter = () => handleNavHover(a.href)
}

// -- Audio playback -----------------------------------------------------

let currentAudio = null
let currentBtn = null
let slowAudio = localStorage.getItem('slow_audio') === '1'

const playAudio = (btn) => {
  const src = `${rootPath}audio/${btn.dataset.audio}?v={{CACHE_HASH}}`
  if (currentAudio) {
    currentAudio.pause()
    currentBtn?.classList.remove('playing')
    if (currentBtn === btn) {
      currentAudio = null
      currentBtn = null
      return
    }
  }
  const audio = new Audio(src)
  audio.playbackRate = slowAudio ? 0.75 : 1
  // One aggregate event per content type per session: is listening content used at all?
  const sub = btn.dataset.audio.split('/')[0]
  if (!sessionStorage.getItem(`audio-evt-${sub}`)) {
    sessionStorage.setItem(`audio-evt-${sub}`, '1')
    window.goatcounter?.count({ path: `audio-${sub}`, title: 'audio', event: true })
  }
  audio.addEventListener('ended', () => {
    btn.classList.remove('playing')
    currentAudio = null
    currentBtn = null
  })
  audio.play().catch(() => {
    btn.classList.remove('playing')
    currentAudio = null
    currentBtn = null
  })
  btn.classList.add('playing')
  currentAudio = audio
  currentBtn = btn
}

const updatePlayButtons = () => {
  for (const btn of document.querySelectorAll('#content .play-btn')) {
    btn.disabled = !navigator.onLine
  }
}

const bindPlayButtons = () => {
  for (const btn of document.querySelectorAll('#content .play-btn')) {
    btn.onclick = () => playAudio(btn)
    btn.disabled = !navigator.onLine
  }
}

// Listen-first mode: text hides behind a summary until revealed.
// The toggle lives inside the Reading page content (the only page with
// reading-text), so it must be rebound after every SPA swap.
const applyListenFirst = () => {
  const on = document.documentElement.classList.contains('listen-first')
  for (const d of document.querySelectorAll('#content details.reading-text')) {
    d.open = !on
  }
  const btn = document.getElementById('btn-listen')
  if (btn) {
    btn.classList.toggle('active', on)
    btn.onclick = () => {
      const next = document.documentElement.classList.toggle('listen-first')
      localStorage.setItem('listen_first', next ? '1' : '0')
      applyListenFirst()
    }
  }
}

// Practice page: restore can-do checkbox state from localStorage
const restoreCandos = () => {
  for (const cb of document.querySelectorAll('#content .cando-check')) {
    cb.checked = localStorage.getItem(`cando:${cb.dataset.id}`) === '1'
  }
}

// Bind lesson-nav and TOC links inside #content (re-run after each swap)
const bindContentLinks = () => {
  for (const a of document.querySelectorAll('.lesson-nav a')) {
    bindLink(a)
  }
  for (const a of document.querySelectorAll('#content a[href^="#"]')) {
    a.onclick = (e) => {
      e.preventDefault()
      document.getElementById(a.getAttribute('href').slice(1))?.scrollIntoView()
    }
  }
  bindPlayButtons()
  applyListenFirst()
  restoreCandos()
}

// Top nav links
for (const a of navLinks) {
  if (a.classList.contains('lang-link')) continue
  bindLink(a)
}

// Initial state
updateActiveNav()
bindContentLinks()

// Back/forward
addEventListener('popstate', async (e) => {
  if (!e.state?.path) return location.reload()
  if (!await navigate(e.state.path)) location.reload()
})

// -- Toggle buttons -------------------------------------------------

const btnTheme = document.getElementById('btn-theme')
const btnFurigana = document.getElementById('btn-furigana')
const btnSpeed = document.getElementById('btn-speed')

btnTheme.addEventListener('click', () => {
  const next = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark'
  document.documentElement.dataset.theme = next
  localStorage.setItem('theme', next)
  btnTheme.classList.toggle('active', next === 'dark')
  document.querySelector('meta[name="theme-color"]').content = next === 'dark' ? '#1A1A1A' : '#FFFFFF'
})

btnFurigana.addEventListener('click', () => {
  const on = document.documentElement.classList.toggle('no-furigana')
  localStorage.setItem('furigana', on ? '0' : '1')
  btnFurigana.classList.toggle('active', !on)
})

btnSpeed.addEventListener('click', () => {
  slowAudio = !slowAudio
  localStorage.setItem('slow_audio', slowAudio ? '1' : '0')
  btnSpeed.classList.toggle('active', slowAudio)
  if (currentAudio) currentAudio.playbackRate = slowAudio ? 0.75 : 1
})

// Initial active state
btnTheme.classList.toggle('active', document.documentElement.dataset.theme === 'dark')
btnFurigana.classList.toggle('active', !document.documentElement.classList.contains('no-furigana'))
btnSpeed.classList.toggle('active', slowAudio)

// Language switcher
window.switchLang = (lang) => {
  localStorage.setItem('lang', lang)
  const pagePath = location.pathname.replace(/^\/(ja|mh)\//, '/')
  const dest = lang === 'en' ? pagePath : `/${lang}${pagePath}`
  document.body.classList.add('page-exit')
  setTimeout(() => { location.href = dest }, 150)
}

// -- Practice page (delegated so it survives #content swaps) ---------

document.addEventListener('change', (e) => {
  const cb = e.target.closest?.('.cando-check')
  if (!cb) return
  const id = cb.dataset.id
  localStorage.setItem(`cando:${id}`, cb.checked ? '1' : '0')
  if (!cb.checked) return
  // Aggregate milestone signal, once per item ever, anonymous
  if (!localStorage.getItem(`cando-sent:${id}`)) {
    localStorage.setItem(`cando-sent:${id}`, '1')
    window.goatcounter?.count({ path: `cando-${id}`, title: 'cando', event: true })
  }
  const all = document.querySelectorAll('#content .cando-check')
  if (all.length && [...all].every(c => c.checked)
      && !localStorage.getItem('cando-complete-sent')) {
    localStorage.setItem('cando-complete-sent', '1')
    window.goatcounter?.count({ path: 'cando-complete', title: 'cando', event: true })
  }
})

document.addEventListener('click', (e) => {
  const opt = e.target.closest?.('.quiz-opt')
  if (opt) {
    const item = opt.closest('.quiz-item')
    if (item.classList.contains('answered')) return
    item.classList.add('answered')
    opt.classList.add(opt.dataset.correct === '1' ? 'right' : 'wrong')
    item.querySelector('.quiz-opt[data-correct="1"]').classList.add('right')
    const answer = item.querySelector('.quiz-answer')
    if (answer) answer.hidden = false
    const section = item.closest('.quiz-section')
    if (section && section.querySelectorAll('.quiz-item.answered').length
        === Number(section.dataset.total)) {
      window.goatcounter?.count({ path: `quiz-${section.dataset.cando}-done`, title: 'quiz', event: true })
    }
    return
  }
  const copy = e.target.closest?.('#copy-prompt')
  if (copy) {
    const text = document.getElementById('ai-prompt')?.textContent || ''
    navigator.clipboard?.writeText(text).then(() => {
      const label = copy.textContent
      copy.textContent = copy.dataset.copied
      setTimeout(() => { copy.textContent = label }, 2000)
    })
    window.goatcounter?.count({ path: 'ai-prompt-copy', title: 'ai', event: true })
  }
})

// -- Download tracking ----------------------------------------------

// Delegated so it survives #content swaps
document.addEventListener('click', (e) => {
  const a = e.target.closest?.('a')
  if (!a || !/\.(apkg|pdf|zip)$/.test(a.pathname)) return
  window.goatcounter?.count({ path: a.pathname, title: 'download', event: true })
})

// -- Service worker -------------------------------------------------

navigator.serviceWorker?.register(`${basePath}sw.js`)

// -- Back to top --------------------------------------------------------

const btnTop = document.getElementById('btn-top')
addEventListener('scroll', () => {
  btnTop.classList.toggle('visible', scrollY > 400)
}, { passive: true })
btnTop.addEventListener('click', () => scrollTo({ top: 0, behavior: 'smooth' }))

// -- Contact author dialog ----------------------------------------------

const btnContact = document.getElementById('btn-contact')
const contactDialog = document.getElementById('contact-dialog')
const contactForm = document.getElementById('contact-form')

btnContact?.addEventListener('click', () => contactDialog.showModal())

// Close on backdrop click (native <dialog> doesn't do this by default)
contactDialog?.addEventListener('click', (e) => {
  if (e.target === contactDialog) contactDialog.close()
})

contactDialog?.querySelector('.contact-cancel')?.addEventListener('click', () => {
  contactDialog.close()
})

contactForm?.addEventListener('submit', (e) => {
  e.preventDefault()
  const data = new FormData(contactForm)
  const type = data.get('type') || 'feedback'
  const channel = data.get('channel') || 'email'
  const title = (data.get('title') || '').toString().trim()
  const body = (data.get('body') || '').toString().trim()
  if (!title || !body) return
  window.goatcounter?.count({ path: `contact-${type}-${channel}`, title: 'contact', event: true })
  if (channel === 'github') {
    const url = 'https://github.com/KakkoiDev/minihongo/issues/new'
      + `?title=${encodeURIComponent(title)}`
      + `&body=${encodeURIComponent(body)}`
      + `&labels=${encodeURIComponent(type)}`
    window.open(url, '_blank', 'noopener')
  } else {
    const subject = `[${type}] ${title}`
    const mailto = 'mailto:contact@kakkoi.dev'
      + `?subject=${encodeURIComponent(subject)}`
      + `&body=${encodeURIComponent(body)}`
    window.location.href = mailto
  }
  contactForm.reset()
  contactDialog.close()
})

// -- Lifecycle recovery ---------------------------------------------

const safeReload = () => {
  try { location.reload() } catch { location.href = location.href }
}

const stopAudio = () => {
  try {
    if (currentAudio) {
      currentAudio.pause()
      currentBtn?.classList.remove('playing')
      currentAudio = null
      currentBtn = null
    }
  } catch {}
}

let hiddenAt = 0

document.addEventListener('visibilitychange', () => {
  try {
    if (document.visibilityState === 'hidden') {
      hiddenAt = Date.now()
      stopAudio()
    } else {
      prefetchCache.clear()
      if (hiddenAt && Date.now() - hiddenAt > 120_000) return safeReload()
      if (!document.querySelector('#content')?.children.length) safeReload()
    }
  } catch { safeReload() }
})

addEventListener('pageshow', (e) => { if (e.persisted) safeReload() })
addEventListener('freeze', stopAudio)
addEventListener('resume', () => {
  try {
    prefetchCache.clear()
    if (!document.querySelector('#content')?.children.length) safeReload()
  } catch { safeReload() }
})

// -- Toast banner system --------------------------------------------

const toastContainer = document.getElementById('toast-container')

const showToast = (msg, opts) => {
  const el = document.createElement('div')
  el.className = 'toast'

  const msgSpan = document.createElement('span')
  msgSpan.className = 'toast-msg'
  msgSpan.innerHTML = msg
  el.appendChild(msgSpan)

  if (opts?.actionLabel) {
    const btn = document.createElement('button')
    btn.className = 'toast-btn'
    btn.innerHTML = opts.actionLabel
    btn.addEventListener('click', (e) => { e.stopPropagation(); opts.action?.() })
    el.appendChild(btn)
  }

  const dismiss = () => {
    el.style.height = `${el.offsetHeight}px`
    el.classList.add('toast-out')
    el.addEventListener('animationend', () => {
      el.remove()
      opts?.onDismiss?.()
    }, { once: true })
  }
  el.addEventListener('click', dismiss)

  toastContainer.appendChild(el)

  if (opts?.duration) setTimeout(dismiss, opts.duration)

  return { el, dismiss }
}

// Network status toasts
let offlineToast = null
addEventListener('offline', () => {
  offlineToast = showToast(TOAST.offline)
  updatePlayButtons()
})
addEventListener('online', () => {
  offlineToast?.dismiss()
  offlineToast = null
  showToast(TOAST.online, { duration: 3000 })
  updatePlayButtons()
})
if (!navigator.onLine) offlineToast = showToast(TOAST.offline)

// -- PWA install prompt ---------------------------------------------

let deferredInstall = null
addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault()
  deferredInstall = e
  const dismissed = localStorage.getItem('install_dismissed')
  if (dismissed && Date.now() - Number(dismissed) < 7 * 86400000) return
  let installToast = null
  installToast = showToast(TOAST.install, {
    actionLabel: TOAST.installBtn,
    action() {
      deferredInstall?.prompt()
      deferredInstall = null
      installToast?.dismiss()
    },
    onDismiss() { localStorage.setItem('install_dismissed', Date.now()) }
  })
})

// Auto-reload when a new service worker takes over (fresh content available)
const hadController = !!navigator.serviceWorker?.controller
navigator.serviceWorker?.addEventListener('controllerchange', () => {
  if (hadController) {
    sessionStorage.setItem('sw_updated', '1')
    location.reload()
  }
})

// Show update toast on the fresh page after a SW-triggered reload
if (sessionStorage.getItem('sw_updated')) {
  sessionStorage.removeItem('sw_updated')
  showToast(TOAST.updated, { duration: 3000 })
}

// Proactively check for SW updates when returning to the tab
document.addEventListener('visibilitychange', () => {
  if (document.visibilityState === 'visible') {
    navigator.serviceWorker?.ready.then((reg) => reg.update())
  }
})
