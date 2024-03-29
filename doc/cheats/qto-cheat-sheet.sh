# file: doc/cheats/qto-cheat-sheet.sh

psql -d "$postgres_app_db" -c "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA public TO $postgres_app_usr; GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_app_usr; GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO $postgres_app_usr; ALTER DEFAULT PRIVILEGES FOR USER $postgres_app_usr IN SCHEMA public GRANT SELECT ON TABLES TO    $postgres_app_usr;  "


# how-to check the perl syntax of single perl file : 
perl -MCarp::Always -I `pwd`/src/perl/*/ -I `pwd`/src/perl/*/lib/ -wc \
   src/perl/qto/lib/Qto/App/Db/In/Postgres/RdrPostgresDb.pm

# start load env vars
export PROJ_INSTANCE_DIR=`pwd`  # or could be any qto proj
export PROJ_CONF_FILE=`pwd`/cnf/env/prd.env.json  # or could be any qto proj's conf file
source lib/bash/funcs/export-json-section-vars.sh
do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/prd.env.json '.env.db'
alias psql="PGPASSWORD=${postgres_sys_usr_admin_pw:-} psql -v -t -X -w -U ${postgres_sys_usr_admin:-} --host $postgres_rdbms_host --port $postgres_rdbms_port"

./src/bash/qto/qto.sh -a provision-db-admin # change the db-admin pw
./src/bash/qto/qto.sh -a provision-app-user # change the app user pw

# how-to load xls sheets into tables , obs - do_truncate_tables=1 WILL truncate the postgres tables
export do_truncate_tables=0 ; clear ; perl src/perl/qto/script/qto.pl --do xls-to-db --tables system_guide_doc

clear ; ./src/bash/qto/qto.sh -a backup-postgres-db-inserts
clear ; ./src/bash/qto/qto.sh -a backup-postgres-table -t readme_doc

export docs_root_dir=`pwd` # or could be any qto proj dir
clear ; ./src/bash/qto/qto.sh -a generate-md-docs  # export the documentation of the desired db
clear ; ./src/bash/qto/qto.sh -a generate-pdf-docs  # export the documentation of the desired db

./src/bash/qto/qto.sh -a mojo-hypnotoad-start # start the hypnotoad web server

# how-to run sql as the postgres user
clear ; sudo su - postgres -c "psql -d postgres -c \"drop database dev_qto\""
clear ; sudo su - postgres -c "psql -d postgres -c \"create database dev_qto\""

# get the id,guid,name from the back-end api
mojo get 'http://host-name:8082/tst_qto/hiselect/requirements_doc?bid=0' |jq '.dat[]|.id,.guid,.name'
mojo get 'http://host-name:8082/tst_qto/hiselect/requirements_doc?bid=0&oa=seq' |jq '.dat[]|{id,guid,name} '

psql -t -d dev_qto -c "select array_to_json(array_agg(row_to_json(t))) from ( select * from release_issues ) t"|jq


# list all the tables in the terminal
clear ; psql -d dev_qto -t -c '\dt' | cut -c 11- | perl -ne 's/^([a-z_0-9]*)( )(.*)/$1/; print '

# how-to backup dirs from remote to local

export ssh_user=ubuntu; export ssh_server=123.123.123.123
export tgt_dir=/tmp/dir-to-be-overwritten; export src_dir=/tmp/dir-to-be-rsynced
rsync -e "ssh -l USERID -i ~/.ssh/id_rsa.tst.qto" -av -r --partial --progress --human-readable \
   --stats --delete-excluded $ssh_user@$ssh_server:$src_dir $tgt_dir

export ssh_server=qto.fi
export ssh_user=ubuntu
export src_dir=/home/ubuntu/opt/qto
export tgt_dir=/hos/opt/opt
rsync -e "ssh -l USERID -i ~/.ssh/id_rsa.aws-ec2.qto.prd" -av -r --partial --progress
   --human-readable --stats $ssh_user@$ssh_server:$src_dir $tgt_dir

# eof file: doc/cheats/qto-cheat-sheet.sh
