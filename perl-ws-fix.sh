#!/bin/bash
echo "-- INFO: fixing whitespace and tabs in perl module and test files." 

#echo `find . -name '*.pm' -or -name '*.pl' -or -name '*.t'`

# creates backup files. 
#perl -i.bak -wple 's/ +$//g; s/\t/    /g' `find . -name '*.pm' -or -name '*.pl' -or -name '*.t'`

# no backup files. 
perl -wple 's/ +$//g; s/\t/    /g' `find . -name '*.pm' -or -name '*.pl' -or -name '*.t'`
