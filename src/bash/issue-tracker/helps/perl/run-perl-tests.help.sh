# src/bash/issue-tracker/funcs/run-perl-tests.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpRunPerlTests comments ...
# ---------------------------------------------------------
doHelpRunPerlTests(){

	doLog "DEBUG START doHelpRunPerlTests"
	
	cat doc/txt/issue-tracker/helps/perl/run-perl-tests.help.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doHelpRunPerlTests"
}
# eof func doHelpRunPerlTests


# eof file: src/bash/issue-tracker/funcs/run-perl-tests.help.sh
