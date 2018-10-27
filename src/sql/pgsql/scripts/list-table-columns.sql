SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name'  ;
--SELECT datname , datcollate FROM pg_database WHERE datname=:'postgres_db_name' ; 
/*
# or straight cp to bash

export postgres_db_name='my_db'
export table_name='my_table_name'

while read -r c; do test -z "$c" || echo $table_name.$c , ; done < <(cat << EOF | psql -t -q -d $postgres_db_name -v table_name="${table_name:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name'  ;
EOF
)

while read -r c; do test -z "$c" || echo  , $table_name.$c  | perl -ne 's/\n//gm;print' ; done < <(cat << EOF | psql -t -q -d $postgres_db_name -v table_name="${table_name:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name'  ;
EOF
)


while read -r c; do test -z "$c" || echo  $c = excluded.$c , | perl -ne 's/\n//gm;print' ; done < <(cat << EOF | psql -t -q -d $postgres_db_name -v table_name="${table_name:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name'  ;
EOF
)
*/
