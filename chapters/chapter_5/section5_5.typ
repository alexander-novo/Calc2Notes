// chapter_5.typ

#import "../../template_notes.typ": *
#show: template
// set up heading numbering
#set heading(numbering: "1.")
#counter(heading).update(5)

#context {
  if target() == "paged" and sys.inputs.at("individualchs", default: "false") == "true" {
    [#counter(heading).update(4)
      = Review of 1225
      #set document(title: "Section 5.5")]
  }
}

// skip 5.1-5.4
#context counter(heading).step(level: 2)
#context counter(heading).step(level: 2)
#context counter(heading).step(level: 2)
#context counter(heading).step(level: 2)

== The Substitution Rule
Recall that we linked the definite integral and area under a curve to the concept of the antiderivative. We did this using the fundamental theorem of Calculus.

#emph-block[
  5.5 Learning Objectives:
  - I can use a substitution to undo the chain rule when antidifferentiating.
  - I can change the bounds of a definite integral when I make a substitution.
  - I can try a few different things for my substitution before giving up.
]

#theorem[The Fundamental Theorem of Calculus, Pt I][
  Let #acc("f") be a function defined on the interval #math.equation($[a,b]$, alt: "a to b inclusive"). Let #math.equation($F$, alt: "capital f") be the function defined, for all #acc("x") in #math.equation($[a,b]$, alt: "the closed interval from a to b"), by
  #math.equation(
    $
      F(x) = integral_a^x f(t) dif t.
    $,
    alt: " capital f of x equals the integral from a to x of lowercase f of t d t",
  )
  Then #math.equation($F$, alt: "capital f") is continuous on #math.equation($[a,b]$, alt: "the closed interval from a to b") and differentiable on #math.equation($(a,b)$, alt: "the open interval from a to b") and #math.equation($F'(x) = f(x)$, alt: "the derivative of capital f of x is lowercase f of x") for all #acc("x") in #math.equation($(a,b)$, alt: "the open interval from a to b") so #math.equation($F$, alt: "capital f") is an antiderivative of #math.equation($f$, alt: "lowercase f").
]

#corollary[The Fundamental Theorem of Calculus, Pt II][
  If #acc("f") is a continuous function defined on #math.equation($[a,b]$, alt: "the closed interval from a to b") and #math.equation($F$, alt: "capital f") is an antiderivative of #acc("f") in #math.equation($[a,b]$, alt: "the closed interval from a to b") then
  #math.equation(
    $integral_a^b f(t) dif t = F(b) - F(a).$,
    alt: " the definite integral from a to b of f of t d t is equal to captial f of b minus capital f of a",
    block: true,
  )
]

This allows us to start evaluating definite integrals without worrying about limits of sums. Instead, to find the area under a curve, we just need an antiderivative of it.

#exercise[
  Find an antiderivative for the following functions. Check your work by taking the derivative of your answer.
  1. #math.equation($f(x) = x^3 - 2x + 1$, alt: "f of x equals x cubed minus 2 x plus 1")
  2. #math.equation($g(x) = (x+1)^10$, alt: "g of x equals x plus 1 all to the power of ten")
]

This is fine for simple functions that we can recognize that we are looking at the derivative of something. As functions get more complicated, we need more clever techniques for antideriving/integrating.

#theorem[The Substitution Rule (for Indefinite Integrals)][
  If #math.equation($u=g(x)$, alt: "u equals g of x") is a differentiable function whose range is an interval #acc("I"), and #acc("f") is continuous on #acc("I"), then
  #math.equation(
    $integral f(g(x)) g'(x) dif x = integral f(u) dif u.$,
    alt: "the integral of f of g of x times g prime of x, d x is equal to the integral of f of u, d u.",
    block: true,
  )
  Note: The Substitution Rule is the "inverse" of the Chain Rule (for derivatives).
]

#remark-block[
  There are two main things we look for when deciding to use a substitution, although there may be other less common applications.
  - First, we use a substitution when we see function composition, or a function plugged into another function.
  - Another use case is if the derivative (up to scaling by a constant) of part of the integrand also appears in the integrand.
]

