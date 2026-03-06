// Minihongo app logic
// Extracted from page-layout.html for caching via service worker

const base = document.querySelector('base').href
const basePath = new URL(base).pathname

// -- Helpers --------------------------------------------------------

const updateTitle = () => {
  const h1 = document.querySelector('#content h1')
  document.title = `${h1?.textContent ?? 'Minihongo'} - Minihongo`
}

const swapContent = (nodes, target) => {
  if (!target || !nodes.length) return false
  target.replaceWith(...nodes)
  updateTitle()
  scrollTo(0, 0)
  return true
}

// -- htmz iframe handler --------------------------------------------

const onHtmzLoad = (frame) => {
  try {
    const { location: loc } = frame.contentWindow
    if (loc.href === 'about:blank') return
    setTimeout(() => {
      try {
        const target = document.querySelector(loc.hash || null)
        const nodes = [...frame.contentDocument.body.childNodes]
        if (!swapContent(nodes, target)) return
        frame.src = 'about:blank'
        const pagePath = loc.pathname.replace(basePath, '').replace(/^_f\//, '')
        const pageUrl = `${base}${pagePath}`
        if (location.href !== pageUrl) history.pushState({ path: pagePath }, '', pageUrl)
      } catch { location.reload() }
    })
  } catch { /* iframe in bad state after OS freeze/resume - ignore */ }
}

// -- Back/forward navigation ----------------------------------------

addEventListener('popstate', async (e) => {
  if (!e.state?.path) return location.reload()
  try {
    const res = await fetch(`${base}_f/${e.state.path}`)
    if (!res.ok) throw new Error(res.status)
    const html = await res.text()
    const doc = new DOMParser().parseFromString(html, 'text/html')
    const nodes = [...doc.body.childNodes]
    if (!swapContent(nodes, document.querySelector('#content'))) location.reload()
  } catch { location.reload() }
})

// -- Rewrite nav links for htmz ------------------------------------

for (const a of document.querySelectorAll('nav:not(.lesson-nav):not(.toc) a:not(.logo)')) {
  if (a.classList.contains('lang-link')) continue
  a.target = 'htmz'
  const path = new URL(a.href).pathname.replace(basePath, '')
  a.href = `${base}_f/${path}#content`
}

// -- Click delegation -----------------------------------------------

document.addEventListener('click', (e) => {
  const anchor = e.target.closest('#content a[href^="#"]')
  if (anchor) {
    e.preventDefault()
    document.getElementById(anchor.getAttribute('href').slice(1))?.scrollIntoView()
    return
  }
  const nav = e.target.closest('.lesson-nav a')
  if (!nav) return
  e.preventDefault()
  const path = new URL(nav.href, base).pathname.replace(basePath, '')
  document.querySelector('iframe[name=htmz]').src = `${base}_f/${path}#content`
})

// -- Toggle buttons -------------------------------------------------

document.getElementById('btn-theme').addEventListener('click', () => {
  const next = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark'
  document.documentElement.dataset.theme = next
  localStorage.setItem('theme', next)
})

document.getElementById('btn-furigana').addEventListener('click', () => {
  const on = document.documentElement.classList.toggle('no-furigana')
  localStorage.setItem('furigana', on ? '0' : '1')
})

// Language switcher - global, called from lang switcher onchange
window.switchLang = (lang) => {
  localStorage.setItem('lang', lang)
  const pagePath = location.pathname.replace(/^\/(ja|mh)\//, '/')
  location.href = lang === 'en' ? pagePath : `/${lang}${pagePath}`
}

// -- Service worker -------------------------------------------------

navigator.serviceWorker?.register('/sw.js')

// -- Content integrity recovery -------------------------------------

const checkContentIntegrity = () => {
  if (!document.querySelector('#content')?.children.length) location.reload()
}
addEventListener('pageshow', (e) => { if (e.persisted) checkContentIntegrity() })
addEventListener('resume', checkContentIntegrity)
document.addEventListener('visibilitychange', () => {
  if (document.visibilityState === 'visible') checkContentIntegrity()
})

// -- Toast banner system --------------------------------------------

const toastContainer = document.getElementById('toast-container')

const showToast = (msg, opts) => {
  const el = document.createElement('div')
  el.className = 'toast'

  const msgSpan = document.createElement('span')
  msgSpan.className = 'toast-msg'
  msgSpan.textContent = msg
  el.appendChild(msgSpan)

  if (opts?.actionLabel) {
    const btn = document.createElement('button')
    btn.className = 'toast-btn'
    btn.textContent = opts.actionLabel
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

const clearToasts = () => {
  for (const el of [...toastContainer.children]) el.remove()
}

// Network status toasts
let offlineToast = null
addEventListener('offline', () => {
  offlineToast = showToast(TOAST.offline)
})
addEventListener('online', () => {
  offlineToast?.dismiss()
  offlineToast = null
  showToast(TOAST.online, { duration: 3000 })
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

navigator.serviceWorker?.addEventListener('controllerchange', () => {
  showToast(TOAST.updated, { duration: 4000 })
})
