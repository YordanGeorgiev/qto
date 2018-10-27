#!/bin/bash 

# v1.0.0
#------------------------------------------------------------------------------
# print the specs for the create-full-7z-package functionality
#------------------------------------------------------------------------------
doSpecCreateFull7zPackage(){

	doLog "INFO ::: START ::: create-full-7z-package" ;

	cat doc/txt/issue-tracker/specs/pckg/create-full-7z-package.spec.txt
	
	sleep $sleep_interval
   printf "\033[2J";printf "\033[0;0H"

	doLog "INFO ::: STOP  ::: create-full-7z-package" ;
}
#eof spec doCreateFullPackage

