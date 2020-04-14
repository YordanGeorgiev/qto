# src/bash/qto/funcs/print-usage.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpPrintUsage comments ...
# ---------------------------------------------------------
doHelpPrintUsage(){

	do_log "DEBUG START doHelpPrintUsage"
	
	cat doc/txt/qto/helps/print-usage.help.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	do_log "DEBUG STOP  doHelpPrintUsage"
}
# eof func doHelpPrintUsage


# eof file: src/bash/qto/funcs/print-usage.help.sh
