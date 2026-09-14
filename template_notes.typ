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

#let sequence = [a #"test"].func()
#let test-symbol = $=$.body.func()
#let styled = $bold(A)$.body.func()

#let warn(body) = {
  let my-message = [#(label(repr(body)))]
}

#let get-alt(body, use-alt: true) = {
  if body.func() == math.equation {
    if use-alt and body.has("alt") and body.alt != none {
      body.alt
    } else {
      get-alt(body.body)
    }
  } else if body.func() == sequence {
    let alt = ""
    for (i, elem) in body.at("children").enumerate() {
      let new-alt = get-alt(elem)
      alt += new-alt
      if i < body.at("children").len() - 1 and new-alt != none and new-alt.len() > 0 {
        alt += " "
      }
    }
    alt
  } else if (body.func() == test-symbol) {
    let text = body.at("text")
    if text == "=" {
      "equals"
    } else if text == "+" {
      "plus"
    } else if text == "-" {
      "minus"
    } else if text == "≈" {
      "approximately equals"
    } else if text == "∫" {
      "integral"
    } else if text == "→" {
      "goes to"
    } else if text == "±" {
      "plus or minus"
    } else if text == "≥" {
      "is greater than or equal to"
    } else if text == "≤" {
      "is less than or equal to"
    } else {
      text
    }
  } else if (body.func() == text) {
    body.at("text")
  } else if (body.func() == math.attach) {
    let alt = get-alt(body.base)

    if alt == "∑" {
      alt = "sum"
    }

    if (alt == "integral" or alt == "sum") {
      if (body.has("b") and body.has("t")) {
        alt += " from " + get-alt(body.b) + " to " + get-alt(body.t)
      }

      alt += " of"
    } else if alt == "lim of" {
      alt = "limit"

      if body.has("b") {
        alt += " as " + get-alt(body.b)
      }

      alt += " of"
    } else {
      if (body.has("t")) {
        if body.t.func() == test-symbol {
          alt += get-alt(body.t)
          if (body.has("b")) {
            alt += " sub "
            alt += get-alt(body.b)
          }
        } else {
          if (body.has("b")) {
            alt += " sub "
            alt += get-alt(body.b)
          }
          // TODO: Make this more natural sounding for squared, cubed, etc.
          alt += " to the power of "
          alt += get-alt(body.t)
        }
      } else if body.has("b") {
        alt += " sub " + get-alt(body.b)
      }
    }

    alt
  } else if body.func() == math.lr {
    get-alt(body.body)
  } else if body.func() == math.op {
    get-alt(body.text) + " of"
  } else if body.func() == math.underbrace {
    // TODO: No clue what to do about underbrace annotation content here
    get-alt(body.body)
  } else if body.func() == math.frac {
    get-alt(body.num) + " over " + get-alt(body.denom)
  } else if body.func() == math.class {
    get-alt(body.body)
  } else if (body.func() == styled) {
    get-alt(body.child)
  } else if body.func() == math.root {
    (
      if body.has("index") {
        "root " + get-alt(body.index)
      } else {
        "square root"
      }
        + " of "
        + get-alt(body.radicand)
    )
  }
}

// put under imports
#let template = doc => {
  context { set page(header: "Math 1226 Completed Notes") if target() == "paged" }
  show: show-theorion
  show: frame-style(styles.boxy)
  // Include styles.css in html output
  context {
    if target() == "html" { html.link(href: sys.inputs.at("root", default: "") + "styles.css", rel: "stylesheet") }
  }
  show math.equation: eq => {
    let keystone = "askjdsajklfghuiedrhguj"

    if eq.alt == keystone {
      eq
    } else {
      let alt = get-alt(eq, use-alt: false)

      // let new-eq = if eq.alt == none {
      //   math.equation(
      //     eq.body,
      //     block: eq.block,
      //     number-align: eq.number-align,
      //     numbering: eq.numbering,
      //     supplement: eq.supplement,
      //     alt: alt,
      //   )
      // } else {
      //   eq
      // }

      let new-eq = math.equation(
        eq.body,
        block: eq.block,
        number-align: eq.number-align,
        numbering: eq.numbering,
        supplement: eq.supplement,
        alt: keystone,
      )

      if eq.block {
        [
          #new-eq

          #text(fill: red)[#alt]
        ]
      } else {
        [#new-eq #text(fill: red)[(#alt)]]
      }
    }
  }
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
