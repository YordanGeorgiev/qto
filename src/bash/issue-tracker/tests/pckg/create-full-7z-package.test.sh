# src/bash/issue-tracker/funcs/create-full-7z-package.test.sh

# v1.1.0
# ---------------------------------------------------------
# todo: add doTestCreateFull7zPackage comments ...
# ---------------------------------------------------------
doTestCreateFull7zPackage(){

	doLog "DEBUG START doTestCreateFull7zPackage"
	
	cat doc/txt/issue-tracker/tests/pckg/create-full-7z-package.test.txt
	
	doSpecCreateFull7zPackage
	doHelpCreateFull7zPackage

	# add your action implementation code here ... 
	bash src/bash/issue-tracker/issue-tracker.sh -a create-full-7z-package

	doLog "DEBUG STOP  doTestCreateFull7zPackage"
}
# eof func doTestCreateFull7zPackage


# eof file: src/bash/issue-tracker/funcs/create-full-7z-package.test.sh
