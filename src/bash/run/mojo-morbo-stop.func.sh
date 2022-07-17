#!/bin/bash


# ---------------------------------------------------------
# stop any running morbo instances listenning on the wanted port
# cat doc/txt/qto/funcs/mojo-morbo-stop.func.txt
# ---------------------------------------------------------
do_mojo_morbo_stop(){

  export PATH=$PATH:~/perl5/bin/
  export PERL5LIB=${PERL5LIB:-}:~/perl5/lib/perl5/:$PRODUCT_DIR/src/perl/qto/t/lib:$PRODUCT_DIR/src/perl/qto/public/lib:$PRODUCT_DIR/src/perl/qto/lib

  do_export_json_section_vars $PRODUCT_DIR/cnf/env/$ENV.env.json '.env.app'
  test -z "${MOJO_MORBO_PORT:-}" && export MOJO_MORBO_PORT=3001

   while read -r listening_on_port_pid; do
      while read -r pid; do
         test $listening_on_port_pid -eq $pid && sudo kill -9 $pid
      done < <(sudo ps -ef| grep -i qto| grep -v grep|awk '{print $2}')
   done < <(lsof -i:${MOJO_MORBO_PORT:-} -t)

   echo start running ps -ef \| grep qto
   ps -ef | grep -i qto
   echo stop  running ps -ef \| grep qto
   echo -e "\n"
   export exit_code=0
}
