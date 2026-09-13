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
    [ #set document(title: "Section 7.3a")
      = Integration Techniques
    ]
  }
}

#counter(heading).update(7)
#counter(heading).step(level: 2)
#counter(heading).step(level: 2)

// any functions and templating you want for just this chapter can go here

// content
== Trigonometric Substitutions
=== Motivation
#emph-block[
  7.3a Learning Objectives
  - I can understand the relationship between right triangles and substitutions.
  - I can draw triangles to represent substitutions.
  - I can understand when and how to use trigonometric substitutions.
]
Suppose we want to derive the formula for area of a circle or radius #acc("r").
#figure(image(
  "figures/trigintegralmotivation.svg",
  alt: "sketch of a graph of a circle with radius r. A right triangle in the first quadrant has been draw in with angle theta between the hypotenuse and x axis and x and y labeled.",
))
We know how to set up the integral for this using area between curves:

#block_eq(
  $A & = integral_(-r)^r underbrace(sqrt(r^2-x^2), "top")-underbrace((-sqrt(r^2-x^2)), "bottom") dif x \
  & = 2 integral_(-r)^r sqrt(r^2-x^2) dif x$,
  "A equals integral from negative r to r of square root of r squared minus x squared minus the negative square root of r squared minus x squared d x. This equals 2 times the integral from minus r to r of square root of r squared minus x squared d x",
)

Up until now, we don't have a method to evaluate this integral. Looking at a point on the circle we can use trig functions to rewrite the expressions in #acc("x") and #acc("y") into #acc("r") and #acc("theta"). We have a few options, so let's do both and compare.

#figure(table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: center + horizon,
  table.header([*Step*], [*Cosine*], [*Sine*]),
  "substitution",
  inline_eq($x=r cos(theta)$, "x equals r cosine theta"),
  inline_eq($x=r sin(theta)$, "x equals r sine theta"),

  "triangle",
  image(
    "figures/73trianglecos.svg",
    alt: "a triangle with angle theta and hypotenuse r. The opposite side is square root of r squared minus x squared and the adjacent side is x.",
  ),
  image(
    "figures/73trianglesin.svg",
    alt: "a triangle with angle theta and hypotenuse r. The opposite side is x and the adjacent side is square root of r squared minus x squared.",
  ),

  "differential",
  inline_eq($dif x = - r sin(theta) dif theta$, "d x equals negative r sine theta d theta"),
  inline_eq($dif x = r cos(theta) dif theta$, "d x equals r cosine theta d theta"),

  [bounds for #acc("theta")],
  block_eq(
    $x=-r &arrow.double theta = pi\ x=r &arrow.double theta = 0$,
    "when x is negative r, theta is pi and when x is r, theta is 0",
  ),
  inline_eq(
    $x = -r &arrow.double theta = 0\ x=r &arrow.double theta = pi/2$,
    "when x is negative r, theta is 0 and when x is r, theta is pi over 2.",
  ),

  [integral after trig sub\ steps below!],
  block_eq(
    $2 integral_pi^0 r sin(theta)(-r sin(theta)) dif theta$,
    "2 times the integral from pi to 0 of r sine theta times negative r sine theta d theta.",
  ),
  block_eq(
    $2 integral_0^(pi/2) r cos(theta)r cos(theta) dif theta$,
    "2 times the integral from 0 to pi over 2 of r cosine theta times r cosine theta d theta.",
  ),

  [integral after trig identity],
  block_eq($2 r^2 (-1)integral_pi^0 1/2(1-cos(2theta)) dif theta$, "d"),
  block_eq($2 r^2 integral_0^(pi/2) 1/2 (1+cos(2 theta)) dif theta$, "a"),

  [Observations],
  table.cell(
    [
      - bounds are flipped
      - extra negatives
    ],
    align: left + horizon,
  ),
  table.cell(
    [
      - the bounds are least to greatest
      - there are no extra negatives
    ],
    align: left + horizon,
  ),
))

