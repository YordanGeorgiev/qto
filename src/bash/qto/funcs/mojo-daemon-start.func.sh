# src/bash/qto/funcs/mojo-daemon-start.func.sh

# v0.6.7
# ---------------------------------------------------------
# start the qto web app with the morbo
# cat doc/txt/qto/funcs/mojo-daemon-start.func.txt
# ---------------------------------------------------------
doMojoDaemonStart(){

   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.app'
   doMojoDaemonStop 0
   
   # to prevent the 'failed: could not create socket: Too many open files at sys' error
   ulimit -n 4096
   
   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='dev'
   test -z "${mojo_daemon_port:-}" && export mojo_daemon_port='http://*:443'
	# Action !!!
   cmd="$PRODUCT_INSTANCE_DIR/src/perl/qto/script/qto daemon -l https://*:443"
   doLog "INFO running: $cmd"
   bash -c "$cmd" &
	doLog "DEBUG check with netstat "
   netstat -tulpn | grep qto
 
   # if cmd arg -b is passed to the qto.sh, should not exit like ever, never because of docker
   # test ${run_in_backround:-} -eq 1 && while true; do sleep 1000; done;

}


# eof file: src/bash/qto/funcs/mojo-daemon-start.func.sh
