// main_notes.typ

// put all useful functions and variables you will use across chapters in template
#import "template_notes.typ": *

#show: template


#set document(title: "Math 1226 Notes")

// some additional formatting
#show: it => context {
  set page(numbering: "1") if target() == "paged"
  it
}

// #show: show-theorion


// but don't define functions or variables there!
// chapters will not see it

#outline()

// Now the chapters themselves as some Typst content
#include "chapters/chapter_5/section5_2.typ"
#include "chapters/chapter_5/section5_5.typ"
#include "chapters/chapter_6/section6_1.typ"
#include "chapters/chapter_6/section6_2a.typ"
#include "chapters/chapter_6/section6_2b.typ"
#include "chapters/chapter_6/section6_3.typ"
#include "chapters/chapter_6/section6_4a.typ"
#include "chapters/chapter_6/section6_4b.typ"
#include "chapters/chapter_6/section6_5.typ"
#include "chapters/chapter_7/section7_1a.typ"
#include "chapters/chapter_7/section7_1b.typ"
#include "chapters/chapter_7/section7_2.typ"
#include "chapters/chapter_7/section7_3a.typ"
#include "chapters/chapter_7/section7_3b.typ"
#include "chapters/chapter_7/section7_4a.typ"
