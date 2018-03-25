# src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/mojo-hypnotoad-start.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStart(){

	doLog "DEBUG START doMojoHypnotoadStart"
	
	
	sleep "$sleep_interval"
	# Action !!!
   cd src/perl/issue_tracker/script
   hypnotoad  issue_tracker  &
   cd $product_instance_dir

	doLog "DEBUG STOP  doMojoHypnotoadStart"
}
# eof func doMojoHypnotoadStart


# eof file: src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh
