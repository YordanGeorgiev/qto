doInitAwdInstance(){

   # attempt to install terraform, if it is missing !!! Obs needs sudo !!!
   which terraform  2>/dev/null || { 
      ver='0.12.8'
      wget -O "/tmp/terraform_""$ver'_linux_amd64.zip" \
         "https://releases.hashicorp.com/terraform/$ver/terraform_""$ver"'_linux_amd64.zip'
      sudo unzip -o "/tmp/terraform_""$ver'_linux_amd64.zip" -d '/usr/local/bin'
      terraform -V
   }

   which terraform  2>/dev/null || { 
      echo >&2 "The terraform binary is missing ! Aborting ..."; exit 1; }
   
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   doExportJsonSectionVars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.aws'
   cp -v $PRODUCT_INSTANCE_DIR/src/terraform/tpl/csitea/main.tf.tpl \
      $PRODUCT_INSTANCE_DIR/src/terraform/csitea/main.tf

	main_tf_file="$PRODUCT_INSTANCE_DIR/src/terraform/csitea/main.tf"   
   perl -pi -e 's|\$access_key|'"$access_key"'|g' "$main_tf_file"
   perl -pi -e 's|\$secret_key|'"$secret_key"'|g' "$main_tf_file"

   cd $PRODUCT_INSTANCE_DIR/src/terraform/csitea/
   terraform init
   terraform plan
	test $? -ne 0 && doExit 1 "terraform plan failed"
	terraform apply -auto-approve
	
	rm -v "$main_tf_file"
}
