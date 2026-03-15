// Minihongo back cover for print-on-demand
// A5 with 3mm bleed
// QR code + minihongo.com

#let text-muted = rgb("#666666")

#let bleed = 3mm
#let page-w = 148mm + 2 * bleed
#let page-h = 210mm + 2 * bleed

#set page(width: page-w, height: page-h, margin: 0pt)
#set text(font: ("Noto Sans", "Noto Sans JP"), lang: "ja")

#place(center + horizon, {
  set align(center)
  image("/typst/qr.svg", width: 6cm)
  v(0.75cm)
  text(size: 14pt, fill: text-muted, weight: "medium", "minihongo.com")
})
