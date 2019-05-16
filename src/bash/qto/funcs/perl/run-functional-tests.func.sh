# src/bash/qto/funcs/run-functional-tests.func.sh

# v1.1.3
# ---------------------------------------------------------
# implement the calls to all the functional tests
# ---------------------------------------------------------
doRunFunctionalTests(){
   
   test -z $sleep_interval && sleep_interval=2
	doLog "DEBUG START : doRunFunctionalTests"

	doLog "INFO START Component testing Initiator.pm with TestInitiator "
	perl src/perl/qto/t/TestInitiator.pl
	sleep 1; clearTheScreen ; 

	doLog "INFO START Component testing Configurator.pm with TestInitiator "
   perl src/perl/qto/t/lib/Qto/App/Utils/TestConfigurator.pl
	sleep 1; clearTheScreen ; 

	doLog "INFO START Component testing Dispatcher.pm with TestDispatcher.pl"
   perl src/perl/qto/t/TestDispatcher.pl	
	sleep 1; clearTheScreen ; 
	
   doLog "INFO START Component testing Model.pm with TestModel.pl"
   perl src/perl/qto/t/TestModel.pl	
	sleep 1; clearTheScreen ; 

   doLog "INFO START Unit testing or the SetGetable base module " 
   perl src/perl/qto/t/lib/Qto/App/Utils/OO/TestSetGetable.pl
	sleep 1; clearTheScreen ; 
   
   doLog "INFO START Unit testing or the AutoLoadable  base module" 
   perl src/perl/qto/t/lib/Qto/App/Utils/OO/TestAutoLoadable.pl
	sleep 1; clearTheScreen ; 

   doLog "INFO START Unit testing or the Command Line Reader module" 
   perl src/perl/qto/t/TestRdrCmdArgs.pl
	sleep 1; clearTheScreen ; 

   doLog "INFO START Unit testing or the CnrXlsHsr3ToDbHsr3 module" 
   perl src/perl/qto/t/lib/Qto/App/Cnvr/TestCnrXlsHsr3ToDbHsr3.pl
	sleep 1; clearTheScreen ; 

}
# eof func doRunFunctionalTests


# eof file: src/bash/qto/funcs/run-functional-tests.func.sh
