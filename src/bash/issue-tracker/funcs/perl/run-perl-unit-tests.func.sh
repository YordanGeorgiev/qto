# src/bash/issue-tracker/funcs/run-perl-unit-tests.func.sh

# v1.1.3
# ---------------------------------------------------------
# implement the calls to all the perl unit testing 
# ---------------------------------------------------------
doRunPerlTests(){
   
   test -z $sleep_interval && sleep_interval=2
	doLog "DEBUG START : doRunPerlTests"

	doLog "INFO START Component testing Initiator.pm with TestInitiator "
	perl src/perl/issue_tracker/t/TestInitiator.pl
	echo -e "\n\n\n" 

	doLog "INFO START Component testing Configurator.pm with TestInitiator "
   perl src/perl/issue_tracker/t/lib/IssueTracker/App/Utils/TestConfigurator.pl
	echo -e "\n\n\n" 

	doLog "INFO START Component testing Dispatcher.pm with TestDispatcher.pl"
   perl src/perl/issue_tracker/t/TestDispatcher.pl	
	echo -e "\n\n\n" 
	
   doLog "INFO START Component testing Model.pm with TestModel.pl"
   perl src/perl/issue_tracker/t/TestModel.pl	
	echo -e "\n\n\n" 

   doLog "INFO START Unit testing or the SetGetable base module " 
   perl src/perl/issue_tracker/t/lib/IssueTracker/App/Utils/OO/TestSetGetable.pl
	echo -e "\n\n\n" 
   
   doLog "INFO START Unit testing or the AutoLoadable  base module" 
   perl src/perl/issue_tracker/t/lib/IssueTracker/App/Utils/OO/TestAutoLoadable.pl
	echo -e "\n\n\n" 

   doLog "INFO START Unit testing or the Command Line Reader module" 
   perl src/perl/issue_tracker/t/TestRdrCmdArgs.pl
	echo -e "\n\n\n" 

   doLog "INFO START Unit testing or the CnrXlsHsr3ToDbHsr3 module" 
   perl src/perl/issue_tracker/t/lib/IssueTracker/App/Cnvr/TestCnrXlsHsr3ToDbHsr3.pl
	echo -e "\n\n\n" 

   doLog "INFO START Unit test the List Controller : <<app-db>>/list/<<table-name>>"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestList.pl
	echo -e "\n\n\n" 
}
# eof func doRunPerlTests


# eof file: src/bash/issue-tracker/funcs/run-perl-unit-tests.func.sh