#tip-block[
  To integrate #math.equation($integral f(g(x)) g'(x) dif x$, alt: "the integral of f of g of x times g prime of x, d x ."):
  1. Substitute #math.equation($u=g(x)$, alt: "u equals g of x") and #math.equation($dif u=g'(x)dif x$, alt: "d u equals g prime of x d x")
  2. Integrate with respect to #acc("u").
  3. Replace #acc("u") with #math.equation($g(x)$, alt: "g of x") in the result.
]

#example[
  Find #math.equation($integral (2x+1)/(x^2+x+3) dif x$, alt: "2 x plus 1 all over x squared plus x plus 3, d x", block: true)
]

#my-solution-block[
  We notice that #math.equation($dv(, x)(x^2 + x + 3) = 2x+1$, alt: "the derivative of x squared plus x plus 3 is 2 x plus 1"). This is our indication to try a substitution:
  #math.equation(
    $
       "Let" u & = x^2+x+3 \
      dv(u, x) & = 2x+1 \
         dif u & = 2x+1 dif x
    $,
    alt: "u equal x squared plus x plus 3. next line then d u d x equals 2 x plus 1. the next line then d u equals 2 x plus 1 d x",
    block: true,
  )
  Substituting in #acc("u") and #math.equation($2x+1 dif x$, alt: "d u equals 2 x plus 1 d x") (note we could solve this for #math.equation($dif x$, alt: "d x") and plug that in instead) we get
  #math.equation(
    $
      integral (2x+1)/(x^2+x+3) dif x & = integral 1/u dif u \
                                      & = ln|u| + C \
                                      & = ln|x^2+x+3| + C
    $,
    alt: "2 x plus 1 all over x squared plus x plus 3, d x is equivalent to the integral of 1 over u d u. The next line says this equals the natural log of absolute value u plus c. The next line says this equals the natural log of the absolute value of x squared plus x plus 3 and plus c at the end",
    block: true,
  )
]

So far we have only discussed indefinite integrals, those without bound. For definite integrals we have to be careful about the bounds when we make the substitution, since the bounds are in terms of the original variable, not our substituted variable.

#theorem[The Substitution Rule (for Definite Integrals)][
  If #math.equation($g'$, alt: "g prime") is continuous on #math.equation($[a,b]$, alt: "the closed interval from a to b") and #acc("f") is continuous on the range of #math.equation($u=g(x)$, alt: "u equals g of x"), then
  #math.equation(
    $
      integral_a^b f(g(x)) g'(x) dif x = integral_g(a)^g(b) f(u) dif u
    $,
    alt: "the integral from a to b of f of g of x times g prime of x, d x is equal to the integral from g of a to g of b of f of u, d u",
    block: true,
  )
]

#warning-block[
  When computing a definite integral with a substitution, you have two options: switch the bounds of integration to be with respect to u *or* switch the variable of integration back to #acc("x") after finding the antiderivative and use the original bounds. Note, if you do not switch the bounds, you cannot write the old bounds in terms of #acc("x") in your work on steps where you are talking about #acc("u").

  Both methods will be demonstrated in this section (and probably throughout these notes), you are free to choose your favorite method, use either, etc.
]

#example[
  Evaluate #math.equation($display(integral_1^e (ln(x))^2/(2x) dif x).$, alt: "the integral from 1 to e of the square of the natural log of x all over 2 times x, d x.")
]

#my-solution-block[
  We see a function composition, #math.equation($ln(x)$, alt: "natural log of x") looks like it has been plugged into something else. We pick that as #acc("u").
  #math.equation(
    $
      "Let" u & = ln(x) \
        dif u & = 1/x dif x. \
    $,
    alt: "let u equal natural log of x then d u equals 1 over x d x.",
    block: true,
  )
  We also need to change the bounds of integration
  #math.equation(
    $
      u(e) & = ln(e) = 1 \
      u(1) & = ln(1) = 0 \
    $,
    alt: "u evaluated at x equals e is natural log of e is 1 and u evaluated at x equals 1 is natural log of 1 is 0",
    block: true,
  )
  The integral then is
  #math.equation(
    $
      integral_1^e (ln(x))^2/(2x) dif x & = integral_0^1 u^2/2 dif u \
                                        & = [1/6 u^3]_0^1 \
                                        & = 1/6
    $,
    alt: "the integral from 1 to e of the square of the natural log of x all over 2 times x, d x equals the integral from 0 to 1 of u squared over 2 ,d u. this is then 1 sixth times u cubed evaluated from 0 to 1 which is one sixth",
    block: true,
  )
]

