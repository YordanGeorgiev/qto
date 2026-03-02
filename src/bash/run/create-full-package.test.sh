#!/usr/bin/env bash 

#v1.1.0
#------------------------------------------------------------------------------
# tests the full package creation
#------------------------------------------------------------------------------
doTestCreateFullPackage(){
	cd $PRODUCT_DIR
	do_log " INFO START : create-full-package.test"
	
	cat doc/txt/qto/tests/pckg/create-full-package.test.txt

	doSpecCreateFullPackage

	doHelpCreateFullPackage

	bash src/bash/qto/qto.sh -a create-full-package
   local _rc=$?
	do_log " create-relative-package.test-1 exit_code: $_rc "
   sleep "$sleep_interval"
   test $_rc -ne 0 && return

	bash src/bash/qto/qto.sh -a create-full-package -i $PRODUCT_DIR/met/.tst.qto
   local _rc=$?
	do_log " create-relative-package.test-1 exit_code: $_rc "
   sleep "$sleep_interval"
   test $_rc -ne 0 && return
	
	bash src/bash/qto/qto.sh -a create-full-package -i $PRODUCT_DIR/met/.prd.qto
   local _rc=$?
	do_log " create-relative-package.test-1 exit_code: $_rc "
   sleep "$sleep_interval"
   test $_rc -ne 0 && return
	
	bash src/bash/qto/qto.sh -a create-full-package -i $PRODUCT_DIR/met/.git.qto
   local _rc=$?
	do_log " create-relative-package.test-1 exit_code: $_rc "
   sleep "$sleep_interval"
   test $_rc -ne 0 && return
	

	do_log " INFO STOP  : create-full-package.test"
}
#eof test doCreateFullPackage
