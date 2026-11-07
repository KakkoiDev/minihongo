// Daily practice: a short spaced-repetition session over the 231 words and the
// 9 core grammar points.
//
// Scheduling is JP Core's shared review module (jp-core-review.js, copied
// unchanged from JP Core browser/review.js), the same engine and state shape
// Echo uses. This file owns what JP Core leaves to consumers: which items go
// into a session, the questions, the wording, and persistence (localStorage,
// this browser only, no account).
//
// Entry point: window.initPracticePage(), called by app.js whenever
// #practice-app is present (SPA navigation swaps #content without running
// inline scripts, the same reason Kaiwa is loaded this way).

import {
  ensureReviewTrack,
  isDue,
  recordReviewMode,
  reviewMode,
  reviewSentence,
} from './jp-core-review.js?v={{CACHE_HASH}}'

const STORAGE_KEY = 'practice_v1'
const SIZE_KEY = 'practice_size'
const NEW_PER_DAY = 10
const SIZES = [5, 10, 20]
const REVIEW_LOG_LIMIT = 30

// -- Strings ---------------------------------------------------------------
// mh uses the 231 words; anything it lacks falls back to ja, then en.

const STRINGS = {
  en: {
    loading: 'Loading…',
    load_error: 'Could not load practice. Check your connection and reload.',
    known: 'Known',
    learning: 'Learning',
    not_started: 'Not started',
    progress: '{known} of {total} known',
    due: '{n} to review now',
    due_none: 'Nothing to review right now.',
    new_today: '{n} new today',
    size_label: 'Items',
    start: 'Start',
    hint: 'A few minutes a day. Items you miss come back sooner, items you know come back less often. Saved in this browser only.',
    caught_up: 'All caught up. Come back tomorrow for new items and reviews.',
    new_badge: 'New',
    got_it: 'Got it',
    q_reading: 'What does this mean?',
    q_listening: 'Listen. What does it mean?',
    q_writing: 'Which is the Japanese?',
    q_sentence: 'Which word fills the blank?',
    play: 'Play',
    correct: 'Correct',
    wrong: 'Not quite',
    next: 'Next',
    finish: 'Finish',
    step: '{i} / {n}',
    done_heading: 'Done for now',
    done_body: '{right} of {total} right.',
    more: 'Practice more',
    grammar_point: 'Grammar',
    again_label: 'Once more',
  },
  ko: {
    loading: '불러오는 중…',
    load_error: '연습을 불러오지 못했어요. 연결을 확인하고 새로고침하세요.',
    known: '익힘',
    learning: '익히는 중',
    not_started: '시작 전',
    progress: '{total}개 중 {known}개 익힘',
    due: '지금 복습할 항목 {n}개',
    due_none: '지금 복습할 항목이 없어요.',
    new_today: '오늘 새 항목 {n}개',
    size_label: '항목 수',
    start: '시작',
    hint: '하루 몇 분이면 돼요. 틀린 항목은 더 빨리, 아는 항목은 더 드물게 다시 나와요. 이 브라우저에만 저장돼요.',
    caught_up: '오늘은 다 했어요. 내일 새 항목과 복습으로 다시 만나요.',
    new_badge: '새 항목',
    got_it: '알겠어요',
    q_reading: '무슨 뜻일까요?',
    q_listening: '들어 보세요. 무슨 뜻일까요?',
    q_writing: '일본어로는 어느 것일까요?',
    q_sentence: '빈칸에 들어갈 말은?',
    play: '재생',
    correct: '정답',
    wrong: '아쉬워요',
    next: '다음',
    finish: '마치기',
    step: '{i} / {n}',
    done_heading: '오늘 연습 끝',
    done_body: '{total}개 중 {right}개 정답.',
    more: '더 연습하기',
    grammar_point: '문법',
    again_label: '한 번 더',
  },
  ja: {
    loading: '読み込み中…',
    load_error: '練習を読み込めませんでした。接続を確認して再読み込みしてください。',
    known: '覚えた',
    learning: '学習中',
    not_started: '未学習',
    progress: '{total}個中{known}個を覚えた',
    due: '今すぐ復習：{n}個',
    due_none: '今は復習するものがありません。',
    new_today: '今日の新しい語：{n}個',
    size_label: '問題数',
    start: '始める',
    hint: '1日数分。間違えた語は早めに、覚えた語は間隔をあけて出てきます。このブラウザにだけ保存されます。',
    caught_up: '今日はここまで。明日、新しい語と復習が出てきます。',
    new_badge: '新しい語',
    got_it: '分かった',
    q_reading: 'どういう意味？',
    q_listening: '聞いてください。どういう意味？',
    q_writing: 'ミニ本語ではどれ？',
    play: '再生',
    correct: '正解',
    wrong: '残念',
    next: '次へ',
    finish: '終わる',
    step: '{i} / {n}',
    done_heading: 'おつかれさま',
    done_body: '{total}問中{right}問正解。',
    more: 'もっと練習する',
    grammar_point: '文法',
    again_label: 'もう一度',
  },
  mh: {
    known: '知【し】っている',
    learning: '今【いま】知【し】る',
    not_started: 'まだ',
    progress: '{total}の中【なか】で{known}を知【し】っている',
    due: '今【いま】また見【み】る物【もの】：{n}',
    due_none: '今【いま】また見【み】る物【もの】はない。',
    new_today: '今【いま】の日【にち】の新【あたら】しい物【もの】：{n}',
    size_label: 'いくつ',
    start: '始【はじ】める',
    caught_up: '今【いま】の日【にち】は終【お】わり。また来【く】る日【にち】に。',
    new_badge: '新【あたら】しい',
    got_it: '分【わ】かった',
    q_reading: '何【なに】を言【い】っている？',
    q_listening: '聞【き】いてください。何【なに】を言【い】っている？',
    q_writing: 'どれ？',
    play: '聞【き】く',
    correct: '良【よ】い',
    wrong: '違【ちが】う',
    next: '次【つぎ】',
    finish: '終【お】わる',
    done_heading: '終【お】わり',
    done_body: '{total}の中【なか】で{right}が良【よ】い。',
    more: 'もっとする',
    again_label: 'また',
  },
}

