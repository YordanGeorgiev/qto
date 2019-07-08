# src/bash/qto/funcs/mojo-daemon-start.func.sh

# v0.6.7
# ---------------------------------------------------------
# start the qto web app with the morbo
# cat doc/txt/qto/funcs/mojo-daemon-start.func.txt
# ---------------------------------------------------------
doMojoDaemonStart(){

	doLog "DEBUG START doMojoDaemonStart"

   test -z ${qto_project:-} && \
      source "$product_instance_dir/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$product_instance_dir/cnf/$run_unit.$env_type.*.cnf"

   doMojoDaemonStop 0
   
   # to prevent the 'failed: could not create socket: Too many open files at sys' error
   ulimit -n 4096
   
   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='dev'
   test -z "${mojo_daemon_port:-}" && export mojo_daemon_port='http://*:6001'
	# Action !!!
   cmd="$product_instance_dir/src/perl/qto/script/qto daemon -l https://[::]:$mojo_daemon_port"
   doLog "INFO running: $cmd"
   bash -c "$cmd" &
	doLog "DEBUG check with netstat "
   netstat -tulpn | grep qto
 
   # if cmd arg -b is passed to the qto.sh, should not exit like ever, never because of docker
   test $run_in_backround -eq 1 && while true; do sleep 1000; done;

   doLog "DEBUG STOP  doMojoDaemonStart"
}


# eof file: src/bash/qto/funcs/mojo-daemon-start.func.sh
