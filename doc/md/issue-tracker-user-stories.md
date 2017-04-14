#  ISSUE-TRACKER DEVOPS GUIDE


Table of Contents

  * [1. DYNAMIC SCENARIOS](#1-dynamic-scenarios)
    * [1.1. Load issue txt files to db](#11-load-issue-txt-files-to-db)
      * [1.1.1. Check the postgres status](#111-check-the-postgres-status)
      * [1.1.2. Run the create db and create issue table scripts](#112-run-the-create-db-and-create-issue-table-scripts)
      * [1.1.3. Run the issue-tracker file to db load](#113-run-the-issue-tracker-file-to-db-load)
      * [1.1.4. Verify the inserted data from the db](#114-verify-the-inserted-data-from-the-db)
  * [2. BUSINESS LOGIC](#2-business-logic)
    * [2.1. Business entities](#21-business-entities)
    * [2.2. Categories](#22-categories)
    * [2.3. HashTags](#23-hashtags)
    * [2.4. Issues / Issue items / items](#24-issues-/-issue-items-/-items)
  * [3. SOURCE CODE MANAGEMENT](#3-source-code-management)
    * [3.1. The meaning of the used brances](#31-the-meaning-of-the-used-brances)


    

## 1. DYNAMIC SCENARIOS


    

### 1.1. Load issue txt files to db
This scenario implements the "Load issues file from file system to db" user story. 

    

#### 1.1.1. Check the postgres status
Check the postgres status.
Check the port to which the postres is running with this command:

    sudo /etc/init.d/postgresql status
    
    # restart if needed
    sudo /etc/init.d/postgresql restart
    
    # check on which ports it is runnning
    sudo netstat -plunt |grep postgres

#### 1.1.2. Run the create db and create issue table scripts
Run the create db and create issue table scripts with the following call

    # run the create db and create table scrpt
    # define the sql_dir where the issue tracker sql scripts are stored 
    export sql_dir=/opt/csitea/issue-tracker/issue-tracker.0.0.5.dev.ysg/src/sql/pgsql/dev_issue_tracker
    
    # run the scripts
    bash /opt/csitea/pgsql-runner/src/bash/pgsql-runner.sh  -a run-pgsql-scripts
    
    # ensure from the STDOUT msgs that both the db and the table were created

#### 1.1.3. Run the issue-tracker file to db load
Run the issue-tracker file to db load 

    # ensure the following actions will be tested
    cat src/bash/issue-tracker/tests/run-issue-tracker-tests.lst | grep -v '#'
    # output should be if not correct
    check-perl-syntax
    run-issue-tracker
    
    # test those uncommented actions
    bash src/bash/issue-tracker/test-issue-tracker.sh

#### 1.1.4. Verify the inserted data from the db
Verify the inserted data from the db as follows:

    # check that the rows where inserted
    echo 'SELECT * FROM issue ; ' | psql -d dev_issue_tracker

## 2. BUSINESS LOGIC


    

### 2.1. Business entities


    

### 2.2. Categories
Each issue item could be categorized under one and only one category. One category might have 1 or more issues. 
The categories could contain letters ,numbers, dashes

    Examples:
    organisation-it
    organisation-it-operations

### 2.3. HashTags
HashTags are presented 

     

### 2.4. Issues / Issue items / items
Issue item is the shortest possible description of task , activity , note or anything requiring distinguishable and prerferable measurable action or producing verfifiable outcome.
Issues could be of different types - tasks, activities, notes etc. 

    Examples:
    go get the milk
    do the homework
    procurement e-mail discussion follow-up

## 3. SOURCE CODE MANAGEMENT
The issue-tracker is a derivative of the wrapp tool - this means that development and deployment process must be integrated into a single pipeline. 

    

### 3.1. The meaning of the used brances
In almost all development projects there are slightly or even quite big differences between what type of code in which branch is situated. 
The ideology of issue tracker is that the code which is under active development is in the dev branch , the code which is under testing in the tst branch , the code which is in production in the prd branch. 
Only after the code in production has been successfully operated and prooved working it could be moved to the master branch and the version increased. 
Once you wanto to start adding new feature branch from the master branch. 

    

