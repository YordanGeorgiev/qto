# src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doMojoHypnotoadStart comments ...
# ---------------------------------------------------------
doMojoHypnotoadStart(){

	doLog "DEBUG START doMojoHypnotoadStart"
	
	# cat doc/txt/issue-tracker/funcs/mojo-hypnotoad-start.func.txt
	
	
	sleep "$sleep_interval"
	# Action !!!
   cd src/perl/issue_tracker/script
   hypnotoad  issue_tracker  &
   cd $product_instance_dir

	doLog "DEBUG STOP  doMojoHypnotoadStart"
}
# eof func doMojoHypnotoadStart


# eof file: src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh
