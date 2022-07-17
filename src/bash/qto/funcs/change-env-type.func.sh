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


	tgt_environment_name=$(echo $environment_name | perl -ne "s/$ENV/$tgt_env/g;print")
	tgt_PRODUCT_DIR=$product_dir/$tgt_environment_name

	test "$tgt_env" == "$ENV" && return
	# remove everything from the tgt product version dir - no extra files allowed !!!
	mkdir -p $tgt_PRODUCT_DIR && test -d $tgt_PRODUCT_DIR && \
      mv -v $tgt_PRODUCT_DIR $tgt_PRODUCT_DIR.$(date "+%Y%m%d_%H%M%S")
	test $? -eq 0  || do_exit 1 "cannot write to $tgt_PRODUCT_DIR !"
	
   mkdir -p $tgt_PRODUCT_DIR	
	test $? -ne 0 && do_exit 1 "Failed to create $tgt_PRODUCT_DIR !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_PRODUCT_DIR
	cp -v $zip_file $tgt_PRODUCT_DIR


   perl -pi -e 's|'$ENV'|'$tgt_env'|g' $tgt_PRODUCT_DIR/.env

   cd $tgt_PRODUCT_DIR
   ln -sf `pwd`/src/bash/qto/qto.sh qto
   ln -sf `pwd`/src/perl/qto/script/qto.pl qto.pl
   cd -
}
