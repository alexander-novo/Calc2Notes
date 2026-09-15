// chapter_5.typ

#import "./../../template_notes.typ": *
#import "@preview/diverential:0.3.0": *
#show: template

// set up heading numbering
#set heading(numbering: "1.")
#context {
  //if individual pdfs
  if target() == "paged" and sys.inputs.at("individualchs", default: "false") == "true" {
    [ #set document(title: "Section 7.1b")
      #counter(heading).update(6)
      = Integration Techniques
      == Integration by Parts
    ]
  } else {
    counter(heading).update(7)
    counter(heading).step(level: 2)
  }
}

#counter(heading).step(level: 3)
#counter(heading).step(level: 3)

// any functions and templating you want for just this chapter can go here

// content
=== Definite Integrals

#emph-block[
  7.1b Learning Objectives
  - I can use integration by parts to solve definite integrals.
  - I understand when and how to use integration by parts.
  - I can choose an appropriate #acc("u") and #acc("v").
  - I can use integration by parts to reduce integrals.
]

Recall the product rule once more to see what we do when the integrals have bounds.

Product Rule: #math.equation($dv(, x)[f(x) g(x)] = f(x) g'(x) + f'(x) g(x)$, alt: "d by d x of f of x times g of x is f of x times g prime of x plus f prime of x g of x", block: true)

Integrating both sides from #acc("a") to #acc("b"), and rearranging slightly, we end up with the following
#math.equation(
  $
                                dv(, x)[f(x) g(x)] & = f(x) g'(x) + f'(x) g(x) \
                                    f(x) g(x)|_a^b & = integral_a^b f(x) g'(x) dif x + integral_a^b f'(x) g(x) dif x \
    f(x) g(x)|_a^b - integral_a^b f'(x) g(x) dif x & = integral_a^b f(x) g'(x) dif x \
  $,
  alt: "d by d x of f of x times g of x is f of x times g prime of x plus f prime of x g of x. This line becomes f of x times g or x evaluated from a to b equals the integral from a to b of f of x times g prime of x d x plus the integral from a to b of f prime of x g of x d x. This line then becomes f of x times g or x minus integral from a to b of f prime of x g of x d x equals the integral from a to b of f of x times g prime of x d x ",
  block: true,
)
Relabeling the last line with a few substitutions #math.equation($u=f(x) arrow.double dif u = f'(x) dif x$, alt: "u equals f of x so d u equals f prime of x d x") and #math.equation($v=g(x) arrow.double dif v = g'(x) dif x$, alt: "v equals g of x so d v equals g prime of x d x") we end up with

#theorem[Integration by Parts for Definite Integrals][
  #math.equation(
    $ integral_a^b u dif v = [u v]_a^b - integral_a^b v dif u $,
    alt: "integral from a to b of u d v equals u v evaluated from a to b times integral from a to b v d u",
    block: true,
  )
]
#note-block[
  Note that in practice, we still have the same variable of integration before and after applying integration by parts. We aren't really substituting anything since the variables #acc("u") and #acc("v") don't stick around. This way, the bounds are still for the original variable of integration and shouldn't be changed. This is different from the substitution method, where the variable of integration does change, so the bounds must also change.
]

#example[
  Find #block_eq($integral_0^1 x 3^x dif x.$, "integral from 0 to 1 of x times 3 to the x d x")
]
#my-solution-block[
  #IBP(
    acc("x"),
    inline_eq($dif x$, "d x"),
    inline_eq($3^x dif x$, "3 to the x d x"),
    vstep: inline_eq($\ &&&=1/ln(3) 3^x$, "equals 1 over natural log of 3 times 3 to the x"),
  )
  Then we have
  #block_eq(
    $
      integral_0^1 x 3^x dif x & = [x/ln(3) 3^x ]_0^1 - integral_0^1 1/ln(3) 3^x dif x \
                               & = [1/ln(3) 3 - 0 ] - [1/(ln(3))^2 3^x]_0^1 \
                               & = 3/ln(3) - [3/(ln(3))^2 -1/(ln(3))^2] \
                               & = 3/ln(3) - 2/(ln(3))^2
    $,
    "integral from 0 to 1 of x times 3 to the x d x equals x over natural log 3 times 3 to the x evaluated from 0 to 1 minus the integral form 0 to 1 of 1 over natural log 3 times 3 to the x d x. This becomes 1 over natural log 3 times 3 minus 0 all minus 1 over the square of natural log 3 times 3 to the x evaluated from x equals 0 to 1. This becomes 3 over natural log 3 minus quantity 3 over square of natural log 3 minus 1 over the square of natural log 3. This becomes 3 over natural log 3 minus 2 over the square of natural log 3.",
  )
]