For #inline_eq($x=r sin(theta)$, "x equals r sine theta") we get #inline_eq($dif x = r cos(theta) dif theta$, "d x equals r cosine theta d theta"). We have to solve little equations for #acc("theta") to get our new bounds.
#block_eq(
  $-r & = r sin(theta) arrow.double theta = pi\
  r &= r sin(theta) arrow.double theta = 0$,
  "if negative r equals r sine theta then theta equals pi. Also, if r equals r sine theta then theta equals 0.",
)
Then the integral becomes
#block_eq(
  $A & = 2 integral_(-r)^r sqrt(r^2-x^2) dif x \
  & = 2 integral_0^(pi) sqrt(r^2-(r sin(theta))^2) (r cos(theta)) dif theta\
  & = 2 integral_0^(pi) sqrt(r^2-r^2 sin^2(theta)) (r cos(theta)) dif theta\
  & = 2 integral_0^(pi) sqrt(r^2(1-sin^2(theta))) (r cos(theta)) dif theta \
  & = 2 integral_0^(pi) sqrt(r^2 cos^2(theta)) (r cos(theta)) dif theta \
  & = 2 integral_0^(pi) r |cos(theta)| (r cos(theta)) dif theta \
  & = 2 integral_0^(pi) r^2 cos^2(theta) dif theta \
  & = 2 integral_0^(pi) r^2 [1/2 (1+cos(2 theta))] dif theta\
  & = r^2 integral_0^(pi) (1+cos(2 theta)) dif theta$,
  "A equals ",
)
Then we can finish this with a quick #acc("u")-substitution, where #inline_eq($u = 2 theta$, " u equals 2 theta") and #inline_eq($dif u = 2 dif theta$, "d u equals 2 d theta") and bounds become #inline_eq($u(0) = 0$, "u of 0 equals 0") and #inline_eq($u(pi)=2pi$, "u of pi equals 2 pi"). Then
#block_eq(
  $A & = 1/2 r^2 integral_0^(2pi) 1+cos(u) dif u\
  & = 1/2 r^2 (u+sin(u))_0^(2pi) \
  & = 1/2 r^2 (2pi+0-0+0) \
  & = pi r^2$,
  "A equals one half r squared integral from 0 to 2 pi of 1 plus cosine of u d u. This becomes one half r squared times the quantity u plus sine of u evaluated from 0 to 2 pi. This becomes one half r squared times 2 pi. This is pi r squared.",
)
And so we can get the area of the circle! You can try doing the other substitution if you want, using the trigonometric identity #inline_eq($1/2 (1-cos(2theta)) = sin^2(theta)$, "one half of 1 minus cosine of 2 theta equals sine squared theta").

Ultimately, either substitution *could* work *if you are careful enough*. However, we will just show the substitutions and patterns for the trig subs that don't give extra minus signs. If you are still confused on why we do things in the order we do them, please come chat in office hours about it! (It honestly took me a while to figure this out myself!)

Here is a "more elegant" way to solve this problem, by which we mean a way that takes a lot fewer steps and uses the triangle a bit more:

We set up the integral the same way, but using trigonometric relations and the triangle reproduced here
#figure(image(
  "figures/73trianglesin.svg",
  alt: "a triangle with angle theta and hypotenuse r. The opposite side is x and the adjacent side is square root of r squared minus x squared.",
))
We can write
#block_eq(
  $cos(theta) = sqrt(r^2-x^2)/r arrow.double sqrt(r^2-x^2) = r cos(theta)$,
  "cosine of theta equals square root or r squared minus x squared over r. In other words, the square root of r squared minus x squared is r times cosine theta.",
)
Combining this with the differential, #inline_eq($dif x = r cos(theta) dif theta$, "d x equals r cosine theta d theta"), from before, we can jump straight to
#block_eq(
  $A & = 2 integral_(-r)^r sqrt(r^2-x^2) dif x\
  & = 2 integral_0^(pi) r cos(theta) r cos(theta) dif theta\
  & = 2 r^2 integral_0^(pi) cos^2(theta) dif theta$,
  "A equals 2 times the integral from negative r to r of square root of r squared minus x squared d dx. This becomes 2 times the integral from 0 to pi of r cosine theta times r cosine theta d theta. This becomes 2 r squared times the integral from 0 to pi of cosine squared theta d theta.",
)
And from this point we finish the problem similarly to before.

