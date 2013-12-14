#!/bin/bash

: <<'END'

## Description
This script compiles latex documents automatically on change.  

## Requirements
* texlive-latex-extra

## Where it works
Linux: with pdlatex and texlive-extra

28.09.13 - Refactored, working on my LMDE. Not tested with windows.  

## Use
* Continous mode(default) needs the atleast one argument, the tex file to
compile.  
* Single compile mode need '-s' and the tex file to compile as arguments.  

## Exmples.
* single compile: 
	compile -s file.tex
* single compile with log file
	compile -s file.tex
* single compile with auto open pdf.
	compile -es file.tex -l log_file.log
* continous compile 
	compile file.tex
* continous compile with log file. 
	compile file.tex

# Specifics and explenations.
compiling twice because once might not do the trick. 

END

echo "Pidof this: "$$
#### Variables
cont=1
startEvince=0
evincePID=0
pdf=""
texFile=""
log=""
#### END variables

#### Functions
Cleanup (){
    # removes garbage after compile. 
	logFile=`echo "$texFile" | cut -d'.' -f1`.log
	# *.aux
    rm -f *.toc *.out *.snm *.nav *.dvi *.lof $logFile $1 
}
WordCount () {
	# get the  wordcount for the current document. 
    wc=`pdftotext $pdf - | wc -w`
    echo "Word count is: $wc "
}
startEvince () {
	### start evince to display the pdf.
    # if the pdf file exists and the evincePid is 0,
    # we assume that evince is running when the pid!=0 
    # drawback is that we don't kill the evince process.  

    #file="/proc/"$evincePID
    #if [ -f $pdf ] && [ ! -f $file ];
	if [ $# -eq 0 ] && [ $startEvince -eq 1 ];
    then
		# TODO pipe evince errors to /dev/null
        evince $pdf &
    elif [ -f $pdf ] && [ $evincePID -eq 0 ] && [ $startEvince -eq 1 ];
    then
		evince $pdf &
        evincePID=$!
        echo "EvincePId: "$evincePID
    fi
    ### end evince start code. 
}
DoCompile () {
    eval $@  
    eval $@
    Cleanup
    WordCount
	# TODO echo if compile error. 
    startEvince
}
Compile () {
	# $1 = the texFile of the tex file. eg: main.tex
	texFile=$1
	pdf=`echo "$1" | cut -d'.' -f1`.pdf
	name=`echo "$1" | cut -d'.' -f1`

    # if log file texFile is provided.  
    if [ "$log" =  "" ];
    then
        execString="pdflatex -interaction nonstopmode $texFile > /dev/null "
		#execString="makeglossaries $name > /dev/null & bibtex $name > /dev/null & $execString"
    else
        execString="pdflatex -interaction nonstopmode $texFile > $log "
    fi
	#execString="makeglossaries $name & bibtex $name  & $execString"
	execString="bibtex $name > /dev/null & $execString"

	# adding glossry and bibliography to the compile command. 

    if [ $cont -eq 1 ] ; # if continous compiling.
    then 
		startEvince=1
		# Files to be excluded from listening by inotifywait. group regex.  
		exclude='(.*\.aux|.*\.out|.*\.toc|.*\.lof|.*\.pdf|.*\.log|.*\.aux|.*\.out|.*\.toc|.*\.lof|.*\.pdf|.*\.log|.*\.blg|.*\.bbl|.*\.lol|\..*\.swp|\..*\.swx)'
		re='^[0-9]+$' # matching number. 

		# if a file in the folder has CLOSE_WRITE og MOVE_SELF event, we read
		# the filename and recompiles the document. 
		# TODO update: use the folder to the input file, not the current directory. 
		# TODO compile only on write, not on create file. 
		# TODO check if evince won't demand focus on compile. 
		inotifywait -qmr --exclude $exclude --format '%f' -e MOVE_SELF,CLOSE_WRITE ./ | while read file;
	    do
			if ! [[ ${file} =~ $re ]];
			then 
	    		# start wait for tex file change event loop.
				echo `date +%T`" - Compiled: "${file} 
				DoCompile $execString
			fi
		done
    else
		echo `date +%T`" - (-s)Single file compile of: "$texFile
		DoCompile $execString
    fi
}
#### END Functions

#### Start Main Exectution

# no arguments --> exit. 
# Not sure if this is needed anymore. 
if [ $# -eq 0 ];
then
	echo "ERROR: Insufficient arguments"
	echo "Use: 'compile file.tex file.log'"
	exit 1
fi 

texFile=$1

# Parsing of input arguments 
while getopts "es:l:" opt; do
  case $opt in
	e)
		startEvince=1
	;;
    s) # Single compile.  
		texFile=$OPTARG
		pdf=`echo "$OPTARG" | cut -d'.' -f1`.pdf
		cont=0 # setting continous compiling off. ==> compiling only once.  
	;;
    l)
      log="`echo "$OPTARG" | cut -d'.' -f1`.log"
    ;;
    \?) echo "Invalid option: -$OPTARG" >&2 ;;
  esac
done 

Compile $texFile
exit 1

