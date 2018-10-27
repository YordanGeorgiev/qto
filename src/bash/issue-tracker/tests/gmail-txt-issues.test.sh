# src/bash/issue-tracker/funcs/gmail-txt-issues.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestGmailTxtIssues comments ...
# ---------------------------------------------------------
doTestGmailTxtIssues(){

	doLog "DEBUG START doTestGmailTxtIssues"
	
	cat doc/txt/issue-tracker/tests/gmail-txt-issues.test.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a gmail-txt-issues

	doLog "DEBUG STOP  doTestGmailTxtIssues"
}
# eof func doTestGmailTxtIssues


# eof file: src/bash/issue-tracker/funcs/gmail-txt-issues.test.sh