#example[
  Find #block_eq($integral_0^1 arctan(x) dif x.$, "the itnegral form 0 to 1 of arctan of x d x")
]
#my-solution-block[
  We want to pick #inline_eq($u=arctan(x)$, "u equals arctan of x") since inverse trig functions get simpler (for integrating) after we take the derivative. Notice that this just leaves #inline_eq($dif v = dif x$, "d v equals d x"). That is okay, and can sometimes be helpful even!
  #IBP(
    inline_eq($arctan(x)$, "arctan of x"),
    inline_eq($1/(1+x^2) dif x$, "one over 1 plus x squared d x"),
    inline_eq($dif x$, "d x"),
    v: inline_eq($x$, "x"),
  )
  Then
  #block_eq(
    $
      integral_0^1 arctan(x) dif x & = [x arctan(x)]_0^1 - integral_0^1 x/(1+x^2) dif x \
                                   & = pi/4 - 0 - integral_0^1 x/(1+x^2) dif x
    $,
    "the itnegral form 0 to 1 of arctan of x d x equals x times arctan of x evaluated from 0 to 1 all minus the integral from 0 to 1 of x over 1 plus x squared d x. This becomes pi over 4 minus 0 minus the integral from 0 to 1 of x over 1 plus x squared d x.",
  )
  Now we just need to evaluate
  #block_eq($integral_0^1 x/(1+x^2) dif x$, "the integral from 0 to 1 of x over 1 plus x squared d x.")
  Take a second to finish this on your own before checking the solution below. You know how to do this.

  We need a substitution, since we see a function and its derivative: Let #inline_eq($w=1+x^2$, "w = 1 plus x squared"). Then #inline_eq($dif w = 2x dif x$, "d w equals 2 x d x"). Since this is an actual substitution, we need to change the bounds as well #inline_eq($w(0)=1$, "w of 0 equals 1") and #inline_eq($w(1)=2$, "w of 1 equals 2"). Lastly, if you want to call this #acc("u") instead of #acc("w"), that is fine too. I just picked something to avoid confusion with integration by parts.
  Then
  #block_eq(
    $
      integral_0^1 x/(1+x^2) dif x & = 1/2 integral_1^2 1/w dif w \
                                   & = 1/2 [ln|w| ]_1^2 \
                                   & = 1/2 ln(2)
    $,
    "the integral from 0 to 1 of x over 1 plus x squared d x = one half times the integral from 1 to 2 of 1 over w d w. This is one half times natural log of absolute value of w evaluated from 1 to 2. Then this is one half times natural log of 2",
  )
  Altogether
  #block_eq(
    $
      integral_0^1 arctan(x) dif x & = pi/4 - 1/2 ln(2).
    $,
    "the integral form 0 to 1 of arctan of x d x equals pi over 4 minus one half times natural log of 2.",
  )

]

#exercise[
  Find #block_eq($integral_3^5 ln(x) dif x.$, "the integral from 3 to 5 of natural log of x d x")
]

Sometimes you have to use integration by parts multiple times to solve an integral. This happens with powers of trig functions, "double transendental functions", and some other things.

#example[
  Find #block_eq($integral e^x cos(x) dif x.$, "integral of e to the x times cosine of x d x")
]
When thinking about what to pick for #acc("u") here, if we pick either #inline_eq($e^x " or " cos(x)$, "e to the x or cosine of x") we run into similar problems: nothing ever really changes.

