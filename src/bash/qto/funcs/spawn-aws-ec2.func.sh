doSpawnAwsEc2(){

   #
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json"

   do_export_json_section_vars $PROJ_CONF_FILE '.env.aws'
   mkdir -p $PROJ_INSTANCE_DIR/src/terraform/qto

   test -f ~/.aws/credentials || \
      do_exit 1 "run the aws configure command - did not find the ~/.aws/credentials file !!!"
   export AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials| grep -i aws_access_key_id | awk '{print $3}')
   export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials| grep -i AWS_SECRET_ACCESS_KEY| awk '{print $3}')

   sudo timedatectl set-ntp no; timedatectl
   sudo service ntp stop ; sudo service ntp start; ntpq -p

   export key_name=$(basename `eval echo ${private_ssh_key_fpath:-}`)
   export public_ssh_key_fpath=$(eval echo ${public_ssh_key_fpath:-})
   export public_ssh_key_content=$(cat ${public_ssh_key_fpath:-})

	main_tf_file="$PROJ_INSTANCE_DIR/src/terraform/qto/main.tf"
	test -f "$main_tf_file" && rm -v "$main_tf_file"

   mkdir -p "$PROJ_INSTANCE_DIR/src/terraform/qto"
   rm -r $PROJ_INSTANCE_DIR/src/terraform/qto/*
   python3 "$PROJ_INSTANCE_DIR/src/python/tpl_gen.py"
   perl -pi -e 'foreach $key(sort keys %ENV){ s|\$$key|$ENV{$key}|g}' "$main_tf_file"
   #perl -e 'foreach $key(sort keys %ENV){ print "echo \$$key key:$key \n, val:$ENV{$key} \n"}'

   cd $PROJ_INSTANCE_DIR/src/terraform/qto/
   terraform init ; terraform plan ; test $? -ne 0 && do_exit 1 "terraform plan failed"
	terraform apply -auto-approve

   rm -v $PROJ_INSTANCE_DIR/src/terraform/qto/main.tf
}
