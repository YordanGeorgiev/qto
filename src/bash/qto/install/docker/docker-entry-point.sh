#!/usr/bin/env bash

   run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   cd $run_unit_bash_dir
   for i in {1..5} ; do cd .. ; done ; export PRODUCT_INSTANCE_DIR=`pwd`;
   export run_unit=$(echo `basename "$PRODUCT_INSTANCE_DIR"`|cut -d'.' -f1)
   export env_type=$(echo `basename "$PRODUCT_INSTANCE_DIR"`|cut -d'.' -f5)

   sudo sh /etc/init.d/postgresql start &

   test -f "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type.$host_host_name.cnf" && \
      cp -v "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type.$host_host_name.cnf" \
            "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type."$(hostname -s)'.cnf'
      
   test -z ${qto_project:-} && \
      source "$PRODUCT_INSTANCE_DIR/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type."$(hostname -s)'.cnf'

	sleep "$sleep_interval"
   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='dev'
   test -z "${mojo_morbo_port:-}" && export mojo_morbo_port='3001'

   export MOJO_LISTEN='http://*:'"$mojo_morbo_port"
   test -z "${mojo_morbo_port:-}" && export MOJO_LISTEN='http://*:3001'

   echo INFO running: morbo -w $PRODUCT_INSTANCE_DIR/src/perl/script/qto
   echo --listen $MOJO_LISTEN $PRODUCT_INSTANCE_DIR/src/perl/qto/script/qto

   morbo -w $PRODUCT_INSTANCE_DIR/src/perl/qto --listen $MOJO_LISTEN $PRODUCT_INSTANCE_DIR/src/perl/qto/script/qto &
   while true; do sleep 1000; done;

# eof file:src/bash/scripts/docker-entry-point.sh 
