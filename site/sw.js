const CACHE = 'minihongo-v1'
const MAX_AGE = 60_000 // 1 minute in ms

self.addEventListener('install', () => {
  self.skipWaiting()
})

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
  )
})

self.addEventListener('fetch', e => {
  if (e.request.method !== 'GET') return

  e.respondWith(
    caches.open(CACHE).then(async cache => {
      const cached = await cache.match(e.request)

      // Background refresh if stale or missing
      const age = cached?.headers.get('x-cached-at')
      const stale = !age || (Date.now() - Number(age)) > MAX_AGE

      if (stale) {
        const refresh = fetch(e.request).then(res => {
          if (res.ok) {
            // Clone and stamp with cache time
            const headers = new Headers(res.headers)
            headers.set('x-cached-at', String(Date.now()))
            const stamped = new Response(res.clone().body, {
              status: res.status,
              statusText: res.statusText,
              headers,
            })
            cache.put(e.request, stamped)
          }
          return res
        }).catch(() => cached) // network fail -> use cache

        // If we have a cached version, serve it now. Otherwise wait for network.
        return cached || refresh
      }

      return cached
    })
  )
})
