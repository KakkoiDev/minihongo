// Kaiwa provider: Anthropic Claude Haiku 4.5, direct browser calls.
// Interface: async send({ apiKey, system, history, onDelta }) -> full reply text.

window.KaiwaProviders = window.KaiwaProviders || {}

// UI text via kaiwa-i18n.js; the English fallback keeps this file usable alone.
const kaiwaText = (key, vars, fallback) => window.kaiwaT?.(key, vars) ?? fallback

window.KaiwaProviders.anthropic = {
  id: 'anthropic',
  label: 'Anthropic (Claude)',
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
        // Current Haiku. Anthropic has no "latest Haiku" alias, so this is the
        // one place to bump when a new Haiku ships. Short spoken replies: no
        // hidden thinking, low effort, for the lowest latency.
        model: 'claude-haiku-5-5',
        max_tokens: 300,
        thinking: { type: 'disabled' },
        output_config: { effort: 'low' },
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
      throw new Error(kaiwaText('err_empty', { provider: 'Anthropic' }, 'Anthropic returned an empty response. Please try again.'))
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
  if (res.status === 401) return kaiwaText('err_key_rejected', { provider: 'Anthropic' }, 'Anthropic rejected the API key (401). Check the key in settings.')
  if (res.status === 429) return kaiwaText('err_rate_limit', { provider: 'Anthropic' }, 'Anthropic rate limit hit (429). Wait a moment and try again.')
  const vars = { provider: 'Anthropic', status: res.status, detail: detail.slice(0, 300) }
  return kaiwaText('err_api', vars, `Anthropic API error ${vars.status}: ${vars.detail}`)
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
