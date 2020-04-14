# src/bash/qto/funcs/gmail-package.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestGmailPackage comments ...
# ---------------------------------------------------------
doTestGmailPackage(){

	do_log "DEBUG START doTestGmailPackage"
	
   cat doc/txt/qto/tests/pckg/gmail-package.test.txt
	sleep "$sleep_interval"

	bash src/bash/qto/qto.sh -a create-full-package -a gmail-package
	sleep "$sleep_interval"
   printf "\033[2J";printf "\033[0;0H"

	do_log "DEBUG STOP  doTestGmailPackage"
}
# eof func doTestGmailPackage


# eof file: src/bash/qto/funcs/gmail-package.test.sh
