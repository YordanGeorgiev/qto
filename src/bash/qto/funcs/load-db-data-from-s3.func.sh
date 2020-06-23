#
# the following db dump in the s3 of the aws credentials owning user should exist:
# https://s3-$AWS_DEFAULT_REGION.amazonaws.com/$bucket/"$ENV_TYPE"_$RUN_UNIT"'.latest.insrts.dmp.sql
# 
doLoadDbDataFromS3(){
   
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   do_export_json_section_vars $proj_instance_dir/cnf/env/$env_type.env.json '.env.db'
   do_export_json_section_vars $proj_instance_dir/cnf/env/$env_type.env.json '.env.aws'

   mkdir -p $product_instance_dir/dat/sql/

   echo "fetch the db inserts data from the s3 bucket from the following url: "
   echo "https://s3-$AWS_DEFAULT_REGION.amazonaws.com/$bucket/"$ENV_TYPE"_$RUN_UNIT"'.latest.insrts.dmp.sql'
   wget -O "$product_instance_dir/dat/sql/"$ENV_TYPE'_'$RUN_UNIT".latest.insrts.dmp.sql" \
      "https://s3-$AWS_DEFAULT_REGION.amazonaws.com/$bucket/"$ENV_TYPE"_$RUN_UNIT"'.latest.insrts.dmp.sql'

   # configure psql to access the db of THIS instance
   PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} \
      --port $postgres_db_port --host $postgres_db_host -d $postgres_db_name < \
         "$product_instance_dir/dat/sql/$ENV_TYPE"'_'"$RUN_UNIT"'.latest.insrts.dmp.sql'

   test -f $product_instance_dir/dat/tmp/bootstrapping && rm -v $product_instance_dir/dat/tmp/bootstrapping
   test -f $product_instance_dir/bootstrapping && rm -v $product_instance_dir/bootstrapping

   # grant the needed select
   PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -v -q -t -X -w -U "${postgres_db_useradmin:-}" \
      -h ${postgres_db_host:-} -p ${postgres_db_port:-} -v ON_ERROR_STOP=1 \
      -d ${postgres_db_name:-} \
      -c "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA public TO $postgres_db_user; 
         GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_db_user"

}
