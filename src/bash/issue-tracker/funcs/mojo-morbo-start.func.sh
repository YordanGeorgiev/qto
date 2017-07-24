# src/bash/issue-tracker/funcs/mojo-morbo-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# start the issue_tracker web app with the morbo
# cat doc/txt/issue-tracker/funcs/mojo-morbo-start.func.txt
# ---------------------------------------------------------
doMojoMorboStart(){

	doLog "DEBUG START doMojoMorboStart"
	
	sleep "$sleep_interval"

	# Action !!!
   bash -c "morbo $product_instance_dir/src/perl/issue_tracker/script/issue_tracker" &
	doLog "DEBUG check with netstat "
   # sudo visudoers 
   # ysg ALL=(ALL) NOPASSWD: /bin/netstat -tulpn
   netstat -tulpn | grep issue_tracker
	
   doLog "DEBUG STOP  doMojoMorboStart"
}
# eof func doMojoMorboStart


# eof file: src/bash/issue-tracker/funcs/mojo-morbo-start.func.sh
