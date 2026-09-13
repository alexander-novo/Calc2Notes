main_notes.pdf:
	typst compile main_notes.typ --pdf-standard ua-1 --deps test.dep --deps-format make

main_notes.html:
	typst compile main_notes.typ --format html --features html --input html-frames=true

htmls: chapters/chapter_5/section5_2.html chapters/chapter_5/section5_5.html chapters/chapter_6/section6_1.html 
htmls: chapters/chapter_6/section6_2a.html chapters/chapter_6/section6_2b.html chapters/chapter_6/section6_3.html
htmls: chapters/chapter_6/section6_4a.html chapters/chapter_6/section6_4b.html chapters/chapter_6/section6_5.html
htmls: chapters/chapter_7/section7_1a.html chapters/chapter_7/section7_1b.html chapters/chapter_7/section7_2.html
htmls: chapters/chapter_7/section7_3a.html

%.html: %.typ
	typst compile $*.typ --format html --features html --root ../.. --input html-frames=true --input individualchs=true

pdfs: chapters/chapter_5/section5_2.pdf chapters/chapter_5/section5_5.pdf chapters/chapter_6/section6_1.pdf 
pdfs: chapters/chapter_6/section6_2a.pdf chapters/chapter_6/section6_2b.pdf chapters/chapter_6/section6_3.pdf
pdfs: chapters/chapter_6/section6_4a.pdf chapters/chapter_6/section6_4b.pdf chapters/chapter_6/section6_5.pdf
pdfs: chapters/chapter_7/section7_1a.pdf chapters/chapter_7/section7_1b.pdf chapters/chapter_7/section7_2.pdf
pdfs: chapters/chapter_7/section7_3a.pdf 

%.pdf: %.typ
	typst compile $*.typ --pdf-standard ua-1 --root ../.. --input individualchs=true

clean:
	del /s /q *.html

clean_main: 
	del main_notes.pdf
	del main_notes.html

main_notes: main_notes.html main_notes.pdf

include test.dep