let lang = 'en'
const t = (key, vars = {}) => {
  const chain = lang === 'mh' ? ['mh', 'ja', 'en'] : [lang, 'en']
  let text = key
  for (const l of chain) {
    if (STRINGS[l]?.[key] != null) { text = STRINGS[l][key]; break }
  }
  return text.replace(/\{(\w+)\}/g, (_, k) => vars[k] ?? '')
}

// -- Text helpers ----------------------------------------------------------

const escapeHtml = s => String(s ?? '').replace(/[&<>"']/g, c => ({
  '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
}[c]))

// 漢字【かんじ】 -> <ruby>, after escaping
const ruby = text => escapeHtml(text).replace(
  /([一-鿿々]+)【([^】]+)】/g,
  '<ruby>$1<rt>$2</rt></ruby>',
)
const plain = text => String(text ?? '').replace(/【[^】]*】/g, '')
// t() result with Minihongo bracket readings rendered
const tr = (key, vars) => ruby(t(key, vars))

// -- Persistence -----------------------------------------------------------

const today = () => new Date().toLocaleDateString('en-CA') // YYYY-MM-DD, local

function loadState() {
  try {
    const raw = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}')
    return { items: raw.items || {}, newDay: raw.newDay || { date: '', count: 0 } }
  } catch {
    return { items: {}, newDay: { date: '', count: 0 } }
  }
}

function saveState(state) {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(state)) } catch {}
}

const newToday = state => (state.newDay.date === today() ? state.newDay.count : 0)

// -- Data ------------------------------------------------------------------

let dataPromise = null
const fetchData = () => {
  dataPromise ??= fetch('/static/practice-data.json?v={{CACHE_HASH}}')
    .then(r => { if (!r.ok) throw new Error(r.status); return r.json() })
    .catch(err => { dataPromise = null; throw err })
  return dataPromise
}

// Grammar cards ask for a translation; ja and mh readers have none to pick
const itemsFor = (data, l) => data.items.filter(i => i.kind === 'word' || (l === 'en' || l === 'ko'))
const meaningOf = item => item.meaning[lang] || item.meaning.en || ''

// -- Session planning --------------------------------------------------------

function summary(items, state, now = new Date()) {
  let known = 0, learning = 0, due = 0
  for (const item of items) {
    const rec = state.items[item.id]
    if (!rec?.srs) continue
    if (rec.srs.state === 2) known++
    else learning++
    if (isDue(rec, now)) due++
  }
  const remainingNew = Math.max(0, NEW_PER_DAY - newToday(state))
  const unstarted = items.length - known - learning
  return { known, learning, due, total: items.length, newAvailable: Math.min(remainingNew, unstarted) }
}

