# src/bash/qto/funcs/mojo-morbo-start.func.sh

# v0.6.5
# ---------------------------------------------------------
# start the qto web app with the morbo
# cat doc/txt/qto/funcs/mojo-morbo-start.func.txt
# ---------------------------------------------------------
doMojoMorboStart(){

   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.app'
   doMojoMorboStop 0
   
   # to prevent the 'failed: could not create socket: Too many open files at sys' error
   # perl -e 'while(1){open($a{$b++}, "<" ,"/dev/null") or die $b;print " $b"}' to check
   ulimit -n 4096

	sleep "$sleep_interval"
   # chk: https://github.com/mojolicious/mojo/wiki/%25ENV
   export MOJO_MODE='development'
   export MOJO_LOG_LEVEL='debug'
   test -z "${mojo_morbo_port:-}" && export mojo_morbo_port='3001'

   export MOJO_LISTEN='http://*:'"$mojo_morbo_port"
   test -z "${mojo_morbo_port:-}" && export MOJO_LISTEN='http://*:3001'
   
   doLog "INFO running: morbo -w $PRODUCT_INSTANCE_DIR/src/perl/script/qto
      --listen $MOJO_LISTEN $PRODUCT_INSTANCE_DIR/src/perl/qto/script/qto"

   bash -c "morbo -w $PRODUCT_INSTANCE_DIR/src/perl/qto --listen $MOJO_LISTEN $PRODUCT_INSTANCE_DIR/src/perl/qto/script/qto" &

   # might require sudo visudoers 
   # usrqtoadmin ALL=(ALL) NOPASSWD: /bin/netstat -tulpn
	doLog "DEBUG check with netstat "
   netstat -tulpn | grep qto
 
   # if cmd arg -b is passed to the qto.sh, should not exit like ever, never because of docker
   test ${run_in_backround:-1} -eq 1 && while true; do sleep 1000; done;

}


# eof file: src/bash/qto/funcs/mojo-morbo-start.func.sh
