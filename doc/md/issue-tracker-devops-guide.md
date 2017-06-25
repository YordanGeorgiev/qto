#  ISSUE-TRACKER DEVOPS GUIDE


Table of Contents

  * [1. INSTALLATIONS AND CONFIGURATIONS](#1-installations-and-configurations)
    * [1.1. Configure the Ubuntu repositories](#11-configure-the-ubuntu-repositories)
    * [1.2. Add the media keys](#12-add-the-media-keys)
    * [1.3. Install the postgre package with apt](#13-install-the-postgre-package-with-apt)
    * [1.4. Change the postgre user password](#14-change-the-postgre-user-password)
      * [1.4.1. start the postgreSQL](#141-start-the-postgresql)
      * [1.4.2. Start the psql client as the postgres shell user](#142-start-the-psql-client-as-the-postgres-shell-user)
      * [1.4.3. Create the pgsql user ](#143-create-the-pgsql-user-)
    * [1.5. Install the perl modules ( optional)](#15-install-the-perl-modules-(-optional))
  * [2. MAINTENANCE AND OPERATIONS](#2-maintenance-and-operations)
    * [2.1. RDBMS Runstate management](#21-rdbms-runstate-management)
      * [2.1.1. To check the status of the postgreSql](#211-to-check-the-status-of-the-postgresql)
      * [2.1.2. To stop the postgreSql](#212-to-stop-the-postgresql)
      * [2.1.3. To start the postgreSql](#213-to-start-the-postgresql)
      * [2.1.4. to check the port on which it is listening ](#214-to-check-the-port-on-which-it-is-listening-)
      * [2.1.5. Check the postgres status](#215-check-the-postgres-status)
    * [2.2. Application Layer runstate management](#22-application-layer-runstate-management)
      * [2.2.1. start the application layer](#221-start-the-application-layer)
      * [2.2.2. stop the application layer](#222-stop-the-application-layer)
  * [3. USAGE SCENARIOS](#3-usage-scenarios)
    * [3.1. Run increase-date action](#31-run-increase-date-action)
    * [3.2. Run xls-to-db action](#32-run-xls-to-db-action)
    * [3.3. Run db-to-txt action](#33-run-db-to-txt-action)
    * [3.4. Load xls issues to db and from db to txt files](#34-load-xls-issues-to-db-and-from-db-to-txt-files)
    * [3.5. Run the issue-tracker file to db load](#35-run-the-issue-tracker-file-to-db-load)
    * [3.6. Verify the inserted data from the db](#36-verify-the-inserted-data-from-the-db)
  * [4. BUSINESS LOGIC](#4-business-logic)
    * [4.1. Projects management](#41-projects-management)
    * [4.2. Categories](#42-categories)
    * [4.3. Issues / Issue items / items](#43-issues-/-issue-items-/-items)
  * [5. NAMING CONVENTIONS](#5-naming-conventions)
    * [5.1. Dirs naming conventions](#51-dirs-naming-conventions)
      * [5.1.1. Root Dirs naming conventions](#511-root-dirs-naming-conventions)
  * [6. SOURCE CODE MANAGEMENT](#6-source-code-management)
    * [6.1. The meaning of the used brances](#61-the-meaning-of-the-used-brances)


    

## 1. INSTALLATIONS AND CONFIGURATIONS


     

### 1.1. Configure the Ubuntu repositories
Configure the Ubuntu repositories

    # creae the following repo list file
    sudo vim /etc/apt/sources.list.d/pgdg.list
    
    # add the following line in it:
    deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main

### 1.2. Add the media keys
Add the media keys as follows:

    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |   sudo apt-key add -

### 1.3. Install the postgre package with apt
Install the postgre package with apt

    # update your repos
    sudo apt-get update
    
    # install the postgresql binary
    sudo apt-get install postgresql postgresql-contrib
    
    # enable postgre
    sudo update-rc.d postgresql enable

### 1.4. Change the postgre user password
Configure the Ubuntu repositories

    sudo passwd postgres
    # Type a pw - add to your password manager !!!
    
    # and verify 
    su - postgres

#### 1.4.1. start the postgreSQL
Start the postgreSQL by issuing the following command

    sudo /etc/init.d/postgresql start

#### 1.4.2. Start the psql client as the postgres shell user
Start the psql client as the postgres shell user
source:
http://dba.stackexchange.com/a/54253/1245

    sudo su - postgres
    # start the psql client
    psql
    
    # the psql prompt should appear as
    # postgres=# 
    
    # list the databases
    \l
    #and quit
    \q

#### 1.4.3. Create the pgsql user 
Create the pgsql user and grant him the privileges to create dbs and to connect to the postgres db. 
You could alternatively configure different way of authenticatio according to the options provided in this stackoverflow answer:
http://stackoverflow.com/a/9736231/65706

    # create the pgsql user to be the same as the shell 
    # user you are going to execute the scripts with 
    sudo su - postgres  -c "psql -c 'CREATE USER '$USER' ;'"
    
    # grant him the priviledges
    sudo su - postgres  -c "psql -c 'grant all privileges on database postgres to '$USER' ;'"
    
    # grant him the privilege to create db's 
    sudo su - postgres  -c "psql -c 'ALTER USER '$USER' CREATEDB;'"
    
    sudo su - postgres  -c 'psql -c "select * from information_schema.role_table_grants where grantee='"'"$USER"'"';"'
    
    # and exit
    \q

### 1.5. Install the perl modules ( optional)
Install the perl module by first installing the server development package

    
    # check which server development packages are available
    sudo apt-cache search postgres | grep -i server-dev | sort
    
    # install it
    sudo apt-get install -y postgresql-server-dev-9.6
    
    # install the DBD::Pg module
    sudo perl -MCPAN -e 'install DBD::Pg'
    
    sudo perl -MCPAN -e 'Tie::Hash::DBD'

## 2. MAINTENANCE AND OPERATIONS


     

### 2.1. RDBMS Runstate management
 

     

#### 2.1.1. To check the status of the postgreSql
To check the status of the postgreSql issue:

    sudo /etc/init.d/postgresql status

#### 2.1.2. To stop the postgreSql
To stop the postgreSql issues:

    sudo /etc/init.d/postgresql stop

#### 2.1.3. To start the postgreSql
To start the postgreSql issues:

    sudo /etc/init.d/postgresql start

#### 2.1.4. to check the port on which it is listening 
To check the port on which it is listening issue:

    sudo netstat -tulntp | grep -i postgres
    # tcp        0      0 127.0.0.1:5432          0.0.0.0:*               LISTEN      8095/postgres

#### 2.1.5. Check the postgres status
Check the postgres status.
Check the port to which the postres is running with this command:

    sudo /etc/init.d/postgresql status
    
    # restart if needed
    sudo /etc/init.d/postgresql restart
    
    # check on which ports it is runnning
    sudo netstat -plunt |grep postgres

### 2.2. Application Layer runstate management
 

     

#### 2.2.1. start the application layer
To start the application layer in development mode use the morbo command ( debug output will be shown ) , to start it in production mode use the hypnotoad pattern 

    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-start
    
    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start

#### 2.2.2. stop the application layer
To stop the application layer in development mode use the morbo command ( debug output will be shown ) , to start it in production mode use the hypnotoad pattern 

    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-stop
    
    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop

## 3. USAGE SCENARIOS


    

### 3.1. Run increase-date action
You track the issues of your projects by storing them into xls files in "daily" proj_txt dirs. 
Each time the day changes by running the increase-date action you will be able to clone the data of the previous date and start working on the currnent date. 

    bash src/bash/issue-tracker/issue-tracker.sh -a increase-date

### 3.2. Run xls-to-db action
You insert the date of the daily , weekly , monthly or yearly issues from the daily input excel file(s) by running the xls-to-db action. 

    bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db

### 3.3. Run db-to-txt action
 

     

### 3.4. Load xls issues to db and from db to txt files
to load xls issues to db and from db to txt files

    bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db -a db-to-txt 
    
    # or run for all the periods
    for period in `echo daily weekly monthly yearly`; do export period=$period ; bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db -a db-to-txt ; done ;

### 3.5. Run the issue-tracker file to db load
Run the issue-tracker file to db load 

    # ensure the following actions will be tested
    cat src/bash/issue-tracker/tests/run-issue-tracker-tests.lst | grep -v '#'
    # output should be if not correct
    check-perl-syntax
    run-issue-tracker
    
    # test those uncommented actions
    bash src/bash/issue-tracker/test-issue-tracker.sh

### 3.6. Verify the inserted data from the db
Verify the inserted data from the db as follows:

    # check that the rows where inserted
    echo 'SELECT * FROM issue ; ' | psql -d dev_issue_tracker

## 4. BUSINESS LOGIC


    

### 4.1. Projects management
You can manage multiple projects with the issue-tracker tool. Each project has its own data directories, database storage and configurations. You could also have different envornments named dev,tst,prd for each project separately. 
As the tool is backwards compatible you could have differrrent instances of the issue-tracker projects with different versions ( and set of features ) operatiing against differrent project ( each one in its own version).
You must pre-set the configuration variables of an issue-tracker project each time you start working on a project from the shell

    doParseIniEnvVars /vagrant/csitea/cnf/projects/isg-pub/isg-pub.issue-tracker.doc-pub-host.conf

### 4.2. Categories
Each issue item could be categorized under one and only one category. One category might have 1 or more issues. 
The categories could contain letters ,numbers, dashes

    Examples:
    organisation-it
    organisation-it-operations

### 4.3. Issues / Issue items / items
Issue item is the shortest possible description of task , activity , note or anything requiring distinguishable and prerferable measurable action or producing verfifiable outcome.
Issues could be of different types - tasks, activities, notes etc. 

    Examples:
    go get the milk
    do the homework
    procurement e-mail discussion follow-up

## 5. NAMING CONVENTIONS


     

### 5.1. Dirs naming conventions
The dir structure should be logical and a person navigating to a dir should almost understand what is to be find in thre by its name .. 

    

#### 5.1.1. Root Dirs naming conventions
The root dirs and named as follows:
bin - contains the produced binaries for th project
cnf - for the configuration
dat - for the data of the app
lib - for any external libraries used
src - for the source code of the actual projects and subprojects

    

## 6. SOURCE CODE MANAGEMENT
The issue-tracker is a derivative of the wrapp tool - this means that development and deployment process must be integrated into a single pipeline. 

    

### 6.1. The meaning of the used brances
In almost all development projects there are slightly or even quite big differences between what type of code in which branch is situated. 
The ideology of issue tracker is that the code which is under active development is in the dev branch , the code which is under testing in the tst branch , the code which is in production in the prd branch. 
Only after the code in production has been successfully operated and prooved working it could be moved to the master branch and the version increased. 
Once you wanto to start adding new feature branch from the master branch. 

    

