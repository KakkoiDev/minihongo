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
const KAIWA_SPEECH_KEY_STORAGE = 'kaiwa_key_groq_speech'

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
  const topicSet = root.dataset.topicSet === 'engineering' ? 'engineering' : 'general'
  const visibleCandos = data.candos.filter(c => (
    topicSet === 'engineering'
      ? c.id.startsWith('cando-eng-')
      : !c.id.startsWith('cando-eng-')
  ))
  const savedProvider = localStorage.getItem(KAIWA_PROVIDER_STORAGE) || 'anthropic'
  const savedKey = localStorage.getItem(KAIWA_KEY_STORAGE[savedProvider]) || ''
  const savedSpeechKey = localStorage.getItem(KAIWA_SPEECH_KEY_STORAGE) || ''
  // Use capability detection, not a browser-name block. Mobile browsers can
  // change their speech support independently of their brand/version.
  const hasRecognition = !!(window.SpeechRecognition || window.webkitSpeechRecognition)
  const hasRecording = !!navigator.mediaDevices?.getUserMedia && 'MediaRecorder' in window

  const candoOptions = visibleCandos.map(c => `
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
      ${hasRecognition || (hasRecording && savedSpeechKey) ? '' : `
        <p class="kaiwa-warning">
          Chrome speech recognition is not available on this phone. Add a Groq speech
          key below to enable recorded voice input on this browser.
        </p>
      `}
      <p class="kaiwa-privacy">
        Your API key is stored only in this browser's local storage and sent only to the
        provider you pick, with every request. With reliable voice enabled, each short
        recording is sent directly to Groq for transcription. Without it, Chrome may
        send speech to Google's recognition service.
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

      <details class="kaiwa-details" id="kaiwa-speech-details" ${savedSpeechKey ? '' : 'open'}>
        <summary>Reliable voice input</summary>
        <div class="kaiwa-details-body">
          <p>For voice input that does not depend on Chrome speech recognition, add a Groq key. Audio is recorded only while you hold a speaking turn and sent to Groq Whisper for Japanese transcription.</p>
          <label class="kaiwa-field">
            <span>Groq speech API key</span>
            <input type="password" id="kaiwa-speech-key" autocomplete="off" spellcheck="false" placeholder="gsk_...">
          </label>
          <p class="kaiwa-key-hint">Get a key at <a href="https://console.groq.com/keys" target="_blank" rel="noopener">console.groq.com/keys</a></p>
        </div>
      </details>

      <details class="kaiwa-details" id="kaiwa-goal-details">
        <summary>Pick a goal <span class="kaiwa-optional">optional</span></summary>
        <div class="kaiwa-details-body">
          <div class="kaiwa-cando-list">
            <label class="kaiwa-cando">
              <input type="radio" name="kaiwa-cando" value="" checked>
              <span class="kaiwa-cando-text">
                <strong>${topicSet === 'engineering' ? 'Engineering conversation' : 'Free conversation'}</strong>
                <span>${topicSet === 'engineering' ? 'No specific task' : 'No specific goal'}</span>
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
  const speechKeyInput = root.querySelector('#kaiwa-speech-key')
  speechKeyInput.value = savedSpeechKey

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
    const speechApiKey = speechKeyInput.value.trim()
    const selectedGoal = root.querySelector('input[name="kaiwa-cando"]:checked')?.value || ''
    const cando = selectedGoal ? data.candos.find(c => c.id === selectedGoal) : null
    if (!apiKey) {
      statusEl.textContent = 'Enter an API key to start.'
      return
    }
    // Must happen synchronously inside the user's Start gesture on mobile.
    // Otherwise the first real utterance arrives only after the API request,
    // when Chrome may no longer allow the speech engine to start.
    primeSpeechSynthesis()
    localStorage.setItem(KAIWA_PROVIDER_STORAGE, providerId)
    localStorage.setItem(KAIWA_KEY_STORAGE[providerId], apiKey)
    if (speechApiKey) localStorage.setItem(KAIWA_SPEECH_KEY_STORAGE, speechApiKey)
    else localStorage.removeItem(KAIWA_SPEECH_KEY_STORAGE)
    startSession(root, data, { providerId, apiKey, speechApiKey, cando, hasRecognition, hasRecording, topicSet })
  })
}

function escapeHtml(s) {
  return String(s ?? '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]))
}

const furiganaPattern = () => /([一-龯々〆ヵヶ]+)[(（]([ぁ-ゖァ-ヺー]+)[)）]/g
const hasKanji = text => /[一-龯々〆ヵヶ]/.test(text)

function buildFuriganaEntries(words) {
  const entries = new Map()
  for (const word of words) {
    const surface = word.kanji || ''
    const reading = word.reading || ''
    if (!surface || !reading || surface === reading || !hasKanji(surface)) continue
    entries.set(surface, reading)

    // Include the kanji stem of words with okurigana: 話す/はなす becomes
    // 話/はな, so inflected forms such as 話します still receive furigana.
    let shared = 0
    while (
      shared < surface.length
      && shared < reading.length
      && surface.at(-1 - shared) === reading.at(-1 - shared)
      && /[ぁ-ゖァ-ヺー]/.test(surface.at(-1 - shared))
    ) shared++
    if (shared) {
      const stem = surface.slice(0, -shared)
      const stemReading = reading.slice(0, -shared)
      if (stem && stemReading && hasKanji(stem)) entries.set(stem, stemReading)
    }
  }
  return [...entries].map(([surface, reading]) => ({ surface, reading }))
    .sort((a, b) => b.surface.length - a.surface.length)
}

function appendRuby(el, surface, reading) {
  const ruby = document.createElement('ruby')
  const rt = document.createElement('rt')
  ruby.append(document.createTextNode(surface))
  rt.textContent = reading
  ruby.append(rt)
  el.append(ruby)
}

function appendJapaneseText(el, text, entries) {
  const source = String(text)
  let plain = ''
  const flushPlain = () => {
    if (!plain) return
    el.append(document.createTextNode(plain))
    plain = ''
  }

  for (let i = 0; i < source.length;) {
    const explicit = source.slice(i).match(/^([一-龯々〆ヵヶ]+)[(（]([ぁ-ゖァ-ヺー]+)[)）]/)
    if (explicit) {
      flushPlain()
      appendRuby(el, explicit[1], explicit[2])
      i += explicit[0].length
      continue
    }

    const entry = entries.find(item => source.startsWith(item.surface, i))
    if (entry) {
      flushPlain()
      appendRuby(el, entry.surface, entry.reading)
      i += entry.surface.length
      continue
    }

    plain += source[i]
    i++
  }
  flushPlain()
}

function textForSpeech(text) {
  // When the model writes 私(わたし), pronounce only わたし. Reading both the
  // kanji and its annotation produces the duplicated speech users heard.
  return String(text).replace(furiganaPattern(), '$2')
}

// -- System prompt ----------------------------------------------------------

function buildSystemPrompt(data, cando, topicSet = 'general') {
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
    : topicSet === 'engineering'
      ? 'Have a natural conversation between engineering colleagues. Discuss work, systems, incidents, demos, planning, requirements, debugging, reviews, deploys, or rollbacks.'
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
      <header class="kaiwa-session-header">
        <p class="kaiwa-goal">${opts.cando
          ? `<strong>${escapeHtml(opts.cando.english)}</strong><span lang="ja">${escapeHtml(opts.cando.japanese)}</span>`
          : opts.topicSet === 'engineering'
          ? '<strong>Engineering conversation</strong><span lang="ja">エンジニアの会話</span>'
          : '<strong>Free conversation</strong><span lang="ja">自由会話</span>'
        }</p>
        <button id="kaiwa-end">End</button>
      </header>
      <div class="kaiwa-transcript" id="kaiwa-transcript" role="log" aria-label="Conversation" aria-live="polite">
        <p class="kaiwa-empty" id="kaiwa-empty">Preparing your conversation…</p>
      </div>
      <div class="kaiwa-composer">
        <p class="kaiwa-live" id="kaiwa-live" aria-live="polite"></p>
        <div class="kaiwa-controls">
          <button id="kaiwa-mic" class="kaiwa-primary" ${opts.hasRecognition || (opts.hasRecording && opts.speechApiKey) ? '' : 'hidden'}>Speak</button>
          <form id="kaiwa-text-form">
            <input type="text" id="kaiwa-text-input" lang="ja" placeholder="Type, or use your keyboard microphone">
            <button type="submit">Send</button>
          </form>
          <button id="kaiwa-permission" type="button" ${opts.hasRecognition || (opts.hasRecording && opts.speechApiKey) ? '' : 'hidden'}>Enable microphone</button>
          <button id="kaiwa-retry" hidden>Try again</button>
        </div>
        <p class="kaiwa-status" id="kaiwa-session-status" role="status"></p>
        <details class="kaiwa-mic-help" id="kaiwa-mic-help" hidden>
          <summary>Microphone help</summary>
          <ol>
            <li>In Chrome, tap the icon beside the address, then Permissions, then allow Microphone.</li>
            <li>If it is still blocked, open Android Settings → Apps → Chrome → Permissions → Microphone → Allow.</li>
            <li>If Chrome can open the microphone but speech recognition fails, update or enable Google Speech Services.</li>
          </ol>
          <p>You can always use the microphone on your Japanese keyboard in the text box.</p>
        </details>
      </div>
    </div>
  `

  const transcriptEl = root.querySelector('#kaiwa-transcript')
  const furiganaEntries = buildFuriganaEntries(data.words)
  const liveEl = root.querySelector('#kaiwa-live')
  const micBtn = root.querySelector('#kaiwa-mic')
  const permissionBtn = root.querySelector('#kaiwa-permission')
  const retryBtn = root.querySelector('#kaiwa-retry')
  const endBtn = root.querySelector('#kaiwa-end')
  const statusEl = root.querySelector('#kaiwa-session-status')
  const micHelp = root.querySelector('#kaiwa-mic-help')
  const textForm = root.querySelector('#kaiwa-text-form')
  const textInput = root.querySelector('#kaiwa-text-input')

  const appendBubble = (role, text) => {
    root.querySelector('#kaiwa-empty')?.remove()

    const message = document.createElement('div')
    message.className = `kaiwa-message kaiwa-message-${role}`

    const p = document.createElement('p')
    p.className = `kaiwa-bubble kaiwa-bubble-${role}`
    p.lang = 'ja'
    if (role === 'assistant') appendJapaneseText(p, text, furiganaEntries)
    else p.textContent = text
    message.append(p)

    if (role === 'assistant') {
      const replay = document.createElement('button')
      replay.type = 'button'
      replay.className = 'kaiwa-replay play-btn'
      replay.setAttribute('aria-label', 'Listen again')
      replay.textContent = 'Listen again'
      replay.addEventListener('click', () => speak(text))
      message.append(replay)
    }

    transcriptEl.append(message)
    transcriptEl.scrollTop = transcriptEl.scrollHeight
  }

  // Chrome can expose an empty voice list on the first call while its speech
  // service is still loading. Wait briefly for voiceschanged so the opening
  // reply is not silently lost.
  const voiceReady = waitForJapaneseVoice()

  const speak = (text) => {
    const clean = textForSpeech(text).trim()
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

    const system = buildSystemPrompt(data, opts.cando, opts.topicSet)
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
  let wantsListening = false
  let listenDeadline = 0
  let restartTimer = null
  let micPermissionReady = false
  let micPermissionState = 'prompt'
  let requestingMicPermission = false
  let mediaRecorder = null
  let recordingStream = null
  let recordingTimer = null
  const LISTEN_WINDOW_MS = 30000

  const resetListeningUi = () => {
    micBtn.textContent = 'Speak'
    liveEl.textContent = ''
  }

  const finishListening = () => {
    wantsListening = false
    listening = false
    clearTimeout(restartTimer)
    clearTimeout(recordingTimer)
    restartTimer = null
    recordingTimer = null
    resetListeningUi()
  }

  const transcribeRecording = async (blob) => {
    statusEl.textContent = 'Transcribing your Japanese…'
    const form = new FormData()
    form.append('file', blob, blob.type.includes('ogg') ? 'speech.ogg' : 'speech.webm')
    form.append('model', 'whisper-large-v3-turbo')
    form.append('language', 'ja')
    form.append('response_format', 'json')

    const response = await fetch('https://api.groq.com/openai/v1/audio/transcriptions', {
      method: 'POST',
      headers: { authorization: `Bearer ${opts.speechApiKey}` },
      body: form,
    })
    if (!response.ok) {
      let detail = ''
      try { detail = (await response.json())?.error?.message || '' } catch {}
      throw new Error(`Voice transcription failed (${response.status}). ${detail}`.trim())
    }
    const result = await response.json()
    return String(result.text || '').trim()
  }

  const beginApiRecording = async (openStream) => {
    try {
      // Reuse the stream opened by the user's button press. Opening it once
      // for permission and immediately closing it made Android's green mic
      // indicator flash, and a second open could then fail on some phones.
      recordingStream = openStream
      const chunks = []
      mediaRecorder = new MediaRecorder(recordingStream)
      mediaRecorder.addEventListener('dataavailable', event => {
        if (event.data.size) chunks.push(event.data)
      })
      mediaRecorder.addEventListener('stop', async () => {
        const type = mediaRecorder.mimeType || 'audio/webm'
        recordingStream?.getTracks().forEach(track => track.stop())
        recordingStream = null
        finishListening()
        try {
          const text = await transcribeRecording(new Blob(chunks, { type }))
          if (!text) throw new Error('No speech was found in the recording.')
          liveEl.textContent = text
          await sendTurn(text)
        } catch (error) {
          retryBtn.hidden = false
          micHelp.hidden = false
          statusEl.textContent = error.message || 'Voice transcription failed. Try again.'
        }
      }, { once: true })
      window.speechSynthesis?.cancel?.()
      wantsListening = true
      retryBtn.hidden = true
      statusEl.textContent = 'Recording… Tap Stop when you finish speaking.'
      micBtn.textContent = 'Stop'
      mediaRecorder.start()
      recordingTimer = setTimeout(() => {
        if (mediaRecorder?.state === 'recording') mediaRecorder.stop()
      }, LISTEN_WINDOW_MS)
    } catch (error) {
      recordingStream?.getTracks().forEach(track => track.stop())
      recordingStream = null
      finishListening()
      permissionBtn.hidden = false
      micHelp.hidden = false
      micHelp.open = true
      statusEl.textContent = `Could not record audio (${error?.name || 'unknown error'}). Open Microphone help below.`
    }
  }

  const startRecognizer = () => {
    if (!wantsListening) return
    recognizer = setupRecognition()
    try {
      // Let Chrome own its microphone session. Holding a parallel
      // getUserMedia stream or passing its track to start() makes recognition
      // terminate immediately on some Android Chrome versions.
      recognizer.start()
      listening = true
      micBtn.textContent = 'Stop'
    } catch {
      finishListening()
      permissionBtn.hidden = false
      micHelp.hidden = false
      micHelp.open = true
      retryBtn.hidden = false
      statusEl.textContent = 'Could not start listening. Tap Enable microphone and allow access when your browser asks.'
    }
  }

  const requestMicPermission = async (keepStream = false) => {
    if (micPermissionReady && !keepStream) return true
    if (!navigator.mediaDevices?.getUserMedia) return true
    if (requestingMicPermission) return false

    requestingMicPermission = true
    micBtn.disabled = true
    micBtn.textContent = 'Enable microphone…'
    statusEl.textContent = 'Waiting for microphone permission…'
    try {
      // SpeechRecognition does not reliably trigger Chromium's permission UI
      // on mobile. getUserMedia does, and the stream is released immediately;
      // recognition owns the microphone after permission is granted.
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true })
      if (!keepStream) stream.getTracks().forEach(track => track.stop())
      micPermissionReady = true
      permissionBtn.hidden = true
      return keepStream ? stream : true
    } catch (error) {
      permissionBtn.hidden = false
      micHelp.hidden = false
      micHelp.open = true
      retryBtn.hidden = false
      if (error?.name === 'NotAllowedError') {
        micPermissionState = 'denied'
        permissionBtn.textContent = 'Microphone blocked — how to allow'
      }
      const micErrors = {
        NotAllowedError: 'Microphone permission is blocked in Chrome or Android settings.',
        NotFoundError: 'This phone did not report an available microphone.',
        NotReadableError: 'The microphone is busy or blocked by Android.',
        SecurityError: 'Chrome blocked microphone access for this page.',
      }
      statusEl.textContent = `${micErrors[error?.name] || 'Could not open the microphone.'} Open Microphone help below.`
      return false
    } finally {
      requestingMicPermission = false
      micBtn.disabled = false
      micBtn.textContent = 'Speak'
    }
  }

  const beginListening = async () => {
    const useApiRecording = !!opts.speechApiKey && 'MediaRecorder' in window
    // MediaRecorder reuses the open stream. Chrome SpeechRecognition must own
    // the microphone itself, so its permission-check stream is released first.
    const permission = await requestMicPermission(useApiRecording)
    if (!permission) return
    if (useApiRecording) {
      await beginApiRecording(permission)
      return
    }
    // Do not let the assistant's voice compete with the user's microphone.
    window.speechSynthesis?.cancel?.()
    hadInterim = false
    wantsListening = true
    listenDeadline = Date.now() + LISTEN_WINDOW_MS
    liveEl.textContent = ''
    retryBtn.hidden = true
    statusEl.textContent = 'Listening…'
    startRecognizer()
  }

  const setupRecognition = () => {
    const Recognition = window.SpeechRecognition || window.webkitSpeechRecognition
    const r = new Recognition()
    r.lang = 'ja-JP'
    r.continuous = false
    r.interimResults = true

    r.onresult = (e) => {
      if (r !== recognizer) return
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
        finishListening()
        r.stop()
        retryBtn.hidden = true
        sendTurn(finalText.trim())
      }
    }

    r.onerror = (event) => {
      if (r !== recognizer) return
      listening = false
      // Chrome commonly ends a recognition attempt after about six seconds of
      // silence. Keep the same user-initiated listening turn alive instead of
      // treating that browser timeout as a failed conversation turn.
      if (event.error === 'no-speech' && wantsListening && Date.now() < listenDeadline) return
      if (event.error === 'aborted' && !wantsListening) return

      finishListening()
      if (hadInterim) session.abandonCount++
      retryBtn.hidden = false
      if (event.error === 'not-allowed') {
        micPermissionState = 'denied'
        permissionBtn.hidden = false
        permissionBtn.textContent = 'Microphone blocked — how to allow'
        micHelp.hidden = false
        micHelp.open = true
        statusEl.textContent = 'Chrome refused speech recognition. Open Microphone help below.'
      } else if (event.error === 'network' || event.error === 'service-not-allowed') {
        // Preserve the microphone control: a temporary mobile network/service
        // failure must not permanently remove audio input from the session.
        textForm.hidden = false
        micHelp.hidden = false
        micHelp.open = true
        statusEl.textContent = `Chrome speech service failed (${event.error}). Try again, or use your keyboard microphone.`
      } else {
        statusEl.textContent = 'Could not hear you. Try again.'
      }
    }

    r.onend = () => {
      if (r !== recognizer) return
      listening = false
      if (!wantsListening) return
      if (Date.now() >= listenDeadline) {
        finishListening()
        retryBtn.hidden = false
        statusEl.textContent = 'No speech heard. Tap Try again when you are ready.'
        return
      }
      clearTimeout(restartTimer)
      restartTimer = setTimeout(startRecognizer, 150)
    }

    return r
  }

  micBtn?.addEventListener('click', () => {
    if (wantsListening) {
      if (mediaRecorder?.state === 'recording') {
        mediaRecorder.stop()
        return
      }
      finishListening()
      recognizer?.stop()
      return
    }
    beginListening()
  })

  permissionBtn.addEventListener('click', () => {
    if (micPermissionState === 'denied') {
      micHelp.hidden = false
      micHelp.open = true
      statusEl.textContent = 'Chrome will not ask again after Block was selected. Follow Microphone help below, then return and tap Speak.'
      micHelp.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
      return
    }
    beginListening()
  })

  // Show permission help before the first failed recording when the browser
  // exposes its current microphone permission state.
  navigator.permissions?.query({ name: 'microphone' }).then((permission) => {
    const updatePermissionUi = () => {
      // A "granted" query result is not proof that the microphone can open.
      // Only a successful getUserMedia call marks it ready. This avoids
      // bypassing the real device check on mobile Chromium.
      if (permission.state !== 'granted') micPermissionReady = false
      micPermissionState = permission.state
      permissionBtn.hidden = permission.state === 'granted'
      permissionBtn.textContent = permission.state === 'denied'
        ? 'Microphone blocked — how to allow'
        : 'Enable microphone'
      if (permission.state === 'denied') {
        micHelp.hidden = false
      }
    }
    updatePermissionUi()
    permission.addEventListener?.('change', updatePermissionUi)
  }).catch(() => {})

  retryBtn.addEventListener('click', () => {
    finishListening()
    recognizer?.abort()
    session.abandonCount++
    beginListening()
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
    const system = buildSystemPrompt(data, opts.cando, opts.topicSet)
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

function primeSpeechSynthesis() {
  if (!('speechSynthesis' in window) || !('SpeechSynthesisUtterance' in window)) return
  speechSynthesis.cancel()
  const primer = new SpeechSynthesisUtterance('\u200b')
  primer.lang = 'ja-JP'
  primer.volume = 0
  speechSynthesis.speak(primer)
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
