# src/bash/issue-tracker/funcs/backup-postgres-table.func.sh

# ---------------------------------------------------------
doBackupPostgresTable(){

	doLog "DEBUG START doBackupPostgresTable"
   echo "start running : pg_dump  --verbose --data-only --table public.$tables $postgres_db_name \\"
   echo -e " --file $DataDir/tmp/$tables.data.sql \n"

   pg_dump  --verbose --data-only --table public.$tables $postgres_db_name \
      --file $DataDir/tmp/$tables.data.sql 
   echo "stop running : pg_dump  --verbose --data-only --table public.$tables $postgres_db_name \\"
   echo -e " --file $DataDir/tmp/$tables.data.sql \n"

   doLog "INFO produced the following file : $(ls -1 $DataDir/tmp/$tables.data.sql)"
   doLog "INFO with the following amount of lines :"
   wc -l $DataDir/tmp/$tables.data.sql
   echo -e "\n\n"
	doLog "DEBUG STOP  doBackupPostgresTable"
}

# eof file: src/bash/issue-tracker/funcs/backup-postgres-table.func.sh
