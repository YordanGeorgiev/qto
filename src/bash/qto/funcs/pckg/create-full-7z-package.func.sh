#!/bin/bash 

#v0.9.1.1
#------------------------------------------------------------------------------
# creates the full package as component of larger product platform
#------------------------------------------------------------------------------
doCreateFull7zPackage(){

	doLog "INFO START  ::: create-full-7z-package" ;
	
	which 7z 2>/dev/null || { echo >&2 "The 7z binary is missing ! Aborting ..."; exit 1; }

	test -z "$pcking_pw" && doExit 1 " Empty packaging password-> do export pcking_pw=secret !!!"
	#define default vars
	test -z $include_file         && \
		include_file="$product_instance_dir/met/.$env_type.$run_unit"

	# relative file path is passed turn it to absolute one 
	[[ $include_file == /* ]] || include_file=$product_instance_dir/$include_file

	test -f $include_file || \
		doExit 3 "did not found any relative file paths containing deploy file @ $include_file"
	cd $org_base_dir

	timestamp=`date +%Y%m%d_%H%M%S`
	# the last token of the include_file with . token separator - thus no points in names
	zip_7z_file_name=$(echo $include_file | rev | cut -d. -f 1 | rev)
	zip_7z_file_name="$zip_7z_file_name.$product_version.$env_type.$timestamp.$host_name.7z"
	zip_7z_file="$product_dir/$zip_7z_file_name"
	mkdir -p $product_instance_dir/dat/$run_unit/tmp
	echo $zip_7z_file>$product_instance_dir/dat/$run_unit/tmp/zip_7z_file
	set -x	

	# start: add the perl_ignore_file_pattern
	while read -r line ; do \
		got=$(echo $line|perl -ne 'm|^\s*#\s*perl_ignore_file_pattern\s*=(.*)$|g;print $1'); \
		test -z "$got" || perl_ignore_file_pattern="$got|$perl_ignore_file_pattern" ;
	done < <(cat $include_file)
	test -z $perl_ignore_file_pattern && perl_ignore_file_pattern='.*\.swp$|.*\.log|$.*\.swo$'

	# or how-to remove the last char from a string 	
	perl_ignore_file_pattern=$(echo "$perl_ignore_file_pattern"|sed 's/.$//')
	echo perl_ignore_file_pattern::: $perl_ignore_file_pattern
	# note: | grep -vP "$perl_ignore_file_pattern" | grep -vP '^\s*#'
	
	ret=0
	while read f ; do
		[[ $f == '#'* ]] && continue ; 
		test -d "$product_instance_dir/$f" && continue ; 
		test -f "$product_instance_dir/$f" && continue ; 
		test -f "$product_instance_dir/$f" || doLog 'FATAL cannot find the file: "'"$product_instance_dir/$f"'" to package it' ;  
		test -f "$product_instance_dir/$f" || doLog 'ERROR search for it in the '"$include_file"' ' ;  
		test -f "$product_instance_dir/$f" || doLog 'INFO if you need the file add it to the list file  ' ;  
		test -f "$product_instance_dir/$f" || doLog 'INFO if you do not need the file remove it from the list file  ' ;  
		test -f "$product_instance_dir/$f" || ret=1
		test -f "$product_instance_dir/$f" && break ;
	done < <(cat $include_file)

	doLog "DEBUG ret is $ret "
	test $ret -ne 0 && doExit "non-existend file specified in the include file: $include_file "

	# All  input  patterns must match at least one file and all input files found must be readable.
	cat $include_file | sort -u | while read -r line ; do test -f "$org_name/$run_unit/$environment_name/$line" && echo $line ; done \
		| grep -vP "$perl_ignore_file_pattern" | grep -vP '^\s*#' | perl -ne 's|\n|\000|g;print'| \
		xargs -0 -I "{}" 7z u -r0 -m0=lzma2 -mx=5 -p"$pcking_pw" -w"$product_dir" "$zip_7z_file" "$org_name/$run_unit/$environment_name/{}"

	ret=$? 

	doLog "INFO created the following full 7z package:"
	doLog "INFO $zip_7z_file"

	test -d $network_backup_dir && doRunCmdAndLog "cp -v $zip_7z_file $network_backup_dir/"

	doLog "INFO STOP  ::: create-full-7z-package" ;
}
#eof func doCreateFull7zPackage

