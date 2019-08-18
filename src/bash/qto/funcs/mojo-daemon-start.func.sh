# src/bash/qto/funcs/mojo-daemon-start.func.sh

# v0.6.7
# ---------------------------------------------------------
# start the qto web app with the morbo
# cat doc/txt/qto/funcs/mojo-daemon-start.func.txt
# ---------------------------------------------------------
doMojoDaemonStart(){

	doLog "DEBUG START doMojoDaemonStart"

   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.app'

   doMojoDaemonStop 0
   
   # to prevent the 'failed: could not create socket: Too many open files at sys' error
   ulimit -n 4096
   
   export MOJO_MODE='dev'
   test $env_type == "prd" && export MOJO_MODE='production'

   test -z "${mojo_daemon_port:-}" && export mojo_daemon_port='http://*:6001'
	# Action !!!
   cmd="$PRODUCT_INSTANCE_DIR/src/perl/qto/script/qto daemon -l https://[::]:$mojo_daemon_port"
   doLog "INFO running: $cmd"
   bash -c "$cmd" &
	doLog "DEBUG check with netstat "
   netstat -tulpn | grep qto
 
   # chk:ysg needed !?
   # if cmd arg -b is passed to the qto.sh, should not exit like ever, never because of docker
   test $run_in_backround -eq 1 && while true; do sleep 1000; done;

   doLog "DEBUG STOP  doMojoDaemonStart"
}


# eof file: src/bash/qto/funcs/mojo-daemon-start.func.sh
