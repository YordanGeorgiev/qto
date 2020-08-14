doInitAwdInstance(){

   doCheckInitTerraform 
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.aws'
   mkdir -p $PRODUCT_INSTANCE_DIR/src/terraform/qto

   test -f ~/.aws/credentials || \
      do_exit 1 "run the aws configure command - did not find the ~/.aws/credentials file !!!"
   export AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials| grep -i aws_access_key_id | awk '{print $3}')
   export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials| grep -i AWS_SECRET_ACCESS_KEY| awk '{print $3}')

   sudo service ntp stop ; sudo ntpdate -s time.nist.gov ; sudo service ntp start
  
	export pem_key=$(cat `eval echo ${pem_key_fpath:-}`) # expand the possible ~'s to the $HOME
   export public_key=$(cat `eval echo $pem_key_fpath.pub`)
   export pem_key_fpath_pub=$(cat `eval echo $pem_key_fpath.pub`)
   export key_name=$(basename `eval echo ${pem_key_fpath:-}`)
   export ssh_key_pair_file=$(echo `eval echo $ssh_key_pair_file`) 

   python3 "$PRODUCT_INSTANCE_DIR/src/python/tpl_gen.py"
	main_tf_file="$PRODUCT_INSTANCE_DIR/src/terraform/qto/main.tf"

   perl -pi -e 'foreach $key(sort keys %ENV){ s/\$$key/$ENV{$key}/g}' "$main_tf_file"

   cd $PRODUCT_INSTANCE_DIR/src/terraform/qto/
   terraform init ; terraform plan ; test $? -ne 0 && do_exit 1 "terraform plan failed"
	terraform apply -auto-approve
	
	rm -v "$main_tf_file"
}
