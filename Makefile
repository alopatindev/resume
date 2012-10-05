all: printable_resume

email:
	convert email.svg email.eps

resume: email
	latex resume.tex
	dvipdf resume.dvi

printable_resume: resume
	latex printable_resume.tex
	dvipdf printable_resume.dvi

clean:
	rm -f *.eps *.dvi *.pdf *.aux *.log *.out
