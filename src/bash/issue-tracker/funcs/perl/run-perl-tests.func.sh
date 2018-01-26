# src/bash/issue-tracker/funcs/run-perl-tests.func.sh

# v1.1.3
# ---------------------------------------------------------
# implement the calls to all the perl unit testing 
# ---------------------------------------------------------
doRunPerlTests(){
	
	doLog "DEBUG START : doRunPerlTests"

	doLog "INFO Component testing Initiator.pm with TestInitiator "
	perl src/perl/issue_tracker/t/TestInitiator.pl
	test -z "$sleep_interval" || sleep $sleep_interval

	doLog "INFO Component testing Configurator.pm with TestInitiator "
	perl src/perl/issue_tracker/t/TestConfigurator.pl
	test -z "$sleep_interval" || sleep $sleep_interval

	doLog "INFO Component testing Dispatcher.pm with TestDispatcher.pl"
   perl src/perl/issue_tracker/t/TestDispatcher.pl	
	test -z "$sleep_interval" || sleep $sleep_interval
	
   doLog "INFO Component testing MdlHsr2.pm with TestMdlHsr2.pl"
   # perl src/perl/issue_tracker/t/TestMdlHsr2.pl	
	test -z "$sleep_interval" || sleep $sleep_interval

   doLog "INFO Unit testing or the SetGetable base class"
   perl src/perl/issue_tracker/t/lib/IssueTracker/App/Utils/OO/TestSetGetable.pl
	test -z "$sleep_interval" || sleep $sleep_interval
   
   doLog "INFO Unit testing or the AutoLoadable  base class"
   perl src/perl/issue_tracker/t/lib/IssueTracker/App/Utils/OO/TestAutoLoadable.pl
	test -z "$sleep_interval" || sleep $sleep_interval
}
# eof func doRunPerlTests


# eof file: src/bash/issue-tracker/funcs/run-perl-tests.func.sh
