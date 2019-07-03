# v0.4.9
#------------------------------------------------------------------------------
# increase or decrease the version of the product
# bash src/bash/tool/tool.sh -a to-ver=1.1.0
#------------------------------------------------------------------------------
doChangeVersion(){

	tgt_version="$1"
	shift 1;


	prefix='to-ver='
	tgt_version=${tgt_version#$prefix}
	tgt_environment_name=$(echo $environment_name | perl -ne "s/$product_version/$tgt_version/g;print")
	# yest the new version is always dev !!!
	tgt_environment_name=$(echo $tgt_environment_name | perl -ne "s/$env_type/dev/g;print")
	tgt_product_instance_dir=$product_dir/$tgt_environment_name
	mkdir -p $tgt_product_instance_dir	

	test "$tgt_product_instance_dir" == "$product_instance_dir" && return
	# remove everything from the tgt product version dir - no extra files allowed !!!
	rm -fvr $tgt_product_instance_dir/*
	test $? -eq 0  || doExit 2 "cannot write to $tgt_product_instance_dir !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_product_instance_dir
	cp -v $zip_file $tgt_product_instance_dir

   # change the current version str to tgt-version in the configuration dir 
   export to_srch=$product_version
   export to_repl=$tgt_version
   export dir_to_morph=$tgt_product_instance_dir/cnf
   doMorphDir # :fin morph-dir.func.sh

	# ensure that all the files in the target product version dir are indentical to the current ones
	while read -r file ; do (
		doLog "DEBUG comparing src file: $file"
		doLog "DEBUG to tgt file: $tgt_product_instance_dir/$file"
		test -f "$product_instance_dir/$file" \
			&& diff "$product_instance_dir/$file" "$tgt_product_instance_dir/$file"
		[[ $? != 0 ]] && exit $?
	);
	done < <(cat $include_file)

}
#eof doChangeVersion

