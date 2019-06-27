cd /opt/csitea/qto/qto.0.6.5.dev.ysg/
doParseCnfEnvVars cnf/qto.dev.host-name.cnf 
bash src/bash/qto/qto.sh -a restart-postgres
bash src/bash/qto/qto.sh -a run-pgsql-scripts
wget 'https://s3-eu-west-1.amazonaws.com/qto.fi/prd_qto.latest.insrt.dmp.sql' -O dat/prd_qto.latest.insrt.dmp.sql
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -q -t -X -w -U ${postgres_db_useradmin:-}"
psql -d dev_qto < dat/prd_qto.latest.insrt.dmp.sql
bash src/bash/qto/qto.sh -a mojo-morbo-start
