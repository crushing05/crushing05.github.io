

cv:
	tail +19 cv-pandoc.md > cv-body.md
	pandoc -S cv-body.md -o cv-body.tex
	perl -p -i -e "s/~/\\\ /g" cv-body.tex
	perl -p -i -e "s/‐/-/g" cv-body.tex
	perl -p -i -e "s/itemsep1pt/itemsep3pt/g" cv-body.tex
	latexmk RushingCV.tex
	pandoc cv-body.md -o cv-body-clean.md
	cat cv-header.txt cv-body-clean.md > RushingCV.txt
	perl -p -i -e "s/–/--/g" RushingCV.txt
	rm cv-body.md
	#rm cv-body.tex
	rm cv-body-clean.md
	rm *.log *.out *.aux *.fdb_latexmk *.fls
	# and pre-process the HTML with pandoc
	# because redcarpet markdown doesn't do definition lists
	pandoc -S cv-pandoc.md -o cv-temp.html
	cat cv-pandoc-header.md cv-temp.html > cv.html
	rm cv-temp.html

docx:
	pandoc -S -s cv-pandoc.md -o rushing-cv.docx

latex2rtf:
	latex2rtf RushingCV.tex



local:
	jekyll build

cleanbib:
	bibtool refs.bib -s > refs2.bib
	mv refs2.bib refs.bib
