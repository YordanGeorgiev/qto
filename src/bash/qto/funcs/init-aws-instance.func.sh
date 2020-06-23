doInitAwdInstance(){

   doCheckInitTerraform 

   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   do_export_json_section_vars $proj_instance_dir/cnf/env/$env_type.env.json '.env.aws'
   mkdir -p $product_instance_dir/src/terraform/qto
   cp -v $product_instance_dir/src/terraform/tpl/qto/main.tf.tpl \
      $product_instance_dir/src/terraform/qto/main.tf

   test -f ~/.aws/credentials || do_exit 1 "run the aws configure command - did not find
   ~/.aws/credentials file !!!"

   AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials| grep -i aws_access_key_id | awk '{print $3}')
   AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials| grep -i AWS_SECRET_ACCESS_KEY| awk '{print $3}')

   sudo service ntp stop
   sudo ntpdate -s time.nist.gov
   sudo service ntp start
  
   # expand the possible ~'s to the $HOME
	pem_key=$(cat `eval echo ${pem_key_fpath:-}`)
   public_key=$(cat `eval echo $pem_key_fpath.pub`)
   pem_key_fpath_pub=$(cat `eval echo $pem_key_fpath.pub`)
   key_name=$(basename `eval echo ${pem_key_fpath:-}`)
   ssh_key_pair_file=$(echo `eval echo $ssh_key_pair_file`) 

	main_tf_file="$product_instance_dir/src/terraform/qto/main.tf"
   VER="${VERSION//./}"  # terraform does not allow dots in technical names

	# search and replace the variables from the configuration file to the tpl file
   perl -pi -e 's|\$AWS_ACCESS_KEY_ID|'"$AWS_ACCESS_KEY_ID"'|g' "$main_tf_file"
   perl -pi -e 's|\$AWS_SECRET_ACCESS_KEY|'"$AWS_SECRET_ACCESS_KEY"'|g' "$main_tf_file"
   perl -pi -e 's|\$AWS_PROFILE|'"$AWS_PROFILE"'|g' "$main_tf_file"
   perl -pi -e 's|\$ENV_TYPE|'"$ENV_TYPE"'|g' "$main_tf_file"
   perl -pi -e 's|\$VERSION|'"$VERSION"'|g' "$main_tf_file"
   perl -pi -e 's|\$VER|'"$VER"'|g' "$main_tf_file"
   perl -pi -e 's|\$AWS_DEFAULT_REGION|'"$AWS_DEFAULT_REGION"'|g' "$main_tf_file"
   perl -pi -e 's|\$availability_zone|'"$availability_zone"'|g' "$main_tf_file"
   perl -pi -e 's|\$ssh_key_pair_file|'"$ssh_key_pair_file"'|g' "$main_tf_file"
   perl -pi -e 's|\$pem_key_fpath|'"$pem_key_fpath"'|g' "$main_tf_file"
   perl -pi -e 's|\$pem_key_fpath_pub|'"$pem_key_fpath_pub"'|g' "$main_tf_file"
   perl -pi -e 's|\$pem_key|'"$pem_key"'|g' "$main_tf_file"
   perl -pi -e 's|\$public_key|'"$public_key"'|g' "$main_tf_file"
   perl -pi -e 's|\$key_name|'"$key_name"'|g' "$main_tf_file"

   cd $product_instance_dir/src/terraform/qto/
   terraform init
   terraform plan
	test $? -ne 0 && do_exit 1 "terraform plan failed"
	
	terraform apply -auto-approve
	
	rm -v "$main_tf_file"
}
