// template_notes.typ


// theorem and example and definition blocks
#import "@preview/theorion:0.6.0": *
#import "@preview/frame-it:1.2.0": *

// don't import here, this is your menu lol
// #import cosmos.simple: *
// #import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
// #show: show-theorion

#let theorem(..args) = context {
  if target() == "paged" {
    import cosmos.fancy: *
    theorem(..args)
  } else {
    import cosmos.clouds: *
    theorem(..args)
  }
}

#let exercise(..args) = context {
  if target() == "paged" {
    import cosmos.fancy: *
    exercise(..args)
  } else {
    import cosmos.clouds: *
    exercise(..args)
  }
}

#let corollary(..args) = context {
  if target() == "paged" {
    import cosmos.fancy: *
    corollary(..args)
  } else {
    import cosmos.clouds: *
    corollary(..args)
  }
}

#let property(..args) = context {
  if target() == "paged" {
    import cosmos.fancy: *
    property(..args)
  } else {
    import cosmos.clouds: *
    property(..args)
  }
}

#let example(..args) = context {
  if target() == "paged" {
    import cosmos.fancy: *
    example(..args)
  } else {
    import cosmos.clouds: *
    example(..args)
  }
}

#let definition(..args) = context {
  if target() == "paged" {
    import cosmos.fancy: *
    definition(..args)
  } else {
    import cosmos.clouds: *
    definition(..args)
  }
}

#let render-fn(
  prefix: none,
  title: "",
  full-title: auto,
  color: red,
  alt: "",
  body,
) = context {
  if title == "" {
    frame(none, color)(alt: alt, numbering: (..args) => { "" })[*#prefix*][#body]
  } else {
    frame(none, color)(alt: alt, numbering: (..args) => { "" })[*#prefix*][*#title*][#body]
  }
}

#let (theorem-counter, theorem-box, theorem, show-theorem) = make-frame(
  "theorem",
  theorion-i18n-map.at("theorem"),
  inherited-levels: 2,
  render: render-fn.with(color: purple.lighten(60%).desaturate(40%), alt: "theorem"),
)

#let (corollary-counter, corollary-box, corollary, show-corollary) = make-frame(
  "corollary",
  theorion-i18n-map.at("corollary"),
  inherited-levels: 2,
  render: render-fn.with(color: gray, alt: "corollary"),
)

#let (exercise-counter, exercise-box, exercise, show-exercise) = make-frame(
  "exercise",
  theorion-i18n-map.at("exercise"),
  inherited-levels: 2,
  render: render-fn.with(color: orange.lighten(60%).desaturate(40%), alt: "exercise"),
)

#let (example-counter, example-box, example, show-example) = make-frame(
  "example",
  theorion-i18n-map.at("example"),
  inherited-levels: 2,
  render: render-fn.with(color: green.lighten(60%).desaturate(40%), alt: "example"),
)

#let (definition-counter, definition-box, definition, show-definition) = make-frame(
  "definition",
  theorion-i18n-map.at("definition"),
  inherited-levels: 2,
  render: render-fn.with(color: olive.lighten(66%), alt: "definition"),
)

#let (property-counter, property-box, property, show-property) = make-frame(
  "property",
  theorion-i18n-map.at("property"),
  inherited-levels: 2,
  render: render-fn.with(color: eastern.lighten(66%), alt: "property"),
)

// Create a tip block with green styling and light bulb icon
// Useful for helpful suggestions and tips
#let my-solution-block = note-block.with(
  fill: rgb("#1A7F37"),
  title: theorion-i18n-map.at("solution"),
  icon-name: "key",
)


// next package:
#import "@preview/diverential:0.3.0": *


#let acc(letter) = {
  math.equation(eval("$" + letter + "$"), alt: letter, block: false)
}
#let xaxis = {
  [#acc("x")-axis]
}
#let yaxis = {
  [#acc("y")-axis]
}
#let coord(xcoord, ycoord) = {
  math.equation(eval("$(" + xcoord + "," + ycoord + ")$"), alt: xcoord + "comma" + ycoord, block: false)
}
#let closedint(a, b) = {
  math.equation(eval("$[" + a + "," + b + "]$"), alt: "the closed interval from " + a + " to " + b, block: false)
}
#let openint(a, b) = {
  math.equation(eval("$(" + a + "," + b + ")$"), alt: "the open interval from " + a + " to " + b, block: false)
}

#let h_html(..args) = {
  // h but only if not in html mode :)
  context { if target() == "paged" { h(..args) } }
}

#let inline_eq(m, a) = {
  math.equation(m, alt: a, block: false)
}
#let block_eq(m, a) = {
  math.equation(m, alt: a, block: true)
}

// u du dv v
#let IBP = (u, du, dv, v: auto, vstep: none) => {
  if v == auto {
    v = math.equation($integral dv$, alt: "integral of" + dv.at("alt"))
  }
  math.equation(
    $
          u & = #u, & dif v & = dv, \
      dif u & = du, &     v & = #v vstep
    $,
    alt: "u = "
      + u.at("alt")
      + ", d u = "
      + du.at("alt")
      + ", d v = "
      + dv.at("alt")
      + ", v = "
      + v.at("alt")
      + if vstep != none { vstep.at("alt") } else { "" },
    block: true,
  )
}



// put under imports
#let template = doc => {
  context { set page(header: "Math 1226 Completed Notes") if target() == "paged" }
  show: show-theorion
  show: frame-style(styles.boxy)
  // Include styles.css in html output
  context { if target() == "html" { html.link(href: "styles.css", rel: "stylesheet") } }
  doc
}

#import "@preview/showybox:2.0.4": showybox
#import "@preview/zero:0.7.0": format-table, num, zi
#let kgm-s2 = zi.declare("kg m/s^2")
#let fts = zi.declare("ft", alt: "feet")
#let ft = zi.declare("ft", alt: "foot")
#let lb = zi.declare("lb", alt: "pound")
#let ftlb = zi.declare("ft-lb", alt: "foot pounds")
#let lb-ft3 = zi.declare("lbs/ft^3", alt: "pounds per cubic foot")
#let imperialwater = lb-ft3(62.4)
