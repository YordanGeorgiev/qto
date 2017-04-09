#!/bin/bash 

# v1.1.0
#------------------------------------------------------------------------------
# creates the full package as component of larger product platform
#------------------------------------------------------------------------------
doCreateFullPackage(){

	doLog "INFO === START === create-full-package" ;

	#define default vars
	test -z $include_file         && \
		include_file="$product_instance_dir/met/.$env_type.$run_unit"

	# relative file path is passed turn it to absolute one 
	[[ $include_file == /* ]] || include_file=$product_instance_dir/$include_file

	test -f "$include_file" || \
		doExit 3 "the deployment file: "'"'"$include_file"'" does not exist !!!'

   tgt_env_type=$(echo `basename "$include_file"`|cut -d'.' -f2)

	# start: add the perl_ignore_file_pattern
	while read -r line ; do \
		got=$(echo $line|perl -ne 'm|^\s*#\s*perl_ignore_file_pattern\s*=(.*)$|g;print $1'); \
		test -z "$got" || perl_ignore_file_pattern="$got|$perl_ignore_file_pattern" ;
	done < <(cat $include_file)

	# or how-to remove the last char from a string 	
	perl_ignore_file_pattern=$(echo "$perl_ignore_file_pattern"|sed 's/.$//')
	test -z $perl_ignore_file_pattern && perl_ignore_file_pattern='.*\.swp$|.*\.log|$.*\.swo$'
	echo perl_ignore_file_pattern::: $perl_ignore_file_pattern
	# note: | egrep -v "$perl_ignore_file_pattern" | egrep -v '^\s*#'
	cd $org_base_dir

	timestamp=`date "+%Y%m%d_%H%M%S"`
	# the last token of the include_file with . token separator - thus no points in names
	zip_file_name=$(echo $include_file | rev | cut -d'.' -f 1 | rev)
	zip_file_name="$zip_file_name.$product_version.$tgt_env_type.$timestamp.$host_name.zip"
	zip_file="$product_dir/$zip_file_name"
	mkdir -p $product_instance_dir/dat/$issue-tracker/tmp
	echo $zip_file>$product_instance_dir/dat/$issue-tracker/tmp/zip_file


	# zip MM ops
	# -MM  --must-match
	# All  input  patterns must match at least one file and all input files found must be readable.
	set -x ; ret=1
	cat $include_file | egrep -v "$perl_ignore_file_pattern" | egrep -v '^\s*#' | perl -ne 's|\n|\000|g;print'| \
	xargs -0 -I "{}" zip -MM $zip_file "$org_name/$run_unit/$environment_name/{}"
	ret=$? 
	set +x
	test $ret -gt 0 && (
		while IFS='' read f ; do (
			test -d "$product_instance_dir/$f" && continue ; 
			test -f "$product_instance_dir/$f" && continue ; 
			test -f "$product_instance_dir/$f" || doLog 'ERROR not a file '"$f" ;  
		); 
		done < <(cat $include_file)
	);

   fatal_msg="FATAL !!! deleted $zip_file , because of packaging errors $! !!!"
	[ $ret == 0 ] || rm -fv $zip_file
	[ $ret == 0 ] || doExit 1 "$fatal_msg"

	doLog "INFO created the following full development package:"
	doLog "INFO `stat -c \"%y %n\" $zip_file`"

	test -d $network_backup_dir && doRunCmdAndLog "cp -v $zip_file $network_backup_dir/"

	doLog "INFO === STOP  === create-full-package" ;
}
#eof func doCreateFullPackage

