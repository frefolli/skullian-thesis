@all:
	pdflatex thesis.tex && pdflatex thesis.tex

clean:
	rm -rf $$(find . -name "*.aux" -not -path '*/.*')
	rm -rf $$(find . -name "*.log" -not -path '*/.*')
	rm -rf $$(find . -name "*.idx" -not -path '*/.*')
	rm -rf $$(find . -name "*.out" -not -path '*/.*')
	rm -rf $$(find . -name "*.ilg" -not -path '*/.*')
	rm -rf $$(find . -name "*.ind" -not -path '*/.*')
