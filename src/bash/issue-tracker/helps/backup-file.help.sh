# src/bash/issue-tracker/funcs/backup-file.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpBackupFile comments ...
# ---------------------------------------------------------
doHelpBackupFile(){

	doLog "DEBUG START doHelpBackupFile"
	
	cat doc/txt/issue-tracker/helps/backup-file.help.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpBackupFile"
}
# eof func doHelpBackupFile


# eof file: src/bash/issue-tracker/funcs/backup-file.help.sh
