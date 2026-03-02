#!/usr/bin/env bash


# v1.1.4
#------------------------------------------------------------------------------
# creates a package from the relative file paths specified in the .dev file
#------------------------------------------------------------------------------
doTestCreateRelativePackage(){
	do_log " START : create-relative-package.test"

	doSpecCreateRelativePackage

	doHelpCreateRelativePackage
   
   #set -x
	# test the call with the include file of the current env - usually dev
   # implicit success
	bash src/bash/qto/qto.sh -a create-relative-package
   local _rc=$?
	do_log " create-relative-package.test-1 exit_code: $_rc "
   sleep "$sleep_interval"
   test $_rc -ne 0 && return
	
	# test the call with the include file of the tst env
   bash src/bash/qto/qto.sh -a create-relative-package -i met/.tst.qto
   local _rc=$?
	do_log " create-relative-package.test-2 exit_code: $_rc "
   sleep "$sleep_interval"
   test $_rc -ne 0 && return
	
	# test the call with the include file of the prd env
	bash src/bash/qto/qto.sh -a create-relative-package -i met/.prd.qto
   local _rc=$?
	do_log " create-relative-package.test-3 exit_code: $_rc "
   sleep "$sleep_interval"
   test $_rc -ne 0 && return
	
   # test the call with the include file of the prd env
   bash src/bash/qto/qto.sh -a create-relative-package -i met/.git.qto
   local _rc=$?
	do_log " create-relative-package.test-4 exit_code: $_rc "
   sleep "$sleep_interval"
   test $_rc -ne 0 && return
	
	do_log " STOP  : create-relative-package.test"
}
#eof doCreateRelativePackage
