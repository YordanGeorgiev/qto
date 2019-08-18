# ---------------------------------------------------------
# create a new <<env-type>> from this product instance
# bash src/bash/qto/qto.sh -a to-dev
# bash src/bash/qto/qto.sh -a to-tst
# bash src/bash/qto/qto.sh -a to-prd
# ---------------------------------------------------------
doChangeEnvType(){

	doLog "DEBUG START doChangeEnvType"

	tgt_env="$1"
	tgt_environment_name=$(echo $environment_name | perl -ne "s/$env_type/$tgt_env/g;print")
	tgt_PRODUCT_INSTANCE_DIR=$product_dir/$tgt_environment_name
	mkdir -p $tgt_PRODUCT_INSTANCE_DIR	
	test $? -ne 0 && doExit 2 "Failed to create $tgt_PRODUCT_INSTANCE_DIR !"

	test "$tgt_env" == "$env_type" && return
	# remove everything from the tgt product version dir - no extra files allowed !!!
	rm -fvr $tgt_PRODUCT_INSTANCE_DIR/*
	test $? -eq 0  || doExit 2 "cannot write to $tgt_PRODUCT_INSTANCE_DIR !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_PRODUCT_INSTANCE_DIR
	cp -v $zip_file $tgt_PRODUCT_INSTANCE_DIR

   tgt_instance_cnf_file=$tgt_PRODUCT_INSTANCE_DIR/cnf/$run_unit.$tgt_env.$host_name.cnf
   test -f $tgt_instance_cnf_file || cp -v $tgt_PRODUCT_INSTANCE_DIR/cnf/tpl/$run_unit.$tgt_env.p-host-name.cnf \
         $tgt_instance_cnf_file && perl -pi -e "s/p-host-name/$host_name/g" $tgt_instance_cnf_file

   perl -pi -e 's|'$env_type'|'$tgt_env'|g' $tgt_PRODUCT_INSTANCE_DIR/.env

	doLog "DEBUG STOP  doChangeEnvType"
}
# eof func doChangeEnvType
