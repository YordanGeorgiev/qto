#!/bin/bash 

# v1.2.1
#------------------------------------------------------------------------------
# creates the full package as component of larger product platform
#------------------------------------------------------------------------------
doCreateFullPackage(){

   test -z ${qto_project:-} && qto_project=qto
	#define default vars
	test -z ${include_file:-}         && \
		include_file="$PRODUCT_INSTANCE_DIR/met/.$env_type.$RUN_UNIT"

	# relative file path is passed turn it to absolute one 
	[[ $include_file == /* ]] || include_file=$PRODUCT_INSTANCE_DIR/$include_file

   if [ ! -f "$include_file" ]; then
      doLog "FATAL the deployment file: $include_file does not exist !!!"
      return 1
   fi

   tgt_env_type=$(echo `basename "$include_file"`|cut -d'.' -f2)

	# start: add the perl_ignore_file_pattern
	while read -r line ; do \
		got=$(echo $line|perl -ne 'm|^\s*#\s*perl_ignore_file_pattern\s*=(.*)$|g;print $1'); \
		test -z "$got" || perl_ignore_file_pattern="$got|${perl_ignore_file_pattern:-}" ;
	done < <(cat $include_file)

	# or how-to remove the last char from a string 	
	perl_ignore_file_pattern=$(echo "$perl_ignore_file_pattern"|sed 's/.$//')
	test -z $perl_ignore_file_pattern && perl_ignore_file_pattern='.*\.swp$|.*\.log|$.*\.swo$'
	echo perl_ignore_file_pattern::: $perl_ignore_file_pattern
	# note: | egrep -v "$perl_ignore_file_pattern" | egrep -v '^\s*#'
	cd $product_base_dir

	timestamp=`date "+%Y%m%d_%H%M%S"`
	# the last token of the include_file with . token separator - thus no points in names
	zip_file_name=$(echo $include_file | rev | cut -d'.' -f 1 | rev)
   test $zip_file_name != $RUN_UNIT && zip_file_name="$zip_file_name"'--'"$qto_project"
	zip_file_name="$zip_file_name.$product_version.$tgt_env_type.$timestamp.$host_name.zip"
	zip_file="$product_dir/$zip_file_name"
	mkdir -p $PRODUCT_INSTANCE_DIR/dat/$RUN_UNIT/tmp
	echo $zip_file>$PRODUCT_INSTANCE_DIR/dat/$RUN_UNIT/tmp/zip_file

   cd $product_base_dir; cd .. ;
	# zip MM ops
	# -MM  --must-match
	# All  input  patterns must match at least one file and all input files found must be readable.
	set -x ; ret=1
	cat $include_file | egrep -v "$perl_ignore_file_pattern" | sed '/^#/ d' | perl -ne 's|\n|\000|g;print'| \
	xargs -0 -I "{}" zip -MM $zip_file "${org_name}/$RUN_UNIT/$environment_name/{}"
	ret=$? 
	set +x
	test $ret -gt 0 && (
		while IFS='' read f ; do (
			test -d "$PRODUCT_INSTANCE_DIR/$f" && continue ; 
			test -f "$PRODUCT_INSTANCE_DIR/$f" && continue ; 
			test -f "$PRODUCT_INSTANCE_DIR/$f" || doLog 'ERROR not a file: "'"$f"'"' ;  
			test -f "$PRODUCT_INSTANCE_DIR/$f" || ret=1 && exit 1
		); 
		done < <(cat $include_file | egrep -v "$perl_ignore_file_pattern" | sed '/^#/ d')
	);

   if [ ! $ret -eq 0 ]; then
      doLog "FATAL deleted $zip_file , because of packaging errors $! !!!"
	   rm -fv $zip_file
      return 1
   fi
 
   test -z ${mix_data_dir:-} && mix_data_dir=$PRODUCT_INSTANCE_DIR/dat/mix
   # backup the project data dir if not running on the product itself ...
   test -d $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d") || doIncreaseDate
   # and zip the project data dir
   if [ ! $RUN_UNIT == $qto_project ]; then
      cd $mix_data_dir
      for i in {1..3} ; do cd .. ; done ;
      zip -r $zip_file $qto_project/dat/mix/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")
	   cd $org_base_dir
   else 
      zip -r $zip_file $org_name/$RUN_UNIT/$environment_name/dat/mix/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")
   fi

   msg="created the following full development package:"
   doLog "INFO $msg"
   msg="`stat -c \"%y %n\" $zip_file`"
   doLog "INFO $msg"

   if [[ ${network_backup_dir+x} && -n $network_backup_dir ]] ; then
      if [ -d "$network_backup_dir" ] ; then
         doRunCmdAndLog "cp -v $zip_file $network_backup_dir/"
         msg=" with the following network dir backup :
         ""$(stat -c "%y %n" "$network_backup_dir/$zip_file_name")"
         doLog "INFO $msg"
      else
         msg="skip backup as network_backup_dir does not exist"
         doLog "ERROR $msg"
      fi
   else
      msg="skip the creation of the network backup as no network_backup_dir is configured"
      doLog "INFO  $msg"
   fi

   doLog "INFO STOP  create-full-package.func.sh" 

}
#eof func doCreateFullPackage

