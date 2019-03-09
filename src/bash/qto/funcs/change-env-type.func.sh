# src/bash/qto/funcs/change-env-type.func.sh

# v1.1.2
# ---------------------------------------------------------
# ---------------------------------------------------------
doChangeEnvType(){

	doLog "DEBUG START doChangeEnvType"
	

	tgt_env="$1"
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

	doLog "DEBUG STOP  doChangeEnvType"
}
# eof func doChangeEnvType

# eof file: src/bash/qto/funcs/change-env-type.func.sh
