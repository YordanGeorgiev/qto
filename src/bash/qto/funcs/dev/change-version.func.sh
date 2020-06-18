doChangeVersion(){

	tgt_version="$1" ; shift 1;
	prefix='to-ver='
	tgt_version=${tgt_version#$prefix}
	tgt_env_name=$(echo $environment_name | perl -ne "s/$product_version/$tgt_version/g;print")
	tgt_env_name=$(echo $tgt_env_name | perl -ne "s/$env_type/dev/g;print") # ALWAYS !!!
	tgt_product_instance_dir=$product_dir/$tgt_env_name
	mkdir -p $tgt_product_instance_dir	

	test "$tgt_product_instance_dir" == "$product_instance_dir" && return
	rm -fvr $tgt_product_instance_dir/*
	test $? -eq 0  || do_exit 2 "cannot write to $tgt_product_instance_dir !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_product_instance_dir ; cp -v $zip_file $tgt_product_instance_dir

   # change the current version str to tgt-version in the configuration dir 
   export to_srch=$product_version
   export to_repl=$tgt_version
   export dir_to_morph=$tgt_product_instance_dir/cnf
   doMorphDir # :fin morph-dir.func.sh

	# ensure that all the files in the target product version dir are indentical to the current ones
	while read -r file ; do (
		do_log "DEBUG comparing src file: $file"
		do_log "DEBUG to tgt file: $tgt_product_instance_dir/$file"
		test -f "$product_instance_dir/$file" \
			&& diff "$product_instance_dir/$file" "$tgt_product_instance_dir/$file"
		[[ $? != 0 ]] && exit $?
	);
	done < <(cat $include_file)

   cd $tgt_product_instance_dir # to create default links
   ln -sf `pwd`/src/bash/qto/qto.sh qto ; sudo chmod 754 `pwd`/src/bash/qto/qto.sh
   ln -sf `pwd`/src/perl/qto/script/qto.pl qto.pl ; sudo chmod 754 `pwd`/src/perl/qto/script/qto.pl
   cd -
}
