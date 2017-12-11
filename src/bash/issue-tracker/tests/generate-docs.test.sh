# src/bash/issue-tracker/funcs/generate-docs.test.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/tests/generate-docs.test.txt
# ---------------------------------------------------------
doTestGenerateDocs(){

	doLog "DEBUG START doTestGenerateDocs"
	
   # to get the doParseIniEnvVars func
   source $product_instance_dir/src/bash/lib/.bash_funcs.host-name
	
   msg="test-01 test run ok - produce all the md files "
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf

   msg="DEBUG remove the md files first"
   doLog "DEBUG $msg"
   find doc/ -name '*.md' -exec rm -fv {} \;
   # Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a generate-docs
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0

	doLog "DEBUG STOP  doTestGenerateDocs"
}
# eof func doTestGenerateDocs


# eof file: src/bash/issue-tracker/funcs/generate-docs.test.sh
