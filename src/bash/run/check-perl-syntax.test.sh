# src/bash/qto/funcs/check-perl-syntax.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestCheckPerlSyntax comments ...
# ---------------------------------------------------------
doTestCheckPerlSyntax(){

	do_log "DEBUG START doTestCheckPerlSyntax"
	
	cat doc/txt/qto/tests/perl/check-perl-syntax.test.txt
	sleep "$sleep_interval"

	bash src/bash/qto/qto.sh -a check-perl-syntax
   local _rc=$?
	do_log " check-perl-syntax-1 exit_code: $_rc "

   sleep "$sleep_interval"
   test $_rc -ne 0 && return

	do_log "DEBUG STOP  doTestCheckPerlSyntax"
}
# eof func doTestCheckPerlSyntax


# eof file: src/bash/qto/funcs/check-perl-syntax.test.sh
