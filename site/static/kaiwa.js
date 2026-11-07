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
const KAIWA_SPEECH_MODE_STORAGE = 'kaiwa_speech_mode'
const KAIWA_STYLE_STORAGE = 'kaiwa_conversation_style'
// Provider id whose saved key arrived through an invite link (key-share.js)
const KAIWA_SHARED_STORAGE = 'kaiwa_shared_key'
const KAIWA_SHARED_EXP_STORAGE = 'kaiwa_shared_exp' // ms timestamp, absent = no expiry
const KAIWA_SHARED_SPEECH_STORAGE = 'kaiwa_shared_speech' // '1' if the Groq key came shared too

// Step-by-step "how do I get a key" guides, shown under the key field for
// the selected provider. Console layouts change; keep steps short and generic.
// Step text lives in kaiwa-i18n.js as guide_<provider>_<n>.
const KAIWA_KEY_GUIDES = {
  anthropic: { site: 'https://console.anthropic.com/', steps: 4 },
  openai: { site: 'https://platform.openai.com/', steps: 4 },
  deepseek: { site: 'https://platform.deepseek.com/', steps: 4 },
}

const t = (key, vars) => window.kaiwaT(key, vars)

function kaiwaLang() {
  return document.getElementById('kaiwa-app')?.dataset.lang || 'en'
}

// The learner-facing label of a can-do / expression row for this edition.
function learnerText(item) {
  const lang = kaiwaLang()
  if (lang === 'ko') return item?.korean || item?.english || ''
  if (lang === 'ja' || lang === 'mh') return item?.japanese || item?.english || ''
  return item?.english || ''
}

// Secondary (Japanese) line under a learner-facing label: the natural
// Japanese for en/ko, the Minihongo wording for ja/mh. Empty when it would
// just repeat the main label.
function learnerSubText(item) {
  const lang = kaiwaLang()
  const sub = (lang === 'ja' || lang === 'mh') ? (item?.kanji || '') : (item?.japanese || '')
  return sub && sub !== learnerText(item) ? sub : ''
}

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

  root.innerHTML = `<p class="kaiwa-loading">${escapeHtml(t('loading'))}</p>`
  let data
  try {
    data = await fetchKaiwaData()
  } catch {
    root.innerHTML = `<p class="kaiwa-error">${escapeHtml(t('data_load_error'))}</p>`
    return
  }

  const expired = expireSharedKey()
  renderPicker(root, data)
  if (expired) root.querySelector('#kaiwa-setup-status').textContent = t('shared_key_expired')
}

// A key unlocked from an invite link carries an expiry (kaiwa_shared_exp).
// Delete it once that passes. App-enforced only: it stops casual reuse, while
// revoking the key in the provider's console is what actually cuts access.
function expireSharedKey() {
  const provider = localStorage.getItem(KAIWA_SHARED_STORAGE)
  const exp = Number(localStorage.getItem(KAIWA_SHARED_EXP_STORAGE) || 0)
  if (!provider || !exp || Date.now() < exp) return false
  forgetSharedKey(provider)
  return true
}

function forgetSharedKey(provider) {
  if (KAIWA_KEY_STORAGE[provider]) localStorage.removeItem(KAIWA_KEY_STORAGE[provider])
  if (localStorage.getItem(KAIWA_SHARED_SPEECH_STORAGE)) localStorage.removeItem(KAIWA_SPEECH_KEY_STORAGE)
  for (const k of [KAIWA_SHARED_STORAGE, KAIWA_SHARED_EXP_STORAGE, KAIWA_SHARED_SPEECH_STORAGE]) localStorage.removeItem(k)
}

// -- Screen 1: settings + can-do picker ------------------------------------

function loadHistory() {
  try { return JSON.parse(localStorage.getItem(KAIWA_HISTORY_STORAGE) || '{}') }
  catch { return {} }
}

function saveSessionSummary(candoId, summary) {
  const all = loadHistory()
  const key = candoId || 'free'
  all[key] = all[key] || []
  all[key].push(summary)
  localStorage.setItem(KAIWA_HISTORY_STORAGE, JSON.stringify(all))
}

function frequentMistakes(history, limit = 5, topicSet = null) {
  const counts = new Map()
  for (const [historyKey, sessions] of Object.entries(history)) {
    if (!Array.isArray(sessions)) continue
    for (const session of sessions) {
      const sessionTopic = session.topicSet
        || (historyKey.startsWith('cando-eng-') ? 'engineering' : 'general')
      if (topicSet && sessionTopic !== topicSet) continue
      for (const mistake of session.mistakes || []) {
        if (!mistake?.corrected) continue
        const key = `${mistake.original || ''}\n${mistake.corrected}`
        const previous = counts.get(key) || { ...mistake, count: 0 }
        previous.count++
        counts.set(key, previous)
      }
    }
  }
  return [...counts.values()]
    .sort((a, b) => b.count - a.count)
    .slice(0, limit)
}

