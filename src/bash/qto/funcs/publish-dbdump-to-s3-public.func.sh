
doPublishDbdumpToS3(){
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   do_export_json_section_vars $proj_instance_dir/cnf/env/$env_type.env.json '.env.db'
   do_export_json_section_vars $proj_instance_dir/cnf/env/$env_type.env.json '.env.aws'

   dump_file="$(find $proj_instance_dir/dat/mix/ -type f -name '*.insrts.dmp.sql'|sort -nr|head -n 1)"
   dump_file_name=$(basename $dump_file)

   export AWS_DEFAULT_PROFILE='default'
   aws configure list
   set -x
   # remove the grants to disable full publicity of the data ...
   aws s3 --profile default cp "$dump_file" "s3://$bucket/$postgres_db_name"'.latest.insrts.dmp.sql' \
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
