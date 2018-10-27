#!/bin/bash


#v1.1.3
#------------------------------------------------------------------------------
# creates a package from the relative file paths specified in the .dev file
#------------------------------------------------------------------------------
doCreateRelative7zPackage(){

	doLog "INFO :: START :: create-relative-7z-package.func"

	test -z "$pcking_pw" && doExit 1 " Empty packaging password-> do export pcking_pw=secret !!!"
	which 7z 2>/dev/null || { echo >&2 "The 7z binary is missing ! Aborting ..."; exit 1; }

	cd $product_instance_dir
	mkdir -p $product_dir/dat/zip
		test $? -ne 0 && doExit 2 "Failed to create $product_instance_dir/dat/zip !"

	#define default vars
	test -z $include_file         && \
		include_file="$product_instance_dir/met/.$env_type.$run_unit"

	# relative file path is passed turn it to absolute one 
	[[ $include_file == /* ]] || include_file=$product_instance_dir/$include_file

	test -f $include_file || \
		doExit 3 "did not found any deployment file paths containing deploy file @ $include_file"
	
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

	# start: add the perl_ignore_file_pattern
	while read -r line ; do \
		got=$(echo $line|perl -ne 'm|^\s*#\s*perl_ignore_file_pattern\s*=(.*)$|g;print $1'); \
		test -z "$got" || perl_ignore_file_pattern="$got|$perl_ignore_file_pattern" ;
	done < <(cat $include_file)

	# or how-to remove the last char from a string 	
	perl_ignore_file_pattern=$(echo "$perl_ignore_file_pattern"|sed 's/.$//')
	test -z $perl_ignore_file_pattern && perl_ignore_file_pattern='.*\.swp$|.*\.log|$.*\.swo$'
	echo perl_ignore_file_pattern::: $perl_ignore_file_pattern
	# note: | grep -vP "$perl_ignore_file_pattern" | grep -vP '^\s*#'
	
	timestamp=`date +%Y%m%d_%H%M%S`
	# the last token of the include_file with . token separator - thus no points in names
	zip_7z_file_name=$(echo $include_file | rev | cut -d. -f 1 | rev)
	zip_7z_file_name="$zip_7z_file_name.$product_version.$env_type.$timestamp.$host_name.rel.7z"
	zip_7z_file="$product_dir/$zip_7z_file_name"
	mkdir -p $product_instance_dir/dat/$run_unit/tmp
	echo $zip_7z_file>$product_instance_dir/dat/$run_unit/tmp/zip_7z_file
	
	# All  input  patterns must match at least one file and all input files found must be readable.
	# 7z does recursively include all the contents of the dirs - and we want exactly the oppposite
	set -x
	ret=1
	cat $include_file | sort -u | while read -r line ; do test -f $line && echo $line ; done \
		| grep -vP "$perl_ignore_file_pattern" | grep -vP '^\s*#' | perl -ne 's|\n|\000|g;print'| \
		xargs -0 7z u -r0 -m0=lzma2 -mx=5 -p"$pcking_pw" -w"$product_instance_dir" "$zip_7z_file"
	ret=$? ; set +x ;
   fatal_msg="FATAL !!! deleted $zip_7z_file , because of packaging errors !!!"
	[ $ret == 0 ] || rm -fv $zip_7z_file
	[ $ret == 0 ] || doExit 1 "$fatal_msg"

	cd $product_dir
	doLog "INFO created the following relative package:"
	doLog "INFO `stat -c \"%y %n\" $zip_7z_file_name`"

   if [ -d "$network_backup_dir" ]; then
      cmd="cp -v $zip_7z_file $product_dir/dat/zip/" && doRunCmdOrExit "$cmd"
      doLog "INFO with the following local backup  :"
      doLog "INFO `stat -c \"%y %n\" $product_dir/dat/zip/$zip_7z_file_name`"
      doLog "INFO in the network dir @::"
      doLog "INFO :: $network_backup_dir"
      cmd="cp -v $zip_7z_file $network_backup_dir/$zip_7z_file_name" && doRunCmdOrExit "$cmd"
      doLog "INFO with the following network backup  :"
      doLog "INFO `stat -c \"%y %n\" \"$network_backup_dir/$zip_7z_file_name\"`"
   else
      msg="skip backup as network_backup_dir is not configured"
      doLog "INFO $msg"
   fi


	mkdir -p $network_backup_dir && \

	doLog "INFO :: STOP  :: create-relative-7z-package.func"

}
#eof doCreateRelative7zPackage
