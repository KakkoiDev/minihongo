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

const updateTitle = () => {
  const h1 = document.querySelector('#content h1')
  document.title = `${h1?.textContent ?? 'Minihongo'} - Minihongo`
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

const playAudio = (btn) => {
  const src = `${rootPath}audio/${btn.dataset.audio}?v=9fdf449d`
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

// Initial active state
btnTheme.classList.toggle('active', document.documentElement.dataset.theme === 'dark')
btnFurigana.classList.toggle('active', !document.documentElement.classList.contains('no-furigana'))

// Language switcher
window.switchLang = (lang) => {
  localStorage.setItem('lang', lang)
  const pagePath = location.pathname.replace(/^\/(ja|mh)\//, '/')
  const dest = lang === 'en' ? pagePath : `/${lang}${pagePath}`
  document.body.classList.add('page-exit')
  setTimeout(() => { location.href = dest }, 150)
}

// -- Service worker -------------------------------------------------

navigator.serviceWorker?.register(`${basePath}sw.js`)

// -- Back to top --------------------------------------------------------

const btnTop = document.getElementById('btn-top')
addEventListener('scroll', () => {
  btnTop.classList.toggle('visible', scrollY > 400)
}, { passive: true })
btnTop.addEventListener('click', () => scrollTo({ top: 0, behavior: 'smooth' }))

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
  if (hadController) location.reload()
})

// Proactively check for SW updates when returning to the tab
document.addEventListener('visibilitychange', () => {
  if (document.visibilityState === 'visible') {
    navigator.serviceWorker?.ready.then((reg) => reg.update())
  }
})
