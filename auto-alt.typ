#let sequence = [a #"test"].func()
#let test-symbol = $=$.body.func()
#let styled = $bold(A)$.body.func()

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
      "integral of"
    } else if text == "→" {
      "goes to"
    } else if text == "±" {
      "plus or minus"
    } else if text == "≥" {
      "is greater than or equal to"
    } else if text == "≤" {
      "is less than or equal to"
    } else if text == ">" {
      "is greater than"
    } else if text == "<" {
      "is less than"
    } else if text == "∞" {
      "infinity"
    } else {
      text
    }
  } else if (body.func() == text) {
    body.at("text")
  } else if (body.func() == math.attach) {
    let alt = get-alt(body.base)

    if alt == "∑" {
      alt = "sum"
    } else if alt == "integral of" {
      alt = "integral"
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
    } else if alt.ends-with("|") and body.has("b") {
      alt = alt.match(regex("(.*)\|$")).at("captures").at(0) + " evaluated "

      if body.has("t") {
        alt += " from " + get-alt(body.b) + " to " + get-alt(body.t)
      } else {
        alt += " at " + get-alt(body.b)
      }
    } else {
      if (body.has("t")) {
        if body.t.func() == test-symbol {
          let new-alt = " " + get-alt(body.t)

          if (new-alt == " ∗") {
            new-alt = " star"
          }

          alt += new-alt
          if (body.has("b")) {
            alt += " sub "
            alt += get-alt(body.b)
          }
        } else {
          if (body.has("b")) {
            alt += " sub "
            alt += get-alt(body.b)
          }
          let temp = " to the power of " + get-alt(body.t)

          alt += if temp == " to the power of 2" {
            " squared"
          } else if temp == " to the power of 3" {
            " cubed"
          } else {
            temp
          }
        }
      } else if body.has("b") {
        alt += " sub " + get-alt(body.b)
      }

      if body.has("tr") {
        alt += " " + get-alt(body.tr)
      }
    }

    alt
  } else if body.func() == math.lr {
    get-alt(body.body)
  } else if body.func() == math.op {
    let temp = get-alt(body.text) + " of"

    if temp == "sin of" {
      "sine of"
    } else if temp == "cos of" {
      "cosine of"
    } else if temp == "tan of" {
      "tangent of"
    } else if temp == "cot of" {
      "cotangent of"
    } else if temp == "sec of" {
      "secant of"
    } else if temp == "csc of" {
      "cosecant of"
    } else {
      temp
    }
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
        let temp = "root " + get-alt(body.index)
        if temp == "root 2" {
          "square root"
        } else if temp == "root 3" {
          "cube root"
        } else {
          temp
        }
      } else {
        "square root"
      }
        + " of "
        + get-alt(body.radicand)
    )
  } else if body.func() == math.primes {
    let alt = ""
    let i = 0
    while i < body.count {
      i = i + 1

      alt += " prime"
    }
    alt
  }
}

// Can use auto-alt($<...>$) to create an equation with automatically-generated alt text
#let auto-alt(eq, ignore_alt: true) = {
  if eq.alt != none and not ignore_alt {
    eq
  } else {
    let alt = get-alt(eq)

    math.equation(
      block: eq.block,
      number-align: eq.number-align,
      numbering: eq.numbering,
      supplement: eq.supplement,
      eq.body,
      alt: alt,
    )
  }
}

// Automatically applies auto-alt() to all equations with missing alt text as a show rule
#let apply-auto-eq-alt(body) = {
  show math.equation.where(alt: none): auto-alt.with(ignore_alt: false)
  body
}

// Show the alt text of all equations after the equation. Screws with labels, so this should only be used as a temporary check
#let show-eq-alt(body) = {
  show math.equation: eq => {
    if eq.alt == none {
      eq
    } else if eq.has("label") and repr(eq.label) == "<__extra-marker>" {
      eq
    } else {
      if eq.block {
        [
          #eq <__extra-marker>

          #text(fill: red)[#eq.alt]
        ]
      } else {
        [#eq <__extra-marker> #text(fill: red)[(#eq.alt)]]
      }
    }
  }
  body
}
