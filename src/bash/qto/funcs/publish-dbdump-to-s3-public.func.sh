#!/bin/bash

do_publish_db_dump_to_s3(){
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.db'
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.aws'

   dump_file="$(find $PROJ_INSTANCE_DIR/dat/mix/ -type f -name '*.insrts.dmp.sql'|sort -nr|head -n 1)"
   dump_file_name=$(basename $dump_file)

   export AWS_DEFAULT_PROFILE='default'
   aws configure list
   set -x
   # remove the grants to disable full publicity of the data ...
   aws s3 --profile default cp "$dump_file" "s3://$bucket/$postgres_app_db"'.latest.insrts.dmp.sql' \
      --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
	set +x

	cat << EOF
		IF error occurs check that your aws credentials file ~/.aws/credentials looks as follws
		sudo ntpdate ntp.ubuntu.com
		cat ~/.aws/credentials
		[default]
		aws_access_key_id = BKIAID4UEECKBMVJMG55
		aws_secret_access_key = 7VB1A4tpSfnE0P22jNEFMurPy8G2n9H7lqxSEFa9
EOF
}
