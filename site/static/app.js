// Minihongo app logic

// Guard: if critical DOM is missing, force clean reload
if (!document.querySelector('base') || !document.getElementById('content')) {
  location.reload()
}

const base = document.querySelector('base').href
const basePath = new URL(base).pathname
const rootPath = basePath.replace(/^(\/(?:ko|ja|mh)\/)/, '/')

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
    const on = path === href || path === href.replace(/\.html$/, '/')
    a.classList.toggle('active', on)
    if (on) a.setAttribute('aria-current', 'page')
    else a.removeAttribute('aria-current')
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

// Grammar page: "core points only" filter, remembered across visits
const applyCoreOnly = () => {
  const btn = document.getElementById('btn-core-only')
  if (!btn) return
  let on = false
  try { on = localStorage.getItem('grammar_core_only') === '1' } catch {}
  const content = document.getElementById('content')
  const render = () => {
    content.classList.toggle('core-only', on)
    btn.classList.toggle('active', on)
    btn.setAttribute('aria-pressed', String(on))
  }
  btn.onclick = () => {
    on = !on
    try { localStorage.setItem('grammar_core_only', on ? '1' : '0') } catch {}
    render()
  }
  render()
}

// Practice page: restore can-do checkbox state from localStorage
const restoreCandos = () => {
  for (const cb of document.querySelectorAll('#content .cando-check')) {
    cb.checked = localStorage.getItem(`cando:${cb.dataset.id}`) === '1'
  }
}

// Kaiwa page: needs its own script since SPA-swapped content never runs
// inline <script> tags. Loaded once, then just re-invoked on every swap
// (initKaiwaPage no-ops if #kaiwa-app is already bound).
let kaiwaLoadPromise = null

const initKaiwa = () => {
  const root = document.getElementById('kaiwa-app')
  if (!root) return
  if (window.initKaiwaPage) {
    window.initKaiwaPage()
    return
  }

  // The Kaiwa UI depends on all provider adapters. Load them before kaiwa.js;
  // otherwise its initial render throws before the Start handler is bound.
  if (!kaiwaLoadPromise) {
    // Strings first: providers and kaiwa.js read window.kaiwaT at render time
    kaiwaLoadPromise = import(`${rootPath}static/kaiwa-i18n.js?v={{CACHE_HASH}}`).then(() => Promise.all([
      import(`${rootPath}static/kaiwa-provider-anthropic.js?v={{CACHE_HASH}}`),
      import(`${rootPath}static/kaiwa-provider-openai.js?v={{CACHE_HASH}}`),
      import(`${rootPath}static/kaiwa-provider-deepseek.js?v={{CACHE_HASH}}`),
      import(`${rootPath}static/key-share.js?v={{CACHE_HASH}}`),
    ]))
      .then(() => import(`${rootPath}static/kaiwa.js?v={{CACHE_HASH}}`))
      .catch(err => {
        console.error('Could not load Kaiwa scripts', err)
        kaiwaLoadPromise = null
        throw err
      })
  }

  kaiwaLoadPromise
    .then(() => window.initKaiwaPage())
    .catch(() => {
      root.innerHTML = '<p class="kaiwa-error">Could not load Kaiwa. Check your connection and reload.</p>'
    })
}

