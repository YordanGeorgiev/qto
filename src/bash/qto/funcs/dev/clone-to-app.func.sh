#!/usr/bin/env bash

#------------------------------------------------------------------------------
# increase or decrease the version of the product
# clone the <<base_dir>>/app_name/a
# bash src/bash/qto/qto.sh -a to-app=<<new_app>>
#------------------------------------------------------------------------------
doCloneToApp(){
	tgt_app="$1"
	prefix='to-app='
	tgt_app=${tgt_app#$prefix}
	tgt_environment_name=$(echo $environment_name | perl -ne "s/$RUN_UNIT/$tgt_app/g;print")
	tgt_environment_name=$(echo $tgt_environment_name | perl -ne "s/$product_version/0.0.0/g;print")
	tgt_environment_name=$(echo $tgt_environment_name | perl -ne "s/$ENV/dev/g;print")
	tgt_product_dir=$product_base_dir/$tgt_app
	tgt_PRODUCT_DIR=$tgt_product_dir/$tgt_environment_name

	mkdir -p $tgt_PRODUCT_DIR 
	[[ $? -eq 0 ]] || do_exit 2 "ERROR :: cannot create the tgt_PRODUCT_DIR: $tgt_PRODUCT_DIR !"

	# remove everything from the tgt product version dir - no extra files allowed !!!
	rm -fvr $tgt_PRODUCT_DIR
	# if the removal failed exit with error msg
	[[ $? -eq 0 ]] || do_exit 2 "ERROR :: cannot write to $tgt_PRODUCT_DIR !"

	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_PRODUCT_DIR

	to_srch=$RUN_UNIT
	to_repl=$tgt_app

	#-- search and replace in file names
	find "$tgt_PRODUCT_DIR/" -type d |\
		perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
	find "$tgt_PRODUCT_DIR/" -type f |\
		perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'


	find $tgt_PRODUCT_DIR -exec file {} \; | grep text | cut -d: -f1| { while read -r file_to_edit ;
		do (
			perl -pi -e "s#$to_srch#$to_repl#g" "$file_to_edit"
		);
		done ;
	}
	
	# on cygwin the perl -pi leaves backup files => remove them
	find $tgt_PRODUCT_DIR -type f -name '*.bak' | xargs rm -fv 

	cp -v $zip_file $tgt_PRODUCT_DIR

}