We can take advantage of the fact that nothing really changes by some really slick algebra shown in the following solution.
#my-solution-block[
  Let's give the thing we want to find a name: Let #inline_eq($I=integral e^x cos(x) dif x$, "I equal integral of e to the x times cosine of x d x").

  Now, apply integration by parts a few times (picking the same type of thing for #acc("u")) until you see #acc("I") show up again, like so
  #IBP(
    inline_eq($cos(x)$, "cosine of x"),
    inline_eq($-sin(x) dif x$, "minus sine of x d x "),
    inline_eq(
      $e^x dif x$,
      "e to the x d x",
    ),
    v: inline_eq($e^x$, "e to the x"),
  )
  #block_eq(
    $
      I & = integral e^x cos(x) dif x \
        & = cos(x)e^x - underbrace(integral e^x (-sin(x)) dif x, eq.not I)
    $,
    "I equal integral of e to the x times cosine of x d x equals cosine of x times e to the x minus the integral of e to the x times negative sine of x d x. This integral is not equal to I.",
  )
  Since the thing in the integral is not #acc("I"), we repeat on this new integral term.
  #IBP(
    inline_eq($-sin(x)$, "minus sine of x  "),
    inline_eq($-cos(x)dif x$, "minus cosine of x d x"),
    inline_eq(
      $e^x dif x$,
      "e to the x d x",
    ),
    v: inline_eq($e^x$, "e to the x"),
  )
  Then
  #block_eq(
    $
      I & = integral e^x cos(x) dif x \
        & = cos(x)e^x - [integral e^x (-sin(x)) dif x] \
        & = cos(x)e^x - [-sin(x)e^x - integral e^x (-cos(x)) dif x] \
        & = cos(x)e^x + sin(x)e^x - underbrace(integral e^x cos(x) dif x, = I) \
    $,
    "I equal integral of e to the x times cosine of x d x equals cosine of x times e to the x minus the integral of e to the x times negative sine of x d x. This is equal to cosine of x times e to the x minus the integral of e to the x times minus sine of x d x. Then this becomes cosine of x times e to the x minus the quantity negative sine of x times e to the x minus integral of e to the x times negative cosine of x d x. A little algebra and this becomes cosine of x times e to the x plus sine of x e to the x minus the integral of e to the x times cosine of x d x. This integral term is exactly the same one we started with, I.",
  )
  So we end up with the algebraic equation which we can solve for the answer, #acc("I"):
  #block_eq(
    $
        I & = cos(x)e^x + sin(x)e^x - I \
      2 I & = cos(x)e^x + sin(x)e^x \
        I & = 1/2 [cos(x)e^x + sin(x)e^x]
    $,
    "I equals cosine of x times e to the x plus sine of x e to the x minus I. So then 2 I equals cosine of x times e to the x plus sine of x e to the x. Thus, I equals one half of the quantity cosine of x times e to the x plus sine of x e to the x.",
  )

]

#exercise[
  Given #inline_eq($n gt.eq 2$, "n is greater than or equal to 2") is an integer, prove the *reduction formula*:
  #block_eq(
    $integral (sin(x))^n dif x = -1/n cos(x) sin^(n-1)(x) + (n-1)/n integral sin^(n-2)(x) dif x$,
    "integral of sine of x to the n d x equals negative one over n times cosine of x times sine to the n minus 1 of x plus n minus 1 over n times the integral of sine to the n minus 2 of x d x",
  )
  Alternatively, use integration by parts to find #inline_eq($integral sin^2(x) dif x$, "integral of sine squared x d x."). Hint use #inline_eq($u=sin(x)$, "u equals sine of x") for the first integration by parts step and follow similar steps as the previous problem.
]
If you want, we can go over this in office hours.



#emph-block[
  7.1b Section Summary:
  - We learned how to handle bounds on integrals when we need to use integration by parts.
  - We also looked at some examples that need multiple steps of integration by parts to solve.
]

