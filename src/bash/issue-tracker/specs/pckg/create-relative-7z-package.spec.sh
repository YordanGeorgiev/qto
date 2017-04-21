# src/bash/issue-tracker/funcs/create-relative-7z-package.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecCreateRelative7zPackage comments ...
# ---------------------------------------------------------
doSpecCreateRelative7zPackage(){

	doLog "DEBUG START doSpecCreateRelative7zPackage"
	
	cat doc/txt/issue-tracker/specs/pckg/create-relative-7z-package.spec.txt

	doLog "DEBUG STOP  doSpecCreateRelative7zPackage"
	
	sleep $sleep_interval
   printf "\033[2J";printf "\033[0;0H"
	
}
# eof func doSpecCreateRelative7zPackage


# eof file: src/bash/issue-tracker/funcs/create-relative-7z-package.spec.sh
