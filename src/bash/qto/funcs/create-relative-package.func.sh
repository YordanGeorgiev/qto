#------------------------------------------------------------------------------
# creates a package from the relative file paths specified in the .env file
#------------------------------------------------------------------------------
doCreateRelativePackage(){
   
   cd $PROJ_INSTANCE_DIR ; cd .. ; product_base_dir=`pwd`; cd -
   
	mkdir -p $product_base_dir/dat/zip
		test $? -ne 0 && do_exit 2 "Failed to create $product_base_dir/dat/zip !"

	test -z ${include_file:-}         && \
		include_file="$PROJ_INSTANCE_DIR/met/.$ENV.$RUN_UNIT"

	# relative file path is passed turn it to absolute one 
	[[ $include_file == /* ]] || include_file=$PROJ_INSTANCE_DIR/$include_file

	test -f $include_file || \
		do_exit 3 "did not found any deployment file paths containing deploy file @ $include_file"

   tgt_ENV=$(echo `basename "$include_file"`|cut -d'.' -f2)

	timestamp=`date "+%Y%m%d_%H%M%S"`
	# the last token of the include_file with . token separator - thus no points in names
   git_short_hash=$(git rev-parse --short HEAD)
	zip_file_name=$(echo $include_file | rev | cut -d. -f 1 | rev)
	zip_file_name="$zip_file_name.$product_version.$tgt_ENV.$timestamp.$git_short_hash.$host_name.rel.zip"
	zip_file="$product_base_dir/$zip_file_name"
	

	ret=0
	while read f ; do
		[[ $f == '#'* ]] && continue ; 
		test -d "$PROJ_INSTANCE_DIR/$f" && continue ; 
		test -f "$PROJ_INSTANCE_DIR/$f" && continue ; 
		test -f "$PROJ_INSTANCE_DIR/$f" || do_log 'FATAL cannot find the file: "'"$PROJ_INSTANCE_DIR/$f"'" to package it' ;  
		test -f "$PROJ_INSTANCE_DIR/$f" || do_log 'ERROR search for it in the '"$include_file"' ' ;  
		test -f "$PROJ_INSTANCE_DIR/$f" || do_log 'INFO if you need the file add it to the list file  ' ;  
		test -f "$PROJ_INSTANCE_DIR/$f" || do_log 'INFO if you do not need the file remove it from the list file  ' ;  
		test -f "$PROJ_INSTANCE_DIR/$f" || ret=1
		test -f "$PROJ_INSTANCE_DIR/$f" && break ;
	done < <(cat $include_file)

	do_log "DEBUG ret is $ret "
	test $ret -ne 0 && do_log "ERROR non-existend file specified in the include file: $include_file "
	
	# start: add the perl_ignore_file_pattern
	while read -r line ; do \
		got=$(echo $line|perl -ne 'm|^\s*#\s*perl_ignore_file_pattern\s*=(.*)$|g;print $1'); \
		test -z "$got" || perl_ignore_file_pattern="$got|${perl_ignore_file_pattern:-}" ;
	done < <(cat $include_file)

	# or how-to remove the last char from a string 	
	perl_ignore_file_pattern=$(echo "$perl_ignore_file_pattern"|sed 's/.$//')
	test -z $perl_ignore_file_pattern && perl_ignore_file_pattern='.*\.swp$|.*\.log|$.*\.swo$'
	# note: | grep -vP "$perl_ignore_file_pattern" | grep -vP '^\s*#'


	# zip MM ops -MM = --must-match
	# All  input  patterns must match at least one file and all input files found must be readable.
	ret=0
	cat $include_file | grep -vP $perl_ignore_file_pattern | grep -vP '^\s*#' \
		| perl -ne 's|\n|\000|g;print'| xargs -0 zip -MM $zip_file
   
	ret=$? ; 
   if (( $ret != 0 )); then
      fatal_msg1="deleting $zip_file !!!"
      fatal_msg2="because of packaging errors !!!"
      rm -fv $zip_file
      do_log "FATAL $fatal_msg1"
      do_log "FATAL $fatal_msg2"
      do_exit 1 "FATAL failed to create relative package"
   else
      cd $product_base_dir
      do_log "INFO created the following relative package:"
      do_log "INFO `stat -c \"%y %n\" $zip_file_name`"

      if [[ ${network_backup_dir+x} && -n $network_backup_dir ]] ; then
         if [ -d "$network_backup_dir" ] ; then
            do_run_cmd_and_log "cp -v $zip_file $network_backup_dir/"
            do_log "INFO with the following network backup  :" && \
            do_log "INFO `stat -c \"%y %n\" \"$network_backup_dir/$zip_file_name\"`"
         else
            msg="skip backup as network_backup_dir is not configured"
            do_log "INFO $msg"
         fi
      fi
   fi


}
