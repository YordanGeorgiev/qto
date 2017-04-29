# src/bash/issue-tracker/funcs/check-perl-syntax.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpCheckPerlSyntax comments ...
# ---------------------------------------------------------
doHelpCheckPerlSyntax(){

	doLog "DEBUG START doHelpCheckPerlSyntax"
	
	cat doc/txt/issue-tracker/helps/check-perl-syntax.help.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doHelpCheckPerlSyntax"
}
# eof func doHelpCheckPerlSyntax


# eof file: src/bash/issue-tracker/funcs/check-perl-syntax.help.sh
