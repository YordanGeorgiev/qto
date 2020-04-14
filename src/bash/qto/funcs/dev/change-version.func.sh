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
	tgt_PRODUCT_INSTANCE_DIR=$product_dir/$tgt_environment_name
	mkdir -p $tgt_PRODUCT_INSTANCE_DIR	

	test "$tgt_PRODUCT_INSTANCE_DIR" == "$PRODUCT_INSTANCE_DIR" && return
	# remove everything from the tgt product version dir - no extra files allowed !!!
	rm -fvr $tgt_PRODUCT_INSTANCE_DIR/*
	test $? -eq 0  || do_exit 2 "cannot write to $tgt_PRODUCT_INSTANCE_DIR !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_PRODUCT_INSTANCE_DIR
	cp -v $zip_file $tgt_PRODUCT_INSTANCE_DIR

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

}
#eof doChangeVersion