// Due reviews first (earliest due first), then new items in course order.
function planSession(items, state, size, now = new Date()) {
  const due = items
    .filter(i => state.items[i.id]?.srs && isDue(state.items[i.id], now))
    .sort((a, b) => Date.parse(state.items[a.id].srs.due) - Date.parse(state.items[b.id].srs.due))
    .slice(0, size)
  const room = Math.min(size - due.length, Math.max(0, NEW_PER_DAY - newToday(state)))
  const fresh = room > 0 ? items.filter(i => !state.items[i.id]?.srs).slice(0, room) : []
  // New items: a short introduction now, their first question at the end
  return [
    ...fresh.map(item => ({ type: 'intro', item })),
    ...due.map(item => ({ type: 'question', item })),
    ...fresh.map(item => ({ type: 'question', item, first: true })),
  ]
}

// The skill comes from the shared rotation. Listening needs audio and a
// connection (audio is not cached offline); otherwise it falls back to reading.
// The writing skill alternates between two forms: pick the Japanese for a
// meaning, or fill the word into its example sentence (en/ko only: those
// editions show the sentence's translation, which pins down the one word
// that fits; a Japanese translation would give the answer away).
function questionMode(item, rec, first) {
  if (first) return { skill: 'reading', form: 'reading' }
  const tracked = ensureReviewTrack(rec || { id: item.id })
  let skill = reviewMode(tracked)
  if (skill === 'listening' && (!item.audio || !navigator.onLine)) skill = 'reading'
  const sentenceOk = item.cloze && (lang === 'en' || lang === 'ko')
  const form = skill === 'writing' && sentenceOk && tracked.reviewTrack.attempts.writing % 2 === 1
    ? 'sentence'
    : skill
  return { skill, form }
}

const shuffle = list => {
  const a = [...list]
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]]
  }
  return a
}

// Three other items of the same kind, preferring the same vocabulary group,
// whose answer text differs from the right one.
function distractors(item, items, mode) {
  const answerOf = i => (mode === 'writing' ? plain(i.jp) : meaningOf(i))
  const right = answerOf(item)
  const pool = items.filter(i => i.kind === item.kind && i.id !== item.id && answerOf(i) && answerOf(i) !== right)
  const same = shuffle(pool.filter(i => i.group === item.group))
  const rest = shuffle(pool.filter(i => i.group !== item.group))
  const seen = new Set([right])
  const picked = []
  for (const i of [...same, ...rest]) {
    if (picked.length === 3) break
    if (seen.has(answerOf(i))) continue
    seen.add(answerOf(i))
    picked.push(i)
  }
  return picked
}

// -- Rendering ---------------------------------------------------------------

function playButton(item, big = false) {
  if (!item.audio) return ''
  return `<button type="button" class="play-btn${big ? ' practice-play-big' : ''}" data-audio="${escapeHtml(item.audio)}" aria-label="${escapeHtml(plain(t('play')))}"${navigator.onLine ? '' : ' disabled'}>&#9654;</button>`
}

function bindPlay(root) {
  for (const btn of root.querySelectorAll('.play-btn')) btn.onclick = () => window.minihongoPlay?.(btn)
}

function play(root) {
  const btn = root.querySelector('.play-btn')
  if (btn && navigator.onLine) window.minihongoPlay?.(btn)
}

function renderHome(root, data, state) {
  const items = itemsFor(data, lang)
  const s = summary(items, state)
  let size = SIZES[1]
  try { size = Number(localStorage.getItem(SIZE_KEY)) || size } catch {}
  if (!SIZES.includes(size)) size = SIZES[1]
  const canStart = s.due > 0 || s.newAvailable > 0
  const pct = n => (s.total ? (100 * n) / s.total : 0)

  root.innerHTML = `
    <div class="practice-home">
      <p class="practice-progress-label">${tr('progress', { known: s.known, total: s.total })}</p>
      <div class="practice-bar" role="img" aria-label="${escapeHtml(plain(t('progress', { known: s.known, total: s.total })))}">
        <span class="practice-bar__known" style="width:${pct(s.known)}%"></span>
        <span class="practice-bar__learning" style="width:${pct(s.learning)}%"></span>
      </div>
      <p class="practice-legend">
        <span><span class="practice-key practice-key--known"></span>${tr('known')} ${s.known}</span>
        <span><span class="practice-key practice-key--learning"></span>${tr('learning')} ${s.learning}</span>
        <span><span class="practice-key"></span>${tr('not_started')} ${s.total - s.known - s.learning}</span>
      </p>
      <p class="practice-today">${s.due ? tr('due', { n: s.due }) : tr('due_none')}${s.newAvailable ? ` · ${tr('new_today', { n: s.newAvailable })}` : ''}</p>
      ${canStart ? `
        <div class="practice-start">
          <fieldset class="practice-sizes">
            <legend>${tr('size_label')}</legend>
            ${SIZES.map(n => `<label><input type="radio" name="practice-size" value="${n}"${n === size ? ' checked' : ''}><span>${n}</span></label>`).join('')}
          </fieldset>
          <button type="button" class="btn btn-primary" id="practice-start">${tr('start')}</button>
        </div>
        <p class="practice-hint">${tr('hint')}</p>
      ` : `<p class="practice-caught-up">${tr('caught_up')}</p>`}
    </div>
  `
  root.querySelector('#practice-start')?.addEventListener('click', () => {
    const chosen = Number(root.querySelector('input[name="practice-size"]:checked')?.value) || size
    try { localStorage.setItem(SIZE_KEY, String(chosen)) } catch {}
    const steps = planSession(items, state, chosen)
    if (steps.length) runSession(root, data, state, items, steps)
  })
}