Notice in the method above, since we changed the bounds of the integral to be in terms of #acc("u"), we did not need to plug in #math.equation($u=ln(x)$, alt: "u equals natural log of x") again. Changing the bounds tends to be faster in most examples, and if you don't change the bounds you have to be much more careful with notation.

#note-block[
  An optional bit of notation for clarity on bounds may be useful. To remember you have to change the bounds of integration when doing a substitution you can write the variable name in the lower bound. For example,
  #math.equation(
    $
      integral_(x=1)^e (ln(x))^2/(2x) dif x & = integral_(u=0)^1 u^2/2 dif u.
    $,
    alt: "the integral from x equals 1 to e of the square of the natural log of x all over 2 times x, d x equals the integral from u equals 0 to 1 of u squared over 2 ,d u.",
    block: true,
  )
  This kind of extra notation for clarity can act as training wheels as you get used to the substitution step of changing bounds, but also this notation becomes _very_ useful in multivariable calculus.
]

Here are some less obvious substitution problems.

#example[
  Evaluate #math.equation($display(integral_0^(pi/16) tan(4x) dif x.)$, alt: "the integral from 0 to pi over 16 of tangent of 4 x, d x.")
]
#my-solution-block[
  It seems that #math.equation($4x$, alt: "4x") has been plugged into the tangent function. However, using this as our #acc("u") would not change the fact that we don't have a known antiderivative for #math.equation($tan(u)$, alt: "tangent of u"). To see the substitution, sometimes we need to rewrite problems
  #math.equation(
    $
      integral_0^(pi/16) tan(4x) dif x & = integral_0^(pi/16) sin(4x)/cos(4x) dif x
    $,
    alt: "the integral from 0 to pi over 16 of tangent of 4 x, d x equals the integral from 0 to pi over 16 of sine of 4 x over cosine of 4 x, d x",
    block: true,
  )
  Now we can see a function and (a constant multiple of) its derivative: #math.equation($dv(, x)cos(4x)=-4sin(4x)$, alt: "the derivative with respect to x of cosine of 4 x is negative 4 times sine of 4 x"). This becomes our candidate for #acc("u")
  #math.equation(
    $
           "Let" u & = cos(4x) \
      "then" dif u & = -4 sin(4x) dif x \
        -1/4 dif u & = sin(4x) dif x
    $,
    alt: "let u equal cosine of 4 x. then d u equals negative 4 times sine of 4 x, d x. then negative 1 fourth d u is equal to sine of 4 x, d x",
    block: true,
  )
  (notice we can solve for #math.equation($dif x$, alt: "d x") and plug that in, but after we sub #acc("u") we can see we have the #math.equation($sin(4x) dif x$, alt: "sine of 4 x, d x") there anyway) and the bounds are changed to
  #math.equation(
    $
      u(pi/16) & = sqrt(2)/2 \
          u(0) & = 1
    $,
    alt: "u of pi over sixteen is square root of 2 over 2, and u of 0 is 1",
    block: true,
  )
  then
  #math.equation(
    $
      integral_0^(pi/16) sin(4x)/cos(4x) dif x & = integral_1^(sqrt(2)/2) -1/4 1/u dif u. \
    $,
    alt: "the integral from 0 to pi over 16 of sine of 4 x over cosine of 4 x, d x becomes the integral from 1 to square root of 2 over 2 of negative one fourth times 1 over u, d u.",
    block: true,
  )
  The antiderivative of #math.equation($1/u$, alt: "1 over u") is #math.equation($ln(u)$, alt: "natural log of u"). So,
  #math.equation(
    $
      integral_0^(pi/16) sin(4x)/cos(4x) dif x & = [-1/4 ln|u| ]_1^(sqrt(2)/2) \
                                               & = -1/4 ln(sqrt(2)/2)
    $,
    alt: "the integral from 0 to pi over 16 of sine of 4 x over cosine of 4 x, d x becomes negative one fourth times the natural log of the absolute value of u evaluated from 1 to root 2 over 2. which is negative one fourth times natural log of root 2 over 2",
    block: true,
  )
  (Optionally,) This could be further simplified by
  #math.equation(
    $-1/4 ln(sqrt(2)/2) = -1/4(ln(sqrt(2)-ln(2))) = -1/4(1/2 ln(2)-ln(2)) = -1/4(-1/2ln(2)) = ln(2)/8$,
    alt: "negative one fourth times natural log of root 2 over 2 is negative one fourth times the difference of l n of root 3 minus l n of 2 which becomes negative one fourth times half l n of 2 minus l n of 2 which is just negative 1 fourth times negative one half times l n 2 or just l n of 2 over 8.",
  )
]

