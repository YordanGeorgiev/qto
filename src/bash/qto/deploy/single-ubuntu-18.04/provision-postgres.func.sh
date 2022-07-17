#!/bin/bash
do_chk_provision_postgres(){

   do_export_json_section_vars $PRODUCT_DIR/cnf/env/$ENV.env.json '.env.db'
   # doScrambleConfs   # because well they were taken from public git repo

   psql_cnf_dir='/etc/postgresql/12/main' ; sudo mkdir -p "$psql_cnf_dir"

   set +e
   echo "$postgres_rdbms_usr:$postgres_rdbms_usr_pw" | chpasswd
   echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' | sudo tee -a /var/lib/postgresql/.bashrc

   sudo /etc/init.d/postgresql restart

   sudo -Hiu postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
   sudo -Hiu postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "pgcrypto";'
   sudo -Hiu postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "dblink";'

   test -f $psql_cnf_dir/pg_hba.conf && \
      sudo cp -v $psql_cnf_dir/pg_hba.conf $psql_cnf_dir/pg_hba.conf.orig.bak && \
      sudo cp -v $PRODUCT_DIR/cnf/postgres/$psql_cnf_dir/pg_hba.conf $psql_cnf_dir/pg_hba.conf && \
      sudo chown postgres:postgres $psql_cnf_dir

   test -f $psql_cnf_dir/postgresql.conf && \
      sudo cp -v $psql_cnf_dir/postgresql.conf $psql_cnf_dir/postgresql.conf.orig && \
      sudo cp -v $PRODUCT_DIR/cnf/postgres/$psql_cnf_dir/postgresql.conf $psql_cnf_dir/postgresql.conf

   sudo chown -R postgres:postgres "/etc/postgresql" && \
      sudo chown -R postgres:postgres "/var/lib/postgresql" && \
      sudo chown -R postgres:postgres "$psql_cnf_dir/pg_hba.conf" && \
      sudo chown -R postgres:postgres "$psql_cnf_dir/postgresql.conf"

   sudo /etc/init.d/postgresql restart

   expect <<- EOF_EXPECT
      set timeout -1
      spawn sudo -u $postgres_rdbms_usr psql --port $postgres_rdbms_port -c "\\\password"
      expect "Enter new password: "
      send -- "$postgres_rdbms_usr_pw\r"
      expect "Enter it again: "
      send -- "$postgres_rdbms_usr_pw\r"
      expect eof
EOF_EXPECT
}
