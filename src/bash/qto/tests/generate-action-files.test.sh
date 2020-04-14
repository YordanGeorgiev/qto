# src/bash/lp_nettilaskuri/funcs/generate-action-files.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestGenerateActionFiles comments ...
# ---------------------------------------------------------
doTestGenerateActionFiles(){

	do_log "DEBUG START doTestGenerateActionFiles"
	
	cat doc/txt/lp_nettilaskuri/tests/generate-action-files.test.txt
	
	doSpecGenerateActionFiles

	doHelpGenerateActionFiles
	
	bash src/bash/lp_nettilaskuri/lp_nettilaskuri.sh -a generate-action-files

	do_log "DEBUG STOP  doTestGenerateActionFiles"
	
	sleep $sleep_interval
   printf "\033[2J";printf "\033[0;0H"

}
# eof func doTestGenerateActionFiles


# eof file: src/bash/lp_nettilaskuri/funcs/generate-action-files.test.sh
