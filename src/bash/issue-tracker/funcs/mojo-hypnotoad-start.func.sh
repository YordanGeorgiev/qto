# src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/mojo-hypnotoad-start.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStart(){

	doLog "DEBUG START doMojoHypnotoadStart"
	
	
   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='prd'

   export MOJO_LISTEN='http://*:'"$mojo_port"
   test -z "$MOJO_LISTEN" && export MOJO_LISTEN='http://*:3001'

	sleep "$sleep_interval"
	# Action !!!
   cd src/perl/issue_tracker/script
   hypnotoad  --listen "$MOJO_LISTEN" issue_tracker  &
   cd $product_instance_dir

	doLog "DEBUG STOP  doMojoHypnotoadStart"
}
# eof func doMojoHypnotoadStart


# eof file: src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh
