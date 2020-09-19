do_configure_aws_keys(){

	# set up confs
   source $PRODUCT_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PRODUCT_DIR/cnf/env/$env_type.env.json"
   source $PRODUCT_DIR/lib/bash/funcs/export-json-section-vars.sh
   do_export_json_section_vars $PROJ_CONF_FILE '.env.aws'

   mkdir -p ~/.aws/

   cat << EOF_AWS | tee ~/.aws/credentials
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF_AWS
}
