# src/bash/issue-tracker/funcs/check-perl-syntax.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestCheckPerlSyntax comments ...
# ---------------------------------------------------------
doTestCheckPerlSyntax(){

	doLog "DEBUG START doTestCheckPerlSyntax"
	
	cat doc/txt/issue-tracker/tests/perl/check-perl-syntax.test.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"

	bash src/bash/issue-tracker/issue-tracker.sh -a check-perl-syntax
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doTestCheckPerlSyntax"
}
# eof func doTestCheckPerlSyntax


# eof file: src/bash/issue-tracker/funcs/check-perl-syntax.test.sh
