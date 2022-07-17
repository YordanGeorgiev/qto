#
# the following db dump in the s3 of the aws credentials owning user should exist:
# https://s3-$AWS_DEFAULT_REGION.amazonaws.com/$bucket/"$ENV"_$RUN_UNIT"'.latest.insrts.dmp.sql
#
do_load_db_data_from_db(){

   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.db'
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.aws'

   mkdir -p $PRODUCT_DIR/dat/sql/

   echo "fetch the db inserts data from the s3 bucket from the following url: "
   echo "https://s3-$AWS_DEFAULT_REGION.amazonaws.com/$bucket/"$ENV"_$RUN_UNIT"'.latest.insrts.dmp.sql'
   wget -O "$PRODUCT_DIR/dat/sql/"$ENV'_'$RUN_UNIT".latest.insrts.dmp.sql" \
      "https://s3-$AWS_DEFAULT_REGION.amazonaws.com/$bucket/"$ENV"_$RUN_UNIT"'.latest.insrts.dmp.sql'

   # configure psql to access the db of THIS instance
   PGPASSWORD=${postgres_sys_usr_admin_pw:-} psql -v -t -X -w -U ${postgres_sys_usr_admin:-} \
      --port $postgres_rdbms_port --host $postgres_rdbms_host -d $postgres_app_db < \
         "$PRODUCT_DIR/dat/sql/$ENV"'_'"$RUN_UNIT"'.latest.insrts.dmp.sql'

   test -f $PRODUCT_DIR/dat/tmp/bootstrapping && rm -v $PRODUCT_DIR/dat/tmp/bootstrapping
   test -f $PRODUCT_DIR/bootstrapping && rm -v $PRODUCT_DIR/bootstrapping

   # grant the needed select
   PGPASSWORD="${postgres_sys_usr_admin_pw:-}" psql -v -q -t -X -w -U "${postgres_sys_usr_admin:-}" \
      -h ${postgres_rdbms_host:-} -p ${postgres_rdbms_port:-} -v ON_ERROR_STOP=1 \
      -d ${postgres_app_db:-} \
      -c "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA public TO $postgres_app_usr;
         GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_app_usr"

   echo "Databases successfully filled with data."

}
