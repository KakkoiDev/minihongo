// Kaiwa (会話) mode: spoken Japanese practice against a bring-your-own-key LLM.
// Entry point: window.initKaiwaPage(), called by app.js's bindContentLinks()
// whenever #kaiwa-app is present - see app.js for why this can't just be a
// <script> tag in the page (SPA nav swaps #content without executing scripts).

const KAIWA_KEY_STORAGE = {
  anthropic: 'kaiwa_key_anthropic',
  openai: 'kaiwa_key_openai',
  deepseek: 'kaiwa_key_deepseek',
}
const KAIWA_PROVIDER_STORAGE = 'kaiwa_provider'
const KAIWA_HISTORY_STORAGE = 'kaiwa_history'

let kaiwaData = null // { words, grammar, candos } - fetched once, reused across sessions
let kaiwaExpressions = null // lazy-loaded only for the end-of-session summary

async function fetchKaiwaData() {
  if (kaiwaData) return kaiwaData
  const res = await fetch('/static/kaiwa-data.json?v={{CACHE_HASH}}')
  kaiwaData = await res.json()
  return kaiwaData
}

async function fetchKaiwaExpressions() {
  if (kaiwaExpressions) return kaiwaExpressions
  const res = await fetch('/static/kaiwa-expressions.json?v={{CACHE_HASH}}')
  kaiwaExpressions = await res.json()
  return kaiwaExpressions
}

// -- Entry point ----------------------------------------------------------

window.initKaiwaPage = async function initKaiwaPage() {
  const root = document.getElementById('kaiwa-app')
  if (!root || root.dataset.bound === '1') return
  root.dataset.bound = '1'

  root.innerHTML = '<p class="kaiwa-loading">Loading...</p>'
  let data
  try {
    data = await fetchKaiwaData()
  } catch {
    root.innerHTML = '<p class="kaiwa-error">Could not load kaiwa data. Check your connection and reload.</p>'
    return
  }

  renderPicker(root, data)
}

// -- Screen 1: settings + can-do picker ------------------------------------

function loadHistory() {
  try { return JSON.parse(localStorage.getItem(KAIWA_HISTORY_STORAGE) || '{}') }
  catch { return {} }
}

function saveSessionSummary(candoId, summary) {
  const all = loadHistory()
  all[candoId] = all[candoId] || []
  all[candoId].push(summary)
  localStorage.setItem(KAIWA_HISTORY_STORAGE, JSON.stringify(all))
}

function candoBadge(history, candoId) {
  const sessions = history[candoId]
  if (!sessions || !sessions.length) return 'not attempted'
  const last = sessions[sessions.length - 1]
  return `${sessions.length} session${sessions.length > 1 ? 's' : ''}, longest: ${last.longestSentence.length} chars`
}

