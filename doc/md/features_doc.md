#  FEATURES, FUNCTIONALITIES AND CAPABILITIES
* [1. INTRODUCTION](#1-introduction)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. DOCUMENT STATUS](#12-document-status)
  * [1.3. AUDIENCE](#13-audience)
  * [1.4. MASTER STORAGE AND STORAGE FORMAT](#14-master-storage-and-storage-format)
  * [1.5. VERSION CONTROL](#15-version-control)
  * [1.6. PROCESS](#16-process)
* [2. DEVOPS FEATURES AND FUNCTIONALITIES](#2-devops-features-and-functionalities)
  * [2.1. TESTABILITY](#21-testability)
    * [2.1.1. Perl syntax check call](#211-perl-syntax-check-call)
    * [2.1.2. Unit tests call](#212-unit-tests-call)
    * [2.1.3. Integration tests call](#213-integration-tests-call)
    * [2.1.4. Bash tests call](#214-bash-tests-call)
  * [2.2. DOCUMENTATION](#22-documentation)
    * [2.2.1. Single shell call documentation generation - the generate-docs shell action](#221-single-shell-call-documentation-generation--the-generate-docs-shell-action)
    * [2.2.2. Full documentation set](#222-full-documentation-set)
    * [2.2.3. Documentation's file formats](#223-documentation's-file-formats)
  * [2.3. LOGGING](#23-logging)
    * [2.3.1. Bash logging](#231-bash-logging)
    * [2.3.2. Perl logging](#232-perl-logging)
  * [2.4. DEVELOPMENT EFFICIENCY INCREASING ACTIONS](#24-development-efficiency-increasing-actions)
    * [2.4.1. Support for different projects](#241-support-for-different-projects)
    * [2.4.2. The "morph-dir" action](#242-the-"morph-dir"-action)
    * [2.4.3. Perl code syntax check](#243-perl-code-syntax-check)
    * [2.4.4. Single call export of the md and pdf documentation files](#244-single-call-export-of-the-md-and-pdf-documentation-files)
* [3. SYSADMIN FEATURES AND FUNCTIONALITIES](#3-sysadmin-features-and-functionalities)
  * [3.1. ENFORCED DAILY BACKUPS BY "INCREASE-DATE" ACTION](#31-enforced-daily-backups-by-"increase-date"-action)
  * [3.2. POSTGRES DB BACKUP](#32-postgres-db-backup)
  * [3.3. THE "RUN-PGSQL-SCRIPTS" ACTION](#33-the-"run-pgsql-scripts"-action)
  * [3.4. THE "RUN-MYSQL-SCRIPTS" ACTION](#34-the-"run-mysql-scripts"-action)
    * [3.4.1. The "txt-to-db" action period handling ( deprecated)](#341-the-"txt-to-db"-action-period-handling-(-deprecated))
    * [3.4.2. The "txt-to-db" action ( deprecated)](#342-the-"txt-to-db"-action-(-deprecated))
    * [3.4.3. The "db-to-txt" action ( deprecated ) ](#343-the-"db-to-txt"-action-(-deprecated-)-)
    * [3.4.4. The "db-to-txt" action with pre-defined sorting attribute ( deprecated )](#344-the-"db-to-txt"-action-with-pre-defined-sorting-attribute-(-deprecated-))
    * [3.4.5. restart the morbo development server](#345-restart-the-morbo-development-server)
    * [3.4.6. restart the hypnotoad production server](#346-restart-the-hypnotoad-production-server)
* [4. ETL / DATA INTEGRATION FEATURES AND FUNCTIONALITIES](#4-etl-/-data-integration-features-and-functionalities)
  * [4.1. THE "DB-TO-XLS" ACTION AGAINST POSTGRES](#41-the-"db-to-xls"-action-against-postgres)
  * [4.2. THE "XLS-TO-DB" ACTION](#42-the-"xls-to-db"-action)
    * [4.2.1. The "xls-to-db" action without passing xls file](#421-the-"xls-to-db"-action-without-passing-xls-file)
    * [4.2.2. The "xls-to-db" action with nested-set mode against mysql](#422-the-"xls-to-db"-action-with-nested-set-mode-against-mysql)
  * [4.3. THE DB-TO-JSON SHELL ACTION](#43-the-db-to-json-shell-action)
  * [4.4. THE JSON-TO-DB SHELL ACTION](#44-the-json-to-db-shell-action)
* [5. BACK-END API FUNCTIONALITIES](#5-back-end-api-functionalities)
  * [5.1. CREATE WEB-ACTION](#51-create-web-action)
    * [5.1.1. Successful execution](#511-successful-execution)
    * [5.1.2. Error handling on non-existing db](#512-error-handling-on-non-existing-db)
    * [5.1.3. Error handling on non-existing table](#513-error-handling-on-non-existing-table)
    * [5.1.4. Error handling on non-existing attribute ](#514-error-handling-on-non-existing-attribute-)
    * [5.1.5. Error handling on wrong data-type](#515-error-handling-on-wrong-data-type)
  * [5.2. UPDATE WEB-ACTION](#52-update-web-action)
    * [5.2.1. Successful execution](#521-successful-execution)
    * [5.2.2. Error handling on non-existing db](#522-error-handling-on-non-existing-db)
    * [5.2.3. Error handling on non-existing table](#523-error-handling-on-non-existing-table)
    * [5.2.4. Error handling on non-existing attribute ](#524-error-handling-on-non-existing-attribute-)
    * [5.2.5. Error handling on wrong data-type](#525-error-handling-on-wrong-data-type)
    * [5.2.6. Automatic upate_time attribute update](#526-automatic-upate_time-attribute-update)
  * [5.3. DELETE WEB ACTION](#53-delete-web-action)
    * [5.3.1. Successful execution](#531-successful-execution)
    * [5.3.2. Error handling on non-existing db](#532-error-handling-on-non-existing-db)
    * [5.3.3. Error handling on non-existing table](#533-error-handling-on-non-existing-table)
  * [5.4. SELECT WEB ACTION](#54-select-web-action)
    * [5.4.1. successful execution](#541-successful-execution)
    * [5.4.2. apply multiple operators on the select properly](#542-apply-multiple-operators-on-the-select-properly)
    * [5.4.3. error handling for failed connect to db in the select web action](#543-error-handling-for-failed-connect-to-db-in-the-select-web-action)
    * [5.4.4. error handling for non-existent table in the select-tables web action](#544-error-handling-for-non-existent-table-in-the-select-tables-web-action)
    * [5.4.5. filter functionality in select table web action](#545-filter-functionality-in-select-table-web-action)
      * [5.4.5.1. successful execution](#5451-successful-execution)
      * [5.4.5.2. error handling for wrong filtering syntax by missed fltr-by or fltr-va url params](#5452-error-handling-for-wrong-filtering-syntax-by-missed-fltr-by-or-fltr-va-url-params)
      * [5.4.5.3. error handling for non-existent filter name](#5453-error-handling-for-non-existent-filter-name)
    * [5.4.6. Use pick url param functionality in select table web action](#546-use-pick-url-param-functionality-in-select-table-web-action)
      * [5.4.6.1. successful execution](#5461-successful-execution)
      * [5.4.6.2. error handling if a picked column does not exist](#5462-error-handling-if-a-picked-column-does-not-exist)
    * [5.4.7. Use filtering with the like operator in select table web action](#547-use-filtering-with-the-like-operator-in-select-table-web-action)
      * [5.4.7.1. successful execution for number types](#5471-successful-execution-for-number-types)
      * [5.4.7.2. successful execution for text types](#5472-successful-execution-for-text-types)
      * [5.4.7.3. error handling for wrong  syntax in the filtering by the like operator by missed like-by or like-val url params](#5473-error-handling-for-wrong-syntax-in-the-filtering-by-the-like-operator-by-missed-like-by-or-like-val-url-params)
      * [5.4.7.4. error handling for non-existent like table's attribute](#5474-error-handling-for-non-existent-like-table's-attribute)
    * [5.4.8. Filtering by using the "with" url param](#548-filtering-by-using-the-"with"-url-param)
      * [5.4.8.1. Successful execution](#5481-successful-execution)
      * [5.4.8.2. Error handling for non-existent column](#5482-error-handling-for-non-existent-column)
    * [5.4.9. the hide operator in the select web action](#549-the-hide-operator-in-the-select-web-action)
      * [5.4.9.1. successful execution for text types](#5491-successful-execution-for-text-types)
      * [5.4.9.2. error handling for inexistent column to hide](#5492-error-handling-for-inexistent-column-to-hide)
  * [5.5. SELECT-TABLES WEB ACTION](#55-select-tables-web-action)
    * [5.5.1. successful execution](#551-successful-execution)
    * [5.5.2. error handling for failed connect to db in the select-tables web action](#552-error-handling-for-failed-connect-to-db-in-the-select-tables-web-action)
  * [5.6. QUERY WEB ACTION](#56-query-web-action)
    * [5.6.1. successful execution](#561-successful-execution)
    * [5.6.2. error handling on non-provided for operator](#562-error-handling-on-non-provided-for-operator)
    * [5.6.3. error handling for empty for url parameter](#563-error-handling-for-empty-for-url-parameter)
* [6. SECURITY FEATURES AND FUNCTIONALITIES](#6-security-features-and-functionalities)
  * [6.1. FULLY OPEN MODE](#61-fully-open-mode)
  * [6.2. BASIC AUTHENTICATION MODE](#62-basic-authentication-mode)




    

## 1. INTRODUCTION


    

### 1.1. Purpose
The purpose of this document is to describe all the features, functionalities and capabilities provided by a properly installed, configured and operated instance of the qto application. 
This document is the CONTRACT between you as the potential, former or active user of an qto instance and the product owner of that instance. 

    

### 1.2. Document status
This document is updated constantly in every release of the application. Each version however is considered to be a complete version regarding the qto version it situated in.

    

### 1.3. Audience
This document is aimed for everyone, who shall, will or even would like to interact with an qto application instance. 

    

### 1.4. Master storage and storage format
The master storage of this document is the master branch of the qto release you are interested in. The main storage format is Markdown. 

    

### 1.5. Version control
The contents of this document MUST be updated according to the EXISTING features, functionalities and capabilities of the qto version, in which this document residues.

    

### 1.6. Process
The qto provides a mean for tracking of this documentation contents to the source code per feature/functionality, thus should you find inconsistencies in the behavior of the application and the content of this document you should create a bug issue and assign it to the owner of your product instance.

    

## 2. DEVOPS FEATURES AND FUNCTIONALITIES


    

### 2.1. Testability
The qto app has a good and improving all the time test coverage. You can all the tests in the application as follows:

    

#### 2.1.1. Perl syntax check call
You can check the perl syntax for each perl code file in the whole project by issuing the following shell call:

    bash src/bash/qto/qto.sh -a check-perl-syntax

#### 2.1.2. Unit tests call
You can run the unit tests of the application by issuing the following single shell call:

    bash src/bash/qto/qto.sh -a run-perl-unit-tests

#### 2.1.3. Integration tests call
You can run the integration tests of the application by issuing the following single shell call ( note that the integration tests will not start if you do not have pre-loaded the needed shell env vars for your project you want to operate on ). 

    bash src/bash/qto/qto.sh -a run-integration-tests

#### 2.1.4. Bash tests call
You can run all the bash functions in the tool by issuing the following command in the shell. 

    # if you set the previous 2 actions as those to be tested
    bash src/bash/qto/test-qto.sh
    
    2018-05-12 18:01:08      START test-qto test run report
    
    result  start-time  stop-time   action-name
       ok    18:01:09 18:01:19 run-perl-unit-tests
       ok    18:01:20 18:01:30 run-perl-integration-tests
    
    
    
    2018-05-12 18:01:30      STOP  test-qto test run report

### 2.2. Documentation
We consider up-to-date and complete documentation as being integral part of the application, thus each release must have the documentation updated to it's current set of features, functionalities and capabilities. 
You might argue that the amount of documentation is too big, yet the more you dive into the application the more you will justify it's existence by yourself. 

    

#### 2.2.1. Single shell call documentation generation - the generate-docs shell action
You can generate all the md and pdf docs by if you have a running instance of the isg-pub application accessible via single shell call by issuing the following command: 
The command will fail if there is a doc configured in the isg-pub database which has less than 100 lines. 

    bash src/bash/qto/qto.sh -a generate-docs

#### 2.2.2. Full documentation set
Every instance of the isssue-tracker application comes with up-to-date documentation set addressing the latest commit of the released version, namely the following documents:
 - Requirements
 - UserStories
 - Features and Functionalities
 - DevOps Guide
 - Installation and Configuration Guide

    find doc/md

#### 2.2.3. Documentation's file formats
The documentation set of the application is available at least in the following file formats:
 - md - ( the master documentation format )
 - pdf - for distribution

The following formats MIGHT be also optionally available :
 - xls ( extracts from the isg-pub database ) 
 - sql ( dumps from the isg-pub database ) 
 - json ( extracts from the isg-pub database )  

    find doc -type f | sort

### 2.3. Logging
Logging is implemented as follows:

    

#### 2.3.1. Bash logging
The qto.sh bash entry point loggs both to STDOUT and file. You cold easily defined your own log levels. 

    doLog "INFO an info msg"
    [INFO ] 2018.05.08-21:05:25 EEST [qto][@host-name] [29667] an info msg:

#### 2.3.2. Perl logging
The perl logger could be configured to log to file and std outputs. 

    doLog "INFO an info msg"
    [INFO ] 2018.05.08-21:05:25 EEST [qto][@host-name] [29667] an info msg:

### 2.4. Development efficiency increasing actions


    

#### 2.4.1. Support for different projects
The qto could be used against many different projects as soon as they have the needed file and dir structure , configuration file and dedicated db in the PostgreSQL. 
You could quickly fork a new project out of the qto instance by copying the 

    # pre-load the vars of an qto project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/qto/qto-issues.dev.doc-pub-host.cnf

#### 2.4.2. The "morph-dir" action
You can recursively search and replace strings in both file and dir paths and their contents ( as soon as they non-binary , txt files ) by issuing the following commands:

    export to_srch=WriterTxtDaily
    export to_repl=WriterTxtTerm
    export dir_to_morph=`pwd`
    bash src/bash/qto/qto.sh -a morph-dir
    fg
    history | cut -c 8-
    

#### 2.4.3. Perl code syntax check
You can check the perl code syntax with the following command:

    bash src/bash/qto/qto.sh -a check-perl-syntax

#### 2.4.4. Single call export of the md and pdf documentation files
Single call export of the md and pdf documentation files

    

## 3. SYSADMIN FEATURES AND FUNCTIONALITIES
The term feature usually denotes an UI usability, but as the sysadmins of the qto system must be technical people accustomed to the black screen in this context feature simply means a well memorizable shell call to perform a single action on the System they must operate. 

    # pre-load the project variables
    doParseCnfEnvVars cnf/qto.dev.host-name.cnf
    
    # run the run-integration-tests
    bash src/bash/qto/qto.sh -a run-integration-tests

### 3.1. Enforced daily backups by "increase-date" action
The concept of daily backups in in-build in the functionalities of the qto application for all the projects data - that is you cannot operate the application without having daily backups, as every day a new working daily dir having the current day daily backup will be created!
The "increase-date" action copies the content of the latest daily data dir ( build by concentrating the mix_data_dir and the latest date string) with the current date in the file path. 
This IS the defacto way of making backup of the data ( including db dumps ) on daily basis, which could be quite easily made really robust for Unix admins with couple of cron scripts and symlinks ... 
The increase-date behaves for different projects in the same way, except of course using a different daily data dir root. 

    # load the env vars for a different proj: 
    clear; doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/qto/ysg-issues.dev.host-name.cnf
    
    # make backup of the latest daily dir
    bash src/bash/qto/qto.sh -a increase-date

### 3.2. Postgres db backup
You can backup any project database by using the following calls:

    # pre-load the project variables
    doParseCnfEnvVars cnf/qto.dev.host-name.cnf
    # replace the second strin to the full path of the project file if needed 
    
    # backup the postgres db of the project 
    bash src/bash/qto/qto.sh -a backup-postgres-db

### 3.3. The "run-pgsql-scripts" action
You can create a preconfigured &lt;&lt;env&gt;&gt;_&lt;&lt;db_name&gt;&gt; postgres via a single shell call. The scripts will fail if any of the sql scripts have a syntax error - all the ddl events will be displayed in the STDOUT and stored in the shell log file for later audit.

    bash src/bash/qto/qto.sh -a run-pgsql-scripts

### 3.4. The "run-mysql-scripts" action
You can create a preconfigured &lt;&lt;env&gt;&gt;_&lt;&lt;db_name&gt;&gt; in mariadb  via a single shell call. The scripts will fail if any of the sql scripts have a syntax error - all the ddl events will be displayed in the STDOUT and stored in the shell log file for later audit

    

#### 3.4.1. The "txt-to-db" action period handling ( deprecated)
Issues txt files are stored in a daily folder with the following naming convention:
&lt;&lt;project&gt;&gt;.&lt;&lt;current_date&gt;&gt;.&lt;&lt;period&gt;&gt;.txt
The tool knows to correctly fetch the issues files for the configured period ( by export period=weekly ) and copy its data in to the &lt;&lt;period&gt;&gt;_issue table. 

    ysg-issues.2017-06-03.daily.txt
    ysg-issues.2017-06-03.monthly.txt
    ysg-issues.2017-06-03.weekly.txt
    ysg-issues.2017-06-03.yearly.txt

#### 3.4.2. The "txt-to-db" action ( deprecated)
You can load you issues from an "issues txt file" , having a specific syntax into a PosgtreSQL issue table, by issueing the shell.
This call with truncate the issue table from the db and convert all the issues data from the issues txt file into the issue table. 

    # pre-load the vars of an qto project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/qto/qto-issues.dev.doc-pub-host.cnf
    
    # ensure there is no data in the issue table
    psql -d "$db_name" -c 'TRUNCATE TABLE issue ;'
    
    # run the txt-to-db action
    bash src/bash/qto/qto.sh -a txt-to-db
    
    # check the data by :
    psql -d "$db_name" -c 'SELECT issue_id , category , name FROM issue order by name'

#### 3.4.3. The "db-to-txt" action ( deprecated ) 
You can load your already stored in the issue table issues and load them into the same issues txt file

    # check the data by :
    psql -d "$db_name" -c '
    SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio'
    
    # run the db-to-xls action
    bash src/bash/qto/qto.sh -a db-to-txt
    
    # check the updated data
    psql -d "$db_name" -c '
    SELECT issue_id , start_time , stop_time , category , name FROM issue order by start_time'

#### 3.4.4. The "db-to-txt" action with pre-defined sorting attribute ( deprecated )
You can load your already stored in the issue table issues and load them into the same issues txt file by using a pre-defined sorting attribute. 

    export issues_order_by_attribute=start_time
    
    bash src/bash/qto/qto.sh -a db-to-txt

#### 3.4.5. restart the morbo development server
You could restart the development morbo server by issuing the following syntax ( Note that each environment type starts within the pre-configured mojo_morbo_port if configured to do so):

    bash src/bash/qto/qto.sh -a mojo-morbo-stop ; bash src/bash/qto/qto.sh -a mojo-morbo-start

#### 3.4.6. restart the hypnotoad production server
You could restart the production hypnotoad server by issuing the following syntax:

    bash src/bash/qto/qto.sh -a mojo-hypnotoad-stop ; bash src/bash/qto/qto.sh -a mojo-hypnotoad-start

## 4. ETL / DATA INTEGRATION FEATURES AND FUNCTIONALITIES


    

### 4.1. The "db-to-xls" action against postgres
You can unload your already stored ANY xls table with unique id's and load them into a xls file. 

    # pre-load the vars of an qto project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/qto/qto-issues.dev.doc-pub-host.cnf
    
    
    # check the data by :
    psql -d "$db_name" -c 'SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio'
    
    # run the db-to-xls action
    bash src/bash/qto/qto.sh -a db-to-xls
    

### 4.2. The "xls-to-db" action
You can load the latest produced xls file ( note as long as your xls sheet headers match the columns in your db table ANY xls is compatible )
You can control whether or not the loadable table should be truncated by setting the do_truncate_tables environment variable to 1 or 0. 

    clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/issue_tracker/script/issue_tracker.pl --tables $tables --do xls-to-db

#### 4.2.1. The "xls-to-db" action without passing xls file
if you do not provide a xls file the newest xls file from the mix data dir will be used

    clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/issue_tracker/script/issue_tracker.pl --tables $tables --do xls-to-db

#### 4.2.2. The "xls-to-db" action with nested-set mode against mysql
You could run the xls-to-db action against mysql or mariadb rdbms so that the qto will arrange your table to be compatible with the nested-set hierarchy model. 

    export tables=Tests,ItemController,ItemModel,ItemView,ExportFile,UserStory,Requirement,DevOps,Feature,ReadMe,SystemGuide,Image,ExportFile; export do_truncate_tables=1 ; export rdbms_type=mysql ; export load_model=nested-set ; perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables $tables

### 4.3. The db-to-json shell action
You could make a backup of all your postgres tables data by running the db-to-json shell action as follows:

    clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-json --tables $tables

### 4.4. The json-to-db shell action
You could restore a previously created json files backup ( the json files are stored in the &lt;&lt;ProductInstanceDir&gt;&gt;/dat/json by default by issueing the following oneliner ( you need to have the web server up and running in order to fetch the list of tables too ) 

    clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; perl src/perl/issue_tracker/script/issue_tracker.pl --do json-to-db --tables $tables

## 5. BACK-END API FUNCTIONALITIES


    

### 5.1. create web-action
An http client could create  a new row into ANY table by passing a bigint as the id.

    <<web-host>>:<<web-port>>/<<database>>/create/<<table-name>>

#### 5.1.1. Successful execution
After 200 http returned code a new item is created in the database. Note that all non-null columns in the database MUST have default values, otherwise this call will always fail. This limitation is by design for now.

    <<web-host>>:<<web-port>>/<<database>>/create/<<table-name>>
    // example data
    { id: "3"}

#### 5.1.2. Error handling on non-existing db
If the db provided in the url pattern does not exist an error is shown. 

    

#### 5.1.3. Error handling on non-existing table
If the table provided in the url pattern does not exist an error is shown. 

    

#### 5.1.4. Error handling on non-existing attribute 
If the attribute(column) provided in the post data does not exist an error is shown. 

    

#### 5.1.5. Error handling on wrong data-type
Whenever a wrong data type is passed the back-end returns with the 400 http code and provides the error from the database.


    

### 5.2. update web-action
An http client could update ANY table with a single column name by provinng the column name and the column value

    <<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>

#### 5.2.1. Successful execution
An http client could update ANY table with a single column name by provinng the column name and the column value

    <<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>
    // example data
    {attribute: "description", id: "3", cnt: "the name attr should be updated to updated-name-3"}

#### 5.2.2. Error handling on non-existing db
If the db provided in the url pattern does not exist an error is shown. 

    

#### 5.2.3. Error handling on non-existing table
If the table provided in the url pattern does not exist an error is shown. 

    

#### 5.2.4. Error handling on non-existing attribute 
If the attribute(column) provided in the post data does not exist an error is shown. 

    

#### 5.2.5. Error handling on wrong data-type
Whenever a wrong data type is passed the back-end returns with the 400 http code and provides the error from the database.


    

#### 5.2.6. Automatic upate_time attribute update
Any item having the update_time attribute will get its value automatically based on the update time of the transaction. 

    

### 5.3. delete web action
An http client could create  a new row into ANY table by passing a bigint as the id.

    <<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>

#### 5.3.1. Successful execution
Once the post call is executed the item is deleted from the db.

    <<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>
    // example data
    {attribute: "description", id: "3", cnt: "the name attr should be updated to updated-name-3"}

#### 5.3.2. Error handling on non-existing db
If the db provided in the url pattern does not exist an error is shown. 

    

#### 5.3.3. Error handling on non-existing table
If the table provided in the url pattern does not exist an error is shown. 

    

### 5.4. select web action
An http-client could get the contents of ANY table of a database to which the qto has connectivity to ( ie not only the one configured in the application layer but also other databases in the same postgres instance)  by using the following syntax:

    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>

#### 5.4.1. successful execution
An http-client could get the contents of ANY table of a database to which the qto has connectivity to by calling the following url:
&lt;&lt;web-host&gt;&gt;:&lt;&lt;web-port&gt;&gt;/&lt;&lt;database&gt;&gt;/select/&lt;&lt;table-name&gt;&gt;

    

#### 5.4.2. apply multiple operators on the select properly
All the operators bellow could be combined and the result set is the one "translated" with the AND operator in the back-end side. 

    

#### 5.4.3. error handling for failed connect to db in the select web action
If the http-client points to a db to which the app layer does not have a connection ( might be a non-existing one ) the proper response is generated. 


    // 20180503234141
    // http://192.168.56.120:3000/non_existent/select/daily_issues
    
    {
      "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
      "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
      "ret": 400
    }

#### 5.4.4. error handling for non-existent table in the select-tables web action
if a table does not exist a proper error msg containing response is generated.


    // 20180505205015
    // http://192.168.56.120:3000/qto/select/non_existent
    
    {
      "msg": " the table non_existent does not exist in the qto database ",
      "req": "GET http://192.168.56.120:3000/qto/select/non_existent",
      "ret": 400
    }

#### 5.4.5. filter functionality in select table web action
The response cold be filtered by ANY attribute with any valid value. 


    // using the following syntax:
    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?fltr-by=<<filter-attribute-to-filter-by>>&fltr-val=<<filter-value-to-filter-by>>

##### 5.4.5.1. successful execution
The response of the select web action could be filtered by using the syntax bellow:
Those are eventual transated to a where clause in the db select part. 



    // 20180505204531
    // http://192.168.56.120:3000/qto/select/monthly_issues?fltr-by=prio&fltr-val=1
    
    {
      "dat": {
        "c89d3283-0a9f-4b8d-9dcc-84a63e64276b": {
          "actual_hours": null,
          "category": "qto-features",
          "description": "add the web select controller “\r\n - implementation code\r\n - tests \r\n - documentation additions for :\r\n-- requirements\r\n-- userstories\r\n-- tests \r\n-- features and functionalities",
          "guid": "c89d3283-0a9f-4b8d-9dcc-84a63e64276b",
          "id": 180402,
          "level": 2,
          "name": "add the web select controller",
          "owner": "ysg",
          "planned_hours": "3.00",
          "prio": 1,
          "seq": 1,
          "start_time": "2018-04-02 18:00",
          "status": "07-qas",
          "stop_time": null,
          "tags": "feature",
          "type": "feature",
          "update_time": "2018-05-04 23:18:45.104771"
        }
      },
      "msg": "SELECT OK for table: monthly_issues",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?fltr-by=prio&fltr-val=1",
      "ret": 200
    }

##### 5.4.5.2. error handling for wrong filtering syntax by missed fltr-by or fltr-va url params
If the request does not have either one of the url params the following response is produced. 


    // 20180505204734
    // http://192.168.56.120:3000/qto/select/monthly_issues?fltr-by=prio
    
    {
      "msg": "mall-formed url params for filtering - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<filter-value>>",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?fltr-by=prio",
      "ret": 400
    }

##### 5.4.5.3. error handling for non-existent filter name
If the syntax is correct but an non-existent filtering attribute is provided ( that is the table columns and the attribute name do not match ) the following error msg is returned: 


    // 20180506220030
    // http://192.168.56.120:3000/qto/select/monthly_issues?fltr-by=foo&fltr-val=sdklfj
    
    {
      "msg": "the foo column does not exist",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?fltr-by=foo&fltr-val=sdklfj",
      "ret": 400
    }

#### 5.4.6. Use pick url param functionality in select table web action
Works for both a single colum and a comma separated select of columns. Obeys the following syntax:


    // using the following syntax:
    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?pick=col1,col2,col3

##### 5.4.6.1. successful execution
if the request contains the "pick" url parameter only the picked column values are selected. 


    // 20180506230955
    // http://192.168.56.120:3000/qto/select/monthly_issues?pick=name,prio
    
    {
      "dat": {
        "0daa3447-42f5-4792-aca2-bd1cb06e2a78": {
          "guid": "0daa3447-42f5-4792-aca2-bd1cb06e2a78",
          "name": "define REST API response structure",
          "prio": 3
        },
        "3c3aff5d-8246-4893-acc4-4853904f1d40": {
          "guid": "3c3aff5d-8246-4893-acc4-4853904f1d40",
          "name": "add the pick in url to select in db reader control flow for Select.pm controller",
          "prio": 3

##### 5.4.6.2. error handling if a picked column does not exist
if a picked column does not exist the following error is displayed. 


    // 20180506230926
    // http://192.168.56.120:3000/qto/select/monthly_issues?pick=non_existent_column
    
    {
      "msg": "the non_existent_column column does not exist",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?pick=non_existent_column",
      "ret": 400
    }
      },
      "msg": "SELECT OK for table: monthly_issues",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?pick=name%2Cprio",
      "ret": 200
    }

#### 5.4.7. Use filtering with the like operator in select table web action
The response cold be liked by ANY attribute with any valid value. 


    // using the following syntax:
    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?like-by=<<like-attribute-to-like-by>>&like-val=<<like-value-to-like-by>>

##### 5.4.7.1. successful execution for number types
The like operator could be used with numbers as well.

    // 20180508191656
    // http://192.168.56.120:3000/qto/select/yearly_issues?like-by=prio&like-val=1&pick=name,prio
    
    {
      "dat": {
        "46533749-1c00-4688-9cdd-1cc276ca40ac": {
          "guid": "46533749-1c00-4688-9cdd-1cc276ca40ac",
          "name": "implement upsert in DbWriterPostgres",
          "prio": 21
        },  "msg": "SELECT OK for table: monthly_issues",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?like-by=prio&like-val=1",
      "ret": 200
    }

##### 5.4.7.2. successful execution for text types
The response of the select web action could be likeed by using the syntax bellow:
Those are eventual transated to a where clause in the db select part. 



    // 20180505204531
    // http://192.168.56.120:3000/qto/select/monthly_issues?like-by=prio&like-val=1
    
    {
      "dat": {
        "c89d3283-0a9f-4b8d-9dcc-84a63e64276b": {
          "actual_hours": null,
          "category": "qto-features",
          "description": "add the web select controller “\r\n - implementation code\r\n - tests \r\n - documentation additions for :\r\n-- requirements\r\n-- userstories\r\n-- tests \r\n-- features and functionalities",
          "guid": "c89d3283-0a9f-4b8d-9dcc-84a63e64276b",
          "id": 180402,
          "level": 2,
          "name": "add the web select controller",
          "owner": "ysg",
          "planned_hours": "3.00",
          "prio": 1,
          "seq": 1,
          "start_time": "2018-04-02 18:00",
          "status": "07-qas",
          "stop_time": null,
          "tags": "feature",
          "type": "feature",
          "update_time": "2018-05-04 23:18:45.104771"
        }
      },
      "msg": "SELECT OK for table: monthly_issues",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?like-by=prio&like-val=1",
      "ret": 200
    }

##### 5.4.7.3. error handling for wrong  syntax in the filtering by the like operator by missed like-by or like-val url params
If the request does not have either one of the url params the following response is produced. 


    // 20180505204734
    // http://192.168.56.120:3000/qto/select/monthly_issues?like-by=prio
    
    {
      "msg": "mall-formed url params for likeing - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?like-by=prio",
      "ret": 400
    }

##### 5.4.7.4. error handling for non-existent like table's attribute
If the syntax is correct but an non-existent like operator's attribute is provided ( that is the table columns and the attriute name do not match ) the following error msg is returned: 


    // 20180506220030
    // http://192.168.56.120:3000/qto/select/monthly_issues?like-by=foo&like-val=sdklfj
    
    {
      "msg": "the foo column does not exist",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?like-by=foo&like-val=sdklfj",
      "ret": 400
    }

#### 5.4.8. Filtering by using the "with" url param
You can filter the result of the query by using the "with=col-operator-value"

    // 20180605150216
    // http://192.168.56.120:3000/qto/select/monthly_issues?as=grid&with=prio-lt-6&o=prio&pick=name,prio&with=status-eq-02-todo
    
    {
       "dat": [
          {
             "guid": "55a06b10-7bbf-4298-a1ee-804bbfd12570",
             "name": "poc for data-load testing",
             "prio": 5
          }
       ],
       "msg": "",
       "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?as=grid",
       "ret": 200
    }

##### 5.4.8.1. Successful execution
The application selects only the rows matching the generated where &lt;&lt;column&gt;&gt; &lt;&lt;operator&gt;&gt; &lt;&lt;value&gt;&gt; , where the operator could be also the like operator ( set also if the value contains the % char ) 

    

##### 5.4.8.2. Error handling for non-existent column
If the column used does not exist an error is provided as follows:


    // 20180605150010
    // http://192.168.56.120:3000/qto/select/monthly_issues?as=grid&with=prio-lt-7&o=prio&pick=name,prio&with=foo-eq-02-todo
    
    {
       "msg": "the foo column does not exist",
       "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?as=grid",
       "ret": 400
    }

#### 5.4.9. the hide operator in the select web action
Whenever a hide=&lt;&lt;col-name&gt;&gt; operator is applied the values and the column names of the column to hide are not displayed in the result. Use command to as the separator for listing multiple columns to hide. 


    // using the following syntax:
    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?hide=guid,prio

##### 5.4.9.1. successful execution for text types
The response of the url query presents all but the hidden attribute values.


    // 20180511144541
    // http://192.168.56.120:3000/qto/select/monthly_issues?like-by=category&like-val=features&pick=name,prio,start_time,stop_time,category,status&o=stop_time&hide=guid
    
    {
      "dat": [
        {
          "category": "qto-features",
          "name": "improve integration testing",
          "prio": 5,
          "start_time": null,
          "status": "09-done",
          "stop_time": null
        }
      ],
      "msg": "",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?like-by=category&like-val=features&pick=name%2Cprio%2Cstart_time%2Cstop_time%2Ccategory%2Cstatus&o=stop_time&hide=guid",
      "ret": 200
    }

##### 5.4.9.2. error handling for inexistent column to hide
If the column which values are requested to be hidden does not exist the proper error message is retrieved. 


    // 20180505204734
    // http://192.168.56.120:3000/qto/select/monthly_issues?like-by=prio
    
    {
      "msg": "mall-formed url params for likeing - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>",
      "req": "GET http://192.168.56.120:3000/qto/select/monthly_issues?like-by=prio",
      "ret": 400
    }

### 5.5. select-tables web action
An http-client could get the select of all the tables of a database to which the qto has connectivity to ( that is not only the one configured in the application layer )


    <<web-host>>:<<web-port>>/<<database>>/select-tables

#### 5.5.1. successful execution
An http-client could get the select of all the tables of a database to which the qto has connectivity to


    // 20180505205212
    // http://192.168.56.120:3000/qto/select-tables
    
    {
      "dat": {
        "1": {
          "row_id": "1",
          "table_catalog": "qto",
          "table_name": "confs",
          "table_schema": "public"
        },
        "2": {
          "row_id": "2",
          "table_catalog": "qto",
          "table_name": "daily_issues",
          "table_schema": "public"
        },
        "3": {
          "row_id": "3",
          "table_catalog": "qto",
          "table_name": "decadally_issues",
          "table_schema": "public"
        }
      },
      "msg": "SELECT tables-select OK ",
      "req": "GET http://192.168.56.120:3000/qto/select-tables",
      "ret": 200
    }

#### 5.5.2. error handling for failed connect to db in the select-tables web action
If the http-client points to a db to which the app layer does not have a connection ( might be a non-existing one ) the proper response is generated. 


    // 20180503234141
    // http://192.168.56.120:3000/non_existent/select/daily_issues
    
    {
      "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
      "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
      "ret": 400
    }

### 5.6. Query web action
An http-client could query the name and description attributes for all the tables having those attributes by a keyword , which is translated to the sql like clause.

    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>

#### 5.6.1. successful execution
An http-client could get the contents of ANY table of a database to which the qto has connectivity to by calling the following url:
&lt;&lt;web-host&gt;&gt;:&lt;&lt;web-port&gt;&gt;/&lt;&lt;database&gt;&gt;/query?for=&lt;&lt;phrase-to-srch-for&gt;&gt;
For example: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/query?for=meta-data

    // 20181105161448
    // http://192.168.56.120:3001/qto/query?for=meta-data
    
    {
       "dat": [
          {
             "description": "The meta-data could be added to the met , as the data is set in the dat of the json ...\nBecause this will also enable the display of the warning msgs capability",
             "guid": "4deaead1-721e-4bee-93ce-22d7e01dd511",
             "id": 180806103105,
             "item": "monthly_issues",
             "name": "add fetching of the meta-data in the select web-action"
          },
          {
             "description": "Basically a good calendar control should be pretty easy to be integrated ... , but it would require \"infra\" for fetching the meta-data as well ...",
             "guid": "bf2206c2-0b12-415f-90a0-d008b0d6913a",
             "id": 180806102543,
             "item": "yearly_issues",
             "name": "add vue calendar on the dates "
          }
       ],
       "met": 0,
       "msg": "",
       "req": "GET http://192.168.56.120:3001/qto/query",
       "ret": 0
    }

#### 5.6.2. error handling on non-provided for operator
If the for operator is not provided an error is returned:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/query

    // 20181105161651
    // http://192.168.56.120:3001/qto/query
    
    {
       "met": "",
       "msg": "nothing to search for, the for url parameter is undefined the query route",
       "req": "GET http://192.168.56.120:3001/qto/query",
       "ret": 400
    }

#### 5.6.3. error handling for empty for url parameter
If the for url parameter is empty  is not provided an error is returned:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/query?for=

    // 20180503234141
    // http://192.168.56.120:3000/non_existent/select/daily_issues
    
    {
      "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
      "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
      "ret": 400
    }

## 6. SECURITY FEATURES AND FUNCTIONALITIES


    

### 6.1. Fully open mode
Currently the default mode of any running qto application is "fully open", that is any user having access to the url of the application might perform any change from the ui. 

    

### 6.2. Basic authentication mode
A fully deployed and configured qto instance provides basic authentication mode for any project database it has access to allowing thus persons having the credentials of the system account used for the particular project database to have full read,write and delete access to the data of that instance, in a way preventing users not having access to those credentials to the application. 
It is worth noting that this basic authentication does not mean strict security requirements for business and personal data on the web.
For more info consult the BasicAuthPlus module docs  :
https://metacpan.org/pod/Mojolicious::Plugin::BasicAuthPlus#DESCRIPTION
 

    

