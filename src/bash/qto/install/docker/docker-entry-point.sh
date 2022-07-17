#!/usr/bin/env bash

RUN_UNIT_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
cd $RUN_UNIT_bash_dir
for i in {1..5} ; do cd .. ; done ; export PRODUCT_DIR=`pwd`;
source $PRODUCT_DIR/.env

# comment out the sudo right from the app user
perl -pi -e 's/^(.*)'"$USER"'(.*$\n)/\#$1'"$USER"'$2/gm' /etc/sudoers

sudo sh /etc/init.d/postgresql start 
bash $PRODUCT_DIR/src/bash/qto/qto.sh -a run-pgsql-scripts


# todo:ysg 
# run the DDL scripts 
# laad the data 

bash $PRODUCT_DIR/src/bash/qto/qto.sh -a mojo-morbo-start
   
while true; do sleep 1000; done;
