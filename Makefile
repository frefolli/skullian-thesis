@all: thesis.pdf

extras:
	make -C diagrams

thesis.pdf: extras thesis.tex chapters/*.tex
	pdflatex thesis && bibtex thesis && pdflatex thesis && pdflatex thesis 

host: thesis.pdf
	static-server -p 8080 -i thesis.pdf

clean:
	rm -rf $$(find . -name "*.aux" -not -path '*/.*')
	rm -rf $$(find . -name "*.log" -not -path '*/.*')
	rm -rf $$(find . -name "*.idx" -not -path '*/.*')
	rm -rf $$(find . -name "*.out" -not -path '*/.*')
	rm -rf $$(find . -name "*.ilg" -not -path '*/.*')
	rm -rf $$(find . -name "*.ind" -not -path '*/.*')
	rm -rf $$(find . -name "*.bbl" -not -path '*/.*')
	rm -rf $$(find . -name "*.bcf" -not -path '*/.*')
	rm -rf $$(find . -name "*.blg" -not -path '*/.*')
	rm -rf $$(find . -name "*.run.xml" -not -path '*/.*')
	rm -rf $$(find . -name "*.toc" -not -path '*/.*')
	rm -rf $$(find . -name "*.lua" -not -path '*/.*')
	rm -rf $$(find . -name "*.in" -not -path '*/.*')
	rm -rf $$(find . -name "*-blx.bib" -not -path '*/.*')
	make -C diagrams clean
