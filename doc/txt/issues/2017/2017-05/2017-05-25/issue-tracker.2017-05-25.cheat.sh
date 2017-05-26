# file: issue-tracker.cheat.2017-05-18.cheat.sh

# how-to go to the run host
ssh ysg@doc-pub-host


export issues_order_by_attribute=start_time
export issues_order_by_attribute=prio
bash src/bash/issue-tracker/issue-tracker.sh -a txt-to-db
bash src/bash/issue-tracker/issue-tracker.sh -a db-to-xls
# now edit the files in the xls 
bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db
bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt


# go to the product instance dir
cd /opt/csitea/issue-tracker/issue-tracker.0.1.5.dev.ysg

# how-to load the env vars for a different project
doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/slk.prd.doc-pub-host.cnf

# test all the actions 
bash src/bash/issue-tracker/test-issue-tracker.sh

# how-to check for duplicates
psql -d "$db_name" -c 'SELECT issue_id , category , name FROM issue order by name'

# how-to truncate the issue table
psql -d "$db_name" -c 'TRUNCATE TABLE isssue ;'

# how-to create a new db instance for specific project and environment
doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/slk.prd.doc-pub-host.cnf

# run the sql scripts for this project instance 
bash /opt/csitea/pgsql-runner/src/bash/pgsql-runner.sh -a run-pgsql-scripts

# how-to check project's todays files
find $proj_txt_dir | grep $(date "+%Y-%m-%d")


# eof file: issue-tracker.cheat.2017-05-18.cheat.sh