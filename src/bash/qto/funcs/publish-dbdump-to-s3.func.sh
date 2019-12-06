
doPublishDbdumpToS3(){
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   doExportJsonSectionVars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.db'
   doExportJsonSectionVars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.aws'

   dump_file="$(find $PROJ_INSTANCE_DIR/dat/mix/ -type f -name '*.insrts.dmp.sql'|sort -nr|head -n 1)"
   dump_file_name=$(basename $dump_file)

   AWS_DEFAULT_PROFILE="$ENV_TYPE"'_'"$RUN_UNIT"
   test -f ~/.aws/credentials && cp -v ~/.aws/credentials ~/.aws/credentials.bak
   cat << EOF_CREDENTIALS > ~/.aws/credentials
     [$AWS_DEFAULT_PROFILE]
     aws_AWS_ACCESS_KEY_ID_id = $AWS_ACCESS_KEY_ID
     aws_secret_AWS_ACCESS_KEY_ID = $AWS_SECRET_ACCESS_KEY
EOF_CREDENTIALS

   test -f ~/.aws/config && cp -v ~/.aws/config ~/.aws/config.bak 
   cat << EOF_CONFIG > ~/.aws/config
     [$AWS_DEFAULT_PROFILE]
     region=$AWS_DEFAULT_REGION
     output=json
     [profile $AWS_DEFAULT_PROFILE]
EOF_CONFIG

   aws configure list
   set -x
   aws s3 cp "$dump_file" s3://$bucket/"$ENV_TYPE"'_'"$RUN_UNIT"'.latest.insrts.dmp.sql' \
      --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
   set +x

   cp -v ~/.aws/config.bak ~/.aws/config
   cp -v ~/.aws/credentials.bak ~/.aws/credentials
}
