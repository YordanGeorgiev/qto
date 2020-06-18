# ---------------------------------------------------------
# create a new <<env-type>> from this product instance
# bash src/bash/qto/qto.sh -a to-dev
# bash src/bash/qto/qto.sh -a to-tst
# bash src/bash/qto/qto.sh -a to-prd
# ---------------------------------------------------------
doChangeEnvType(){
   tgt_env="${1:-}"
   prefix='to-env='
   tgt_env=${tgt_env#$prefix}


	tgt_environment_name=$(echo $environment_name | perl -ne "s/$ENV_TYPE/$tgt_env/g;print")
	tgt_product_instance_dir=$product_dir/$tgt_environment_name

	test "$tgt_env" == "$env_type" && return
	# remove everything from the tgt product version dir - no extra files allowed !!!
	mkdir -p $tgt_product_instance_dir && test -d $tgt_product_instance_dir && \
      mv -v $tgt_product_instance_dir $tgt_product_instance_dir.$(date "+%Y%m%d_%H%M%S")
	test $? -eq 0  || do_exit 1 "cannot write to $tgt_product_instance_dir !"
	
   mkdir -p $tgt_product_instance_dir	
	test $? -ne 0 && do_exit 1 "Failed to create $tgt_product_instance_dir !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_product_instance_dir
	cp -v $zip_file $tgt_product_instance_dir


   perl -pi -e 's|'$env_type'|'$tgt_env'|g' $tgt_product_instance_dir/.env

   cd $tgt_product_instance_dir
   ln -sf `pwd`/src/bash/qto/qto.sh qto
   ln -sf `pwd`/src/perl/qto/script/qto.pl qto.pl
   cd -
}
