// Minihongo Book Template - A5 format for print
// Matches website styling: accent #BC002D, Noto Sans JP, card borders

#import "@preview/rubby:0.10.2": get-ruby

// -- Colors --
#let accent = rgb("#BC002D")
#let text-color = rgb("#2B2B2B")
#let text-muted = rgb("#666666")
#let bg-raised = rgb("#F7F7F7")
#let border-color = rgb("#E5E5E5")

// -- Ruby/Furigana function --
#let ruby = get-ruby(size: 0.5em, dy: 0pt, pos: top, alignment: "center")

// -- Cover page --
#let cover-page(title, tagline, logo-path) = {
  set page(margin: 0pt, header: none, footer: none)
  place(center + horizon, {
    set align(center)
    v(-2cm)
    if logo-path != none {
      image(logo-path, width: 5cm)
      v(1cm)
    }
    text(size: 28pt, weight: "bold", fill: text-color, title)
    v(0.5cm)
    text(size: 12pt, fill: text-muted, tagline)
  })
}

// -- Back cover with QR code --
#let back-cover(url) = {
  pagebreak(to: "even", weak: true)
  set page(margin: 0pt, header: none, footer: none)
  place(center + horizon, {
    set align(center)
    image("/typst/qr.svg", width: 6cm)
    v(0.75cm)
    text(size: 14pt, fill: text-muted, weight: "medium", url)
  })
}

// -- Grammar card --
#let grammar-card(pattern, explanation, examples) = {
  block(
    width: 100%,
    inset: (left: 0.75em, top: 1.1em, bottom: 0.8em, right: 1em),
    stroke: (left: 3pt + accent),
    fill: bg-raised,
    radius: 6pt,
    {
      text(size: 12pt, weight: "bold", pattern)
      linebreak()
      text(size: 9pt, fill: text-muted, explanation)
      v(0.5em)
      examples
    },
  )
  v(0.75em)
}

// -- Haiku block --
#let haiku-block(japanese, translation) = {
  block(
    width: 100%,
    inset: (left: 1em, top: 1.2em, bottom: 1em, right: 1em),
    fill: bg-raised,
    radius: 6pt,
    {
      set align(center)
      text(size: 13pt, weight: "regular", japanese)
      if translation != none {
        v(0.4em)
        text(size: 9pt, fill: text-muted, style: "italic", translation)
      }
    },
  )
  v(0.75em)
}

// -- Dialog block --
#let dialog-block(title, lines-content, translation-content) = {
  text(size: 11pt, weight: "bold", title)
  v(0.3em)
  block(
    width: 100%,
    inset: (left: 0.75em, top: 0.9em, bottom: 0.6em, right: 1em),
    stroke: (left: 3pt + accent),
    fill: bg-raised,
    radius: 6pt,
    lines-content,
  )
  if translation-content != none {
    block(
      inset: (left: 1.5em, top: 0.3em, bottom: 0.3em),
      {
        set text(size: 9pt, fill: text-muted)
        translation-content
      },
    )
  }
  v(0.75em)
}

// -- Story block --
#let story-block(title, paragraphs-content, translation) = {
  text(size: 11pt, weight: "bold", title)
  v(0.3em)
  block(
    width: 100%,
    inset: (left: 0.75em, top: 0.9em, bottom: 0.6em, right: 1em),
    stroke: (left: 3pt + accent),
    fill: bg-raised,
    radius: 6pt,
    {
      set text(size: 10.5pt)
      paragraphs-content
    },
  )
  if translation != none {
    block(
      inset: (left: 1.5em, top: 0.3em, bottom: 0.3em),
      text(size: 9pt, fill: text-muted, translation),
    )
  }
  v(0.75em)
}

// -- Rounded table wrapper --
#let rounded-table(body) = {
  block(
    clip: true,
    radius: 6pt,
    stroke: 0.5pt + border-color,
    body,
  )
  v(0.4em)
}

// -- Note/warning block --
#let note-block(body) = {
  block(
    width: 100%,
    inset: (left: 0.75em, top: 0.7em, bottom: 0.5em, right: 0.75em),
    stroke: (left: 3pt + accent),
    fill: bg-raised,
    radius: 6pt,
    text(size: 9pt, fill: text-muted, body),
  )
  v(0.6em)
}

// -- Book setup function --
// print: true = asymmetric margins for binding, false = equal margins for screen
#let book(title: "", lang: "en", print: false, body) = {
  set document(title: title, author: "Minihongo")
  set page(
    paper: "a5",
    margin: if print {
      (top: 20mm, bottom: 20mm, inside: 20mm, outside: 15mm)
    } else {
      (top: 18mm, bottom: 18mm, left: 18mm, right: 18mm)
    },
    header: none,
    footer: context {
      if counter(page).get().first() > 1 {
        set align(center)
        set text(size: 8pt, fill: text-muted)
        counter(page).display()
      }
    },
  )
  set text(
    font: ("Noto Sans", "Noto Sans CJK JP"),
    size: 9.5pt,
    weight: "medium",
    fill: text-color,
    lang: if lang == "mh" { "ja" } else { lang },
  )
  set par(leading: 0.8em, spacing: 0.8em)

  // -- Heading styles (enables TOC via outline) --
  // H1: chapter title
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    text(size: 18pt, weight: "bold", fill: text-color, it.body)
    v(1.8em)
  }

  // H2: section heading with 4px left accent border
  show heading.where(level: 2): it => {
    v(2em)
    block(
      breakable: false,
      below: 0.8em,
      inset: (left: 0.75em, top: 0.3em, bottom: 0.2em),
      stroke: (left: 4pt + accent),
      text(size: 14pt, weight: "bold", fill: text-color, it.body),
    )
  }

  // H3: sub-heading with 3px left accent border
  show heading.where(level: 3): it => {
    v(1.5em)
    block(
      breakable: false,
      below: 0.6em,
      inset: (left: 0.75em, top: 0.25em, bottom: 0.15em),
      stroke: (left: 3pt + accent),
      text(size: 12pt, weight: "bold", fill: text-color, it.body),
    )
  }

  body
}
