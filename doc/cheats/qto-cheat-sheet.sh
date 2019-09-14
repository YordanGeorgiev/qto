# file: doc/cheats/qto-cheat-sheet.sh

# source the env vars loading function:
source lib/bash/funcs/export-json-section-vars.sh

# optional stop if the env vars from a different project must be loaded ..
export PROJ_INSTANCE_DIR=`pwd`

# load the env vars from a section
doExportJsonSectionVars $PROIJ_INSTANCE_DIR/cnf/env/prd.env.json '.env.db'

# how to add files to the git 
git add --all; GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
git commit -m "$git_msg" --author "Yordan Georgiev <yordan.georgiev@gmail.com" # --amend

# and push them
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git push

# set the authentication for the psql 
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --host $postgres_db_host --port $postgres_db_port"


# eof file: doc/cheats/qto-cheat-sheet.sh
