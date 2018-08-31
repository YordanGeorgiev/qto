# src/bash/issue-tracker/funcs/mojo-morbo-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# start the issue_tracker web app with the morbo
# cat doc/txt/issue-tracker/funcs/mojo-morbo-start.func.txt
# ---------------------------------------------------------
doMojoMorboStart(){

	doLog "DEBUG START doMojoMorboStart"
	
	sleep "$sleep_interval"
   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='dev'
   test -z "${mojo_morbo_port:-}" && export mojo_morbo_port='3001'

   export MOJO_LISTEN='http://*:'"$mojo_morbo_port"
   test -z "${mojo_morbo_port:-}" && export MOJO_LISTEN='http://*:3001'
	# Action !!!
   bash -c "morbo -w $product_instance_dir/src/perl/issue_tracker --listen $MOJO_LISTEN $product_instance_dir/src/perl/issue_tracker/script/issue_tracker" &
	doLog "DEBUG check with netstat "
   # sudo visudoers 
   # usr_it ALL=(ALL) NOPASSWD: /bin/netstat -tulpn
   netstat -tulpn | grep issue_tracker

   doLog "DEBUG STOP  doMojoMorboStart"
}
# eof func doMojoMorboStart


# eof file: src/bash/issue-tracker/funcs/mojo-morbo-start.func.sh
