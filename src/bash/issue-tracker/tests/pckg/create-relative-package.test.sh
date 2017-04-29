#!/bin/bash


# v1.1.4
#------------------------------------------------------------------------------
# creates a package from the relative file paths specified in the .dev file
#------------------------------------------------------------------------------
doTestCreateRelativePackage(){
	doLog " START : create-relative-package.test"

	doSpecCreateRelativePackage

	doHelpCreateRelativePackage
   
   #set -x
	# test the call with the include file of the current env - usually dev
   exit_code=0
	bash src/bash/issue-tracker/issue-tracker.sh -a create-relative-package
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	
	# test the call with the include file of the tst env
   bash src/bash/issue-tracker/issue-tracker.sh -a create-relative-package -i met/.tst.issue-tracker
   export exit_code=$?
	doLog " create-relative-package.test-2 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	
	# test the call with the include file of the prd env
	bash src/bash/issue-tracker/issue-tracker.sh -a create-relative-package -i met/.prd.issue-tracker
   export exit_code=$?
	doLog " create-relative-package.test-3 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	
   # test the call with the include file of the prd env
   bash src/bash/issue-tracker/issue-tracker.sh -a create-relative-package -i met/.git.issue-tracker
   export exit_code=$?
	doLog " create-relative-package.test-4 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	
	doLog " STOP  : create-relative-package.test"
}
#eof doCreateRelativePackage
