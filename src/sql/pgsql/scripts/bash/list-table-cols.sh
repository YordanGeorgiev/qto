#!/bin/bash

source lib/bash/funcs/export-json-section-vars.sh
doExportJsonSectionVars cnf/env/dev.env.json '.env.db'

cmd_psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host"
export postgres_db_name=$1
export table_name_01=$2
export table_name_02=$3

test -z ${postgres_db_name:-} && export postgres_db_name='dev_qto'
test -z ${table_name_01:-} && export table_name_01='monthly_issues'
test -z ${table_name_02:-} && export table_name_01='yearly_issues'
echo -e "\n\n"

# , t.col1
# , t.col2
while read -r c; do test -z "$c" || comma_col_list="$comma_col_list , $table_name_01.$c" ; \
   done < <(cat << EOF | PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host -t -q -d $postgres_db_name -v table_name_01="${table_name_01:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name_01'  ;
EOF
)
echo "$comma_col_list"
echo -e "\n\n"

# generate col1, col2, col3 ...
while read -r c; do test -z "$c" || simple_comma_list="$simple_comma_list  , $c" ; \
   done < <(cat << EOF | PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host -t -q -d $postgres_db_name -v table_name_01="${table_name_01:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name_01'  ;
EOF
)
echo "$simple_comma_list"
echo -e "\n\n"

# generate t.col1, t.col2, t.col3 ...
while read -r c; do test -z "$c" || echo  , $table_name_01.$c  | perl -ne 's/\n//gm;print' ; \
   done < <(cat << EOF | PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host -t -q -d $postgres_db_name -v table_name_01="${table_name_01:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name_01'  ;
EOF
)
echo -e "\n\n"


# generate guid = excluded.guid ,id = excluded.id ,col = excluded.col
while read -r c; do test -z "$c" || echo  $c = excluded.$c , | perl -ne 's/\n//gm;print' ; \
   done < <(cat << EOF | PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host -t -q -d $postgres_db_name -v table_name_01="${table_name_01:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name_01'  ;
EOF
)

echo "$old_smpl_comma_lst"
echo -e "\n\n"
old_smpl_comma_lst=''
# generate OLD.col1, OLD.col2, OLD.col3 ...
while read -r c; do test -z "$c" || old_smpl_comma_lst="$old_smpl_comma_lst  , OLD.$c" ; \
   done < <(cat << EOF | PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host -t -q -d $postgres_db_name -v table_name_01="${table_name_01:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name_01'  ;
EOF
)
echo "$old_smpl_comma_lst"
echo -e "\n\n"

new_smpl_comma_lst=""
# generate NEW.col1, NEW.col2, NEW.col3 ...
while read -r c; do test -z "$c" || new_smpl_comma_lst="$new_smpl_comma_lst  , NEW.$c" ; \
   done < <(cat << EOF | PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host -t -q -d $postgres_db_name -v table_name_01="${table_name_01:-}"
SELECT column_name
FROM information_schema.columns
WHERE 1=1
AND table_schema = 'public'
AND table_name   =:'table_name_01'  ;
EOF
)
echo "$new_smpl_comma_lst"
echo -e "\n\n"
#INSERT INTO yearly_issues (guid, id, level, seq, type, weight, category, status, prio, name, description, owner, start_time, stop_time, planned_hours, actual_hours, tags, update_time) SELECT guid, u, monthly_issues.level, monthly_issues.seq, monthly_issues.type, monthly_issues.weight, monthly_issues.category, monthly_issues.status, monthly_issues.prio, monthly_issues.name, monthly_issues.description, monthly_issues.owner, monthly_issues.start_time, monthly_issues.stop_time, monthly_issues.planned_hours, monthly_issues.actual_hours, monthly_issues.tags, monthly_issues.update_time FROM monthly_issues  WHERE 1=1 and status='09-done'
#ON CONFLICT (id) DO UPDATE
#SET guid = excluded.guid ,id = excluded.id ,level = excluded.level ,seq = excluded.seq ,prio = excluded.prio ,weight = excluded.weight ,status = excluded.status ,category = excluded.category ,name = excluded.name ,description = excluded.description ,type = excluded.type ,owner = excluded.owner ,start_time = excluded.start_time ,stop_time = excluded.stop_time ,planned_hours = excluded.planned_hours ,actual_hours = excluded.actual_hours ,tags = excluded.tags ,update_time = excluded.update_time
# , yearly_issues.guid , yearly_issues.id , yearly_issues.type , yearly_issues.category , yearly_issues.status , yearly_issues.prio , yearly_issues.name , yearly_issues.description , yearly_issues.owner , yearly_issues.update_time
#, yearly_issues.guid, yearly_issues.id, yearly_issues.type, yearly_issues.category, yearly_issues.status, yearly_issues.prio, yearly_issues.name, yearly_issues.description, yearly_issues.owner, yearly_issues.update_time
#guid = excluded.guid ,id = excluded.id ,type = excluded.type ,category = excluded.category ,status = excluded.status ,prio = excluded.prio ,name = excluded.name ,description = excluded.description ,owner = excluded.owner ,update_time = excluded.update_time

