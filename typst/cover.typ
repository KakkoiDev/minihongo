// Minihongo wraparound cover for print-on-demand (Lulu)
// Single page: back cover | spine | front cover
// Params passed via --input: title, tagline, spine-width, page-count

#import "@preview/rubby:0.10.2": get-ruby

#let accent = rgb("#BC002D")
#let text-color = rgb("#2B2B2B")
#let text-muted = rgb("#666666")

#let ruby = get-ruby(size: 0.5em, dy: 0pt, pos: top, alignment: "center")

// A5 trim dimensions (Lulu: 5.83 x 8.27in)
#let trim-w = 148.08mm
#let trim-h = 210.06mm
#let bleed = 3.175mm  // Lulu standard: 0.125in

// Spine width passed as input (in mm)
#let spine-w = eval(sys.inputs.at("spine-width", default: "7")) * 1mm

// Total cover dimensions with bleed
#let total-w = bleed + trim-w + spine-w + trim-w + bleed
#let total-h = bleed + trim-h + bleed

#set page(
  width: total-w,
  height: total-h,
  margin: 0pt,
)
#set text(
  font: ("Noto Sans", "Noto Sans JP"),
  fill: text-color,
  lang: "ja",
)

// -- Back cover (left side) --
#place(
  top + left,
  dx: bleed,
  dy: bleed,
  box(
    width: trim-w,
    height: trim-h,
    {
      place(center + horizon, {
        set align(center)
        image("/typst/qr.svg", width: 5cm)
        v(0.75cm)
        text(size: 14pt, fill: text-muted, weight: "medium", "minihongo.com")
      })
    },
  ),
)

// -- Spine (center strip) --
#place(
  top + left,
  dx: bleed + trim-w,
  dy: bleed,
  box(
    width: spine-w,
    height: trim-h,
    fill: white,
    {
      place(center + horizon, {
        set align(center)
        // Rotated text along the spine
        rotate(
          -90deg,
          text(
            size: 8pt,
            weight: "bold",
            fill: text-color,
            sys.inputs.at("title", default: "Minihongo"),
          ),
        )
      })
    },
  ),
)

// -- Front cover (right side) --
#place(
  top + left,
  dx: bleed + trim-w + spine-w,
  dy: bleed,
  box(
    width: trim-w,
    height: trim-h,
    {
      place(center + horizon, {
        set align(center)
        v(-2cm)
        image("/site/static/logo.svg", width: 5cm)
        v(1cm)
        text(
          size: 28pt,
          weight: "bold",
          fill: text-color,
          sys.inputs.at("title", default: "Minihongo"),
        )
        v(0.5cm)
        text(
          size: 12pt,
          fill: text-muted,
          sys.inputs.at("tagline", default: ""),
        )
      })
    },
  ),
)
