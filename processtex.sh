#!/bin/sh

# cd /Users/janmartinek/Documents/Projekty/diplomka

mkdir output

cp thesis.tex output/thesis.tex
echo "File thesis.tex copied..."

cp apa-good.bst output/apa-good.bst
cp sources.bib output/sources.bib
echo "File sources.bib copied..."

# copy assets
for file in ./assets/* ./latex/*
do
	filenameWithExt=$(basename "$file")
	cp $file output/$filenameWithExt
	echo "$filenameWithExt copied..."
done

for file in ./*.md
do
	filenameWithExt=$(basename "$file")
	filename="${filenameWithExt%.*}"
	pandoc $filename.md -o output/$filename.tex
	echo "Markdown file $filename.md has been converted to TeX..."
done

cd output
mkdir out

pdflatex thesis.tex
bibtex thesis
pdflatex thesis.tex
pdflatex thesis.tex


# rmdir out
# mkdir out
# cd out
# mkdir x


# pandoc -s testing.md -o testing.tex
# pdflatex -output-directory /Users/janmartinek/Documents/Projekty/diplomka/out thesis.tex



