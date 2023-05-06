@all:
	pdflatex thesis && biber thesis && pdflatex thesis && pdflatex thesis 

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
