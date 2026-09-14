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
    [ #set document(title: "Section 7.3b")
      = Integration Techniques
      #counter(heading).step(level: 2)
      #counter(heading).step(level: 2)
      == Trigonometric Substitutions
    ]
  } else [
    #counter(heading).update(7)
    #counter(heading).step(level: 2)
    #counter(heading).step(level: 2)
    #counter(heading).step(level: 2)
  ]
}
#counter(heading).step(level: 3)
#counter(heading).step(level: 3)
#counter(heading).step(level: 3)

// any functions and templating you want for just this chapter can go here

// content
#emph-block[
  7.3b Learning Objectives
  - I can properly handle the bounds on a trigonometric substitution problem.
]
=== Definite Integrals

We touched on it in our motivating example, but we have to be more careful with bounds on these substitutions. Of course, you can find the indefinite integral and deal with bounds separately if you are careful with notation. Here we will go through an example or 2 of a definite integral where we change the bounds. This saves a lot of writing, and means we don't have to rewrite the integral in terms of #acc("x") at the end.

#example[
  Find #block_eq($integral_0^((3sqrt(3))/2) (x^3)/((4x^2+9)^(3/2)) dif x$, "integral from 0 to 3 root 3 over 2 of x cubed over quantity of 4 x squared plus 9 to the three halves d x.")
]
#my-solution-block[
  First we rewrite the integrand with something that has a root.
  #block_eq(
    $
      integral_0^((3sqrt(3))/2) (x^3)/((4x^2+9)^(3/2)) dif x & = integral_0^((3sqrt(3))/2) (x^3)/((sqrt(4x^2+9))^(3)) dif x
    $,
    "integral from 0 to 3 root 3 over 2 of x cubed over quantity of 4 x squared plus 9 to the three halves d x equalsintegral from 0 to 3 root 3 over 2 of x cubed over the square root of 4 x squared plus 9 to the third power d x ",
  )
  Now we draw the triangle. Since the root has a plus sign (instead of minus) the root term goes on the hypotenuse of the triangle. That means the #inline_eq($2x$, "2 x") is either on the opposite or the adjacent side, and the trig function that avoids the root is tangent. So the substitution we need to use is
  #block_eq(
    $      x & = 3/2 tan(theta) \
    (2x)/3 & = tan(theta) = "opp"/"adj" $,
    "x equals 3 over 2 times tangent of theta. So 2x over 3 equals tangent of theta is opposite over adjacent.",
  ).
  Now we can tell the opposite side is #inline_eq($2x$, "2 x") and the adjacent side is 3. The triangle is
  #figure(image(
    "figures/73triangleexample3.svg",
    alt: "right triangle with base angle theta, adjacent side 3, opposite side 2 x, and hypotenuse square root of 4 x squared plus 9.",
  ))
  Ok, now to get the differential
  #block_eq(
    $
          x & = 3/2 tan(theta) \
      dif x & = 3/2 sec^2(theta) dif theta
    $,
    "x equals 3 over 2 times tangent of theta so d x equals 3 over 2 secant squared theta d theta",
  )
  Lastly we need to rewrite the root expression as a trig function. The trigonometric function that includes the root term and the constant term in our triangle is cosine or secant. We know we already have secant in our problem, so we'll use that
  #block_eq(
    $
                     sec(theta) & = "hyp"/"adj" = sqrt(9+4x^2)/3 \
      arrow.double 3 sec(theta) & = sqrt(9+4x^2)
    $,
    "secant theta equals hypotenuse over adjacent equals square root of 9 plus 4 x squared over 3. So 3 secant theta is square root of 9 plus 4 x squared.",
  )
  Now we have to actually make this substitution. Plugging in #acc("x"), d#acc("x"), and #inline_eq($sqrt(9+4x^2) = 3 sec(theta)$, "square root of 9 plus 4 x squared equals 3 secant theta") gives us
  #block_eq(
    $
      integral_0^((3sqrt(3))/2) (x^3)/((sqrt(4x^2+9))^(3)) dif x = integral_square.stroked.dotted^square.stroked.dotted ((3/2 tan(theta))^3)/((3sec(theta))^3) (3/2 sec^2(theta))dif theta.
    $,
    "integral from 0 to 3 root 3 over 2 of x cubed over quantity of 4 x squared plus 9 to the three halves d x equals the integral from blank to blank of 3 halves tangent theta cubed all over 3 secant theta cubed times 3 halves secant theta d theta.",
  )
  And the new bounds are found from
  #block_eq(
    $
                 0 & = 3/2 tan(theta) arrow.double theta = 0 \
      (3sqrt(3))/2 & = 3/2 tan(theta) arrow.double sqrt(3) = tan(theta) arrow.double theta = pi/3
    $,
    "0 equals 3 over 2 tangent theta so theta is 0. And 3 root 3 over 2 equals 3 over 2 tangent theta so root 3 is tangent of theta so theta equals pi over 3.",
  )
  So now we need to solve the following integral
  #block_eq(
    $
      integral_0^(pi/3) ((3/2 tan(theta))^3)/((3sec(theta))^3) (3/2 sec^2(theta))dif theta & = 3/16 integral_0^(pi/3) (tan^3(theta))/sec(theta) dif theta \
      & = 3/16 integral_0^(pi/3) (sin^3(theta)cos(theta))/(cos^3(theta)) dif theta \
      & = 3/16 integral_0^(pi/3) tan^2(theta)sin(theta) dif theta \
      & = 3/16 integral_0^(pi/3) (sec^2(theta)-1)sin(theta) dif theta \
      & = 3/16 integral_0^(pi/3) sin(theta)/(cos(theta)) sec(theta)-sin(theta) dif theta \
      & = 3/16 integral_0^(pi/3) tan(theta) sec(theta) dif theta - 3/16 integral_0^(pi/3)sin(theta) dif theta \
      & = 3/16 [sec(theta)]_0^(pi/3) - 3/16 [-cos(theta)]_0^(pi/3) \
      & = 3/16 [2-1] + 3/16 [1/2-1] \
      & = 3/32
    $,
    "the integral from 0 to pi over 3 of 3 halves tangent theta cubed all over 3 secant theta cubed times 3 halves secant theta d theta equals 3 sixteenths integral from 0 to pi over 3 of tangent cubed theta over secant theta d theta. This simplifies a bit to 3 sixteenths integral from 0 to pi over 3 of tangent squared theta sine of theta d theta. This becomes 3 sixteenths integral from 0 to pi over 3 of secant squared theta times sine theta minus sine theta d theta. Then this becomes 3 sixteenths times the integral from 0 to pi over 3 of tangent theta secant theta d theta minus 3 sixteenths the integral form 0 to pi over 3 of sine of theta d theta. This becomes 3 sixteenths times secant theta evaluated from 0 to pi over 3 minus 3 sixteenths times negative cosine theta evaluated from 0 to pi over 3. This becomes 3 sixteenths times 2 minus 1 plus 3 sixteenths times one half minus 1. This is 3 over thirty 2.",
  )
]

