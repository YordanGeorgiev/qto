#!/usr/bin/env bash

   set -x 

   run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   cd $run_unit_bash_dir
   for i in {1..5} ; do cd .. ; done ; export product_instance_dir=`pwd`;
   export run_unit=$(echo `basename "$product_instance_dir"`|cut -d'.' -f1)
   export env_type=$(echo `basename "$product_instance_dir"`|cut -d'.' -f5)

   sudo sh /etc/init.d/postgresql start &

   test -f "$product_instance_dir/cnf/$run_unit.$env_type.host-name.cnf" && \
      cp -v "$product_instance_dir/cnf/$run_unit.$env_type.host-name.cnf" \
            "$product_instance_dir/cnf/$run_unit.$env_type."$(hostname -s)'.cnf'
      
   test -z ${qto_project:-} && \
      source "$product_instance_dir/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$product_instance_dir/cnf/$run_unit.$env_type."$(hostname -s)'.cnf'

	sleep "$sleep_interval"
   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='dev'
   test -z "${mojo_morbo_port:-}" && export mojo_morbo_port='3001'

   export MOJO_LISTEN='http://*:'"$mojo_morbo_port"
   test -z "${mojo_morbo_port:-}" && export MOJO_LISTEN='http://*:3001'

   echo INFO running: morbo -w $product_instance_dir/src/perl/script/qto
   echo --listen $MOJO_LISTEN $product_instance_dir/src/perl/qto/script/qto

   morbo -w $product_instance_dir/src/perl/qto --listen $MOJO_LISTEN $product_instance_dir/src/perl/qto/script/qto &
   while true; do sleep 1000; done;

# eof file:src/bash/scripts/docker-entry-point.sh 