// Going Further: filter the large reference tables without leaving the page.
const bindGoingFurtherFilter = () => {
  const input = document.getElementById('gf-filter')
  if (!input) return

  const sections = [...document.querySelectorAll('.gf-search-section')]
  const status = document.querySelector('.gf-filter__status')
  const normalize = (value) => value.normalize('NFKC').toLocaleLowerCase().trim()

  const update = () => {
    const query = normalize(input.value)
    let matchingRows = 0

    for (const section of sections) {
      let visibleGroups = 0
      for (const group of section.querySelectorAll('.gf-search-group')) {
        const heading = normalize(group.querySelector('h3')?.textContent || '')
        const headingMatches = query && heading.includes(query)
        let groupMatches = 0

        for (const row of group.querySelectorAll('tbody tr')) {
          const matches = !query || headingMatches || normalize(row.textContent).includes(query)
          row.hidden = !matches
          if (matches) groupMatches += 1
        }

        group.hidden = !!query && groupMatches === 0
        if (!group.hidden) visibleGroups += 1
        if (query) matchingRows += groupMatches
      }
      section.hidden = !!query && visibleGroups === 0
    }

    if (!status) return
    status.textContent = !query
      ? ''
      : matchingRows
        ? `${matchingRows} ${input.dataset.countLabel}`
        : input.dataset.emptyLabel
    status.classList.toggle('is-empty', !!query && matchingRows === 0)
  }

  input.oninput = update
  input.onkeydown = (event) => {
    if (event.key === 'Escape' && input.value) {
      input.value = ''
      update()
    }
  }
  update()
}

// Bind lesson-nav and TOC links inside #content (re-run after each swap)
const bindContentLinks = () => {
  if (matchMedia('(min-width: 601px)').matches)
    document.querySelectorAll('#content .toc-box').forEach(d => { d.open = true })
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
  applyCoreOnly()
  restoreCandos()
  bindGoingFurtherFilter()
  initKaiwa()
}

