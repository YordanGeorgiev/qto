# ---------------------------------------------------------
# create a new <<env-type>> from this product instance
# bash src/bash/qto/qto.sh -a to-dev
# bash src/bash/qto/qto.sh -a to-tst
# bash src/bash/qto/qto.sh -a to-prd
# ---------------------------------------------------------
doChangeEnvType(){

   tgt_env="$1"
   prefix='to-env='
   tgt_env=${tgt_env#$prefix}

	tgt_environment_name=$(echo $environment_name | perl -ne "s/$env_type/$tgt_env/g;print")
	tgt_product_instance_dir=$product_dir/$tgt_environment_name
	mkdir -p $tgt_product_instance_dir	
	test $? -ne 0 && doExit 2 "Failed to create $tgt_product_instance_dir !"

	test "$tgt_env" == "$env_type" && return
	# remove everything from the tgt product version dir - no extra files allowed !!!
	rm -fvr $tgt_product_instance_dir/*
	test $? -eq 0  || doExit 2 "cannot write to $tgt_product_instance_dir !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_product_instance_dir
	cp -v $zip_file $tgt_product_instance_dir

   tgt_instance_cnf_file=$tgt_product_instance_dir/cnf/$run_unit.$tgt_env.$host_name.cnf
   test -f $tgt_instance_cnf_file || cp -v $tgt_product_instance_dir/cnf/tpl/$run_unit.$tgt_env.p-host-name.cnf \
         $tgt_instance_cnf_file && perl -pi -e "s/p-host-name/$host_name/g" $tgt_instance_cnf_file

   perl -pi -e 's|'$env_type'|'$tgt_env'|g' $tgt_product_instance_dir/.env

	doLog "DEBUG STOP  doChangeEnvType"
}
