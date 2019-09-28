# file: doc/cheats/qto-cheat-sheet.sh


sudo -u postgres psql -c "ALTER USER "$postgres_db_useradmin" WITH SUPERUSER CREATEROLE 
      CREATEDB REPLICATION BYPASSRLS PASSWORD '"$postgres_db_useradmin_pw"';"
# caveat-01: do not use ? char in passwords - it breaks the ui of the doc pages
# caveat-02: escape the ! char in passwords - does not work in the shell
# caveats: do not use ? char in passwords ( breaks the ui ), escape the ! char 
sudo su - postgres -c \
   "psql --port 15432 -d tst_qto -c \"ALTER ROLE usrqtoapp WITH PASSWORD 'foo-bar\!' LOGIN \""
sudo -u postgres psql -x -c "select * from pg_user where usename='usrqtoadmin'"

# how-to export the documentation of the desired db. 
clear ; bash src/bash/qto/qto.sh -a generate-md-docs

# how-to run sql as the postgres user
clear ; sudo su - postgres -c "psql -d postgres -c \"drop database dev_qto\""
clear ; sudo su - postgres -c "psql -d postgres -c \"create database dev_qto\""

# how-to load xls sheets into tables , obs - do_truncate_tables=1 WILL truncate the postgres tables
export do_truncate_tables=0 ; clear ; perl src/perl/qto/script/qto.pl --do xls-to-db --tables system_guide_doc

# source the env vars loading function:
source lib/bash/funcs/export-json-section-vars.sh

# optional stop if the env vars from a different project must be loaded ..
export PROJ_INSTANCE_DIR=`pwd`
export PROJ_CONF_FILE=`pwd`/cnf/env/dev.env.json

# load the env vars from a section
doExportJsonSectionVars $PROIJ_INSTANCE_DIR/cnf/env/prd.env.json '.env.db'

# set the authentication for the psql 
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --host $postgres_db_host --port $postgres_db_port"

# how to add files to the git 
git add --all; GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" \
git commit -m "$git_msg" --author "Yordan Georgiev <yordan.georgiev@gmail.com" # --amend
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" git push
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg" git pull

# OBS AMMEND AND git push FORCE !!
git add --all ; GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg " git commit -am "$git_msg" \
   --author "Yordan Georgiev <yordan.georgiev@gmail.com>" --amend && \
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg " git push --force

# eof file: doc/cheats/qto-cheat-sheet.sh