// Top nav links
for (const a of navLinks) {
  // cross-locale: a link that deliberately leaves the current edition's base.
  // Left as a plain link - the SPA router derives paths relative to the base.
  if (a.classList.contains('lang-link') || a.classList.contains('cross-locale')) continue
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

// Reflect a toggle's state both visually (.active) and for assistive tech
const setPressed = (btn, on) => {
  btn.classList.toggle('active', on)
  btn.setAttribute(btn.getAttribute('role') === 'switch' ? 'aria-checked' : 'aria-pressed', String(on))
}

btnTheme.addEventListener('click', () => {
  const next = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark'
  document.documentElement.dataset.theme = next
  localStorage.setItem('theme', next)
  setPressed(btnTheme, next === 'dark')
  document.querySelector('meta[name="theme-color"]').content = next === 'dark' ? '#1A1A1A' : '#FFFFFF'
})

btnFurigana.addEventListener('click', () => {
  const on = document.documentElement.classList.toggle('no-furigana')
  localStorage.setItem('furigana', on ? '0' : '1')
  setPressed(btnFurigana, !on)
})

btnSpeed.addEventListener('click', () => {
  slowAudio = !slowAudio
  localStorage.setItem('slow_audio', slowAudio ? '1' : '0')
  setPressed(btnSpeed, slowAudio)
  if (currentAudio) currentAudio.playbackRate = slowAudio ? 0.75 : 1
})

// Initial active state
setPressed(btnTheme, document.documentElement.dataset.theme === 'dark')
setPressed(btnFurigana, !document.documentElement.classList.contains('no-furigana'))
setPressed(btnSpeed, slowAudio)

// Keep the current lesson tab visible in the horizontally scrolling mobile nav
document.querySelector('.nav-tabs a.active')?.scrollIntoView({ block: 'nearest', inline: 'center' })

// -- Dialogs (settings, share/invite, install) ---------------------------

const openDialog = (d) => { if (d && !d.open) d.showModal() }
for (const d of document.querySelectorAll('.app-dialog')) {
  d.addEventListener('click', (e) => {
    // Close on the close button, or on a click on the backdrop itself
    if (e.target.closest('[data-close]') || e.target === d) d.close()
  })
}

const settingsDialog = document.getElementById('settings-dialog')
// In-content buttons (e.g. on the homepage) open a dialog by id. Delegated so
// it survives SPA swaps; the share/install buttons reuse their header logic.
document.addEventListener('click', (e) => {
  const opener = e.target.closest?.('[data-open]')
  if (!opener) return
  const id = opener.dataset.open
  if (id === 'share-dialog') document.getElementById('btn-share')?.click()
  else if (id === 'install-dialog') openInstallDialog()
  else openDialog(document.getElementById(id))
})
document.getElementById('btn-settings')?.addEventListener('click', () => openDialog(settingsDialog))

// Invite links: /<edition>/<page>?lang=<edition>[&install=1]. The ?lang
// parameter makes the link's language win over the visitor's saved one
// (see the routing script in page-layout.html).
const shareDialog = document.getElementById('share-dialog')
const shareLang = document.getElementById('share-lang')
const shareInstall = document.getElementById('share-install')
const shareUrl = document.getElementById('share-url')
const shareCopy = document.getElementById('share-copy')
const shareNative = document.getElementById('share-native')
const SHARE_COPY_LABEL = shareCopy?.innerHTML

// Optional: an encrypted Kaiwa AI key in the link's #fragment (key-share.js).
// The link points at the Kaiwa page; the unlock code is shown here only, for
// the sender to pass on separately. One code per dialog session.
const shareKeySection = document.getElementById('share-key-section')
const shareKey = document.getElementById('share-key')
const shareKeyOptions = document.getElementById('share-key-options')
const shareKeyDays = document.getElementById('share-key-days')
const shareKeyGroq = document.getElementById('share-key-groq')
const shareKeyGroqRow = document.getElementById('share-key-groq-row')
const shareKeyCode = document.getElementById('share-key-code')
const shareKeyCopyCode = document.getElementById('share-key-copy-code')
const SHARE_CODE_COPY_LABEL = shareKeyCopyCode?.innerHTML
let sealed = null // { token, code, days, groq }
let keyShareLoad = null

const loadKeyShare = () => {
  keyShareLoad ??= import(`${rootPath}static/key-share.js?v={{CACHE_HASH}}`)
    .then(() => window.MinihongoKeyShare)
    .catch(() => { keyShareLoad = null; return null })
  return keyShareLoad
}

const savedGroqKey = () => { try { return localStorage.getItem('kaiwa_key_groq_speech') || '' } catch { return '' } }

// The saved chat key, plus the Groq speech key when the sender opts in
const savedKaiwaKey = (withGroq = false) => {
  try {
    const provider = localStorage.getItem('kaiwa_provider') || 'anthropic'
    const key = localStorage.getItem(`kaiwa_key_${provider}`)
    if (!key) return null
    const payload = { provider, key }
    const speechKey = savedGroqKey()
    if (withGroq && speechKey) payload.speechKey = speechKey
    return payload
  } catch { return null }
}

const buildInviteUrl = () => {
  const lang = shareLang.value
  const page = location.pathname.replace(/^\/(ko|ja|mh)\//, '/')
  const url = new URL(lang === 'en' ? page : `/${lang}${page}`, location.origin)
  url.searchParams.set('lang', lang)
  if (shareInstall.checked) url.searchParams.set('install', '1')
  if (shareKey?.checked && sealed) url.hash = `key=${sealed.token}`
  return url.href
}
const refreshShareUrl = async () => {
  shareCopy.innerHTML = SHARE_COPY_LABEL
  const wantsKey = shareKey?.checked
  shareKeyOptions.hidden = !wantsKey
  const days = Number(shareKeyDays?.value || 0)
  const groq = !!(shareKeyGroq?.checked && savedGroqKey())
  shareKeyGroqRow.hidden = !savedGroqKey()
  if (wantsKey && (!sealed || sealed.days !== days || sealed.groq !== groq)) {
    const payload = savedKaiwaKey(groq)
    const ks = await loadKeyShare()
    if (!payload || !ks) { shareKey.checked = false; shareKeyOptions.hidden = true }
    else {
      shareKeyCode.textContent = '…'
      shareUrl.value = ''
      const { token, code } = await ks.sealKey(payload, days)
      sealed = { token, code, days, groq }
    }
  }
  if (sealed) {
    shareKeyCode.textContent = sealed.code
    shareKeyCopyCode.innerHTML = SHARE_CODE_COPY_LABEL
  }
  shareUrl.value = buildInviteUrl()
}

if (shareDialog) {
  shareNative.hidden = !navigator.share
  shareLang.addEventListener('change', refreshShareUrl)
  shareInstall.addEventListener('change', refreshShareUrl)
  shareKey?.addEventListener('change', refreshShareUrl)
  shareKeyDays?.addEventListener('change', refreshShareUrl)
  shareKeyGroq?.addEventListener('change', refreshShareUrl)
  shareDialog.addEventListener('close', () => {
    // Forget the sealed key: reopening the dialog makes a fresh code
    sealed = null
    if (shareKey) shareKey.checked = false
  })
  document.getElementById('btn-share').addEventListener('click', async () => {
    // Offer the key option only when this browser has a Kaiwa key to share
    shareKeySection.hidden = true
    if (savedKaiwaKey()) loadKeyShare().then(ks => { shareKeySection.hidden = !ks?.isSupported() })
    openDialog(shareDialog)
    await refreshShareUrl()
    shareUrl.select()
  })
  shareUrl.addEventListener('focus', () => shareUrl.select())
  shareCopy.addEventListener('click', async () => {
    try {
      await navigator.clipboard.writeText(shareUrl.value)
    } catch {
      shareUrl.select()
      document.execCommand?.('copy')
    }
    shareCopy.textContent = shareCopy.dataset.copied
  })
  shareKeyCopyCode?.addEventListener('click', async () => {
    if (!sealed) return
    try { await navigator.clipboard.writeText(sealed.code) } catch {}
    shareKeyCopyCode.textContent = shareKeyCopyCode.dataset.copied
  })
  shareNative.addEventListener('click', async () => {
    try {
      // The link only - the unlock code must travel separately
      await navigator.share({ title: 'Minihongo', url: shareUrl.value })
      shareDialog.close()
    } catch { /* cancelled */ }
  })
}

// Language switcher
window.switchLang = (lang) => {
  localStorage.setItem('lang', lang)
  const pagePath = location.pathname.replace(/^\/(ko|ja|mh)\//, '/')
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

navigator.serviceWorker?.register(`/sw.js?v={{CACHE_HASH}}`, { scope: "/", updateViaCache: "none" })

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
const installDialog = document.getElementById('install-dialog')
const installYes = document.getElementById('install-yes')
const isStandaloneApp = () => matchMedia('(display-mode: standalone)').matches || navigator.standalone === true
const isIOS = () => /iphone|ipad|ipod/i.test(navigator.userAgent)
  || (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1)

// Pick what the install dialog can offer on this browser:
// 'prompt' = native install prompt available, 'ios' = Share > Add to Home Screen,
// 'other' = browser-menu instructions, 'done' = already running as the app.
const installMode = () => isStandaloneApp() ? 'done'
  : deferredInstall ? 'prompt'
  : isIOS() ? 'ios' : 'other'

const renderInstallDialog = () => {
  const mode = installMode()
  for (const p of installDialog.querySelectorAll('.install-steps')) p.hidden = p.dataset.for !== mode
  installYes.hidden = mode !== 'prompt'
}

const installSection = document.getElementById('install-section')
const keyUnlockSection = document.getElementById('key-unlock')

// One arrival dialog with two optional parts: unlocking a shared Kaiwa key
// (#key= in the link) and installing the app (?install=1).
const openInstallDialog = ({ install = true, key = false } = {}) => {
  if (!installDialog) return
  renderInstallDialog()
  installSection.hidden = !install
  keyUnlockSection.hidden = !key
  installDialog.setAttribute('aria-labelledby', key ? 'key-unlock-title' : 'install-title')
  openDialog(installDialog)
  if (key) document.getElementById('key-unlock-code')?.focus()
}

installYes?.addEventListener('click', async () => {
  if (!deferredInstall) return renderInstallDialog()
  deferredInstall.prompt()
  const choice = await deferredInstall.userChoice.catch(() => null)
  deferredInstall = null
  if (choice?.outcome === 'accepted') installDialog.close()
  else renderInstallDialog()
})

document.getElementById('btn-install-open')?.addEventListener('click', () => {
  settingsDialog?.close()
  openInstallDialog()
})

// Install links (?install=1): ask once on arrival, then drop the parameter so
// a reload or a shared copy of the address bar does not ask again. Chromium
// fires beforeinstallprompt shortly after load, so give it a moment.
// Links carrying a shared key (#key=…) open the same dialog with an unlock-code
// field, whatever page they land on.
const sharedKeyToken = (location.hash.match(/[#&]key=([A-Za-z0-9._-]+)/) || [])[1] || null
{
  const params = new URLSearchParams(location.search)
  const wantsInstall = params.has('install') && !isStandaloneApp()
  if (params.has('install')) {
    params.delete('install')
    const rest = params.toString()
    history.replaceState(history.state, '', location.pathname + (rest ? `?${rest}` : '') + location.hash)
  }
  if (sharedKeyToken || wantsInstall) {
    const open = () => openInstallDialog({ install: wantsInstall, key: !!sharedKeyToken })
    if (sharedKeyToken) loadKeyShare().then(open) // need the decryptor ready
    else setTimeout(open, deferredInstall ? 0 : 1200)
  }
}

// Unlock: decrypt on this device, then store the key where Kaiwa reads it,
// along with when it expires (Kaiwa deletes it after that).
{
  const form = document.getElementById('key-unlock-form')
  const input = document.getElementById('key-unlock-code')
  const button = document.getElementById('key-unlock-btn')
  const status = document.getElementById('key-unlock-status')
  const done = document.getElementById('key-unlock-done')
  const msg = (k) => document.getElementById('key-unlock-msgs')?.content
    .querySelector(`[data-k="${k}"]`)?.innerHTML || k

  form?.addEventListener('submit', async (e) => {
    e.preventDefault()
    const ks = await loadKeyShare()
    if (!ks?.isSupported()) { status.innerHTML = msg('unsupported'); return }
    button.disabled = true
    status.innerHTML = msg('working')
    try {
      const shared = await ks.openKey(sharedKeyToken, input.value)
      if (!['anthropic', 'openai', 'deepseek'].includes(shared.provider)) throw new ks.KeyShareError('malformed')
      localStorage.setItem('kaiwa_provider', shared.provider)
      localStorage.setItem(`kaiwa_key_${shared.provider}`, shared.key)
      localStorage.setItem('kaiwa_shared_key', shared.provider)
      if (shared.exp) localStorage.setItem('kaiwa_shared_exp', String(shared.exp))
      else localStorage.removeItem('kaiwa_shared_exp')
      if (shared.speechKey) {
        // Kept as the Auto-mode fallback; the receiver's voice choice is untouched
        localStorage.setItem('kaiwa_key_groq_speech', shared.speechKey)
        localStorage.setItem('kaiwa_shared_speech', '1')
      }
      // The encrypted key must not linger in history, bookmarks or a re-shared URL
      history.replaceState(history.state, '', location.pathname + location.search)
      form.hidden = true
      status.textContent = ''
      done.hidden = false
      // Already on a Kaiwa screen: re-render it so it picks up the key
      const kaiwaRoot = document.getElementById('kaiwa-app')
      if (kaiwaRoot && window.initKaiwaPage) {
        kaiwaRoot.dataset.bound = ''
        window.initKaiwaPage()
      }
    } catch (err) {
      status.innerHTML = msg(err?.code || 'malformed')
      button.disabled = false
      if (err?.code === 'wrong-code') input.select()
    }
  })
  document.getElementById('key-unlock-kaiwa')?.addEventListener('click', () => installDialog.close())
}

addEventListener('appinstalled', () => {
  deferredInstall = null
  if (installDialog?.open) renderInstallDialog()
})

addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault()
  deferredInstall = e
  // The install dialog may already be showing fallback steps - upgrade it
  if (installDialog?.open) return renderInstallDialog()
  const dismissed = localStorage.getItem('install_dismissed')
  if (dismissed && Date.now() - Number(dismissed) < 7 * 86400000) return
  let installToast = null
  installToast = showToast(TOAST.install, {
    actionLabel: TOAST.installBtn,
    action() {
      installToast?.dismiss()
      openInstallDialog()
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
