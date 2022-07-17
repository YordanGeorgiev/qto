#!/bin/bash

# v0. chk: https://github.com/mojolicious/mojo/wiki/%25ENV
do_mojo_morbo_start(){


  export PATH=$PATH:~/perl5/bin/
  export PERL5LIB=${PERL5LIB:-}:~/perl5/lib/perl5/:$PRODUCT_DIR/src/perl/qto/t/lib:$PRODUCT_DIR/src/perl/qto/public/lib:$PRODUCT_DIR/src/perl/qto/lib

  do_export_json_section_vars $PRODUCT_DIR/cnf/env/$ENV.env.json '.env.app'
  do_mojo_morbo_stop 0

  # to prevent the 'failed: could not create socket: Too many open files at sys' error
  # perl -e 'while(1){open($a{$b++}, "<" ,"/dev/null") or die $b;print " $b"}' to check
  ulimit -n 4096

  sleep "${sleep_interval:=0}"
  export MOJO_LOG_LEVEL='debug'
  export MOJO_MODE='development'
  #export MOJO_MODE='production'
  test -z "${MOJO_MORBO_PORT:-}" && export MOJO_MORBO_PORT='3001'

  export MOJO_LISTEN='http://*:'"$MOJO_MORBO_PORT"
  test -z "${MOJO_MORBO_PORT:-}" && export MOJO_LISTEN='http://*:3001'

  do_log "INFO running: morbo -w $PRODUCT_DIR/src/perl/script/qto
  --listen $MOJO_LISTEN $PRODUCT_DIR/src/perl/qto/script/qto"

  while read -r p ; do
    p=$(echo $p|sed 's/^ *//g')
    test $p -ne $$ && kill -9 $p ;
  done < <(sudo ps -ef | grep -v grep | grep 'mojo-morbo-start'|awk '{print $2}')

  export PERL5LIB=${PERL5LIB:-}:/opt/qto/src/perl/qto/t/lib:/opt/qto/src/perl/qto/public/lib:/opt/qto/src/perl/qto/lib

  bash -c "morbo -w $PRODUCT_DIR/src/perl/qto --listen $MOJO_LISTEN $PRODUCT_DIR/src/perl/qto/script/qto" &

  # might require sudo visudoers
  # usrqtoadmin ALL=(ALL) NOPASSWD: /bin/netstat -tulpn
  do_log "INFO check with netstat, running netstat -tulpn" ; netstat -tulpn | grep qto

}