function candoBadge(history, candoId) {
  const sessions = history[candoId]
  if (!sessions || !sessions.length) return t('badge_not_attempted')
  const last = sessions[sessions.length - 1]
  return t(sessions.length > 1 ? 'badge_sessions_many' : 'badge_sessions_one', {
    count: sessions.length,
    chars: last.longestSentence.length,
  })
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
  // Like Echo: Auto (browser recognition, then Groq Whisper) unless the learner chose one
  const savedSpeechMode = localStorage.getItem(KAIWA_SPEECH_MODE_STORAGE) || 'auto'
  const savedStyle = localStorage.getItem(KAIWA_STYLE_STORAGE) || 'conversation'
  // Use capability detection, not a browser-name block. Mobile browsers can
  // change their speech support independently of their brand/version.
  const hasRecognition = !!(window.SpeechRecognition || window.webkitSpeechRecognition)
  const hasRecording = !!navigator.mediaDevices?.getUserMedia && 'MediaRecorder' in window

  const candoOptions = visibleCandos.map(c => {
    const sub = learnerSubText(c)
    return `
    <label class="kaiwa-cando">
      <input type="radio" name="kaiwa-cando" value="${c.id}">
      <span class="kaiwa-cando-text">
        <strong>${escapeHtml(learnerText(c))}</strong>
        ${sub ? `<span lang="ja">${escapeHtml(sub)}</span>` : ''}
        <span class="kaiwa-cando-badge">${escapeHtml(candoBadge(history, c.id))}</span>
      </span>
    </label>
  `
  }).join('')

  // Provider names only: model versions change too often to show in the UI.
  // Each provider file owns its label and model id.
  const providerLabels = Object.fromEntries(
    ['anthropic', 'openai', 'deepseek'].map(id => [id, window.KaiwaProviders[id]?.label || id]),
  )
  const providerRadios = Object.keys(providerLabels).map(id => `
    <label class="kaiwa-provider-opt">
      <input type="radio" name="kaiwa-provider" value="${id}" ${id === savedProvider ? 'checked' : ''}>
      <span>${providerLabels[id]}</span>
    </label>
  `).join('')

  root.innerHTML = `
    <div class="kaiwa-setup">
      <details class="kaiwa-details" id="kaiwa-provider-details" ${savedKey ? '' : 'open'}>
        <summary>${t('provider_summary')}</summary>
        <div class="kaiwa-details-body">
          <fieldset class="kaiwa-field">
            <legend>${t('provider_legend')}</legend>
            ${providerRadios}
          </fieldset>

          <label class="kaiwa-field">
            <span>${t('api_key_label')}</span>
            <input type="password" id="kaiwa-api-key" autocomplete="off" spellcheck="false">
          </label>
          <p class="kaiwa-key-hint" id="kaiwa-key-hint"></p>
          <details class="kaiwa-key-guide" id="kaiwa-key-guide" ${savedKey ? '' : 'open'}>
            <summary>${t('key_guide_summary')}</summary>
            <p>${t('key_guide_intro')}</p>
            <ol id="kaiwa-key-steps"></ol>
            <p class="kaiwa-key-privacy">${t('key_guide_privacy')}</p>
          </details>
        </div>
      </details>

      <details class="kaiwa-details" id="kaiwa-speech-details">
        <summary id="kaiwa-speech-summary">${t('voice_summary', { name: voiceName(savedSpeechMode) })}</summary>
        <div class="kaiwa-details-body">
          <fieldset class="kaiwa-field">
            <legend class="visually-hidden">${t('voice_legend')}</legend>
            <label class="kaiwa-provider-opt">
              <input type="radio" name="kaiwa-speech-mode" value="auto" ${savedSpeechMode === 'auto' ? 'checked' : ''}>
              <span>${t('voice_auto')} <small>${t('voice_auto_note')}</small></span>
            </label>
            <label class="kaiwa-provider-opt">
              <input type="radio" name="kaiwa-speech-mode" value="browser" ${savedSpeechMode === 'browser' ? 'checked' : ''}>
              <span>Google <small>${t('voice_google_note')}</small></span>
            </label>
            <label class="kaiwa-provider-opt">
              <input type="radio" name="kaiwa-speech-mode" value="groq" ${savedSpeechMode === 'groq' ? 'checked' : ''}>
              <span>Groq <small>${t('voice_groq_note')}</small></span>
            </label>
          </fieldset>
          <label class="kaiwa-field" id="kaiwa-speech-key-field">
            <span>${t('groq_key_label')}</span>
            <input type="password" id="kaiwa-speech-key" autocomplete="off" spellcheck="false" placeholder="gsk_...">
          </label>
          <p class="kaiwa-key-hint" id="kaiwa-speech-key-hint">${t('groq_key_hint')}</p>
          <p class="kaiwa-status" id="kaiwa-speech-status"></p>
        </div>
      </details>

      <details class="kaiwa-details" id="kaiwa-style-details">
        <summary id="kaiwa-style-summary">${t('style_summary', { name: t(savedStyle === 'tutor' ? 'style_tutor' : 'style_conversation') })}</summary>
        <div class="kaiwa-details-body">
          <fieldset class="kaiwa-field kaiwa-style-field">
            <legend class="visually-hidden">${t('style_legend')}</legend>
            <label class="kaiwa-provider-opt">
              <input type="radio" name="kaiwa-style" value="conversation" ${savedStyle === 'conversation' ? 'checked' : ''}>
              <span>${t('style_conversation')}</span>
            </label>
            <label class="kaiwa-provider-opt">
              <input type="radio" name="kaiwa-style" value="tutor" ${savedStyle === 'tutor' ? 'checked' : ''}>
              <span>${t('style_tutor')} <small>${t('style_tutor_note')}</small></span>
            </label>
          </fieldset>
        </div>
      </details>

      <details class="kaiwa-details" id="kaiwa-goal-details">
        <summary id="kaiwa-goal-summary">${t('topic_summary', { name: t(topicSet === 'engineering' ? 'topic_engineering' : 'topic_free') })}</summary>
        <div class="kaiwa-details-body">
          <fieldset class="kaiwa-cando-list" id="kaiwa-goal-fieldset">
            <label class="kaiwa-cando">
              <input type="radio" name="kaiwa-cando" value="" checked>
              <span class="kaiwa-cando-text">
                <strong>${t(topicSet === 'engineering' ? 'goal_engineering_title' : 'goal_free_title')}</strong>
                <span>${t(topicSet === 'engineering' ? 'goal_engineering_sub' : 'goal_free_sub')}</span>
              </span>
            </label>
            ${candoOptions}
          </fieldset>
        </div>
      </details>

      <button id="kaiwa-start" class="kaiwa-primary" disabled>${t('start')}</button>
      <p class="kaiwa-status" id="kaiwa-setup-status"></p>
    </div>
  `

  const keyInput = root.querySelector('#kaiwa-api-key')
  const startBtn = root.querySelector('#kaiwa-start')
  const statusEl = root.querySelector('#kaiwa-setup-status')
  const keyHint = root.querySelector('#kaiwa-key-hint')
  const providerDetails = root.querySelector('#kaiwa-provider-details')
  const speechKeyInput = root.querySelector('#kaiwa-speech-key')
  const speechKeyField = root.querySelector('#kaiwa-speech-key-field')
  const speechKeyHint = root.querySelector('#kaiwa-speech-key-hint')
  const speechStatus = root.querySelector('#kaiwa-speech-status')
  const speechSummary = root.querySelector('#kaiwa-speech-summary')
  const styleSummary = root.querySelector('#kaiwa-style-summary')
  const goalSummary = root.querySelector('#kaiwa-goal-summary')
  const goalDetails = root.querySelector('#kaiwa-goal-details')
  const goalFieldset = root.querySelector('#kaiwa-goal-fieldset')
  speechKeyInput.value = savedSpeechKey

  root.querySelectorAll('input[name="kaiwa-speech-mode"]').forEach(radio => {
    radio.addEventListener('change', () => {
      if (!radio.checked) return
      localStorage.setItem(KAIWA_SPEECH_MODE_STORAGE, radio.value)
      // The Groq key field stays visible in every mode (Auto uses it as fallback)
      speechSummary.textContent = t('voice_summary', { name: voiceName(radio.value) })
      validate()
    })
  })

  const currentProvider = () => root.querySelector('input[name="kaiwa-provider"]:checked').value
  const currentSpeechMode = () => root.querySelector('input[name="kaiwa-speech-mode"]:checked')?.value || 'auto'
  const currentTutorMode = () => root.querySelector('input[name="kaiwa-style"]:checked')?.value === 'tutor'

  const updateGoalSummary = () => {
    const selectedGoal = root.querySelector('input[name="kaiwa-cando"]:checked')?.value || ''
    const cando = selectedGoal ? data.candos.find(c => c.id === selectedGoal) : null
    goalSummary.textContent = t('topic_summary', {
      name: cando
        ? learnerText(cando)
        : t(currentTutorMode()
          ? 'topic_automatic'
          : topicSet === 'engineering' ? 'topic_engineering' : 'topic_free'),
    })
  }

  const updateGoalAvailability = () => {
    const automatic = currentTutorMode()
    if (automatic) {
      root.querySelector('input[name="kaiwa-cando"][value=""]').checked = true
      goalDetails.open = false
    }
    goalFieldset.disabled = automatic
    goalDetails.classList.toggle('is-disabled', automatic)
    goalDetails.setAttribute('aria-disabled', String(automatic))
    updateGoalSummary()
  }

  goalDetails.querySelector('summary').addEventListener('click', event => {
    if (currentTutorMode()) event.preventDefault()
  })

  const refreshKeyField = () => {
    const providerId = currentProvider()
    const provider = window.KaiwaProviders[providerId]
    keyInput.value = localStorage.getItem(KAIWA_KEY_STORAGE[providerId]) || ''
    if (!keyInput.value) providerDetails.open = true
    keyInput.placeholder = provider.keyHint
    keyHint.innerHTML = t('key_have_account', {
      link: `<a href="${provider.keyHelpUrl}" target="_blank" rel="noopener">${provider.keyHelpUrl.replace(/^https:\/\//, '')}</a>`,
    })
    // A key unlocked from an invite link: say so, and make it easy to drop
    if (keyInput.value && localStorage.getItem(KAIWA_SHARED_STORAGE) === providerId) {
      const exp = Number(localStorage.getItem(KAIWA_SHARED_EXP_STORAGE) || 0)
      const badge = exp
        ? t('shared_key_badge_until', { date: new Date(exp).toLocaleDateString(document.documentElement.lang) })
        : t('shared_key_badge')
      keyHint.innerHTML = `${escapeHtml(badge)} <button type="button" class="kaiwa-link-btn" id="kaiwa-shared-remove">${escapeHtml(t('shared_key_remove'))}</button>`
      keyHint.querySelector('#kaiwa-shared-remove').addEventListener('click', () => {
        forgetSharedKey(providerId)
        refreshKeyField()
      })
    }
    const guide = KAIWA_KEY_GUIDES[providerId]
    root.querySelector('#kaiwa-key-steps').innerHTML = guide
      ? Array.from({ length: guide.steps }, (_, i) => `<li>${t(`guide_${providerId}_${i + 1}`)}</li>`).join('')
      : ''
    validate()
  }

  const validate = () => {
    const speechMode = currentSpeechMode()
    const missingChatKey = !keyInput.value.trim()
    const hasGroqKey = !!speechKeyInput.value.trim()
    const missingGroqKey = speechMode === 'groq' && !hasGroqKey
    const unavailableGoogle = speechMode === 'browser' && !hasRecognition
    // Auto with no browser recognition and no Groq key: typing still works, so
    // allow Start, but say how to get voice input.
    const autoWithoutVoice = speechMode === 'auto' && !hasRecognition && !hasGroqKey
    startBtn.disabled = missingChatKey || missingGroqKey || unavailableGoogle
    speechStatus.textContent = missingGroqKey
      ? t('groq_key_missing')
      : unavailableGoogle
        ? t('google_unavailable')
        : autoWithoutVoice
          ? t('auto_needs_groq')
          : ''
  }

  root.querySelectorAll('input[name="kaiwa-provider"]').forEach(r => r.addEventListener('change', () => {
    localStorage.setItem(KAIWA_PROVIDER_STORAGE, currentProvider())
    refreshKeyField()
  }))
  root.querySelectorAll('input[name="kaiwa-cando"]').forEach(r => r.addEventListener('change', () => {
    updateGoalSummary()
    validate()
  }))
  root.querySelectorAll('input[name="kaiwa-style"]').forEach(radio => {
    radio.addEventListener('change', () => {
      if (!radio.checked) return
      styleSummary.textContent = t('style_summary', { name: t(radio.value === 'tutor' ? 'style_tutor' : 'style_conversation') })
      localStorage.setItem(KAIWA_STYLE_STORAGE, radio.value)
      updateGoalAvailability()
    })
  })
  // Save keys as they are typed, so the invite dialog and the next visit see
  // them without the learner having to press Start first.
  const saveTypedKey = (storageKey, value) => {
    if (value) localStorage.setItem(storageKey, value)
    else localStorage.removeItem(storageKey)
  }
  keyInput.addEventListener('input', () => {
    const providerId = currentProvider()
    const value = keyInput.value.trim()
    if (localStorage.getItem(KAIWA_SHARED_STORAGE) === providerId
      && localStorage.getItem(KAIWA_KEY_STORAGE[providerId]) !== value) {
      // Edited a shared key: it is now the learner's own
      for (const k of [KAIWA_SHARED_STORAGE, KAIWA_SHARED_EXP_STORAGE]) localStorage.removeItem(k)
    }
    saveTypedKey(KAIWA_KEY_STORAGE[providerId], value)
    localStorage.setItem(KAIWA_PROVIDER_STORAGE, providerId)
    validate()
  })
  speechKeyInput.addEventListener('input', () => {
    const value = speechKeyInput.value.trim()
    if (localStorage.getItem(KAIWA_SPEECH_KEY_STORAGE) !== value) localStorage.removeItem(KAIWA_SHARED_SPEECH_STORAGE)
    saveTypedKey(KAIWA_SPEECH_KEY_STORAGE, value)
    validate()
  })

  refreshKeyField()
  updateGoalAvailability()

  // Linked from a real-life goal on the Practice page (?goal=cando-…):
  // preselect it. Tutor mode picks its own topic, so a chosen goal switches
  // the style back to conversation.
  const linkedGoal = new URLSearchParams(location.search).get('goal')
  const goalRadio = linkedGoal
    && [...root.querySelectorAll('input[name="kaiwa-cando"]')].find(r => r.value === linkedGoal)
  if (goalRadio) {
    if (currentTutorMode()) {
      const conversation = root.querySelector('input[name="kaiwa-style"][value="conversation"]')
      conversation.checked = true
      conversation.dispatchEvent(new Event('change'))
    }
    goalRadio.checked = true
    updateGoalSummary()
    validate()
    // Drop ?goal= so a reload or a shared address shows the setup again
    const url = new URL(location.href)
    url.searchParams.delete('goal')
    window.history.replaceState(window.history.state, '', url.pathname + url.search + url.hash)
    // Every key this setup needs is already saved: skip setup and open the
    // conversation on that goal right away. Deferred until the rest of this
    // function has bound the Start handler.
    queueMicrotask(() => { if (!startBtn.disabled) startBtn.click() })
  }

  startBtn.addEventListener('click', () => {
    const providerId = currentProvider()
    const apiKey = keyInput.value.trim()
    const speechApiKey = speechKeyInput.value.trim()
    const speechMode = currentSpeechMode()
    const tutorMode = currentTutorMode()
    const selectedGoal = root.querySelector('input[name="kaiwa-cando"]:checked')?.value || ''
    const cando = selectedGoal ? data.candos.find(c => c.id === selectedGoal) : null
    if (!apiKey) {
      statusEl.textContent = t('enter_api_key')
      return
    }
    if (speechMode === 'groq' && !speechApiKey) {
      speechStatus.textContent = t('groq_key_missing')
      root.querySelector('#kaiwa-speech-details').open = true
      return
    }
    // Must happen synchronously inside the user's Start gesture on mobile.
    // Otherwise the first real utterance arrives only after the API request,
    // when Chrome may no longer allow the speech engine to start.
    primeSpeechSynthesis()
    localStorage.setItem(KAIWA_PROVIDER_STORAGE, providerId)
    // The page may have stayed open past the shared key's expiry
    if (expireSharedKey()) {
      statusEl.textContent = t('shared_key_expired')
      keyInput.value = ''
      validate()
      return
    }
    if (localStorage.getItem(KAIWA_SHARED_STORAGE) === providerId
      && localStorage.getItem(KAIWA_KEY_STORAGE[providerId]) !== apiKey) {
      // Replaced with their own key: it is no longer the shared one
      for (const k of [KAIWA_SHARED_STORAGE, KAIWA_SHARED_EXP_STORAGE]) localStorage.removeItem(k)
    }
    localStorage.setItem(KAIWA_KEY_STORAGE[providerId], apiKey)
    if (speechApiKey) localStorage.setItem(KAIWA_SPEECH_KEY_STORAGE, speechApiKey)
    else localStorage.removeItem(KAIWA_SPEECH_KEY_STORAGE)
    localStorage.setItem(KAIWA_SPEECH_MODE_STORAGE, speechMode)
    localStorage.setItem(KAIWA_STYLE_STORAGE, tutorMode ? 'tutor' : 'conversation')
    startSession(root, data, {
      providerId,
      apiKey,
      speechApiKey: speechMode === 'browser' ? '' : speechApiKey,
      speechMode,
      cando,
      hasRecognition,
      hasRecording,
      topicSet,
      tutorMode,
      tutorFocus: tutorMode ? frequentMistakes(history, 5, topicSet) : [],
    })
  })
}

