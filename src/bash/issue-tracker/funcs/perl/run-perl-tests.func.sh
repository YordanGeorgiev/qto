# src/bash/issue-tracker/funcs/run-perl-tests.func.sh

# v1.1.1
# ---------------------------------------------------------
# implement the calls to all the unit testing 
# ---------------------------------------------------------
doRunPerlTests(){
	
	doLog "DEBUG START : doRunPerlTests"

	doLog "INFO Component testing Initiator.pm with TestInitiator "
	perl src/perl/issue_tracker/t/TestInitiator.pm
	test -z "$sleep_interval" || sleep $sleep_interval

	doLog "INFO Component testing Configurator.pm with TestInitiator "
	perl src/perl/issue_tracker/t/TestConfigurator.pm
	test -z "$sleep_interval" || sleep $sleep_interval

	doLog "INFO Component testing Dispatcher.pm with TestDispatcher.pl"
   perl src/perl/issue_tracker/t/TestDispatcher.pl	
	test -z "$sleep_interval" || sleep $sleep_interval
}
# eof func doRunPerlTests


# eof file: src/bash/issue-tracker/funcs/run-perl-tests.func.sh
