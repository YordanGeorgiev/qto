# src/bash/qto/funcs/run-unit-tests.func.sh

# v5.0.8
# ---------------------------------------------------------
#	cat doc/txt/qto/funcs/run-unit-tests.func.txt
# ---------------------------------------------------------
doRunUnitTests(){

	doLog "DEBUG START doRunUnitTests"

# ysg:todo move to the run-data-load-tests shell action
# src/perl/qto/t/lib/Qto/Controller/LoadTestSelect.pl
# those are in onhold status because of the required setup needed ...
# src/perl/qto/t/lib/Qto/Controller/TestListOnClientPOC1.pl
# src/perl/qto/t/lib/Qto/Controller/TestListBySelenium.t
	
   doLog "INFO START test the Select Controller "
   doLog " $postgres_db_name/select-tables"
   doLog " $postgres_db_name/select/<<table-name>>"
   test_script='src/perl/qto/t/lib/Qto/Controller/TestSelect.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestSelect.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 
  
   test_script='src/perl/qto/t/lib/Qto/Controller/TestSelectPick.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestSelectPick.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   test_script='src/perl/qto/t/lib/Qto/Controller/TestSelectOrder.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestSelectOrder.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   test_script='src/perl/qto/t/lib/Qto/Controller/TestSelectLike.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestSelectLike.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   test_script='src/perl/qto/t/lib/Qto/Controller/TestSelectHide.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestSelectHide.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   test_script='src/perl/qto/t/lib/Qto/Controller/TestSelectFilter.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestSelectFilter.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 
   
   doLog "INFO START test the List Controller with the hide url param"
   test_script='src/perl/qto/t/lib/Qto/Controller/TestListHide.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestListHide.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   doLog "INFO TODO: implement proper client side testing"

   test_script='src/perl/qto/t/lib/Qto/Controller/TestSelectWith.pl'
   doLog "INFO START select with operator testing"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestSelectWith.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   doLog "INFO START testing the list as <<output-type>> page"
   test_script='src/perl/qto/t/lib/Qto/Controller/TestListAsOutputType.pl'
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestListAsOutputType.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 
  
   test_script='src/perl/qto/t/lib/Qto/Controller/TestCreate.pl'
   doLog "INFO test the create action on the web-action"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestCreate.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 
 
   test_script='src/perl/qto/t/lib/Qto/Controller/TestUpdate.pl'
   doLog "INFO test the update action on the web-action"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestUpdate.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 
  
   test_script='src/perl/qto/t/lib/Qto/Controller/TestDelete.pl'
   doLog "INFO test the delete action on the web-action"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestDelete.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   test_script='src/perl/qto/t/lib/Qto/Controller/TestQuery.pl'
   doLog "INFO test the query action on the web-action"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestQuery.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   test_script='src/perl/qto/t/lib/Qto/Controller/TestSearch.pl'
   doLog "INFO test the search action on the web-action"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestSearch.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   test_script='src/perl/qto/t/lib/Qto/Controller/TestAppLabel.pl'
   doLog "INFO test the search action on the web-action"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestAppLabel.pl
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

   test_script='src/perl/qto/t/lib/Qto/Controller/TestHSelect.t'
   doLog "INFO test the search action on the web-action"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestHSelect.t
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 
   
   
   test_script='src/perl/qto/t/lib/Qto/Controller/TestHSelectWith.t'
   doLog "INFO test the hierarchichal select filtering by the whith operator"
   doLog "INFO START $test_script"
   perl src/perl/qto/t/lib/Qto/Controller/TestHSelectWith.t
   test $? -ne 0 && return
   doLog "INFO STOP  $test_script"
	echo -e "\n\n\n" 

	doLog "DEBUG STOP  doRunUnitTests"
}

# eof file: src/bash/qto/funcs/run-unit-tests.func.sh
