#!/bin/bash 

# v1.0.0
#------------------------------------------------------------------------------
# print the help for the create-full-7z-package functionality
#------------------------------------------------------------------------------
doHelpCreateFull7zPackage(){

	doLog "INFO ::: START ::: create-full-7z-package.help" ;

	cat doc/txt/issue-tracker/helps/pckg/create-full-7z-package.help.txt

	sleep $sleep_interval
   printf "\033[2J";printf "\033[0;0H"

	doLog "INFO ::: STOP  ::: create-full-7z-package.help" ;
}
#eof help doCreateFullPackage

