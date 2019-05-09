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
	echo -e "\n\n\n" 

	doLog "INFO START Component testing Configurator.pm with TestInitiator "
   perl src/perl/qto/t/lib/Qto/App/Utils/TestConfigurator.pl
	echo -e "\n\n\n" 

	doLog "INFO START Component testing Dispatcher.pm with TestDispatcher.pl"
   perl src/perl/qto/t/TestDispatcher.pl	
	echo -e "\n\n\n" 
	
   doLog "INFO START Component testing Model.pm with TestModel.pl"
   perl src/perl/qto/t/TestModel.pl	
	echo -e "\n\n\n" 

   doLog "INFO START Unit testing or the SetGetable base module " 
   perl src/perl/qto/t/lib/Qto/App/Utils/OO/TestSetGetable.pl
	echo -e "\n\n\n" 
   
   doLog "INFO START Unit testing or the AutoLoadable  base module" 
   perl src/perl/qto/t/lib/Qto/App/Utils/OO/TestAutoLoadable.pl
	echo -e "\n\n\n" 

   doLog "INFO START Unit testing or the Command Line Reader module" 
   perl src/perl/qto/t/TestRdrCmdArgs.pl
	echo -e "\n\n\n" 

   doLog "INFO START Unit testing or the CnrXlsHsr3ToDbHsr3 module" 
   perl src/perl/qto/t/lib/Qto/App/Cnvr/TestCnrXlsHsr3ToDbHsr3.pl
	echo -e "\n\n\n" 

}
# eof func doRunFunctionalTests


# eof file: src/bash/qto/funcs/run-functional-tests.func.sh
