all: resume
#printable_resume

#email:
#	convert email.svg email.eps

resume:
	#email
	#latex -halt-on-error resume.tex
	#dvipdf resume.dvi
	pdflatex -halt-on-error resume.tex
	./optpdf.sh resume.pdf
	mv resume.pdf Alexander_Lopatin.pdf

#printable_resume: resume
#	latex printable_resume.tex
#	dvipdf printable_resume.dvi
#	./optpdf.sh printable_resume.pdf
#	#pdflatex printable_resume.tex

clean:
	rm -f *.eps *.dvi *.pdf *.aux *.log *.out