#example[
  Evaluate the following definite integral. Include a drawing of the triangle used in the trig sub.
  #block_eq($integral_0^1 sqrt(x-x^2) dif x$, "integral from 0 to 1 of square root of x minus x squared d x")
]
#my-solution-block[
  We can use trig subs to help us solve even more complicated integrals! We've seen we need something with #acc("x") squared and something without #acc("x").

  Recall how to complete the square.

  #block_eq(
    $
      x-x^2 & = b - (x-c)^2 \
            & = b - (x-2 x c + c^2) \
            & = (b-c^2) + 2 c x - x^2
    $,
    "x minus x squared can be rewritten as b minus x minus c squared which would be the same as b minus x minus 2 x c plus c squared. This is b minus c squared plus 2 c x minus x squared.",
  )
  So
  #block_eq($2 c = 1 " and " b-c^2 = 0$, " 2 c equals 1 and b minus c squared equals 0")
  then
  #block_eq($c = 1/2 " and " b = 1/4$, "c equals one half and b equals one quarter")
  So we can rewrite
  #block_eq(
    $
      integral_0^1 sqrt(x-x^2) dif x & = integral_0^1 sqrt(1/4 - (x-1/2)^2) dif x \
    $,
    "integral from 0 to 1 of square root of x minus x squared d x equals integral from 0 to 1 of the square root of one quarter minus x minus one half squared.",
  )
  Setting up the triangle, the hypotenuse is #inline_eq($1/4$, "one quarter"). We know the adjacent side to be the square root term, and the opposite side to be #inline_eq($x-1/2$, "x minus one half"). Then the triangle is

  #figure(image(
    "figures/73triangleexample4.svg",
    alt: "right triangle with base angle theta, adjacent side x minus one half, opposite side square root of one quarter minus x minus one half squared, and hypotenuse one half.",
  ))
  The substitution we use is #inline_eq($1/2 sin(theta) + 1/2 = x$, "one half sine theta plus one half equals x") so #inline_eq($dif x = 1/2 cos(theta)dif theta$, "d x equals one half cosine theta d theta"), and #inline_eq($sec(theta)=sqrt(1/4 - (x-1/2)^2)/(1/2)$, "secant theta equals square root of one quarter minus x minus half squared all over one half")
  The integrand becomes
  #block_eq(
    $
      integral_0^1 sqrt(1/4 - (x-1/2)^2) dif x & = integral_square.stroked.dotted^square.stroked.dotted 1/2 sec(theta) 1/2 cos(theta) dif theta \
    $,
    "integral from 0 to 1 of the square root of one quarter minus x minus one half squared.",
  )
  The bounds become
  #block_eq(
    $
               0 & = 1/2 sin(theta) + 1/2 \
      sin(theta) & = -1 \
           theta & = -pi/2
    $,
    "theta equals negative pi over 2",
  )
  and
  #block_eq(
    $
               1 & = 1/2 sin(theta) + 1/2 \
      sin(theta) & = 1 \
           theta & = pi/2
    $,
    "theta equals pi over 2",
  )
  So the integral is an easy one it is
  #block_eq(
    $integral_(-pi/2)^(pi/2) 1/4 dif theta = pi/4$,
    "integral from negative pi over 2 to pi over 2 of one quarter d theta. this is pi over 4",
  )
]

#tip-block[
  Procedure for Trigonometric Substitution
  + Draw a right triangle with appropriate side lengths and angle #acc("theta") labeled. Write down #inline_eq($sin(theta)", " cos(theta)", and "tan(theta)$, "sine of theta, cosine of theta, and tangent of theta"), in terms of the side lengths.
  + Write down the substitution for the variable #acc("x"), calculate the differential d#acc("x"), and specify the selected values of #acc("theta") for substitution.
  + Substitute the trigonometric expression and the calculated differential into the integrand. Simplify the results algebraically.
  + Integrate the trigonometric integral, keeping in mind the restrictions on the angle #acc("theta") for reversibility.
  + Use the right triangle to reverse the substitution in the integration result and convert it back to the original variable #acc("x"). In particular, compositions of trig and inverse trig functions of #acc("x") should be avoided (final answers should be in fully simplified form).
]

#emph-block[
  7.3b Section Summary:
  - We did a definite integral that needed a trig substitution.
  - We used complete the square to evaluate a more complicated integral with a square root.
]

