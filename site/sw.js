const CACHE = 'minihongo-{{CACHE_HASH}}'
const MAX_AGE = 60_000 // 1 minute in ms
const NET_TIMEOUT = 2_000 // network-first timeout in ms

const PRECACHE = [
  './',
  'static/style.css',
  // en
  'lessons/2-vocabulary.html',
  'lessons/3-grammar.html',
  'lessons/5-word-building.html',
  'lessons/6-texts-dialogs.html',
  '_f/index.html',
  '_f/lessons/2-vocabulary.html',
  '_f/lessons/3-grammar.html',
  '_f/lessons/5-word-building.html',
  '_f/lessons/6-texts-dialogs.html',
  // ja
  'ja/',
  'ja/lessons/2-vocabulary.html',
  'ja/lessons/3-grammar.html',
  'ja/lessons/5-word-building.html',
  'ja/lessons/6-texts-dialogs.html',
  '_f/ja/index.html',
  '_f/ja/lessons/2-vocabulary.html',
  '_f/ja/lessons/3-grammar.html',
  '_f/ja/lessons/5-word-building.html',
  '_f/ja/lessons/6-texts-dialogs.html',
  // mh
  'mh/',
  'mh/lessons/2-vocabulary.html',
  'mh/lessons/3-grammar.html',
  'mh/lessons/5-word-building.html',
  'mh/lessons/6-texts-dialogs.html',
  '_f/mh/index.html',
  '_f/mh/lessons/2-vocabulary.html',
  '_f/mh/lessons/3-grammar.html',
  '_f/mh/lessons/5-word-building.html',
  '_f/mh/lessons/6-texts-dialogs.html',
]

self.addEventListener('install', () => {
  self.skipWaiting()
})

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
      .then(() => {
        // Background precache - does not block activation or navigation
        caches.open(CACHE).then(c => c.addAll(PRECACHE)).catch(() => {})
      })
  )
})

self.addEventListener('fetch', e => {
  if (e.request.method !== 'GET') return

  const url = new URL(e.request.url)

  // Fragments: network-first (small, want fresh content)
  // Everything else: stale-while-revalidate (instant loads)
  if (url.pathname.includes('/_f/')) {
    e.respondWith(networkFirst(e.request))
  } else {
    e.respondWith(staleWhileRevalidate(e.request))
  }
})

async function networkFirst(request) {
  const cache = await caches.open(CACHE)
  try {
    const res = await timeout(fetch(request), NET_TIMEOUT)
    if (res.ok) cache.put(request, res.clone())
    return res
  } catch {
    return await cache.match(request) || new Response('Offline', { status: 503 })
  }
}

async function staleWhileRevalidate(request) {
  const cache = await caches.open(CACHE)
  const cached = await cache.match(request)

  const age = cached?.headers.get('x-cached-at')
  const stale = !age || (Date.now() - Number(age)) > MAX_AGE

  if (stale) {
    const refresh = fetch(request).then(res => {
      if (res.ok) {
        const headers = new Headers(res.headers)
        headers.set('x-cached-at', String(Date.now()))
        cache.put(request, new Response(res.clone().body, {
          status: res.status,
          statusText: res.statusText,
          headers,
        }))
      }
      return res
    }).catch(() => cached)

    return cached || refresh
  }

  return cached
}

function timeout(promise, ms) {
  return Promise.race([
    promise,
    new Promise((_, reject) => setTimeout(() => reject(new Error('timeout')), ms)),
  ])
}
