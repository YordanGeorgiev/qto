# file: doc/cheats/qto-cheat-sheet.sh

# how-to export the documentation of the desired db. 
clear ; bash src/bash/qto/qto.sh -a generate-md-docs

# how-to run sql as the postgres user
clear ; sudo su - postgres -c "psql -d postgres -c \"drop database dev_qto\""

# how-to load xls sheets into tables , obs - do_truncate_tables=1 WILL truncate the postgres tables
export do_truncate_tables=0 ; clear ; perl src/perl/qto/script/qto.pl --do xls-to-db --tables system_guide_doc

# source the env vars loading function:
source lib/bash/funcs/export-json-section-vars.sh

# optional stop if the env vars from a different project must be loaded ..
export PROJ_INSTANCE_DIR=`pwd`

# load the env vars from a section
doExportJsonSectionVars $PROIJ_INSTANCE_DIR/cnf/env/prd.env.json '.env.db'

# how to add files to the git 
git add --all; GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" \
git commit -m "$git_msg" --author "Yordan Georgiev <yordan.georgiev@gmail.com" # --amend
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" git push
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" git pull

# set the authentication for the psql 
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --host $postgres_db_host --port $postgres_db_port"


# eof file: doc/cheats/qto-cheat-sheet.sh
