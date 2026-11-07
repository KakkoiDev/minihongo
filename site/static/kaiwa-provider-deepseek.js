// Kaiwa provider: DeepSeek V4 Flash via the Chat Completions API.
// Interface: async send({ apiKey, system, history, onDelta }) -> full reply text.

window.KaiwaProviders = window.KaiwaProviders || {}

// UI text via kaiwa-i18n.js; the English fallback keeps this file usable alone.
const kaiwaText = (key, vars, fallback) => window.kaiwaT?.(key, vars) ?? fallback

window.KaiwaProviders.deepseek = {
  id: 'deepseek',
  label: 'DeepSeek (V4 Flash)',
  keyHint: 'sk-...',
  keyHelpUrl: 'https://platform.deepseek.com/api_keys',

  async send({ apiKey, system, history, onDelta }) {
    const res = await fetch('https://api.deepseek.com/chat/completions', {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        authorization: `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model: 'deepseek-v4-flash',
        messages: [
          { role: 'system', content: system },
          ...history.map(({ role, content }) => ({ role, content })),
        ],
        thinking: { type: 'disabled' },
        max_tokens: 512,
        stream: true,
      }),
    })

    if (!res.ok) throw new Error(await describeDeepSeekError(res))

    const reader = res.body?.getReader()
    if (!reader) throw new Error(kaiwaText('err_no_stream', null, 'DeepSeek returned no response stream.'))

    const decoder = new TextDecoder()
    let buffer = ''
    let text = ''

    const consume = (line) => {
      if (!line.startsWith('data:')) return
      const data = line.slice(5).trim()
      if (!data || data === '[DONE]') return

      let event
      try { event = JSON.parse(data) } catch { return }

      const choice = event.choices?.[0]
      const delta = choice?.delta?.content
      if (typeof delta === 'string' && delta) {
        text += delta
        onDelta?.(delta, text)
      }

      const finish = choice?.finish_reason
      if (finish && finish !== 'stop') {
        const labels = {
          length: ['stop_length', 'the output limit was reached'],
          content_filter: ['stop_content_filter', 'the content filter stopped the response'],
          insufficient_system_resource: ['stop_insufficient_resource', 'DeepSeek had insufficient capacity'],
          tool_calls: ['stop_tool_calls', 'the model returned a tool call instead of text'],
        }
        const label = labels[finish]
        const reason = label ? kaiwaText(label[0], null, label[1]) : finish
        throw new Error(kaiwaText('err_stopped_early', { reason }, `DeepSeek stopped early: ${reason}.`))
      }
    }

    while (true) {
      const { done, value } = await reader.read()
      if (done) break
      buffer += decoder.decode(value, { stream: true })
      const lines = buffer.split('\n')
      buffer = lines.pop() || ''
      for (const line of lines) consume(line)
    }
    buffer += decoder.decode()
    if (buffer) consume(buffer)

    if (!text.trim()) throw new Error(kaiwaText('err_empty', { provider: 'DeepSeek' }, 'DeepSeek returned an empty response. Please try again.'))
    return text
  },
}

async function describeDeepSeekError(res) {
  let detail = ''
  try {
    const body = await res.json()
    detail = body?.error?.message || body?.message || JSON.stringify(body)
  } catch {
    detail = await res.text().catch(() => '')
  }
  if (res.status === 401) return kaiwaText('err_key_rejected', { provider: 'DeepSeek' }, 'DeepSeek rejected the API key (401). Check the key in settings.')
  if (res.status === 402) return kaiwaText('err_no_balance', null, 'DeepSeek has no balance remaining. Add credits in the DeepSeek platform.')
  if (res.status === 429) return kaiwaText('err_rate_limit', { provider: 'DeepSeek' }, 'DeepSeek rate limit hit (429). Wait a moment and try again.')
  const vars = { provider: 'DeepSeek', status: res.status, detail: detail.slice(0, 300) }
  return kaiwaText('err_api', vars, `DeepSeek API error ${vars.status}: ${vars.detail}`)
}
