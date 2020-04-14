# src/bash/qto/funcs/clone-project.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/clone-project.func.txt
# ---------------------------------------------------------
doCloneProject(){

	do_log "DEBUG START doCloneProject"
	
	sleep "$sleep_interval"
   # doc/txt/qto/spec/clone-project.spec.txt
   export src_proj='ysg-issues'
   export tgt_proj='phz'
   export global_cnf_dir='/vagrant/csitea/cnf/projects/qto'

   # load the src project configuration file
   doParseIniEnvVars "$global_cnf_dir"'/'"$src_proj"".prd.host-name.cnf"

   # go to the ysg projects daily data root dir
   cd $mix_data_dir

   # define yesterday 
   export tgt_date=$(date --date="-1 day" "+%Y-%m-%d")

   # create a zip package of the yester-day day 
   while read -r f ; do zip $tgt_date.zip $f ; \
   done < <(find "$(date "+%Y" -d "$tgt_date")"'/'$(date "+%Y-%m" -d "$tgt_date")/$(date "+%Y-%m-%d" -d "$tgt_date"))

   # load the newly defined cloned project dir
   doParseIniEnvVars "$global_cnf_dir"'/'"$tgt_proj"".prd.host-name.cnf"

   # create the new projects daily data root dir
   mkdir -p $mix_data_dir
   export dir_to_morph=$mix_data_dir

   # unzip the yesterday daily dir for the new project
   unzip -o $tgt_date.zip -d $mix_data_dir/

   # go back to the product instance dir
   cd -

   # morph the dir
   export to_srch=$src_proj
   export to_repl=$tgt_proj
   bash src/bash/qto/qto.sh -a morph-dir

   # start working again on the project to be cloned
   doParseIniEnvVars "$global_cnf_dir"'/'"$tgt_proj"".prd.host-name.cnf"

   # and increase the dat
   bash src/bash/qto/qto.sh -a increase-date -d today

	do_log "DEBUG STOP  doCloneProject"
}
# eof func doCloneProject


# eof file: src/bash/qto/funcs/clone-project.func.sh
