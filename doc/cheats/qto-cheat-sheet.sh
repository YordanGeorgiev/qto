# file: doc/cheats/qto-cheat-sheet.sh

# set the authentication for the psql 
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port"
# set the authentication for the psql 
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host"



# eof file: doc/cheats/qto-cheat-sheet.sh
