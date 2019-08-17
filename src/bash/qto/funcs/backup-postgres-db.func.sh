# src/bash/qto/funcs/backup-postgres-db.func.sh

# v0.6.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/backup-postgres-db.func.txt
# ---------------------------------------------------------
doBackupPostgresDb(){

	doLog "DEBUG START doBackupPostgresDb"
   test -z ${qto_project:-} && doParseCnfEnvVars $cnf_file
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"

   doExportJsonSectionVars cnf/env/$env_type.env.json '.env.db'

   test -z "${mix_data_dir-}" && mix_data_dir="$proj_instance_dir/dat/mix"
   test -z "${postgres_db_name-}" && postgres_db_name="${env_type-}"_"${run_unit//-/_}"

   backup_dir=$mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name
   backup_fname=$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.insrt.dmp.sql
   test -d $backup_dir || mkdir -p $backup_dir

   nmap -Pnv -p $postgres_db_port $postgres_db_host || \
         doExit 1 "cannot connect to $postgres_db_port:$postgres_db_host"

   PGPASSWORD="${postgres_db_useradmin_pw:-}" pg_dump -U "${postgres_db_useradmin:-}"  \
         -h $postgres_db_host -p $postgres_db_port -w --format=plain \
         $postgres_db_name   > $backup_dir/$backup_fname
         #--column-inserts --data-only \

   ls -1 $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/* | sort -nr
   echo -e "\n"
   wc -l $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/* | sort -nr
   sleep 1
	

	doLog "DEBUG STOP  doBackupPostgresDb"
}


# eof file: src/bash/qto/funcs/backup-postgres-db.func.sh
