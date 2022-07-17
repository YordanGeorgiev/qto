#!/bin/bash
do_print_usage(){
   # if $run_unit is --help, then message will be "--help deployer PURPOSE"
   cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   This is a generic bash funcs runner script:
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

   You can also execute one or multiple actions with the
   $0 --action <<action-name>>
   or
   $0 -a <<action-name>> -a <<action-name-02>>

   where the <<action-name>> is one of the following

EOF_USAGE

   find src/bash/run/ -name *.func.sh \
      | perl -ne 's/(.*)(\/)(.*).func.sh/$3/g;print'| perl -ne 's/-/_/g;print "do_" . $_' | sort

   exit 1
}
