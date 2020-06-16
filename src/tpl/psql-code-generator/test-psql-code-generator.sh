#!/usr/bin/env bash


main(){
   do_run_test_01 "test-01 the usage is print if no \$1 and \$2 are passed"
   do_run_test_02 "test-02 the usage is print if no \$2 are passed"
   do_run_test_03 "test-03 a normal run when both \$1 and \$2 are passed"
}


do_run_test_01(){
  echo $1 ; shift 
  to_tst='psql-code-generator - a script for generating code'
  out=`echo $(bash src/tpl/psql-code-generator/psql-code-generator.sh)|grep -c "$to_tst"`
  test $out -eq 1 && echo     test-01 ok
  test $out -eq 0 && echo     test-01 failed
  echo -e "\n\n"
  sleep 1
  clearTheScreen
}


do_run_test_02(){
  echo $1 ; shift 
  to_tst='psql-code-generator - a script for generating code'
  out=`echo $(bash src/tpl/psql-code-generator/psql-code-generator.sh dev_qto)|grep -c "$to_tst"`
  test $out -eq 1 && echo     test-02 ok
  test $out -eq 0 && echo     test-02 failed
  echo -e "\n\n"
  sleep 1
  clearTheScreen
}


do_run_test_03(){
  echo $1 ; shift 
  bash src/tpl/psql-code-generator/psql-code-generator.sh dev_qto release_issues monthly_issues
  sleep 1
  #clearTheScreen
}


clearTheScreen(){
	printf "\033[2J";printf "\033[0;0H"
}


main
