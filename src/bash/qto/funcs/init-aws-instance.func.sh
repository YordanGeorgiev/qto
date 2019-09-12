doInitAwdInstance(){

   doCheckInitTerraform 

   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   doExportJsonSectionVars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.aws'
   mkdir -p $PRODUCT_INSTANCE_DIR/src/terraform/qto
   cp -v $PRODUCT_INSTANCE_DIR/src/terraform/tpl/qto/main.tf.tpl \
      $PRODUCT_INSTANCE_DIR/src/terraform/qto/main.tf

	public_key=$(cat echo $public_key_path)
	main_tf_file="$PRODUCT_INSTANCE_DIR/src/terraform/qto/main.tf"   


	# search and replace the variables from the configuration file to the tpl file
   perl -pi -e 's|\$access_key|'"$access_key"'|g' "$main_tf_file"
   perl -pi -e 's|\$secret_key|'"$secret_key"'|g' "$main_tf_file"
   perl -pi -e 's|\$ENV_TYPE|'"$ENV_TYPE"'|g' "$main_tf_file"
   perl -pi -e 's|\$aws_region|'"$aws_region"'|g' "$main_tf_file"
   perl -pi -e 's|\$availability_zone|'"$availability_zone"'|g' "$main_tf_file"
   perl -pi -e 's|\$ssh_key_pair_file|'"$ssh_key_pair_file"'|g' "$main_tf_file"
   perl -pi -e 's|\$public_key_path|'"$public_key_path"'|g' "$main_tf_file"
   perl -pi -e 's|\$public_key|'"$public_key"'|g' "$main_tf_file"
   perl -pi -e 's|\$key_name|'"$key_name"'|g' "$main_tf_file"

   cd $PRODUCT_INSTANCE_DIR/src/terraform/qto/
   terraform init
   terraform plan
	test $? -ne 0 && doExit 1 "terraform plan failed"
	
	# import the deployment key first ?!
	# nope terraform import aws_key_pair."aws_key_pair-$ENV_TYPE" "$key_name"
	terraform apply -auto-approve
	
	rm -v "$main_tf_file"
}
