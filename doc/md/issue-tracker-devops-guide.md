#  ISSUE-TRACKER DEVOPS GUIDE


Table of Contents

  * [1. GUIDING PRINCIPES](#1-guiding-principes)
    * [1.1. It should just work](#11-it-should-just-work)
      * [1.1.1. Personal responsibility](#111-personal-responsibility)
      * [1.1.2. Attempt for 100% test coverage to achieve reliability](#112-attempt-for-100%-test-coverage-to-achieve-reliability)
    * [1.2. Naming conventions principle](#12-naming-conventions-principle)
    * [1.3. Be user-friendly especially to developers and devops](#13-be-user-friendly-especially-to-developers-and-devops)
    * [1.4. Aim for simplicity](#14-aim-for-simplicity)
    * [1.5. Do not allow broken windows](#15-do-not-allow-broken-windows)
  * [2. INSTALLATIONS AND CONFIGURATIONS](#2-installations-and-configurations)
    * [2.1. Configure the Ubuntu repositories](#21-configure-the-ubuntu-repositories)
    * [2.2. Add the media keys](#22-add-the-media-keys)
    * [2.3. Install the postgre package with apt](#23-install-the-postgre-package-with-apt)
    * [2.4. Change the postgre user password](#24-change-the-postgre-user-password)
      * [2.4.1. start the postgreSQL](#241-start-the-postgresql)
      * [2.4.2. Start the psql client as the postgres shell user](#242-start-the-psql-client-as-the-postgres-shell-user)
      * [2.4.3. Create the pgsql user ](#243-create-the-pgsql-user-)
      * [2.4.4. add the uuid generation capability enabling extension](#244-add-the-uuid-generation-capability-enabling-extension)
      * [2.4.5. Install the dblink extension as follows](#245-install-the-dblink-extension-as-follows)
    * [2.5. Install the perl modules ( optional)](#25-install-the-perl-modules-(-optional))
  * [3. MAINTENANCE AND OPERATIONS](#3-maintenance-and-operations)
    * [3.1. RDBMS Runstate management](#31-rdbms-runstate-management)
      * [3.1.1. To check the status of the postgreSql](#311-to-check-the-status-of-the-postgresql)
      * [3.1.2. To stop the postgreSql](#312-to-stop-the-postgresql)
      * [3.1.3. To start the postgreSql](#313-to-start-the-postgresql)
      * [3.1.4. to check the port on which it is listening ](#314-to-check-the-port-on-which-it-is-listening-)
      * [3.1.5. Check the postgres status](#315-check-the-postgres-status)
    * [3.2. Application Layer runstate management](#32-application-layer-runstate-management)
      * [3.2.1. start the application layer](#321-start-the-application-layer)
      * [3.2.2. stop the application layer](#322-stop-the-application-layer)
      * [3.2.3. restart the application layer](#323-restart-the-application-layer)
  * [4. USAGE SCENARIOS](#4-usage-scenarios)
    * [4.1. Shell based actions usage](#41-shell-based-actions-usage)
      * [4.1.1. Run increase-date action](#411-run-increase-date-action)
      * [4.1.2. Run xls-to-db action](#412-run-xls-to-db-action)
      * [4.1.3. Run db-to-txt action](#413-run-db-to-txt-action)
      * [4.1.4. Load xls issues to db and from db to txt files](#414-load-xls-issues-to-db-and-from-db-to-txt-files)
      * [4.1.5. Run the issue-tracker file to db load](#415-run-the-issue-tracker-file-to-db-load)
      * [4.1.6. Verify the inserted data from the db](#416-verify-the-inserted-data-from-the-db)
    * [4.2. web based routes usage](#42-web-based-routes-usage)
      * [4.2.1. Run the http://&lt;&lt;web-host&gt;&gt;:&lt;&lt;web-port&gt;&gt;/&lt;&lt;proj-db&gt;&gt;/get/&lt;&lt;table&gt;&gt;/&lt;&lt;guid&gt;&gt; route](#421-run-the-http//web-hostweb-port/proj-db/get/table/guid-route)
  * [5. NAMING CONVENTIONS](#5-naming-conventions)
    * [5.1. Dirs naming conventions](#51-dirs-naming-conventions)
    * [5.2. Root Dirs naming conventions](#52-root-dirs-naming-conventions)
  * [6. SOURCE CODE MANAGEMENT](#6-source-code-management)
    * [6.1. Aim for tracability between userstories, requirements, features and functionalities](#61-aim-for-tracability-between-userstories,-requirements,-features-and-functionalities)
    * [6.2. Feature development in a feature branch](#62-feature-development-in-a-feature-branch)
    * [6.3. ALWAYS Start with Unit Test](#63-always-start-with-unit-test)
    * [6.4. Branch for development - dev](#64-branch-for-development--dev)
    * [6.5. Testing and integrations in the tst branch](#65-testing-and-integrations-in-the-tst-branch)
    * [6.6. Quality assurance in the qas branch](#66-quality-assurance-in-the-qas-branch)
    * [6.7. Production in the prd branch](#67-production-in-the-prd-branch)
  * [7. SCENARIOS](#7-scenarios)
    * [7.1. A small team project hours tracking scenario](#71-a-small-team-project-hours-tracking-scenario)
  * [8. WAY OF WORKING](#8-way-of-working)
    * [8.1. Definition of Done](#81-definition-of-done)
    * [8.2. E-mail communication](#82-e-mail-communication)
    * [8.3. Chat / IRC](#83-chat-/-irc)
    * [8.4. Documentation](#84-documentation)
  * [9. FEATURE IMPLEMENTATION WORKFLOW](#9-feature-implementation-workflow)
    * [9.1. Issue creation](#91-issue-creation)
    * [9.2. UserStory creation](#92-userstory-creation)
    * [9.3. Requirements creation](#93-requirements-creation)
    * [9.4. Problem registration](#94-problem-registration)
    * [9.5. Feature branch creation](#95-feature-branch-creation)
    * [9.6. Create a test-entry point](#96-create-a-test-entry-point)
    * [9.7. Implementation of Proof of Concept](#97-implementation-of-proof-of-concept)
    * [9.8. Prototype implementation](#98-prototype-implementation)
    * [9.9. Unit and / or integration test creation](#99-unit-and-/-or-integration-test-creation)
    * [9.10. Implementation ](#910-implementation-)
    * [9.11. Deployment and test to the test environment](#911-deployment-and-test-to-the-test-environment)
      * [9.11.1. Deployment to the test environment](#9111-deployment-to-the-test-environment)
      * [9.11.2. Check that all the files in the deployment pacakge are the same as those in the latest commit of the dev git branch. ](#9112-check-that-all-the-files-in-the-deployment-pacakge-are-the-same-as-those-in-the-latest-commit-of-the-dev-git-branch-)
    * [9.12. Deployment and test to the production environment](#912-deployment-and-test-to-the-production-environment)
    * [9.13. Quality assurance iteration](#913-quality-assurance-iteration)
    * [9.14. DoD check-list walktrough](#914-dod-check-list-walktrough)
      * [9.14.1. The feature or functionality current description is added in the docs](#9141-the-feature-or-functionality-current-description-is-added-in-the-docs)
      * [9.14.2. The related requirement is added in the requirements document](#9142-the-related-requirement-is-added-in-the-requirements-document)
      * [9.14.3. At least 2 times passed unit tests run in each environment instance](#9143-at-least-2-times-passed-unit-tests-run-in-each-environment-instance)
      * [9.14.4. At least 2 times passed integration tests run in each environment instance](#9144-at-least-2-times-passed-integration-tests-run-in-each-environment-instance)


    

## 1. GUIDING PRINCIPES
This section might seem too philosophical for a start, yet all the development in the issue-tracker has ATTEMPTED to follow the principles described bellow. If you skip this section now you might later on wander many times why something works and it is implemented as it is ... and not "the right way". 
Of course you are free to not follow these principles, the less you follow them the smaller the possibility to pull features from your instance(s) - you could even use the existing functionality to create a totally different fork with different name and start developing your own toll with name X - the authours give you the means to do that with this tool ... , but if you want to use and contribute to THIS tool than you better help defined those leading principles and follow them. 

    

### 1.1. It should just work
Any instance of the issue-tracker should simply work as promised. No less no more. 
Any instance is the combination of code, configurations, binaries in the System and data - that is the instance you are using should just work for the set of functionalities promised. 

    

#### 1.1.1. Personal responsibility
Any givien instance of the issue-tracker should have ONE and only ONE person which is responsible at the end for the funtioning of THIS instance - so think carefully before attempting to take ownership for an instance. The author(s) of the code are not responsible for the operation, bugs or whatever happens to a new instannce. As a responsible owner of an instance you could create, share and assign issues to the authors of the source code, yet there is no service level agreement, nor even promise to help. 

    

#### 1.1.2. Attempt for 100% test coverage to achieve reliability
The more you increase your test coverage the greater the confidence that the code will work as expected. 
Do not write a single function without first implementing the testing call for that function - this has been proven really, really difficult, yet the more features are added the less the time wasted in troubleshooting of bugs and un-expected behaviour when proper testing is implemented. 
Testing ensures the consistency and future expandability of the functionalities. 

    

### 1.2. Naming conventions principle
All the names used in the code and the configurations MUST BE human readable and expandable - that is name the objects from the greater realm to the smaller - for example &lt;&lt;env&gt;&gt;_&lt;&lt;db_name&gt;&gt; , because the concept of operational IT environments ( dev , tst , qas , prd ) is broader than the concept of a application databases ... 

    

### 1.3. Be user-friendly especially to developers and devops
You cannot achieve user-friendliness for the end-users unless your developers and technical personnel are happy while interacting with your artifacts. 

    

### 1.4. Aim for simplicity
Things should be as simple as possible, but not simpler - if Einstein said it it makes sense - having lost so much time in endless loops of IT complexity - the older we get the more it gets more rational. 

    

### 1.5. Do not allow broken windows
A broken windows is any peace of code or documentation which is hanging around not included in the integration tests suite and not matching the most up-to-date standars for work deliverables. Either bring it up to the standard level or get rid of it. 

    

## 2. INSTALLATIONS AND CONFIGURATIONS


    

### 2.1. Configure the Ubuntu repositories
Configure the Ubuntu repositories

    sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"
    
    sudo apt-get update
    sudo apt-get install postgresql-9.6

### 2.2. Add the media keys
Add the media keys as follows:

    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

### 2.3. Install the postgre package with apt
Install the postgre package with apt

    # update your repos
    sudo apt-get update
    
    # install the postgresql binary
    sudo apt-get install postgresql postgresql-contrib
    
    # enable postgre
    sudo update-rc.d postgresql enable

### 2.4. Change the postgre user password
Configure the Ubuntu repositories

    sudo passwd postgres
    # Type a pw - add to your password manager !!!
    
    # and verify 
    su - postgres

#### 2.4.1. start the postgreSQL
Start the postgreSQL by issuing the following command

    sudo /etc/init.d/postgresql start

#### 2.4.2. Start the psql client as the postgres shell user
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

#### 2.4.3. Create the pgsql user 
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
    
    sudo su - postgres  -c 'psql -c "select * from information_schema.role_table_grants
     where grantee='"'"$USER"'"';"'

#### 2.4.4. add the uuid generation capability enabling extension
add the uuid generation capability enabling extension

    sudo su - postgres  -c "psql template1 -c 'CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";'"
    
    sudo su - postgres  -c "psql template1 -c 'CREATE EXTENSION IF NOT EXISTS \"pgcrypto\";'"

#### 2.4.5. Install the dblink extension as follows
Install the dblink extension as follows

    sudo su - postgres  -c "psql template1 -c 'CREATE EXTENSION IF NOT EXISTS \"dblink\";' "

### 2.5. Install the perl modules ( optional)
Install the perl module by first installing the server development package

    
    # check which server development packages are available
    sudo apt-cache search postgres | grep -i server-dev | sort
    
    # install it
    sudo apt-get install -y postgresql-server-dev-9.6
    
    # install the DBD::Pg module
    sudo perl -MCPAN -e 'install DBD::Pg'
    
    sudo perl -MCPAN -e 'Tie::Hash::DBD'

## 3. MAINTENANCE AND OPERATIONS


    

### 3.1. RDBMS Runstate management


    

#### 3.1.1. To check the status of the postgreSql
To check the status of the postgreSql issue:

    sudo /etc/init.d/postgresql status

#### 3.1.2. To stop the postgreSql
To stop the postgreSql issues:

    sudo /etc/init.d/postgresql stop

#### 3.1.3. To start the postgreSql
To start the postgreSql issues:

    sudo /etc/init.d/postgresql start

#### 3.1.4. to check the port on which it is listening 
To check the port on which it is listening issue:

    sudo netstat -tulntp | grep -i postgres
    # tcp        0      0 127.0.0.1:5432          0.0.0.0:*               LISTEN      8095/postgres

#### 3.1.5. Check the postgres status
Check the postgres status.
Check the port to which the postres is running with this command:

    sudo /etc/init.d/postgresql status
    
    # restart if needed
    sudo /etc/init.d/postgresql restart
    
    # check on which ports it is runnning
    sudo netstat -plunt |grep postgres

### 3.2. Application Layer runstate management


    

#### 3.2.1. start the application layer
To start the application layer in development mode use the morbo command ( debug output will be shown ) , to start it in production mode use the hypnotoad pattern 

    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-start
    
    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start

#### 3.2.2. stop the application layer
To stop the application layer in development mode use the morbo command ( debug output will be shown ) , to start it in production mode use the hypnotoad pattern 

    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-stop
    
    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop

#### 3.2.3. restart the application layer
Well just chain the both commands. 

    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop ; bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start

## 4. USAGE SCENARIOS


    

### 4.1. Shell based actions usage


    

#### 4.1.1. Run increase-date action
You track the issues of your projects by storing them into xls files in "daily" proj_txt dirs. 
Each time the day changes by running the increase-date action you will be able to clone the data of the previous date and start working on the currnent date. 

    bash src/bash/issue-tracker/issue-tracker.sh -a increase-date

#### 4.1.2. Run xls-to-db action
You insert the date of the daily , weekly , monthly or yearly issues from the daily input excel file(s) by running the xls-to-db action. 
If you have the guid column with uuid's than this will be upsert and not bare insert.
You should be able to update only non-nullable column by reducing the number of columns in your xls sheet.

    
    export do_truncate_tables=1 ;
    bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db

#### 4.1.3. Run db-to-txt action


    

#### 4.1.4. Load xls issues to db and from db to txt files
to load xls issues to db and from db to txt files

    bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db -a db-to-txt 
    
    # or run for all the periods
    for period in `echo daily weekly monthly yearly`; do export period=$period ; 
    bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db -a db-to-txt ; done ;

#### 4.1.5. Run the issue-tracker file to db load
Run the issue-tracker file to db load 

    # ensure the following actions will be tested
    cat src/bash/issue-tracker/tests/run-issue-tracker-tests.lst | grep -v '#'
    # output should be if not correct
    check-perl-syntax
    run-issue-tracker
    
    # test those uncommented actions
    bash src/bash/issue-tracker/test-issue-tracker.sh

#### 4.1.6. Verify the inserted data from the db
Verify the inserted data from the db as follows:

    # check that the rows where inserted
    echo 'SELECT * FROM issue ; ' | psql -d dev_issue_tracker

### 4.2. web based routes usage


    

#### 4.2.1. Run the http://&lt;&lt;web-host&gt;&gt;:&lt;&lt;web-port&gt;&gt;/&lt;&lt;proj-db&gt;&gt;/get/&lt;&lt;table&gt;&gt;/&lt;&lt;guid&gt;&gt; route
Load a table with guid's.
Check a single item with your browser, for example:
http://doc-pub-host:3000/dev_stockit_issues/get/company_eps/727cf807-c9f1-446b-a7fc-65f9dc53ed2d

    # load the items
    while read -r f; do 
    export xls_file=$f; 
    bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db  ; 
    done < <(find $proj_txt_dir -type f)
    
    # verify the data
    psql -d $db_name -c "SELECT * FROM company_eps "

## 5. NAMING CONVENTIONS


    

### 5.1. Dirs naming conventions
The dir structure should be logical and a person navigating to a dir should almost understand what is to be find in thre by its name .. 

    

### 5.2. Root Dirs naming conventions
The root dirs and named as follows:
bin - contains the produced binaries for th project
cnf - for the configuration
dat - for the data of the app
lib - for any external libraries used
src - for the source code of the actual projects and subprojects

    

## 6. SOURCE CODE MANAGEMENT
The issue-tracker is a derivative of the wrapp tool - this means that development and deployment process must be integrated into a single pipeline. 

    

### 6.1. Aim for tracability between userstories, requirements, features and functionalities
Once the issues are defined and you start working on your own branch which is named by the issue-id aim to map one on one each test in your code with each listed requirement in confluence and / or JIRA. 

    

### 6.2. Feature development in a feature branch
You start the development in your own feature branch named : dev--&lt;&lt;issue-id&gt;&gt;-&lt;&lt;short-and-descriptive-name&gt;&gt;.

    

### 6.3. ALWAYS Start with Unit Test
Do not ever never write code without starting firsr the unit test on how-to test the code. Period. This is he only way to avoid braking old functionalities when the application code base grows larger. 
Each time a new bug is found fix it by adding new UnitTest!

    

### 6.4. Branch for development - dev
No code should be merged into the development branch without broad testing coverage and approval from the owner of the instance - as the owner of the instance is at the end responsible personally for the whole instance. 

    

### 6.5. Testing and integrations in the tst branch
The tst branch is dedicated for testing of all the tests, the deployment, performance testing and configuration changes. Should you need to perform bigger than a small hotfix changes you must branch the tst branch into a separate dev--feature branch and re-run the integration testing and approval all over. 

    

### 6.6. Quality assurance in the qas branch
At this phase all the tests with all the expected functionalities should work at once. No small hotfixes are allowed - if a need arrises new branch is created to the tst branch The quality assurance

    

### 6.7. Production in the prd branch
The prd branch is the one deployed to the production environment. This code is NOT straight merged into the master branch , but after certain time depending on the dynamic of the tool with bugless operation merged. 

    

## 7. SCENARIOS


    

### 7.1. A small team project hours tracking scenario
This scenario describes the steps and processes, which could be implemented to achieve a small team ( 3-10 ) members issue-tracking with hours reporting by using the issue-handler combined with Google Cloud authentication and storage.

    

## 8. WAY OF WORKING
This section describes the way of working within a team working on the issue-tracker project. 
The work on the issue-tracker project is conducted by using the Scrum methodology, thus the ScruM

    

### 8.1. Definition of Done
Each issue must have a tangible artifact. An issue without tangible artifact is a tought thrown in the air.
The DoD must be iterated and updated during each Sprint Review. 

    

### 8.2. E-mail communication
Do not use e-mail communiction for code style, testing, developing etc. Issues which could be achieved witht the code review intervace of the source code management system. 
Before writing an e-mail think first could you find a way to avoid writing it at all. 
Do not expect answer of your e-mail within 2 hours. 
Use e-mail when you have to get an written evidence on agreed matters, which might cause later on discussions. 

    

### 8.3. Chat / IRC
Should you want a quicker respond than 2 hours use thre chat tool

    

### 8.4. Documentation
Undocumented feature is not a feature. 

    

## 9. FEATURE IMPLEMENTATION WORKFLOW
This section describes the common workflow for implementing a feature. 
As in other places the main principle to follow is "use common sense" , thus try to follow this workflow for feature implementation, but challenge it as soon as it defies the common sense. 

    

### 9.1. Issue creation
Even if you do not have a defined documentation artifact - create a new issue, which could be the start for a an action affecting the run-state, configuration , data , features and functionalities or other aspects of the issue-tracker appclication. 
An issue could be a bug, a request for a feature or even simply an undefined combination of problems and solution which could quickly be formalized by defining a new requirement, another issue, feature-request

    

### 9.2. UserStory creation
Use the following template while creating the user story:
As an &lt;&lt;role&gt;&gt;
In order to &lt;&lt;achieve something&gt;&gt; 
I wanto to be able &lt;&lt;action-description&gt;&gt; 

    

### 9.3. Requirements creation
Define a formal requirement as soon as possible. 

    

### 9.4. Problem registration
Problems are usually entities which last for longer time period. 

    

### 9.5. Feature branch creation
Create the feature branch by using the following naming convention:
 - dev--&lt;&lt;short-feature-title&gt;&gt;

     git branch -a
    * dev
    dev--it-18050801-add-order-by-in-select-ctrlr
    master
    prd
    tst
    remotes/origin/dev
    remotes/origin/master
    

### 9.6. Create a test-entry point
Even the smallest proof of concept needs a small test-entry point. Start always witht the testing and the testing scalability in mind. 

    

### 9.7. Implementation of Proof of Concept


    

### 9.8. Prototype implementation


    

### 9.9. Unit and / or integration test creation


    

### 9.10. Implementation 
Implement by quick unit test runs. Constantly improve both the code , configuration changes and the test code. 

    

### 9.11. Deployment and test to the test environment
Deploy to the test environment. 

    # deploy to the tst environment
    bash src/bash/issue-tracker/issue-tracker.sh -a to-tst
    
    # go to the product instance dir of the tst env for this version
    cd ../issue-tracker.<<version>>.tst.<<owner>>
    # run the integration tests
    bash src/bash/issue-tracker/issue-tracker.sh -a run-perl-integration-tests
    

#### 9.11.1. Deployment to the test environment
Deploy to the test environmen as follows:

    # deploy to the tst environment
    bash src/bash/issue-tracker/issue-tracker.sh -a to-tst
    
    # go to the product instance dir of the tst env for this version
    cd ../issue-tracker.<<version>>.tst.<<owner>>
    

#### 9.11.2. Check that all the files in the deployment pacakge are the same as those in the latest commit of the dev git branch. 
Deploy to the test environmen as follows:

    # deploy to the tst environment
    bash src/bash/issue-tracker/issue-tracker.sh -a to-tst
    
    # go to the product instance dir of the tst env for this version
    cd ../issue-tracker.<<version>>.tst.<<owner>>
    

### 9.12. Deployment and test to the production environment
Repeat the same to the production environment. As the current version is usually work in progress your stable version will be one level bellow and thanks to the architecture of the tool you could test in the production environment ( as soon as you have proper configuration ) 

    

### 9.13. Quality assurance iteration
This phase might be longer depending on the feature. Some of the features stay in quality assurance mode EVEN if they have been deployed to production 

    

### 9.14. DoD check-list walktrough
Perform the DoD checklist as follows

    

#### 9.14.1. The feature or functionality current description is added in the docs
The feature or functionality current description is added in the Features and Functionalities document. 

    

#### 9.14.2. The related requirement is added in the requirements document
The related requirement is added in the requirements document - there might be one or more requirements added. 

    

#### 9.14.3. At least 2 times passed unit tests run in each environment instance
At least 2 times passed unit tests run in each environment instance - run the unit tests at least twice per environment. Should the run behave differently start all over from dev. 

    

#### 9.14.4. At least 2 times passed integration tests run in each environment instance
At least 2 times passed unit tests run in each environment instance - run the unit tests at least twice per environment. Should the run behave differently start all over from dev. 

    