function renderPicker(root, data) {
  const history = loadHistory()
  const savedProvider = localStorage.getItem(KAIWA_PROVIDER_STORAGE) || 'anthropic'
  const savedKey = localStorage.getItem(KAIWA_KEY_STORAGE[savedProvider]) || ''
  const hasRecognition = !!(window.SpeechRecognition || window.webkitSpeechRecognition)

  const candoOptions = data.candos.map(c => `
    <label class="kaiwa-cando">
      <input type="radio" name="kaiwa-cando" value="${c.id}">
      <span class="kaiwa-cando-text">
        <strong>${escapeHtml(c.english)}</strong>
        <span lang="ja">${escapeHtml(c.japanese)}</span>
        <span class="kaiwa-cando-badge">${escapeHtml(candoBadge(history, c.id))}</span>
      </span>
    </label>
  `).join('')

  const providerLabels = {
    anthropic: 'Anthropic (Claude Haiku 4.5)',
    openai: 'OpenAI (GPT-5.6 Luna)',
    deepseek: 'DeepSeek (V4 Flash)',
  }
  const providerRadios = Object.keys(providerLabels).map(id => `
    <label class="kaiwa-provider-opt">
      <input type="radio" name="kaiwa-provider" value="${id}" ${id === savedProvider ? 'checked' : ''}>
      <span>${providerLabels[id]}</span>
    </label>
  `).join('')

  root.innerHTML = `
    <div class="kaiwa-setup">
      ${hasRecognition ? '' : `
        <p class="kaiwa-warning">
          Your browser does not support speech recognition (this needs Chrome or a
          Chromium-based browser). You can still practice by typing your replies instead
          of speaking them.
        </p>
      `}
      <p class="kaiwa-privacy">
        Your API key is stored only in this browser's local storage and sent only to the
        provider you pick, with every request. In Chrome, your spoken audio is sent to
        Google's servers to turn it into text. That's how the browser's speech
        recognition works; it never reaches the AI provider.
      </p>

      <details class="kaiwa-details" id="kaiwa-provider-details" ${savedKey ? '' : 'open'}>
        <summary>AI provider and API key</summary>
        <div class="kaiwa-details-body">
          <fieldset class="kaiwa-field">
            <legend>AI provider</legend>
            ${providerRadios}
          </fieldset>

          <label class="kaiwa-field">
            <span>API key</span>
            <input type="password" id="kaiwa-api-key" autocomplete="off" spellcheck="false">
          </label>
          <p class="kaiwa-key-hint" id="kaiwa-key-hint"></p>
        </div>
      </details>

      <details class="kaiwa-details" id="kaiwa-goal-details">
        <summary>Pick a goal <span class="kaiwa-optional">optional</span></summary>
        <div class="kaiwa-details-body">
          <div class="kaiwa-cando-list">
            <label class="kaiwa-cando">
              <input type="radio" name="kaiwa-cando" value="" checked>
              <span class="kaiwa-cando-text">
                <strong>Free conversation</strong>
                <span>No specific goal</span>
              </span>
            </label>
            ${candoOptions}
          </div>
        </div>
      </details>

      <button id="kaiwa-start" class="kaiwa-primary" disabled>Start</button>
      <p class="kaiwa-status" id="kaiwa-setup-status"></p>
    </div>
  `

  const keyInput = root.querySelector('#kaiwa-api-key')
  const startBtn = root.querySelector('#kaiwa-start')
  const statusEl = root.querySelector('#kaiwa-setup-status')
  const keyHint = root.querySelector('#kaiwa-key-hint')
  const providerDetails = root.querySelector('#kaiwa-provider-details')

  const currentProvider = () => root.querySelector('input[name="kaiwa-provider"]:checked').value

  const refreshKeyField = () => {
    const providerId = currentProvider()
    const provider = window.KaiwaProviders[providerId]
    keyInput.value = localStorage.getItem(KAIWA_KEY_STORAGE[providerId]) || ''
    if (!keyInput.value) providerDetails.open = true
    keyInput.placeholder = provider.keyHint
    keyHint.innerHTML = `Get a key at <a href="${provider.keyHelpUrl}" target="_blank" rel="noopener">${provider.keyHelpUrl}</a>`
    validate()
  }

  const validate = () => {
    startBtn.disabled = !keyInput.value.trim()
  }

  root.querySelectorAll('input[name="kaiwa-provider"]').forEach(r => r.addEventListener('change', refreshKeyField))
  root.querySelectorAll('input[name="kaiwa-cando"]').forEach(r => r.addEventListener('change', validate))
  keyInput.addEventListener('input', validate)

  refreshKeyField()

  startBtn.addEventListener('click', () => {
    const providerId = currentProvider()
    const apiKey = keyInput.value.trim()
    const selectedGoal = root.querySelector('input[name="kaiwa-cando"]:checked')?.value || ''
    const cando = selectedGoal ? data.candos.find(c => c.id === selectedGoal) : null
    if (!apiKey) {
      statusEl.textContent = 'Enter an API key to start.'
      return
    }
    localStorage.setItem(KAIWA_PROVIDER_STORAGE, providerId)
    localStorage.setItem(KAIWA_KEY_STORAGE[providerId], apiKey)
    startSession(root, data, { providerId, apiKey, cando, hasRecognition })
  })
}

