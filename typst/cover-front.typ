// Minihongo front cover for print-on-demand
// A5 with 3mm bleed
// Params via --input: title, tagline

#let text-color = rgb("#2B2B2B")
#let text-muted = rgb("#666666")

#let bleed = 3mm
#let page-w = 148mm + 2 * bleed
#let page-h = 210mm + 2 * bleed

#set page(width: page-w, height: page-h, margin: 0pt)
#set text(font: ("Noto Sans", "Noto Sans JP"), fill: text-color, lang: "ja")

#place(center + horizon, {
  set align(center)
  v(-2cm)
  image("/site/static/logo.svg", width: 5cm)
  v(1cm)
  text(
    size: 28pt,
    weight: "bold",
    sys.inputs.at("title", default: "Minihongo"),
  )
  v(0.5cm)
  text(
    size: 12pt,
    fill: text-muted,
    sys.inputs.at("tagline", default: ""),
  )
})
