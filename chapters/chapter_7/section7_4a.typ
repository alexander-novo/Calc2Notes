// chapter_5.typ

#import "./../../template_notes.typ": *
#import "@preview/diverential:0.3.0": *
#show: template

// set up heading numbering
#set heading(numbering: "1.")
#counter(heading).update(6)
#context {
  //if individual pdfs
  if target() == "paged" and sys.inputs.at("individualchs", default: "false") == "true" {
    [ #set document(title: "Section 7.4a")
      = Integration Techniques

    ]
  }
}
#counter(heading).step(level: 2)
#counter(heading).step(level: 2)
#counter(heading).step(level: 2)
== Integration by Partial Fractions


// any functions and templating you want for just this chapter can go here

// content
#emph-block[
  7.4a Learning Objectives
  - I can understand how to rewrite rational functions as a sum of partial fractions.
  - I can understand when and how to integrate by partial fractions.
]

#theorem[Fundamental Theorem of Algebra][
  If #inline_eq($P(x)$, "p of x") is a polynomial with real coefficients, then #acc("P") can be factored into linear #inline_eq($(a x + b)$, "a x plus b") and irreducible quadratic #inline_eq($(a x^2 + b x + c)$, "a x squared plus b x plus c") factors.
  #block_eq(
    $P(x)=underbrace((a_1 x + b_1)...(a_n x + b_n), "linear")underbrace((A_1 x^2 + B_1 x + C_1)...(A_m x^2 + B_m x + C_m), "quadratic")$,
    "P of x equals a one x plus b one times dot dot dot times a n x plus b n times a one x squared plus b one x plus c one times dot dot dot a m x squared plus b m x plus c m.",
  )
]

#emph-block[
  7.4a Section Summary:
]

