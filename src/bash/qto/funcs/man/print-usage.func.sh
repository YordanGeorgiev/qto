#v1.0.7 
#------------------------------------------------------------------------------
# prints the usage of this script
#------------------------------------------------------------------------------
doPrintUsage(){

   source $PRODUCT_DIR/lib/bash/funcs/flush-screen.sh
   do_flush_screen

   while read -r f ; do
      acts="${acts:-} "$(echo `basename $f`| perl -ne 's/^(.*?)\.func.sh$/$1/g;print') ;
   done < <(ls -1 src/bash/$RUN_UNIT/funcs/*.func.sh)

   test_script=$(dirname $0)"/$RUN_UNIT.sh"
   do_flush_screen
   cat << EOF_USAGE | tee -a $log_file

------------------------------------------------------------------------
--   the main shell entry point of the $RUN_UNIT
--
------------------------------------------------------------------------
   Purpose:
	$RUN_UNIT - the main shell entry point for the $RUN_UNIT        

   Usage:
   $0 -a <<action-name-01>> -a <<ation-name-02>> -a <<action-name-03>>

   where <<action-name> is one of the following:
   $acts
	
	Qto CAN run against different qto projects :
   source lib/bash/funcs/export-json-section-vars.sh ; 
   do_export_json_section_vars <<some-dir>>/cnf/env/dev.env.json '.env.db'
   
		bash $0 -a to-tst
		bash $0 -a to-dev
		bash $0 -a to-prd
      bash $0 -a to-ver=1.0.5
      bash $0 -a to-app=<<new_app_name>>

------------------------------------------------------------------------

EOF_USAGE


   cat <<END_HELP


   #
   ## STOP  --- USAGE `basename $0`
   #------------------------------------------------------------------------------

END_HELP


}
#eof func doPrintUsage
