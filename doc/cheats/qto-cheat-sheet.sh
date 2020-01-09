# file: doc/cheats/qto-cheat-sheet.sh

# start load env vars
export PROJ_INSTANCE_DIR=`pwd`  # or could be any qto proj
export PROJ_CONF_FILE=`pwd`/cnf/env/prd.env.json  # or could be any qto proj's conf file
source lib/bash/funcs/export-json-section-vars.sh
doExportJsonSectionVars $PROJ_INSTANCE_DIR/cnf/env/prd.env.json '.env.db'
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --host $postgres_db_host --port $postgres_db_port"

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

psql -d "$postgres_db_name" -c "GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA public TO $postgres_db_user; GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_db_user"

# list all the tables in the terminal
clear ; psql -d dev_qto -t -c '\dt' | cut -c 11- | perl -ne 's/^([a-z_0-9]*)( )(.*)/$1/; print '

# eof file: doc/cheats/qto-cheat-sheet.sh
