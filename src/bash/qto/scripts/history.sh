# make a data dump of a single table
export table=benchmarks; export db=prd_nokia_musa
pg_dump  --verbose --data-only --table public.$table $db --file dat/tmp/$table.data.sql ; wc -l dat/tmp/$table.data.sql

# find the daily dir
find $mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")

# set the daily data dir
export daily_data_dir=$mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")