#example[
  Find #math.equation($display(integral x^2 root(3, x+1) dif x)$, alt: "integral of x squared times cube root of quantity x plus 1, d x")
]
This is another common type of substitution problem that doesn't follow the usual patterns. You can recognize these types of problems by the product of a polynomial (in this case #math.equation($x^2$, alt: "x squared")) and another polynomial to some exponent (in this case #math.equation($root(3, x+1)$, alt: " cube root of x plus 1")).
#my-solution-block[
  Let #math.equation($u=x+1$, alt: "u equal x plus 1"). Then #math.equation($dif u = dif x$, alt: "d u equals d x"). Note, that we also need something to plug into the #math.equation($x^2$, alt: "x squared") term, so solving for #acc("x") we have #math.equation($x=u-1$, alt: "x equals u minus 1") so #math.equation($x^2=(u-1)^2$, alt: "x squared is quantity u minus 1 squared"). Then,
  #math.equation(
    $
      integral x^2 root(3, x+1) dif x & = integral (u-1)^2 root(3, u) dif u \
                                      & = integral (u^2-2u+1) root(3, u) dif u \
                                      & = integral (u^2 u^(1/3)-2u u^(1/3)+1u^(1/3)) dif u \
                                      & = integral u^(7/3) - 2 u^(4/3) + u^(1/3) dif u
    $,
    alt: "integral of x squared times cube root of quantity x plus 1, d x becomes the integral of u minus 1 squared, all times the cuberoot of u, d u. expanding we have the integral of u squared minus 2 u plus 1 all times the cube root of u, d u. then distributing we have integral of u squared times u to the one third minus 2 u times u to the one third plus 1 times u to the one third, du . simplifying we have the integral of u to the 7 thirds minus 2 u to the 4 thirds plus u to the 1 third, du",
    block: true,
  )
  Note: because we moved the polynomial with multiple terms to the integer exponent, we could manually expand and distribute. Now we only need to use power rule a few times. Integrating we get
  #math.equation(
    $
      integral u^(7/3) - 2 u^(4/3) + u^(1/3) dif u & = 3/10 u^(10/3) - 6/7 u^(7/3) + 3/4 u^(4/3) + C \
                                                   & = 3/10 (x+1)^(10/3) - 6/7 (x+1)^(7/3) + 3/4 (x+1)^(4/3) + C.
    $,
    alt: "the integral of u to the 7 thirds minus 2 u to the 4 thirds plus u to the 1 third, du equals 3 tenths times u to the ten thirds minus six sevenths times u to the seven thirds plus 3 fourths times u to the four thirds plus c. then this is 3 tenths times x plus 1 to the ten thirds minus six sevenths times x plus 1 to the seven thirds plus 3 fourths times x plus 1 to the four thirds plus c.",
    block: true,
  )
]

#emph-block[
  5.5 Section Summary:
  - We reviewed the fundamental theorem of calculus, linking the area under a curve to the antiderivative of the function.
  - We learned about one solution method for integrals: making a substitution.
  - We noticed how the bounds of the integral change when we make substitutions.
]
