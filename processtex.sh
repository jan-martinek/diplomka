#!/bin/sh

# cd /Users/janmartinek/Documents/Projekty/diplomka

mkdir out

cp thesis.tex out/thesis.tex
cp structure.tex out/structure.tex
cp sources.bib out/sources.bib

# copy assets
for file in ./assets/* ./latex/*
do
	filenameWithExt=$(basename "$file")
	cp $file out/$filenameWithExt
	echo "$filenameWithExt copied..."
done

# pandoc md -> latex
for file in ./src/*.md
do
	filenameWithExt=$(basename "$file")
	filename="${filenameWithExt%.*}"
	pandoc $file -o out/$filename.tex
	echo "Markdown file $filename.md has been converted to TeX..."
done

# czech quotes - pandoc/latex workaround
for file in ./out/[0-9]*.tex
do
	filenameWithExt=$(basename "$file")
	sed "s/\`\`/\\\enquote{/" $file > out/$filenameWithExt.tmp
	sed "s/''/}/" out/$filenameWithExt.tmp > out/$filenameWithExt.tmp2
	rm out/$filenameWithExt.tmp
	mv out/$filenameWithExt.tmp2 $file
	echo "Czech quotes on $filenameWithExt applied."
done

cd out

# do the latex work
pdflatex thesis.tex # creates .aux file which includes keywords of any citations
bibtex thesis # uses the .aux file to extract cited publications from the database in the .bib file, formats them according to the indicated style, and puts the results into in a .bbl file
pdflatex thesis.tex # inserts appropriate reference indicators at each point of citation, according to the indicated bibliography style
pdflatex thesis.tex # refines citation references and other cross-references, page formatting and page numbers

