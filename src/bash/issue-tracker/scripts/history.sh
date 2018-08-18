# make a backup of the project db
mkdir -p $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name ; pg_dump  --column-inserts --data-only $postgres_db_name  > $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name/$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.insrt.dmp.sql ; ls -1 $mix_data_dir/sql/pgsql/dbdumps/$postgres_db_name/* | sort -nr

# make a backup of the project db to the daily dir
mkdir -p $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/; pg_dump  --column-inserts --data-only $postgres_db_name  > $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.insrt.dmp.sql ; ls -1 $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")/sql/$postgres_db_name/* | sort -nr

# find the daily dir
find $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")

# set the daily data dir
export daily_data_dir=$mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")
