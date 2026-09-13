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
  -
]
=== Definite Integrals


#emph-block[
  7.3b Section Summary:
  -
]

