#!/bin/bash

export postgres_db_name=$1
export table_name=$2

test -z ${postgres_db_name:-} && export postgres_db_name='dev_qto'
test -z ${table_name:-} && export table_name='monthly_issues'
echo -e "\n\n"

# , t.col1
# , t.col2
while read -r c; do test -z "$c" || echo , $table_name.$c ; \
   done < <(cat << EOF | psql -t -q -d $postgres_db_name -v table_name="${table_name:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name'  ;
EOF
)
echo -e "\n\n"

# generate col1, col2, col3 ...
while read -r c; do test -z "$c" || echo  , $c  | perl -ne 's/\n//gm;print' ; \
   done < <(cat << EOF | psql -t -q -d $postgres_db_name -v table_name="${table_name:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name'  ;
EOF
)
echo -e "\n\n"

# generate t.col1, t.col2, t.col3 ...
while read -r c; do test -z "$c" || echo  , $table_name.$c  | perl -ne 's/\n//gm;print' ; \
   done < <(cat << EOF | psql -t -q -d $postgres_db_name -v table_name="${table_name:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name'  ;
EOF
)
echo -e "\n\n"


# generate guid = excluded.guid ,id = excluded.id ,col = excluded.col
while read -r c; do test -z "$c" || echo  $c = excluded.$c , | perl -ne 's/\n//gm;print' ; \
   done < <(cat << EOF | psql -t -q -d $postgres_db_name -v table_name="${table_name:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name'  ;
EOF
)
