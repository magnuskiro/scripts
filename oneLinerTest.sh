# test script for one liners. 

# l = ls -lah if not pwd==home


if [[ ${pwd} == '/home/kiro' ]] ; then 
	cmd='ls -lh' 
else 
	cmd='ls -lsah' 
fi 
exec $cmd

