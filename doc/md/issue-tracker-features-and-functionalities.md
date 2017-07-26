#  ISSUE TRACKER FEATURES AND FUNCTIONALITIES


Table of Contents

  * [1. ISSUES DATA TRANSFORMATION ACTIONS](#1-issues-data-transformation-actions)
    * [1.1. txt-to-db action](#11-txt-to-db-action)
    * [1.2. db-to-xls action](#12-db-to-xls-action)
    * [1.3. xls-to-db action](#13-xls-to-db-action)
    * [1.4. db-to-txt action](#14-db-to-txt-action)
      * [1.4.1. db-to-txt action with pre-defined sorting attribute](#141-db-to-txt-action-with-pre-defined-sorting-attribute)
  * [2. DEVOPS FEATURES AND FUNCTIONALITIES](#2-devops-features-and-functionalities)
    * [2.1. Shell based actions](#21-shell-based-actions)
      * [2.1.1. morph-dir action](#211-morph-dir-action)
      * [2.1.2. work against different projects](#212-work-against-different-projects)
      * [2.1.3. issue-tracker tool perl code syntax check](#213-issue-tracker-tool-perl-code-syntax-check)
    * [2.2. Web based routes](#22-web-based-routes)
      * [2.2.1. single item data fetch in json via web](#221-single-item-data-fetch-in-json-via-web)


    

## 1. ISSUES DATA TRANSFORMATION ACTIONS
You can load your issues data from different sources into different targets, whenever those sources and targets comply with the syntax and format of the issue tracker. 
A single call performing the transformation of one issues source data into another taget data instance artifact are called actions. 
This section contains the description of this feature-set per action.  

     

### 1.1. txt-to-db action
You can load you issues from an "issues txt file" , having a specic syntax into a PosgtreSQL issue table, by issueing the shell.
This call with truncate the issue table from the db and convert all the issues data from the issues txt file into the issue table. 

    # pre-load the vars of an issue-tracker project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf
    
    # ensure there is no data in the issue table
    psql -d "$db_name" -c 'TRUNCATE TABLE issue ;'
    
    # run the txt-to-db action
    bash src/bash/issue-tracker/issue-tracker.sh -a txt-to-db
    
    # check the data by :
    psql -d "$db_name" -c 'SELECT issue_id , category , name FROM issue order by name'

### 1.2. db-to-xls action
You can unload your already stored ANY xls table with unique id's and load them into a xls file. 

    # pre-load the vars of an issue-tracker project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf
    
    
    # check the data by :
    psql -d "$db_name" -c 'SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio'
    
    # run the db-to-xls action
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-xls
    

### 1.3. xls-to-db action
You can load the latest produced xls file ( note as long as your xls sheet headers match the columns in your db table ANY xls is compatible )

    # check the data by :
    psql -d "$db_name" -c 'SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio'
    
    # run the db-to-xls action
    bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db
    
    # check the updated data
    psql -d "$db_name" -c 'SELECT issue_id , start_time , stop_time , category , name FROM issue order by start_time'
    

### 1.4. db-to-txt action
You can load your already stored in the issue table issues and load them into the same issues txt file

    # check the data by :
    psql -d "$db_name" -c 'SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio'
    
    # run the db-to-xls action
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt
    
    # check the updated data
    psql -d "$db_name" -c 'SELECT issue_id , start_time , stop_time , category , name FROM issue order by start_time'

#### 1.4.1. db-to-txt action with pre-defined sorting attribute
You can load your already stored in the issue table issues and load them into the same issues txt file by using a pre-defined sorting attribute. 

    export issues_order_by_attribute=start_time
    
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt

## 2. DEVOPS FEATURES AND FUNCTIONALITIES


     

### 2.1. Shell based actions


    

#### 2.1.1. morph-dir action
You can recursively search and replace strings in both file and dir paths and their contents ( as soon as they non-binary , txt files ) by issuing the following commands:

    export to_srch=WriterTxtDaily
    export to_repl=WriterTxtTerm
    export dir_to_morph=`pwd`
    bash src/bash/issue-tracker/issue-tracker.sh -a morph-dir
    fg
    history | cut -c 8-
    

#### 2.1.2. work against different projects
The issue-tracker could be used against many different projects as soon as they have the needed file and dir structure , configuration file and dedicated db in the PostgreSQL. 

    # pre-load the vars of an issue-tracker project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf

#### 2.1.3. issue-tracker tool perl code syntax check
You can check the perl code syntax with the following command:

    bash src/bash/issue-tracker/issue-tracker.sh -a check-perl-syntax

### 2.2. Web based routes


    

#### 2.2.1. single item data fetch in json via web
You can get the data of a single item in db by guid in json format via the web interface , for example:
http://doc-pub-host:3000/dev_stockit_issues/get/company_eps/727cf807-c9f1-446b-a7fc-65f9dc53ed2d

    # run for the loaded items
    while read -r guid ; do curl "http://doc-pub-host:3000/dev_stockit_issues/get/company_eps/$guid" ; done < <(psql -d dev_stockit_issues -t -c "SELECT guid FROM company_eps")