#note-block[
  This was a lot of writing, but I hope you found a method in here that makes sense, and you understand that there are multiple ways to do the following problems. We will try to just show you the streamlined version of this in future examples, but feel free to try other substitutions if you want the practice!
]

=== Substitutions To Use

The substitutions we will use (to avoid extra negatives) for this section will be
#figure(table(
  columns: (auto, auto, auto, auto, auto),
  inset: 7pt,
  align: center + horizon,
  table.header([*Form*], [*Trig Identity*], [*Substitution*], [*Assumptions*], [*Triangle*]),
  block_eq($sqrt(b^2x^2-a^2)$, "square root of b squared x squared minus a squared"),
  block_eq($sec^2(theta)-1=tan^2(theta)$, "secant squared theta minus 1 equals tangent squared theta"),
  block_eq($x=a/b sec(theta)$, "x equals a over b times secant theta"),
  block_eq(
    $0lt.eq theta lt pi/2,\ pi/2 lt theta lt.eq pi$,
    "0 is less than or equal to theta is less than pi over 2 or pi over two is less then theta is less than or equal to pi.",
  ),
  [#image(
    "figures/73triangle1.svg",
    alt: "right triangle with base angle theta, adjacent side a, opposite side square root of b squared x squared minus a squared, and hypotenuse b x.",
  )],
  // row break
  block_eq($sqrt(a^2-b^2x^2)$, "square root of a squared minus b squared x squared"),
  block_eq($1-sin^2(theta)=cos^2(theta)$, "1 minus sine squared theta equals cosine squared theta"),
  block_eq($x = a/b sin(theta)$, "x equals a over b times sine of theta"),
  block_eq(
    $-pi/2 lt.eq theta lt.eq pi/2$,
    "negative pi over 2 is less than or equal to theta is less than or equal to pi over 2.",
  ),
  [#image(
    "figures/73triangle2.svg",
    alt: "right triangle with base angle theta, adjacent side square root of a squared minus b squared x squared, opposite side bx, and hypotenuse a.",
  )],
  // row break
  block_eq($sqrt(a^2+b^2x^2)$, "square root of a squared plus b squared x squared"),
  block_eq($tan^2(theta)+1=sec^2(theta)$, "tangent squared theta plus 1 equals secant squared theta."),
  block_eq($x = a/b tan(theta)$, "x equals a over b tangent of theta"),
  block_eq(
    $-pi/2 lt theta lt pi/2$,
    "negative pi over 2 is less than theta is less than pi over 2.",
  ),
  [#image(
    "figures/73triangle3.svg",
    alt: "right triangle with base angle theta, adjacent side a, opposite side b x and hypotenuse square root of a squared plus b squared x squared.",
  )],
))

Note: Most of the examples you will see in this class will have #inline_eq($b=1$, "b equals 1"), but the above formulas are given for completion.

=== Indefinite Integrals
Let's do some examples.
#example[
  Evaluate #block_eq(
    $ integral (x^3)/(sqrt(4+x^2)) dif x $,
    "integral of x cubed over square root of 4 plus x squared d x",
  )
]