function voiceName(mode) {
  return mode === 'groq' ? 'Groq' : mode === 'browser' ? 'Google' : t('voice_auto')
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

function buildSystemPrompt(data, cando, topicSet = 'general', tutorFocus = []) {
  const wordList = data.words.map(w => (
    w.kanji === w.reading ? w.kanji : `${w.kanji}(${w.reading})`
  ) + `=${w.english}`).join(', ')

  const tutorInstruction = tutorFocus === null
    ? 'Do not deliberately drill past mistakes; keep the conversation natural.'
    : tutorFocus.length
      ? `Act as a subtle tutor. Repeatedly create natural opportunities for the learner to retry these frequent past mistakes, prioritizing the highest count:\n${tutorFocus.map(m => `- ${m.original || '(unknown)'} -> ${m.corrected} (${m.count} time(s))`).join('\n')}`
      : 'Act as a subtle tutor. There is no saved mistake history yet, so notice recurring errors during this session and create natural opportunities to retry them.'

  return `You are a Japanese conversation partner for a spoken-practice exercise called Minihongo.

RULES (follow every one, every turn):
1. Reply using ONLY the following 231 words, plus proper nouns and numbers. Combine them to
   express anything else (e.g. word-for-word "body help place" for "hospital"). Never switch
   to English or any other language.
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
7. ${tutorInstruction}

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
    mistakes: [],
    outOfSet: [], // {word}
    longestSentence: '',
    abandonCount: 0,
    englishSwitchCount: 0,
  }

  const goalHeader = (title, sub) => (
    `<strong>${escapeHtml(title)}</strong>${sub && sub !== title ? `<span lang="ja">${escapeHtml(sub)}</span>` : ''}`
  )
  const fixedGoalSub = opts.topicSet === 'engineering' ? 'エンジニアの会話' : '自由会話'
  const showsJapaneseTitle = ['ja', 'mh'].includes(kaiwaLang())

  root.innerHTML = `
    <div class="kaiwa-session">
      <header class="kaiwa-session-header">
        <p class="kaiwa-goal">${opts.cando
          ? goalHeader(learnerText(opts.cando), learnerSubText(opts.cando))
          : goalHeader(
            t(opts.topicSet === 'engineering' ? 'goal_engineering_title' : 'goal_free_title'),
            showsJapaneseTitle ? '' : fixedGoalSub,
          )
        }</p>
        <button id="kaiwa-end">${t('end')}</button>
      </header>
      <div class="kaiwa-transcript" id="kaiwa-transcript" role="log" aria-label="${escapeHtml(t('transcript_label'))}" aria-live="polite">
        <p class="kaiwa-empty" id="kaiwa-empty">${t('preparing')}</p>
      </div>
      <div class="kaiwa-composer">
        <p class="kaiwa-live" id="kaiwa-live" aria-live="polite"></p>
        <div class="kaiwa-controls">
          <button id="kaiwa-mic" class="kaiwa-primary" ${opts.hasRecognition || (opts.hasRecording && opts.speechApiKey) ? '' : 'hidden'}>${t('speak')}</button>
          <form id="kaiwa-text-form">
            <input type="text" id="kaiwa-text-input" lang="ja" placeholder="${escapeHtml(t('text_placeholder'))}">
            <button type="submit">${t('send')}</button>
          </form>
          <button id="kaiwa-permission" type="button" ${opts.hasRecognition || (opts.hasRecording && opts.speechApiKey) ? '' : 'hidden'}>${t('enable_mic')}</button>
          <button id="kaiwa-retry" hidden>${t('try_again')}</button>
        </div>
        <p class="kaiwa-status" id="kaiwa-session-status" role="status"></p>
        <details class="kaiwa-mic-help" id="kaiwa-mic-help" hidden>
          <summary>${t('mic_help_summary')}</summary>
          <ol>
            <li>${t('mic_help_1')}</li>
            <li>${t('mic_help_2')}</li>
            <li>${t('mic_help_3')}</li>
          </ol>
          <p>${t('mic_help_keyboard')}</p>
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
      replay.setAttribute('aria-label', t('listen_again'))
      replay.textContent = t('listen_again')
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
    statusEl.textContent = t('thinking')

    appendBubble('user', userText)
    trackUserTurn(session, userText)
    session.history.push({ role: 'user', content: userText })

    const system = buildSystemPrompt(data, opts.cando, opts.topicSet, opts.tutorMode ? opts.tutorFocus : null)
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
      statusEl.textContent = err.message || t('provider_error')
      micBtn.disabled = false
      textInput.disabled = false
      return
    }

    if (!full.trim()) {
      statusEl.textContent = t('empty_reply_retry')
      micBtn.disabled = false
      textInput.disabled = false
      return
    }
    speakAsItStreams.flush(full)
    const { reply, correction } = parseModelTurn(full)
    appendBubble('assistant', reply)
    session.history.push({ role: 'assistant', content: full })
    session.transcript.push({ role: 'assistant', text: reply, correction })
    if (correction && correction !== 'NONE') {
      session.corrections.push(correction)
      session.mistakes.push({ original: userText, corrected: correction })
    }

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
  // End-of-speech detection for recorded (Groq) input, as in Echo: watch the
  // microphone level and stop once the learner has spoken and then gone quiet.
  // Learners pause to find words, so the quiet gap is a little longer than
  // Echo's 900 ms. Browser recognition ends on its own and needs none of this.
  const SPEECH_LEVEL = 0.025 // RMS of the waveform, Echo's threshold
  const END_OF_SPEECH_MS = 1200
  const NOTHING_HEARD_MS = 8000
  let levelWatch = null // { ctx, source, raf, heard }
  const stopLevelWatch = () => {
    if (!levelWatch) return
    cancelAnimationFrame(levelWatch.raf)
    try { levelWatch.source.disconnect() } catch {}
    levelWatch.ctx.close().catch(() => {})
    levelWatch = null
  }
  const watchLevel = (stream, onDone) => {
    const AudioCtx = window.AudioContext || window.webkitAudioContext
    if (!AudioCtx) return
    const ctx = new AudioCtx()
    const source = ctx.createMediaStreamSource(stream)
    const analyser = ctx.createAnalyser()
    analyser.fftSize = 512
    source.connect(analyser)
    const data = new Uint8Array(analyser.fftSize)
    const started = performance.now()
    let lastSound = started
    levelWatch = { ctx, source, raf: 0, heard: false }
    const tick = () => {
      if (!levelWatch) return
      analyser.getByteTimeDomainData(data)
      let sum = 0
      for (const v of data) { const x = (v - 128) / 128; sum += x * x }
      const now = performance.now()
      if (Math.sqrt(sum / data.length) > SPEECH_LEVEL) { levelWatch.heard = true; lastSound = now }
      const quietAfterSpeech = levelWatch.heard && now - lastSound > END_OF_SPEECH_MS
      const nothingHeard = !levelWatch.heard && now - started > NOTHING_HEARD_MS
      if (quietAfterSpeech || nothingHeard) { onDone(); return }
      levelWatch.raf = requestAnimationFrame(tick)
    }
    tick()
  }
  const LISTEN_WINDOW_MS = 30000
  let browserRecognitionFailed = false // Auto mode: fall back to Groq Whisper

  const resetListeningUi = () => {
    micBtn.textContent = t('speak')
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
    statusEl.textContent = t('transcribing')
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
      throw new Error(t('transcription_failed_status', { status: response.status, detail }).trim())
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
        // Without a level meter (no Web Audio) we cannot tell; transcribe anyway
        const heard = levelWatch ? levelWatch.heard : true
        stopLevelWatch()
        recordingStream?.getTracks().forEach(track => track.stop())
        recordingStream = null
        finishListening()
        if (!heard) {
          // Nothing but silence: don't spend a transcription on it
          retryBtn.hidden = false
          statusEl.textContent = t('no_speech_heard')
          return
        }
        try {
          const text = await transcribeRecording(new Blob(chunks, { type }))
          if (!text) throw new Error(t('no_speech_in_recording'))
          liveEl.textContent = text
          await sendTurn(text)
        } catch (error) {
          retryBtn.hidden = false
          micHelp.hidden = false
          statusEl.textContent = error.message || t('transcription_failed')
        }
      }, { once: true })
      window.speechSynthesis?.cancel?.()
      wantsListening = true
      retryBtn.hidden = true
      statusEl.textContent = t('recording')
      micBtn.textContent = t('stop')
      mediaRecorder.start()
      const stopRecording = () => {
        if (mediaRecorder?.state === 'recording') mediaRecorder.stop()
      }
      watchLevel(recordingStream, stopRecording)
      recordingTimer = setTimeout(stopRecording, LISTEN_WINDOW_MS)
    } catch (error) {
      stopLevelWatch()
      recordingStream?.getTracks().forEach(track => track.stop())
      recordingStream = null
      finishListening()
      permissionBtn.hidden = false
      micHelp.hidden = false
      micHelp.open = true
      statusEl.textContent = t('record_failed', { error: error?.name || t('unknown_error') })
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
      micBtn.textContent = t('stop')
    } catch {
      finishListening()
      permissionBtn.hidden = false
      micHelp.hidden = false
      micHelp.open = true
      retryBtn.hidden = false
      statusEl.textContent = t('listen_start_failed')
    }
  }

  const requestMicPermission = async (keepStream = false) => {
    if (micPermissionReady && !keepStream) return true
    if (!navigator.mediaDevices?.getUserMedia) return true
    if (requestingMicPermission) return false

    requestingMicPermission = true
    micBtn.disabled = true
    micBtn.textContent = t('enable_mic_pending')
    statusEl.textContent = t('waiting_permission')
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
        permissionBtn.textContent = t('mic_blocked_button')
      }
      const micErrors = {
        NotAllowedError: 'mic_err_not_allowed',
        NotFoundError: 'mic_err_not_found',
        NotReadableError: 'mic_err_not_readable',
        SecurityError: 'mic_err_security',
      }
      statusEl.textContent = t('mic_error_with_help', { message: t(micErrors[error?.name] || 'mic_err_generic') })
      return false
    } finally {
      requestingMicPermission = false
      micBtn.disabled = false
      micBtn.textContent = t('speak')
    }
  }

  const beginListening = async () => {
    // Groq mode always records for Whisper. Auto records only when the browser
    // has no recognizer or it has already failed this session.
    const useApiRecording = !!opts.speechApiKey && 'MediaRecorder' in window
      && (opts.speechMode === 'groq' || !opts.hasRecognition || browserRecognitionFailed)
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
    statusEl.textContent = t('listening')
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
        permissionBtn.textContent = t('mic_blocked_button')
        micHelp.hidden = false
        micHelp.open = true
        statusEl.textContent = t('speech_refused')
      } else if ((event.error === 'network' || event.error === 'service-not-allowed')
        && opts.speechMode === 'auto' && opts.speechApiKey && opts.hasRecording) {
        // Auto: the browser's speech service is broken here; use Groq from now on
        browserRecognitionFailed = true
        statusEl.textContent = t('auto_switched_to_groq')
      } else if (event.error === 'network' || event.error === 'service-not-allowed') {
        // Preserve the microphone control: a temporary mobile network/service
        // failure must not permanently remove audio input from the session.
        textForm.hidden = false
        micHelp.hidden = false
        micHelp.open = true
        statusEl.textContent = t('speech_service_failed', { error: event.error })
      } else {
        statusEl.textContent = t('could_not_hear')
      }
    }

    r.onend = () => {
      if (r !== recognizer) return
      listening = false
      if (!wantsListening) return
      if (Date.now() >= listenDeadline) {
        finishListening()
        retryBtn.hidden = false
        statusEl.textContent = t('no_speech_heard')
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
      statusEl.textContent = t('mic_denied_help')
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
        ? t('mic_blocked_button')
        : t('enable_mic')
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
    statusEl.textContent = t('starting')
    const system = buildSystemPrompt(data, opts.cando, opts.topicSet, opts.tutorMode ? opts.tutorFocus : null)
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
      statusEl.textContent = err.message || t('provider_start_error')
      return
    }
    if (!full.trim()) {
      statusEl.textContent = t('empty_reply_start')
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

  // Count turns where the learner fell back to their own language (Latin or Hangul)
  if (/[a-zA-Z]{3,}|[\uAC00-\uD7A3]{2,}/.test(text)) session.englishSwitchCount++

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
    mistakes: session.mistakes,
    topicSet: session.topicSet,
  }
  saveSessionSummary(session.cando?.id, summary)

  const sentenceRows = session.transcript
    .filter(t => t.role === 'user')
    .map(t => `<li lang="ja">${escapeHtml(t.text)}</li>`).join('')

  const correctionRows = session.corrections.length
    ? session.corrections.map(c => `<li lang="ja">${escapeHtml(c)}</li>`).join('')
    : `<li>${escapeHtml(t('summary_no_corrections'))}</li>`

  const outOfSetRows = resolved.length
    ? resolved.map(o => `
        <li>
          <span lang="ja">${escapeHtml(o.word)}</span>
          ${o.paraphrase
            ? t('outofset_try', { paraphrase: `<span lang="ja">${escapeHtml(o.paraphrase)}</span>` })
            : escapeHtml(t('outofset_no_paraphrase'))}
          ${o.real ? t('outofset_real', { real: `<span lang="ja">${escapeHtml(o.real)}</span>` }) : ''}
        </li>
      `).join('')
    : `<li>${escapeHtml(t('outofset_inside'))}</li>`

  root.innerHTML = `
    <div class="kaiwa-summary">
      <h2>${t('summary_title')}</h2>
      <p class="kaiwa-summary-headline">
        ${t('summary_abandoned', { count: session.abandonCount + session.englishSwitchCount })}
      </p>
      <p>${t('summary_longest', { count: session.longestSentence.length })}</p>
      <p lang="ja" class="kaiwa-longest">${escapeHtml(session.longestSentence) || escapeHtml(t('summary_none'))}</p>

      <h3>${t('summary_said')}</h3>
      <ul class="kaiwa-sentence-list">${sentenceRows || `<li>${escapeHtml(t('summary_nothing'))}</li>`}</ul>

      <h3>${t('summary_corrections')}</h3>
      <ul class="kaiwa-correction-list">${correctionRows}</ul>

      <h3>${t('summary_outofset')}</h3>
      <ul class="kaiwa-outofset-list">${outOfSetRows}</ul>

      <button id="kaiwa-again" class="kaiwa-primary">${t('practice_again')}</button>
    </div>
  `

  root.querySelector('#kaiwa-again').addEventListener('click', () => {
    root.dataset.bound = ''
    window.initKaiwaPage()
  })
}
