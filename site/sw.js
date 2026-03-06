// Service Worker for Minihongo PWA
// Provides offline support via two caching strategies:
// - Cache-first with background revalidation (static assets, full pages)
// - Network-first with cache fallback (htmz fragment pages)

// Cache name includes a content hash so a new deploy busts the old cache
const CACHE = 'minihongo-{{CACHE_HASH}}'

// All pages and assets to pre-cache on install (enables full offline use)
const PRECACHE = [
  './',
  'static/style.css',
  'static/app.js',
  // English pages + htmz fragments
  'lessons/2-vocabulary.html',
  'lessons/3-grammar.html',
  'lessons/5-word-building.html',
  'lessons/6-texts-dialogs.html',
  '_f/index.html',
  '_f/lessons/2-vocabulary.html',
  '_f/lessons/3-grammar.html',
  '_f/lessons/5-word-building.html',
  '_f/lessons/6-texts-dialogs.html',
  // Japanese pages + htmz fragments
  'ja/',
  'ja/lessons/2-vocabulary.html',
  'ja/lessons/3-grammar.html',
  'ja/lessons/5-word-building.html',
  'ja/lessons/6-texts-dialogs.html',
  'ja/_f/index.html',
  'ja/_f/lessons/2-vocabulary.html',
  'ja/_f/lessons/3-grammar.html',
  'ja/_f/lessons/5-word-building.html',
  'ja/_f/lessons/6-texts-dialogs.html',
  // Minihongo pages + htmz fragments
  'mh/',
  'mh/lessons/2-vocabulary.html',
  'mh/lessons/3-grammar.html',
  'mh/lessons/5-word-building.html',
  'mh/lessons/6-texts-dialogs.html',
  'mh/_f/index.html',
  'mh/_f/lessons/2-vocabulary.html',
  'mh/_f/lessons/3-grammar.html',
  'mh/_f/lessons/5-word-building.html',
  'mh/_f/lessons/6-texts-dialogs.html',
]

// -- Lifecycle events ---------------------------------------------------

// Pre-cache all assets on install, then activate immediately
self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(PRECACHE)))
  self.skipWaiting()
})

// Delete old caches from previous versions, then claim all clients
self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  )
})

// -- Fetch routing ------------------------------------------------------

// Fragment pages (/_f/*) use network-first so htmz navigation stays fresh.
// Everything else uses cache-first for instant loads with background refresh.
self.addEventListener('fetch', (e) => {
  if (e.request.method !== 'GET') return
  const { pathname } = new URL(e.request.url)
  e.respondWith(pathname.includes('/_f/') ? networkFirst(e.request) : cacheFirst(e.request))
})

// -- Caching strategies -------------------------------------------------

// Network-first: try network, fall back to cache, last resort 503
const networkFirst = async (request) => {
  const cache = await caches.open(CACHE)
  try {
    const res = await fetch(request)
    if (res.ok) cache.put(request, res.clone())
    return res
  } catch {
    return (await cache.match(request)) ?? new Response('Offline', { status: 503 })
  }
}

// Cache-first with stale-while-revalidate: serve cached immediately,
// refresh in the background for next visit
const cacheFirst = async (request) => {
  const cache = await caches.open(CACHE)
  const cached = await cache.match(request)

  // Background refresh (don't await unless no cache hit)
  const refresh = fetch(request).then((res) => {
    if (res.ok) cache.put(request, res.clone())
    return res
  }).catch(() => null)

  return cached ?? (await refresh) ?? new Response('Offline', { status: 503 })
}