#my-solution-block[
  We see a weird root in the integral, so we know to try a trig sub. In this case, the form is #inline_eq($sqrt(4+x^2) arrow.squiggly sqrt(a^2+b^2x^2)$, "square root of 4 plus x squared is like the square root of a squared plus b squared x squared") where #inline_eq($a=2 " and " b=1$, "a equals 2 and b equals 1"). Then, in this form the substitution we use is #block_eq(
    $x & =a/b tan (theta) \
    x & = 2 tan(theta) \
    dif x & = 2 sec^2(theta) dif theta$,
    " x equals a over b tangent of theta, or 2 tangent of theta. Then d x equals 2 secant squared theta d theta",
  )
  This substitution gives us
  #block_eq(
    $
      integral (x^3)/(sqrt(4+x^2)) dif x & = integral ((2 tan(theta))^3)/(sqrt(4+(2tan(theta))^2)) 2 sec^2(theta) dif theta \
                                         & = 16 integral (tan^3(theta))/sqrt(4(1 + tan^2(theta))) sec^2(theta) dif theta \
                                         & = 16/2 integral (tan^3(theta))/sqrt(sec^2(theta)) sec^2(theta) dif theta \
                                         & = 8 integral tan^3(theta) sec(theta) dif theta ," for "-pi/2<theta<pi/2 \
    $,
    "integral of x cubed over square root of 4 plus x squared d x equals the cube of 2 times tangent theta all over the square root of 4 plus 2 tan theta squared this whole fraction is then multiplied by 2 secant squared theta d theta. This becomes sixteen times integral of tan cubed theta over square root of 4 times 1 plus tangent squared theta all times secant squared theta d theta. This becomes sixteen over 2 integral of tangent cubed theta over square root of secand squared theta times secant squared theta d theta. This becomes 8 times the integral of tangent cubed theta times secant theta for theta between negative pi over 2 and pi over 2.",
  )
  Now we have converted the integral into a trigonometric integral that we can solve using methods from Section 7.2.
  //todo reference 7.2?
  Now, we keep one factor of #inline_eq($tan(theta)sec(theta)$, "tangent theta times secant theta") and rewrite everything else in terms of #inline_eq($sec(theta)$, "secant theta").
  #block_eq(
    $
      integral (x^3)/(sqrt(4+x^2)) dif x & = 8 integral tan^2(theta) tan(theta) sec(theta) dif theta \
                                         & = 8 integral (sec^2(theta)-1) tan(theta) sec(theta) dif theta \
    $,
    "integral of x cubed over square root of 4 plus x squared d x equals 8 integral of tangent squared theta times tangent theta secant theta d theta. This becomes 8 integral secant squared theta minus 1 times tangent theta secant theta d theta.",
  )
  Now we have converted the trig integral into one we can solve with a #acc("u")-sub where #inline_eq($u=sec(theta)$, "u equals secant theta") so #inline_eq($dif u = sec(theta)tan(theta)dif theta$, "d u equals secant theta tangent theta d theta."). Thus,
  #block_eq(
    $
      integral (x^3)/(sqrt(4+x^2)) dif x & = 8 integral (sec^2(theta)-1) tan(theta) sec(theta) dif theta \
                                         & = 8 integral u^2-1 dif u \
                                         & = 8[(u^3)/3-u] \
                                         & = 8 [(sec^3(theta))/3-sec(theta)]
    $,
    "integral of x cubed over square root of 4 plus x squared d x equals 8 integral secant squared theta minus 1 times tangent theta secant theta d theta. This becomes 8 times the integral of u squared minus 1 d u. This becomes 8 times the quantity u cubed over 3 minus u. This becomes 8 times the quantity secant cubed of theta over three minus secant of theta.",
  )
  Lastly, the question was in #acc("x"), not #acc("theta"). So we need something to replace #inline_eq($sec(theta)$, "secant theta") with. Looking back at our substitution, we have #block_eq($x=2tan(theta) arrow.double tan(theta)=x/2 = "opp"/"adj"$, "x equals 2 tangent theta implies tangent theta equals x over 2, which is opposite over adjacent") lets us build the triangle below.

  #figure(image(
    "figures/73triangleexample1.svg",
    alt: "right triangle with base angle theta, adjacent side 2, opposite side x and hypotenuse square root of 4 plus x squared.",
  ))

  So we can see that #block_eq($sec(theta)="hyp"/"adj" = sqrt(4+x^2)/2.$, "secant theta equals hypotenuse over adjacent which is square root of 4 plus x squared all over 2.")
  Finally the antiderivative is
  #block_eq(
    $integral (x^3)/(sqrt(4+x^2)) dif x & = 8 [(sec^3(theta))/3-sec(theta)] \
    & = 8 [1/3(sqrt(4+x^2)/2)^3-sqrt(4+x^2)/2] + C$,
    "integral of x cubed over square root of 4 plus x squared d x equals 8 times the quantity secant cubed of theta over three minus secant of theta. This becomes 8 times the quantity square root of 4 plus x squared over 2 cubed over three minus square root of 4 plus x squared over 2.",
  )
]

#note-block[
  That was a really long problem. We can shorten some of the substitutions using the triangle at the end a bit sooner. Here is another way to solve the same problem:
]


