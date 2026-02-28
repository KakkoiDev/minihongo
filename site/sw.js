const CACHE = 'minihongo-{{CACHE_HASH}}'

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
  'ja/_f/index.html',
  'ja/_f/lessons/2-vocabulary.html',
  'ja/_f/lessons/3-grammar.html',
  'ja/_f/lessons/5-word-building.html',
  'ja/_f/lessons/6-texts-dialogs.html',
  // mh
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

self.addEventListener('install', () => {
  self.skipWaiting()
})

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
      .then(() => {
        caches.open(CACHE).then(c => c.addAll(PRECACHE)).catch(() => {})
      })
  )
})

self.addEventListener('fetch', e => {
  if (e.request.method !== 'GET') return
  e.respondWith(cacheFirst(e.request))
})

async function cacheFirst(request) {
  const cache = await caches.open(CACHE)
  const cached = await cache.match(request)

  // Always revalidate in the background
  const refresh = fetch(request).then(res => {
    if (res.ok) cache.put(request, res.clone())
    return res
  }).catch(() => null)

  // Serve cached immediately if available, otherwise wait for network
  return cached || await refresh || new Response('Offline', { status: 503 })
}
