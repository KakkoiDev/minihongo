// Kaiwa provider: OpenAI GPT-5.6 Luna, via the Responses API (OpenAI's
// current recommended surface as of 2026-09; Chat Completions is legacy).
// Interface: async send({ apiKey, system, history, onDelta }) -> full reply text.
//
// Luna has no service_tier / fast-mode parameter (verified against the live
// model page before building this) - this is a plain call.

window.KaiwaProviders = window.KaiwaProviders || {}

window.KaiwaProviders.openai = {
  id: 'openai',
  label: 'OpenAI (GPT-5.6 Luna)',
  keyHint: 'sk-...',
  keyHelpUrl: 'https://platform.openai.com/api-keys',

  async send({ apiKey, system, history, onDelta }) {
    const res = await fetch('https://api.openai.com/v1/responses', {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        authorization: `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model: 'gpt-5.6-luna',
        instructions: system,
        input: history.map(m => (
          m.role === 'assistant'
            ? { role: 'assistant', type: 'message', content: [{ type: 'output_text', text: m.content }] }
            : { role: 'user', content: m.content }
        )),
        // This is a latency-sensitive voice UI. Luna supports reasoning.effort
        // "none"; avoiding hidden reasoning also ensures the output budget is
        // available for the short visible reply.
        reasoning: { effort: 'none' },
        max_output_tokens: 512,
        store: false,
        stream: true,
      }),
    })

    if (!res.ok) {
      throw new Error(await describeError(res))
    }

    const text = await readSSE(res, (evt) => {
      if (evt.type === 'response.output_text.delta' && typeof evt.delta === 'string') {
        return evt.delta
      }
      // Some successful streams can reach the final text event without the
      // browser observing every delta (for example after a mobile connection
      // pause). Use the done event as a full-text fallback.
      if (evt.type === 'response.output_text.done' && typeof evt.text === 'string') {
        return { final: evt.text }
      }
      if (evt.type === 'response.refusal.done') {
        throw new Error(`OpenAI refused the request: ${evt.refusal || 'no reason provided'}`)
      }
      return null
    }, onDelta, (evt) => {
      if (evt.type === 'response.failed') {
        throw new Error(`OpenAI response failed: ${evt.response?.error?.message || 'unknown error'}`)
      }
      if (evt.type === 'response.incomplete') {
        const reason = evt.response?.incomplete_details?.reason || 'unknown reason'
        throw new Error(`OpenAI response was incomplete: ${reason}`)
      }
      if (evt.type !== 'response.completed') return null
      return evt.response?.output
        ?.flatMap(item => item.content || [])
        .filter(part => part.type === 'output_text')
        .map(part => part.text || '')
        .join('') || null
    })

    if (!text.trim()) {
      throw new Error('OpenAI returned an empty response. Please try again.')
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
  if (res.status === 401) return 'OpenAI rejected the API key (401). Check the key in settings.'
  if (res.status === 429) return 'OpenAI rate limit hit (429). Wait a moment and try again.'
  return `OpenAI API error ${res.status}: ${detail.slice(0, 300)}`
}

// Shared shape with the Anthropic provider's SSE reader, duplicated rather
// than imported so each provider file stays a self-contained drop-in.
async function readSSE(res, extract, onDelta, extractFinal) {
  const reader = res.body.getReader()
  const decoder = new TextDecoder()
  let buf = ''
  let text = ''
  let finalText = ''
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
      const completed = extractFinal?.(evt)
      if (completed) finalText = completed
      const delta = extract(evt)
      if (delta?.final) {
        finalText = delta.final
      } else if (delta) {
        text += delta
        onDelta?.(delta, text)
      }
    }
  }
  // A final text event is authoritative and can repair a stream where one or
  // more deltas were missed. Avoid duplicating text when both paths agree.
  if (finalText && finalText !== text) onDelta?.(finalText, finalText)
  return finalText || text
}
