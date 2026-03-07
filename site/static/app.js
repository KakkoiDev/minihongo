// Minihongo app logic

const base = document.querySelector('base').href
const basePath = new URL(base).pathname

// -- SPA navigation -----------------------------------------------------

const updateTitle = () => {
  const h1 = document.querySelector('#content h1')
  document.title = `${h1?.textContent ?? 'Minihongo'} - Minihongo`
}

const navigate = async (path) => {
  try {
    const res = await fetch(`${base}_f/${path}`)
    if (!res.ok) throw new Error(res.status)
    const html = await res.text()
    const doc = new DOMParser().parseFromString(html, 'text/html')
    const newContent = doc.querySelector('#content')
    if (!newContent) throw new Error('no #content')
    const target = document.querySelector('#content')
    target.replaceWith(newContent)
    updateTitle()
    scrollTo(0, 0)
    bindContentLinks()
    return true
  } catch {
    return false
  }
}

const handleNavClick = async (e, href) => {
  e.preventDefault()
  const path = new URL(href, base).pathname.replace(basePath, '')
  history.pushState({ path }, '', `${base}${path}`)
  if (!await navigate(path)) location.reload()
}

// Bind lesson-nav and TOC links inside #content (re-run after each swap)
const bindContentLinks = () => {
  for (const a of document.querySelectorAll('.lesson-nav a, .toc a')) {
    a.onclick = (e) => handleNavClick(e, a.href)
  }
  for (const a of document.querySelectorAll('#content a[href^="#"]')) {
    a.onclick = (e) => {
      e.preventDefault()
      document.getElementById(a.getAttribute('href').slice(1))?.scrollIntoView()
    }
  }
}

// Top nav links
for (const a of document.querySelectorAll('nav:not(.lesson-nav):not(.toc) a:not(.logo)')) {
  if (a.classList.contains('lang-link')) continue
  a.onclick = (e) => handleNavClick(e, a.href)
}

// Initial content links
bindContentLinks()

// Back/forward
addEventListener('popstate', async (e) => {
  if (!e.state?.path) return location.reload()
  if (!await navigate(e.state.path)) location.reload()
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

// Language switcher
window.switchLang = (lang) => {
  localStorage.setItem('lang', lang)
  const pagePath = location.pathname.replace(/^\/(ja|mh)\//, '/')
  location.href = lang === 'en' ? pagePath : `/${lang}${pagePath}`
}

// -- Service worker -------------------------------------------------

navigator.serviceWorker?.register(`${basePath}sw.js`)

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
