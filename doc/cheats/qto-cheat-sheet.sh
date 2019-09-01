# file: doc/cheats/qto-cheat-sheet.sh

# how to add files to the git 
git add --all; GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
git commit -m "$git_msg" --author "Yordan Georgiev

<yordan.georgiev@gmail.com>"
# set the authentication for the psql 
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port"
# set the authentication for the psql 
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host"



# eof file: doc/cheats/qto-cheat-sheet.sh
