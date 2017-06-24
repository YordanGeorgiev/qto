# src/bash/issue-tracker/funcs/mojo-hypnotoad-stop.func.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doMojoHypnotoadStop comments ...
# ---------------------------------------------------------
doMojoHypnotoadStop(){

	doLog "DEBUG START doMojoHypnotoadStop"
	
	# cat doc/txt/issue-tracker/funcs/mojo-hypnotoad-stop.func.txt
	
	sleep "$sleep_interval"
	# Action !!!
   cd src/perl/issue_tracker/script/
   hypnotoad  -s issue_tracker &
   cd $procuct_instance_dir

	doLog "DEBUG STOP  doMojoHypnotoadStop"
}
# eof func doMojoHypnotoadStop


# eof file: src/bash/issue-tracker/funcs/mojo-hypnotoad-stop.func.sh
