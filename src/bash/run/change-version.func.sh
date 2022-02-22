doChangeVersion(){

	tgt_version="$1" ; shift 1;
	prefix='to-ver='
	tgt_version=${tgt_version#$prefix}
	tgt_env_name=$(echo $environment_name | perl -ne "s/$product_version/$tgt_version/g;print")
	tgt_env_name=$(echo $tgt_env_name | perl -ne "s/$env_type/dev/g;print") # ALWAYS !!!
	tgt_PRODUCT_INSTANCE_DIR=$product_dir/$tgt_env_name
	mkdir -p $tgt_PRODUCT_INSTANCE_DIR	

	test "$tgt_PRODUCT_INSTANCE_DIR" == "$PRODUCT_INSTANCE_DIR" && return
	rm -fvr $tgt_PRODUCT_INSTANCE_DIR/*
	test $? -eq 0  || do_exit 2 "cannot write to $tgt_PRODUCT_INSTANCE_DIR !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_PRODUCT_INSTANCE_DIR ; cp -v $zip_file $tgt_PRODUCT_INSTANCE_DIR

   # change the current version str to tgt-version in the configuration dir 
   export to_srch=$product_version
   export to_repl=$tgt_version
   export dir_to_morph=$tgt_PRODUCT_INSTANCE_DIR/cnf
   doMorphDir # :fin morph-dir.func.sh

	# ensure that all the files in the target product version dir are indentical to the current ones
	while read -r file ; do (
		do_log "DEBUG comparing src file: $file"
		do_log "DEBUG to tgt file: $tgt_PRODUCT_INSTANCE_DIR/$file"
		test -f "$PRODUCT_INSTANCE_DIR/$file" \
			&& diff "$PRODUCT_INSTANCE_DIR/$file" "$tgt_PRODUCT_INSTANCE_DIR/$file"
		[[ $? != 0 ]] && exit $?
	);
	done < <(cat $include_file)

   cd $tgt_PRODUCT_INSTANCE_DIR # to create default links
   ln -sf `pwd`/src/bash/qto/qto.sh qto ; sudo chmod 754 `pwd`/src/bash/qto/qto.sh
   ln -sf `pwd`/src/perl/qto/script/qto.pl qto.pl ; sudo chmod 754 `pwd`/src/perl/qto/script/qto.pl
   cd -
}
