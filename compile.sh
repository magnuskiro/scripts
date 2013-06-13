#!/bin/sh

: <<'END'

# Description
This script compiles latex documents.

# Where it works
Linux: with pdlatex and texlive-extra
win7: with git bash and mikitex 

30.04.13 After resent changes some functionality might not work anymore. 

# Use
It takes one, or two arguments. 
The first being the document and the second being the log output file. 

# Specifics and explenations.
compiling twice because once might not do the trick. 

# TODO 

TODO: add functionality for opening the pdf document in evince. 
"evince $doc &" 

TODO: add file changed listening. On write, recompile document. 

END

echo "Pidof this: "$$
name=`echo "$1" | cut -d'.' -f1`
pdf=$name".pdf" 
evincePID=0

while event=$(inotifywait -e MOVE_SELF,CLOSE_WRITE $1 > /dev/null 2>&1)
do

if [ -n "$1" ] && [ -n "$2" ];
then
	pdflatex -interaction nonstopmode $1 > $2
	pdflatex -interaction nonstopmode $1 > $2
elif [ "$1" != "" ];
then
	pdflatex -interaction nonstopmode $1 > log
	pdflatex -interaction nonstopmode $1 > log
else
	echo "usage: ./compile file.tex file.log"
	exit 1
fi

# removes garbage after compile. 
rm -f log *.toc *.aux *.out  *.snm *.nav *.dvi *.lof 

# get the  wordcount for the current document. 
wc=`pdftotext $pdf - | wc -w`

echo "Compiled '$1' with $wc words"


### start evince to display the pdf.
# if the pdf file exists and the pid is 0.
# we assume that when the pdi!=0 evince is running
# drawback is that we don't kill the evince process.  

#file="/proc/"$evincePID
#if [ -f $pdf ] && [ ! -f $file ];
if [ -f $pdf ] && [ $evincePID -eq 0 ];
then
    evince $pdf &
    evincePID=$!
    echo "EvincePId: "$evincePID
fi
### end evince start code. 

done

exit 1