function runSession(root, data, state, items, steps) {
  let index = 0
  let right = 0
  let graded = 0
  const planned = steps.length // retries are appended past this point

  const header = () => {
    const retry = index >= planned
    return `
    <div class="practice-step-head">
      <span>${retry ? tr('again_label') : tr('step', { i: index + 1, n: planned })}</span>
      <div class="practice-step-bar"><span style="width:${Math.min(100, (100 * index) / planned)}%"></span></div>
    </div>`
  }

  const show = () => {
    if (index >= steps.length) return finish()
    const step = steps[index]
    if (step.type === 'intro') return showIntro(step)
    return showQuestion(step)
  }

  const advance = () => { index++; show() }

  const showIntro = ({ item }) => {
    // Counts toward today's new-item allowance once introduced
    const day = today()
    state.newDay = { date: day, count: (state.newDay.date === day ? state.newDay.count : 0) + 1 }
    saveState(state)
    root.innerHTML = `
      <div class="practice-card">
        ${header()}
        <p class="practice-badge">${tr('new_badge')}${item.kind === 'grammar' ? ` · ${tr('grammar_point')}: ${escapeHtml(item.point?.[lang] || item.point?.en || '')}` : ''}</p>
        <p class="practice-jp" lang="ja">${ruby(item.jp)} ${playButton(item)}</p>
        <p class="practice-meaning">${ruby(meaningOf(item))}</p>
        <div class="practice-actions"><button type="button" class="btn btn-primary" id="practice-next">${tr('got_it')}</button></div>
      </div>`
    bindPlay(root)
    play(root)
    const next = root.querySelector('#practice-next')
    next.addEventListener('click', advance)
    next.focus()
  }

  const showQuestion = (step) => {
    const { item } = step
    const rec = state.items[item.id]
    const { skill: mode, form } = questionMode(item, rec, step.first)
    const others = distractors(item, items, mode)
    const options = shuffle([item, ...others])
    const optionHtml = i => (mode === 'writing'
      ? `<span lang="ja">${ruby(i.jp)}</span>`
      : `<span>${ruby(meaningOf(i))}</span>`)
    const blank = '<span class="practice-blank" aria-label="blank">＿＿＿</span>'
    const prompt = form === 'sentence'
      ? `<p class="practice-sentence-trans">${ruby(item.cloze.meaning[lang] || item.cloze.meaning.en)}</p>
         <p class="practice-jp practice-jp--sentence" lang="ja">${ruby(item.cloze.jp).replace('＿＿＿', blank)}</p>`
      : mode === 'listening'
        ? `<p class="practice-listen">${playButton(item, true)}</p>`
        : mode === 'writing'
          ? `<p class="practice-meaning practice-meaning--prompt">${ruby(meaningOf(item))}</p>`
          : `<p class="practice-jp" lang="ja">${ruby(item.jp)}</p>`

    root.innerHTML = `
      <div class="practice-card">
        ${header()}
        <p class="practice-question">${tr(`q_${form}`)}${item.kind === 'grammar' ? ` <span class="practice-badge">${tr('grammar_point')}</span>` : ''}</p>
        ${prompt}
        <div class="practice-options" role="group">
          ${options.map((o, n) => `<button type="button" class="practice-option" data-id="${escapeHtml(o.id)}"><kbd>${n + 1}</kbd>${optionHtml(o)}</button>`).join('')}
        </div>
        <div class="practice-feedback" role="status" aria-live="polite"></div>
      </div>`
    bindPlay(root)
    if (mode === 'listening') play(root)

    const buttons = [...root.querySelectorAll('.practice-option')]
    const answer = (btn) => {
      if (root.dataset.answered === '1') return
      root.dataset.answered = '1'
      const ok = btn.dataset.id === item.id
      for (const b of buttons) {
        b.disabled = true
        if (b.dataset.id === item.id) b.classList.add('is-right')
        else if (b === btn) b.classList.add('is-wrong')
      }
      // Grade once per item per session; a retry at the end is practice only
      if (!step.retry) {
        const now = new Date()
        const rating = ok ? 'ok' : 'again'
        // Record the skill actually asked: a first question is always reading,
        // and listening falls back to reading offline.
        const tracked = ensureReviewTrack(rec || { id: item.id })
        const asked = { ...tracked, reviewTrack: { ...tracked.reviewTrack, next: mode } }
        let next = reviewSentence(asked, rating, now)
        next = recordReviewMode(next, rating, now)
        const entry = { at: now.toISOString(), rating, mode }
        if (form !== mode) entry.form = form
        next.reviews = [...(rec?.reviews || []), entry].slice(-REVIEW_LOG_LIMIT)
        state.items[item.id] = next
        saveState(state)
        graded++
        if (ok) right++
        else steps.push({ type: 'question', item, retry: true })
      }
      const feedback = root.querySelector('.practice-feedback')
      // A sentence question answers with the whole sentence and its audio
      const shown = form === 'sentence'
        ? { jp: item.cloze.full, audio: item.cloze.audio, meaning: item.cloze.meaning[lang] || item.cloze.meaning.en }
        : { jp: item.jp, audio: item.audio, meaning: meaningOf(item) }
      feedback.innerHTML = `
        <p class="practice-verdict ${ok ? 'is-right' : 'is-wrong'}">${tr(ok ? 'correct' : 'wrong')}</p>
        <p class="practice-jp practice-jp--answer" lang="ja">${ruby(shown.jp)} ${playButton(shown)}</p>
        <p class="practice-meaning">${ruby(shown.meaning)}</p>
        <div class="practice-actions"><button type="button" class="btn btn-primary" id="practice-next">${tr(index + 1 >= steps.length ? 'finish' : 'next')}</button></div>`
      bindPlay(feedback)
      if (mode !== 'listening') play(feedback)
      const next = feedback.querySelector('#practice-next')
      next.addEventListener('click', () => { delete root.dataset.answered; advance() })
      next.focus()
    }
    for (const b of buttons) b.addEventListener('click', () => answer(b))
    delete root.dataset.answered
  }

  const finish = () => {
    const s = summary(items, state)
    // Anonymous aggregate signal, as the old quiz sent: a session was finished
    window.goatcounter?.count({ path: 'practice-session-done', title: 'practice', event: true })
    root.innerHTML = `
      <div class="practice-card practice-done">
        <h3>${tr('done_heading')}</h3>
        <p>${tr('done_body', { right, total: graded })}</p>
        <p class="practice-progress-label">${tr('progress', { known: s.known, total: s.total })}</p>
        <div class="practice-actions">
          ${s.due > 0 || s.newAvailable > 0 ? `<button type="button" class="btn btn-primary" id="practice-more">${tr('more')}</button>` : `<p class="practice-caught-up">${tr('caught_up')}</p>`}
        </div>
      </div>`
    root.querySelector('#practice-more')?.addEventListener('click', () => renderHome(root, data, state))
  }

  show()
}

// Number keys pick an option; Enter/space work through the focused button.
document.addEventListener('keydown', (e) => {
  const root = document.getElementById('practice-app')
  if (!root || e.metaKey || e.ctrlKey || e.altKey) return
  if (/^(INPUT|TEXTAREA|SELECT)$/.test(document.activeElement?.tagName)) return
  const n = Number(e.key)
  if (n >= 1 && n <= 4) root.querySelectorAll('.practice-option:not([disabled])')[n - 1]?.click()
})

window.initPracticePage = async function initPracticePage() {
  const root = document.getElementById('practice-app')
  if (!root || root.dataset.bound === '1') return
  root.dataset.bound = '1'
  lang = root.dataset.lang || 'en'
  root.innerHTML = `<p class="practice-loading">${tr('loading')}</p>`
  let data
  try {
    data = await fetchData()
  } catch {
    root.innerHTML = `<p class="practice-error">${tr('load_error')}</p>`
    return
  }
  renderHome(root, data, loadState())
}
