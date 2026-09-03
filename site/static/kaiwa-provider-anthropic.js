// Kaiwa provider: Anthropic Claude Haiku 4.5, direct browser calls.
// Interface: async send({ apiKey, system, history, onDelta }) -> full reply text.

window.KaiwaProviders = window.KaiwaProviders || {}

window.KaiwaProviders.anthropic = {
  id: 'anthropic',
  label: 'Anthropic (Claude Haiku 4.5)',
  keyHint: 'sk-ant-...',
  keyHelpUrl: 'https://console.anthropic.com/settings/keys',

  async send({ apiKey, system, history, onDelta }) {
    const res = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
        'anthropic-dangerous-direct-browser-access': 'true',
      },
      body: JSON.stringify({
        model: 'claude-haiku-4-5-20251001',
        max_tokens: 300,
        system,
        stream: true,
        messages: history.map(m => ({ role: m.role, content: m.content })),
      }),
    })

    if (!res.ok) {
      throw new Error(await describeError(res))
    }

    const text = await readSSE(res, (evt) => {
      if (evt.type === 'content_block_delta' && evt.delta?.type === 'text_delta') {
        return evt.delta.text
      }
      // Normally text arrives as deltas, but accept providers/proxies that put
      // an initial text chunk in the content-block start event.
      if (evt.type === 'content_block_start' && evt.content_block?.type === 'text') {
        return evt.content_block.text || null
      }
      return null
    }, onDelta)

    if (!text.trim()) {
      throw new Error('Anthropic returned an empty response. Please try again.')
    }
    return text
  },
}

async function describeError(res) {
  let detail = ''
  try {
    const body = await res.json()
    detail = body?.error?.message || JSON.stringify(body)
  } catch {
    detail = await res.text().catch(() => '')
  }
  if (res.status === 401) return 'Anthropic rejected the API key (401). Check the key in settings.'
  if (res.status === 429) return 'Anthropic rate limit hit (429). Wait a moment and try again.'
  return `Anthropic API error ${res.status}: ${detail.slice(0, 300)}`
}

// Shared SSE line reader: `extract(evt)` returns a text delta or null per event.
async function readSSE(res, extract, onDelta) {
  const reader = res.body.getReader()
  const decoder = new TextDecoder()
  let buf = ''
  let text = ''
  while (true) {
    const { done, value } = await reader.read()
    if (done) break
    buf += decoder.decode(value, { stream: true })
    const lines = buf.split('\n')
    buf = lines.pop()
    for (const line of lines) {
      if (!line.startsWith('data:')) continue
      const data = line.slice(5).trim()
      if (!data || data === '[DONE]') continue
      let evt
      try { evt = JSON.parse(data) } catch { continue }
      const delta = extract(evt)
      if (delta) {
        text += delta
        onDelta?.(delta, text)
      }
    }
  }
  return text
}
