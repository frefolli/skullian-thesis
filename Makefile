@all:
	pdflatex thesis.tex && pdflatex thesis.tex && cp thesis.pdf static/ && static-server -p 8080 static