function escapeHtml(s) {
  return String(s ?? '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]))
}

// -- System prompt ----------------------------------------------------------

function buildSystemPrompt(data, cando) {
  const wordList = data.words.map(w => (
    w.kanji === w.reading ? w.kanji : `${w.kanji}(${w.reading})`
  ) + `=${w.english}`).join(', ')

  return `You are a Japanese conversation partner for a spoken-practice exercise called Minihongo.

RULES (follow every one, every turn):
1. Reply using ONLY the following 231 words, plus proper nouns and numbers. Combine them to
   express anything else (e.g. word-for-word "body help place" for "hospital"). Never switch
   to English.
2. Write normal Japanese text - kanji as shown, no bracket/reading annotations.
3. Keep your reply to one or two short sentences. The user should be talking most of the time.
4. End nearly every turn with a question, so the user has to respond.
5. Do NOT correct the user's Japanese inside your reply. That breaks the flow this exercise
   exists to build. Instead, produce a silent correction on a separate line (see FORMAT).
6. ${cando
    ? `Hold the whole conversation around this one goal: "${cando.english}" (${cando.japanese}).
   Stay on topic; don't wander to unrelated small talk for more than a line.`
    : 'Have a natural, general conversation. Let the user choose and change the topic.'}

FORMAT - reply with exactly two lines, nothing else:
REPLY: <your one or two Japanese sentences, spoken aloud to the user>
CORRECTION: <if the user's last turn had a Japanese error, one corrected sentence in Japanese; otherwise the literal word NONE>

The 231 words (kanji(reading)=meaning): ${wordList}`
}

// -- Screen 2: live session ---------------------------------------------

function startSession(root, data, opts) {
  const session = {
    ...opts,
    data,
    history: [], // {role: 'user'|'assistant', content}
    transcript: [], // {role, text, correction?}
    corrections: [],
    outOfSet: [], // {word}
    longestSentence: '',
    abandonCount: 0,
    englishSwitchCount: 0,
  }

  root.innerHTML = `
    <div class="kaiwa-session">
      <p class="kaiwa-goal">${opts.cando
        ? `<strong>${escapeHtml(opts.cando.english)}</strong> - <span lang="ja">${escapeHtml(opts.cando.japanese)}</span>`
        : '<strong>Free conversation</strong> - <span lang="ja">自由会話</span>'
      }</p>
      <div class="kaiwa-transcript" id="kaiwa-transcript" aria-live="polite"></div>
      <p class="kaiwa-live" id="kaiwa-live"></p>
      <div class="kaiwa-controls">
        <button id="kaiwa-mic" class="kaiwa-primary" ${opts.hasRecognition ? '' : 'hidden'}>Speak</button>
        <form id="kaiwa-text-form" ${opts.hasRecognition ? 'hidden' : ''}>
          <input type="text" id="kaiwa-text-input" lang="ja" placeholder="Type your reply in Japanese">
          <button type="submit">Send</button>
        </form>
        <button id="kaiwa-retry" hidden>Retry</button>
        <button id="kaiwa-end">End session</button>
      </div>
      <p class="kaiwa-status" id="kaiwa-session-status"></p>
    </div>
  `

  const transcriptEl = root.querySelector('#kaiwa-transcript')
  const liveEl = root.querySelector('#kaiwa-live')
  const micBtn = root.querySelector('#kaiwa-mic')
  const retryBtn = root.querySelector('#kaiwa-retry')
  const endBtn = root.querySelector('#kaiwa-end')
  const statusEl = root.querySelector('#kaiwa-session-status')
  const textForm = root.querySelector('#kaiwa-text-form')
  const textInput = root.querySelector('#kaiwa-text-input')

  const appendBubble = (role, text) => {
    const p = document.createElement('p')
    p.className = `kaiwa-bubble kaiwa-bubble-${role}`
    p.lang = 'ja'
    p.textContent = text
    transcriptEl.appendChild(p)
    transcriptEl.scrollTop = transcriptEl.scrollHeight
  }

  // Chrome can expose an empty voice list on the first call while its speech
  // service is still loading. Wait briefly for voiceschanged so the opening
  // reply is not silently lost.
  const voiceReady = waitForJapaneseVoice()

  const speak = (text) => {
    const clean = text.trim()
    if (!('speechSynthesis' in window) || !clean) return
    voiceReady.then((voice) => {
      const utter = new SpeechSynthesisUtterance(clean)
      utter.lang = 'ja-JP'
      if (voice) utter.voice = voice
      speechSynthesis.resume()
      speechSynthesis.speak(utter)
    })
  }

  // The provider streams the two-line protocol (REPLY + CORRECTION), but TTS
  // must speak only the reply body. Wait until the REPLY marker is complete,
  // stop before CORRECTION, and speak complete sentences as they arrive.
  const makeReplySpeaker = () => {
    let spokenLength = 0

    const read = (fullTextSoFar, flush = false) => {
      const match = fullTextSoFar.match(/(?:^|\n)REPLY:\s*/)
      if (!match) return

      let reply = fullTextSoFar.slice(match.index + match[0].length)
      const correctionAt = reply.search(/\nCORRECTION:/)
      if (correctionAt >= 0) reply = reply.slice(0, correctionAt)

      const unspoken = reply.slice(spokenLength)
      if (!unspoken) return

      let complete = ''
      if (flush) {
        complete = unspoken
      } else {
        const endings = [...unspoken.matchAll(/[。！？]/g)]
        if (endings.length) complete = unspoken.slice(0, endings.at(-1).index + 1)
      }

      if (complete.trim()) speak(complete)
      spokenLength += complete.length
    }

    read.flush = (fullText) => read(fullText, true)
    return read
  }

  async function sendTurn(userText) {
    micBtn.disabled = true
    textInput.disabled = true
    statusEl.textContent = 'Thinking...'

    appendBubble('user', userText)
    trackUserTurn(session, userText)
    session.history.push({ role: 'user', content: userText })

    const system = buildSystemPrompt(data, opts.cando)
    const provider = window.KaiwaProviders[opts.providerId]
    const speakAsItStreams = makeReplySpeaker()

    let full = ''
    try {
      full = await provider.send({
        apiKey: opts.apiKey,
        system,
        history: session.history,
        onDelta: (_delta, soFar) => { speakAsItStreams(soFar); full = soFar },
      })
    } catch (err) {
      statusEl.textContent = err.message || 'Something went wrong talking to the provider.'
      micBtn.disabled = false
      textInput.disabled = false
      return
    }

    if (!full.trim()) {
      statusEl.textContent = 'The AI returned an empty response. Please retry.'
      micBtn.disabled = false
      textInput.disabled = false
      return
    }
    speakAsItStreams.flush(full)
    const { reply, correction } = parseModelTurn(full)
    appendBubble('assistant', reply)
    session.history.push({ role: 'assistant', content: full })
    session.transcript.push({ role: 'assistant', text: reply, correction })
    if (correction && correction !== 'NONE') session.corrections.push(correction)

    statusEl.textContent = ''
    micBtn.disabled = false
    textInput.disabled = false
  }

  // -- Speech recognition --------------------------------------------------

  let recognizer = null
  let listening = false
  let hadInterim = false

  const setupRecognition = () => {
    const Recognition = window.SpeechRecognition || window.webkitSpeechRecognition
    const r = new Recognition()
    r.lang = 'ja-JP'
    r.continuous = false
    r.interimResults = true

    r.onresult = (e) => {
      let finalText = ''
      let interimText = ''
      for (let i = e.resultIndex; i < e.results.length; i++) {
        const chunk = e.results[i][0].transcript
        if (e.results[i].isFinal) finalText += chunk
        else interimText += chunk
      }
      hadInterim = hadInterim || !!interimText || !!finalText
      liveEl.textContent = finalText || interimText
      if (finalText) {
        listening = false
        r.stop()
        liveEl.textContent = ''
        retryBtn.hidden = true
        sendTurn(finalText.trim())
      } else {
        retryBtn.hidden = false
      }
    }

    r.onerror = () => {
      listening = false
      micBtn.textContent = 'Speak'
      if (hadInterim) session.abandonCount++
      statusEl.textContent = 'Could not hear you. Try again.'
    }

    r.onend = () => {
      listening = false
      micBtn.textContent = 'Speak'
    }

    return r
  }

  micBtn?.addEventListener('click', () => {
    if (listening) {
      recognizer?.stop()
      listening = false
      micBtn.textContent = 'Speak'
      return
    }
    hadInterim = false
    recognizer = setupRecognition()
    recognizer.start()
    listening = true
    micBtn.textContent = 'Stop'
    statusEl.textContent = ''
  })

  retryBtn.addEventListener('click', () => {
    recognizer?.abort()
    listening = false
    liveEl.textContent = ''
    retryBtn.hidden = true
    micBtn.textContent = 'Speak'
    session.abandonCount++
  })

  textForm?.addEventListener('submit', (e) => {
    e.preventDefault()
    const text = textInput.value.trim()
    if (!text) return
    textInput.value = ''
    sendTurn(text)
  })

  endBtn.addEventListener('click', () => finishSession(root, session))

  // Opening line: the model greets and asks the first question.
  ;(async () => {
    statusEl.textContent = 'Starting...'
    const system = buildSystemPrompt(data, opts.cando)
    const provider = window.KaiwaProviders[opts.providerId]
    const speakAsItStreams = makeReplySpeaker()
    let full = ''
    try {
      full = await provider.send({
        apiKey: opts.apiKey,
        system,
        history: [{ role: 'user', content: '(Begin the conversation now: greet me and ask your first question.)' }],
        onDelta: (_d, soFar) => { speakAsItStreams(soFar); full = soFar },
      })
    } catch (err) {
      statusEl.textContent = err.message || 'Could not reach the provider to start.'
      return
    }
    if (!full.trim()) {
      statusEl.textContent = 'The AI returned an empty response. Please start again.'
      return
    }
    speakAsItStreams.flush(full)
    const { reply, correction } = parseModelTurn(full)
    appendBubble('assistant', reply)
    session.history.push({ role: 'assistant', content: full })
    session.transcript.push({ role: 'assistant', text: reply, correction })
    statusEl.textContent = ''
  })()
}

function parseModelTurn(full) {
  const replyMatch = full.match(/REPLY:\s*([\s\S]*?)(?:\nCORRECTION:|$)/)
  const correctionMatch = full.match(/CORRECTION:\s*([\s\S]*)$/)
  if (!replyMatch) {
    // Model didn't follow the format. Fail soft: treat everything as the reply.
    return { reply: full.trim(), correction: null }
  }
  return {
    reply: replyMatch[1].trim(),
    correction: correctionMatch ? correctionMatch[1].trim() : null,
  }
}

function pickJapaneseVoice() {
  const voices = speechSynthesis.getVoices?.() || []
  return voices.find(v => v.lang === 'ja-JP') || voices.find(v => v.lang?.startsWith('ja')) || null
}

function waitForJapaneseVoice(timeoutMs = 1000) {
  if (!('speechSynthesis' in window)) return Promise.resolve(null)
  const ready = pickJapaneseVoice()
  if (ready || speechSynthesis.getVoices().length) return Promise.resolve(ready)

  return new Promise((resolve) => {
    let settled = false
    const finish = () => {
      if (settled) return
      settled = true
      speechSynthesis.removeEventListener?.('voiceschanged', finish)
      resolve(pickJapaneseVoice())
    }
    speechSynthesis.addEventListener?.('voiceschanged', finish, { once: true })
    setTimeout(finish, timeoutMs)
  })
}

// -- Out-of-set word tracking ------------------------------------------------
//
// Heuristic only: forward maximum-match tokenization of the user's transcript
// against the 231-word surface forms (plus a small particle list), with no
// verb/adjective conjugation normalization. Inflected forms of core words
// (e.g. a conjugated form of a verb whose dictionary form is core) will be
// flagged as "out of set" even though they are legitimate uses of a core
// word. A real analyzer (MeCab-style) would fix this but is far too heavy
// for a static, dependency-free site. See the Build log in KAIWA-SPEC.md.

const KAIWA_PARTICLES = ['を', 'は', 'が', 'に', 'で', 'と', 'も', 'の', 'へ', 'から', 'まで', 'や', 'か', 'ね', 'よ', 'な', 'だ', 'です', 'ます', 'ました', 'ません', 'でした', 'たい', 'たら', 'ば', 'て']

function trackUserTurn(session, text) {
  if (text.length > session.longestSentence.length) session.longestSentence = text

  if (/[a-zA-Z]{3,}/.test(text)) session.englishSwitchCount++

  const coreForms = new Set(session.data.words.flatMap(w => [w.kanji, w.reading]).filter(Boolean))
  const dict = [...coreForms, ...KAIWA_PARTICLES].sort((a, b) => b.length - a.length)

  let i = 0
  const outside = []
  while (i < text.length) {
    const match = dict.find(w => text.startsWith(w, i))
    if (match) {
      i += match.length
    } else {
      // Collect a run of unmatched characters as one "outside" span.
      let j = i + 1
      while (j < text.length && !dict.some(w => text.startsWith(w, j))) j++
      outside.push(text.slice(i, j))
      i = j
    }
  }

  for (const word of outside) {
    if (!word.trim() || /^[。、！？\s]+$/.test(word)) continue
    session.outOfSet.push({ word })
  }

  session.transcript.push({ role: 'user', text })
}

// -- End of session: resolve paraphrases, persist, render summary -----------

async function resolveOutOfSet(outOfSet) {
  if (!outOfSet.length) return []
  let expressions
  try {
    expressions = await fetchKaiwaExpressions()
  } catch {
    return outOfSet.map(o => ({ ...o, paraphrase: null, real: null }))
  }
  return outOfSet.map(({ word }) => {
    const match = expressions.find(e => e.kanji.includes(word) || word.includes(e.kanji))
    if (!match) return { word, paraphrase: null, real: null }
    return {
      word,
      paraphrase: match.paraphrase,
      real: match.reading ? `${match.kanji}(${match.reading})` : match.kanji,
    }
  })
}

async function finishSession(root, session) {
  speechSynthesis.cancel()
  const resolved = await resolveOutOfSet(session.outOfSet)

  const summary = {
    date: new Date().toISOString(),
    turns: session.transcript.filter(t => t.role === 'user').length,
    longestSentence: session.longestSentence,
    abandonCount: session.abandonCount,
    englishSwitchCount: session.englishSwitchCount,
    correctionsCount: session.corrections.length,
  }
  if (session.cando) saveSessionSummary(session.cando.id, summary)

  const sentenceRows = session.transcript
    .filter(t => t.role === 'user')
    .map(t => `<li lang="ja">${escapeHtml(t.text)}</li>`).join('')

  const correctionRows = session.corrections.length
    ? session.corrections.map(c => `<li lang="ja">${escapeHtml(c)}</li>`).join('')
    : '<li>No corrections needed.</li>'

  const outOfSetRows = resolved.length
    ? resolved.map(o => `
        <li>
          <span lang="ja">${escapeHtml(o.word)}</span>
          ${o.paraphrase ? ` - try <span lang="ja">${escapeHtml(o.paraphrase)}</span>` : ' - no minihongo paraphrase found'}
          ${o.real ? ` (real word: <span lang="ja">${escapeHtml(o.real)}</span>, for recognition only)` : ''}
        </li>
      `).join('')
    : '<li>Stayed inside the core set.</li>'

  root.innerHTML = `
    <div class="kaiwa-summary">
      <h2>Session summary</h2>
      <p class="kaiwa-summary-headline">
        Abandoned or switched to English <strong>${session.abandonCount + session.englishSwitchCount}</strong> time(s).
      </p>
      <p>Longest finished sentence (${session.longestSentence.length} chars):</p>
      <p lang="ja" class="kaiwa-longest">${escapeHtml(session.longestSentence) || '(none)'}</p>

      <h3>What you said</h3>
      <ul class="kaiwa-sentence-list">${sentenceRows || '<li>(nothing recorded)</li>'}</ul>

      <h3>Corrections</h3>
      <ul class="kaiwa-correction-list">${correctionRows}</ul>

      <h3>Words outside the 231 - comprehension wide, production narrow</h3>
      <ul class="kaiwa-outofset-list">${outOfSetRows}</ul>

      <button id="kaiwa-again" class="kaiwa-primary">Practice again</button>
    </div>
  `

  root.querySelector('#kaiwa-again').addEventListener('click', () => {
    root.dataset.bound = ''
    window.initKaiwaPage()
  })
}