#my-solution-block[
  We see a weird root in the integral, so we know to try a trig sub. In this case, the form is #inline_eq($sqrt(4+x^2) arrow.squiggly sqrt(a^2+b^2x^2)$, "square root of 4 plus x squared is like the square root of a squared plus b squared x squared") where #inline_eq($a=2 " and " b=1$, "a equals 2 and b equals 1"). Then, in this form the substitution we use is #block_eq(
    $x & =a/b tan (theta) \
    x & = 2 tan(theta) \
    dif x & = 2 sec^2(theta) dif theta$,
    " x equals a over b tangent of theta, or 2 tangent of theta. Then d x equals 2 secant squared theta d theta",
  )
  Further, we have #block_eq($x=2tan(theta) arrow.double tan(theta)=x/2 = "opp"/"adj"$, "x equals 2 tangent theta implies tangent theta equals x over 2, which is opposite over adjacent") lets us build the triangle below
  #figure(image(
    "figures/73triangleexample1.svg",
    alt: "right triangle with base angle theta, adjacent side 2, opposite side x and hypotenuse square root of 4 plus x squared.",
  ))
  Then, we can see that the square root term in our integral can be quickly replaced by a trig function:
  #block_eq(
    $sec(theta)=sqrt(4+x^2)/2arrow.double sqrt(4+x^2 = 2 sec(theta))$,
    "secant of theta equals square root of 4 plus x squared over 2 thus the squre root of 4 plus x squared is just 2 secant theta.",
  )

  This substitution gives us
  #block_eq(
    $
      integral (x^3)/(sqrt(4+x^2)) dif x & = integral ((2 tan(theta))^3)/(2sec(theta)) 2 sec^2(theta) dif theta \
                                         & = 8 integral tan^3(theta) sec(theta) dif theta ," for "-pi/2<theta<pi/2 \
    $,
    "integral of x cubed over square root of 4 plus x squared d x equals the cube of 2 times tangent theta all over 2 secant of theta this whole fraction is then multiplied by 2 secant squared theta d theta. This becomes 8 times the integral of tangent cubed theta times secant theta for theta between negative pi over 2 and pi over 2.",
  )
  Now we have converted the integral into a trigonometric integral that we can solve using methods from Section 7.2.
  //todo reference 7.2?
  Now, we keep one factor of #inline_eq($tan(theta)sec(theta)$, "tangent theta times secant theta") and rewrite everything else in terms of #inline_eq($sec(theta)$, "secant theta").
  #block_eq(
    $
      integral (x^3)/(sqrt(4+x^2)) dif x & = 8 integral tan^2(theta) tan(theta) sec(theta) dif theta \
                                         & = 8 integral (sec^2(theta)-1) tan(theta) sec(theta) dif theta \
    $,
    "integral of x cubed over square root of 4 plus x squared d x equals 8 integral of tangent squared theta times tangent theta secant theta d theta. This becomes 8 integral secant squared theta minus 1 times tangent theta secant theta d theta.",
  )
  Now we have converted the trig integral into one we can solve with a #acc("u")-sub where #inline_eq($u=sec(theta)$, "u equals secant theta") so #inline_eq($dif u = sec(theta)tan(theta)dif theta$, "d u equals secant theta tangent theta d theta."). Thus,
  #block_eq(
    $
      integral (x^3)/(sqrt(4+x^2)) dif x & = 8 integral (sec^2(theta)-1) tan(theta) sec(theta) dif theta \
                                         & = 8 integral u^2-1 dif u \
                                         & = 8[(u^3)/3-u] \
                                         & = 8 [(sec^3(theta))/3-sec(theta)]
    $,
    "integral of x cubed over square root of 4 plus x squared d x equals 8 integral secant squared theta minus 1 times tangent theta secant theta d theta. This becomes 8 times the integral of u squared minus 1 d u. This becomes 8 times the quantity u cubed over 3 minus u. This becomes 8 times the quantity secant cubed of theta over three minus secant of theta.",
  )
  Lastly, the question was in #acc("x"), not #acc("theta"). So we need something to replace #inline_eq($sec(theta)$, "secant theta") with. Looking back at our triangle, we can see that #block_eq($sec(theta)="hyp"/"adj" = sqrt(4+x^2)/2.$, "secant theta equals hypotenuse over adjacent which is square root of 4 plus x squared all over 2.")
  Finally the antiderivative is
  #block_eq(
    $integral (x^3)/(sqrt(4+x^2)) dif x & = 8 [(sec^3(theta))/3-sec(theta)] \
    & = 8 [1/3(sqrt(4+x^2)/2)^3-sqrt(4+x^2)/2] + C$,
    "integral of x cubed over square root of 4 plus x squared d x equals 8 times the quantity secant cubed of theta over three minus secant of theta. This becomes 8 times the quantity square root of 4 plus x squared over 2 cubed over three minus square root of 4 plus x squared over 2.",
  )
]

