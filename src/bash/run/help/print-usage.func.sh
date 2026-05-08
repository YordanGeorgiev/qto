#!/bin/bash
#------------------------------------------------------------------------------
# @description Prints the usage instructions and dynamically lists all
# @description available actions in the framework.
# @example ./run -a do_print_usage
#------------------------------------------------------------------------------

do_print_usage() {
  # if $run_unit is --help, then message will be "--help "
  cat <<EOF_USAGE_01
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   run.sh is the ultimate bash entrypoint, a generic bash funcs runner script
   providing multi-OS support, logging & configuration utils to avoid
   reinventing the wheel each time you start writing a new bash script ...
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   to install it:
   wget https://github.com/csitea/run.sh/archive/refs/tags/current.zip && unzip -o current.zip -d . && mv -v run.sh-current my-app
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


   IT Works !!! by executing one or more multiple "actions" with the

   $0 --action <<action-name>>
   or
   $0 -a <<do_action_name>> -a <<do_action_name>>


   where the
   each <<action_name>> is placed in a single *.func.sh file under these dirs:
   - lib/bash/funcs/
   - src/bash/run/
   and
   <<action_name>> is the snake case named function with the "do_" suffix
   be called by
   ./run -a do_action_name
   as follows:

EOF_USAGE_01

  while read -r func; do
    echo -e "\t ./run -a $func;"
  done < <(find src/bash/run/ lib/bash/funcs -name *.func.sh |
    perl -ne 's/(.*)(\/)(.*).func.sh/$3/g;print' | perl -ne 's/-/_/g;print "do_" . $_' | sort)

  cat <<EOF_USAGE_02


   Check the logs from the following dirs:
    find $PROJ_PATH/dat/log -name '*.log' | sort -nr | tail -n 7
    find ~/var/log/$PROJ -name '*.log' | sort -nr | tail -n 7

    echo less -R <<file-name>>

EOF_USAGE_02
  exit 1
}
# run-bsh ::: v3.8.2
