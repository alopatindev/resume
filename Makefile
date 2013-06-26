all: resume
#printable_resume

#email:
#	convert email.svg email.eps

resume:
	#email
	latex resume.tex
	dvipdf resume.dvi
	mv resume.pdf Alexander_Lopatin.pdf
	#pdflatex resume.tex

#printable_resume: resume
#	latex printable_resume.tex
#	dvipdf printable_resume.dvi
#	#pdflatex printable_resume.tex

clean:
	rm -f *.eps *.dvi *.pdf *.aux *.log *.out
