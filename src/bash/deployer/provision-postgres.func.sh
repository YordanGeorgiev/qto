do_provision_postgres(){

   do_export_json_section_vars $PRODUCT_DIR/cnf/env/$ENV_TYPE.env.json '.env.db'
   doScrambleConfs   # because well they were taken from public git repo

   psql_cnf_dir='/etc/postgresql/12/main'
   sudo mkdir -p "$psql_cnf_dir"

   echo "postgres:$postgres_os_usr_pw" | chpasswd   # probably obsolete
   echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' | sudo tee -a /var/lib/postgresql/.bashrc
   
   sudo /etc/init.d/postgresql restart
   
   sudo -u postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
   sudo -u postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "pgcrypto";'
   sudo -u postgres psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "dblink";' 

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
}