#note-block[
  A lot of the steps are the same, use whichever method above you prefer when solving these, but always draw the triangle as part of your work.
]

#example[
  Evaluate
  #block_eq(
    $
      integral (sqrt(9-x^2))/(x^2) dif x
    $,
    "integral of square root of 9 minus x squared all over x squared d x.",
  )
]

#my-solution-block[
  The form of the root in this problem is #inline_eq($sqrt(9-x^2) arrow.squiggly sqrt(a^2-b^2x^2)$, "square root of 9 minus x squared is like square root of a squared minus b squared x squared."). So, we know that we need to use the substitution
  #block_eq(
    $
          x & = a/b sin(theta) \
            & = 3 sin(theta) \
      dif x & = 3 cos(theta) dif theta
    $,
    "x equals a over b sine of theta which is 3 sine theta. Then d x is 3 cosine theta d theta.",
  )
  The triangle is then
  #figure(image(
    "figures/73triangleexample2.svg",
    alt: "right triangle with base angle theta, adjacent side square root of 9 minus x squared, opposite side x and hypotenuse 3.",
  ))

  So, the square root part of the integral becomes #inline_eq($sqrt(9-x^2)=3 cos(theta)$, "square root of 9 minus x squared equals 3 cosine theta"). The substitution gives us
  #block_eq(
    $
      integral (sqrt(9-x^2))/(x^2) dif x & = integral (3 cos(theta))/(3 sin(theta))^2 3 cos(theta) dif theta \
                                         & = integral cot^2(theta) dif theta
    $,
    "integral of square root of 9 minus x squared all over x squared d x equals the integral of 3 cosine theta over the square of 3 sine theta all times 3 cosine theta d theta. This becomes the integral of cotangent squared theta d theta.",
  )
  Now we can try solving this.
  #block_eq(
    $
      integral cot^2(theta) dif theta & = integral csc^2(theta) - 1 dif theta \
                                      & = integral csc^2(theta) dif theta - integral 1 dif theta \
                                      & = -cot(theta) - theta
    $,
    "integral of cotangent squared theta d theta equals the integral of cosecant squared theta minus 1 d theta. This becomesthe integral of cosecant squared theta d theta minus the integral of 1 d theta. This becomes negative cotangent theta minus theta.",
  )
  Lastly, we need to get back to #acc("x") for the final answer. Using the triangle from before we can see
  #block_eq(
    $cot(theta) = "adj"/"opp" = sqrt(9-x^2)/x$,
    "cotangent theta equals adjacent over opposite is square root of 9 minus x squared all over x.",
  )
  and (using any trig function, we just picked sine because we like sine/cosine and it gives a simple expression without a root)
  #block_eq(
    $sin(theta) = x/3 arrow.double theta = arcsin(x/3)$,
    "sine of theta equals x over 3 so theta is arc sine of x over 3.",
  )
  Thus, our final answer is
  #block_eq(
    $integral sqrt(9-x^2)/x^2 dif x = -sqrt(9 - x^2)/x - arcsin(x/3).$,
    "integral of square root of 9 minus x squared over x squared d x equals negative square root of 9 minus x squared all over x minus arc sine of x over 3.",
  )
]



#emph-block[
  7.3a Section Summary:
  - We figured out which trigonometric substitutions would help us simplify problems without extra negatives.
  - We used trig substitutions to simplify indefinite integrals.
  - We used right trianlges to rewrite answers in terms of the original variable.
]

