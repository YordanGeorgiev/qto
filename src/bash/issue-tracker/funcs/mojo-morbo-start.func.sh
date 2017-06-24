# src/bash/issue-tracker/funcs/mojo-morbo-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# start the issue_tracker web app with the morbo
# ---------------------------------------------------------
doMojoMorboStart(){

	doLog "DEBUG START doMojoMorboStart"
	
	# cat doc/txt/issue-tracker/funcs/mojo-morbo-start.func.txt
	
	sleep "$sleep_interval"
	# Action !!!
   cd src/perl/issue_tracker/script/
   morbo issue_tracker &
   cd $procuct_instance_dir
	doLog "DEBUG STOP  doMojoMorboStart"
}
# eof func doMojoMorboStart


# eof file: src/bash/issue-tracker/funcs/mojo-morbo-start.func.sh
