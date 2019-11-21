#  FEATURES AND FUNCTIONALITIES 
* [1. INTRO](#1-intro)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
  * [1.3. RELATED DOCUMENTATION](#13-related-documentation)
* [2. DEPLOYABILITY](#2-deployability)
  * [2.1. FULL DEPLOYMENT IN LESS THAN AN HOUR](#21-full-deployment-in-less-than-an-hour)
  * [2.2. EASY DOCKER BASED FULL DEPLOYMENT ( DEPRECATING )](#22-easy-docker-based-full-deployment-(-deprecating-))
    * [2.2.1. New version deployment by simple unzip](#221-new-version-deployment-by-simple-unzip)
    * [2.2.2. Oneliner for prerequisite binaries check](#222-oneliner-for-prerequisite-binaries-check)
    * [2.2.3. Installation documentation](#223-installation-documentation)
  * [2.3. A FULL APPLICATION CLONE IN LESS THAN 5 MINUTES](#23-a-full-application-clone-in-less-than-5-minutes)
    * [2.3.1. Shell script for postgres db creation](#231-shell-script-for-postgres-db-creation)
    * [2.3.2. One liner for single restore and / or load](#232-one-liner-for-single-restore-and-/-or-load)
* [3. USER-FRIENDLINESS](#3-user-friendliness)
  * [3.1. ONELINER SHELL CALLS](#31-oneliner-shell-calls)
    * [3.1.1. Database recreation and DDL scripts run one-liners](#311-database-recreation-and-ddl-scripts-run-one-liners)
  * [3.2. TABLES LOAD VIA A SINGLE ONE-LINER](#32-tables-load-via-a-single-one-liner)
    * [3.2.1. Testing one-liner call](#321-testing-one-liner-call)
    * [3.2.2. Test messages user](#322-test-messages-user)
* [4. RELIABILITY AND STABILITY](#4-reliability-and-stability)
  * [4.1. DAILY BACKUPS](#41-daily-backups)
  * [4.2. LOGGING](#42-logging)
  * [4.3. FULL BACKUP TO THE CLOUD IN LESS THAN 5 MINUTES](#43-full-backup-to-the-cloud-in-less-than-5-minutes)
  * [4.4. STABILITY BASED ON OPERATIONAL EXPERIENCE ON THE CLOUD SINCE 2019](#44-stability-based-on-operational-experience-on-the-cloud-since-2019)
* [5. SCALABILITY](#5-scalability)
  * [5.1. FEATURE SCALABILITY](#51-feature-scalability)
  * [5.2. SETUP SCALABILITY](#52-setup-scalability)
  * [5.3. PROJECTS DATABASES SCALABILITY](#53-projects-databases-scalability)
* [6. PERFORMANCE](#6-performance)
  * [6.1. PAGE LOAD TIMES](#61-page-load-times)
  * [6.2. LOGIN, LOGOUT](#62-login-logout)
* [7. MULTI-INSTANCE OPERABILITY AND DEPLOYABILITY](#7-multi-instance-operability-and-deployability)
  * [7.1. ENVIRONMENT TYPE SELF-AWARENESS](#71-environment-type-self-awareness)
  * [7.2. ONELINER FOR ENVIRONMENT AND VERSION CHANGE. ](#72-oneliner-for-environment-and-version-change-)
* [8. USER INTERFACE FEATURES AND FUNCTIONALITIES](#8-user-interface-features-and-functionalities)
  * [8.1. LIST PAGE FEATURES](#81-list-page-features)
    * [8.1.1. Execution time](#811-execution-time)
    * [8.1.2. List page features](#812-list-page-features)
    * [8.1.3. Visual indication](#813-visual-indication)
  * [8.2. VIEW PAGE FEATURES](#82-view-page-features)
    * [8.2.1. CRUD in the view doc page ( beta )](#821-crud-in-the-view-doc-page-(-beta-))
    * [8.2.2. Add an item in the doc view page UI ( beta)](#822-add-an-item-in-the-doc-view-page-ui-(-beta))
    * [8.2.3. Update item](#823-update-item)
    * [8.2.4. Delete item ( beta )](#824-delete-item-(-beta-))
* [9. SECURITY](#9-security)
  * [9.1. AUTHENTICATION](#91-authentication)
    * [9.1.1. Non-athentication mode](#911-non-athentication-mode)
    * [9.1.2. Simple native authentication mode](#912-simple-native-authentication-mode)
  * [9.2. AUTHORISATION](#92-authorisation)
* [10. DOCUMENTATION](#10-documentation)
  * [10.1. DOCUMENTATION COMPLETENESS](#101-documentation-completeness)
  * [10.2. DOCUMENTATION AND CODE BASE SYNCHRONIZATION](#102-documentation-and-code-base-synchronization)




    

## 1. INTRO


    

### 1.1. Purpose
The purpose of this document is to present the features and functionalities set to the qto application for this current version.

    

### 1.2. Audience
This document could be of interest for any potential and actual users of the application. Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for it. 

    

### 1.3. Related documentation
This document is part of the qto application documentation-set, which contains the following documents:
 - readme - the initial readme file of the project
 - enduser_guide_doc - the end users guide - mostly ui usage and concepts
 - concepts_doc - contains the concepts of the application
 - userstories_doc - the collection of userstories used to describe "what is desired"
 - system_guide_doc - architecture and System description
 - devops_guide_doc - a guide for the developers and devops operators
 - installation_guide_doc - a guide for installation of the application
 - features_doc - description of the current features and functionalities
 - requirements_doc - description of the Requirements for the application


All the documents should be updated and redistributed in combination of the current version of the appilication and should be found under the following directories:
doc/md
doc/xls
according to the file format used for the documentation storage.

    

## 2. DEPLOYABILITY
The qto is easily deployable on any Unix like OS. Windows family based OS'es are explicitly out of the scope of the qto tool. Any qto instance should be configurable as easily as possible for the version it has.  

    

### 2.1. Full deployment in less than an hour
The full System is ready for use in a "blank" Unix-like OS host in less than an hour.
The installations instructions are done for Ubuntu 18.04 LTS, yet should you feel confortable with other Linux distros or even BSD Unix you should be able to complete it in less than 2 hours. 

    

### 2.2. Easy docker based full deployment ( deprecating )
This feature is being deprecated ... yet you could quickly re-implement it by changing the Dockerfiles versions .. By following the installation instructions in the installations_doc you can deploy on any docker running Unix-like OS the qto application running on a docker and Ubuntu 18.04 LTS with initially loaded database and data. 

    

#### 2.2.1. New version deployment by simple unzip
The qto tool could be deployed by a simply unzip of the full package, which must have all of the documentation and scripts to provide assistance for the setup and the configuration of the tool. 

    

#### 2.2.2. Oneliner for prerequisite binaries check
All the binaries which are required for the running of the tool must be checked by a user-friendly binaries prerequisites check script

    

#### 2.2.3. Installation documentation
The installation of the required mysql and postgres db must be documented in the DevOps guide, which should have both markdown and pdf versions in the doc directory of the deployment package. 

    

### 2.3. A full application clone in less than 5 minutes
A DevOps operator is able to perform an application clone of the qto application in less than 5 minutes. 

    

#### 2.3.1. Shell script for postgres db creation
The creation of the postgres database is doable via a single shell call. 

    

#### 2.3.2. One liner for single restore and / or load
A qto db clone can be loaded via a single oneliner.

    

## 3. USER-FRIENDLINESS
The interaction with each endpoint and interface of an application instance is implemented to be as user-friendly as possible. 
As abstract as it may sound the tool is multi-dimensionally and vertically integrated regarding the questions what, how and why towards a new person interacting with the tool by the usage of code comments, links from the documentations and uuids to be used for simple grepping from the docs till the source code. 

    

### 3.1. Oneliner shell calls
The interaction of the application on the shell should be designed and implemented so that most of the features and bigger entry points should be accessible via one-liners on the shell - for example the testers should be able to lunch all the unit-tests via a single one line call. The integration tests should be triggerable via single oneline call. 

    

#### 3.1.1. Database recreation and DDL scripts run one-liners
The developers should be able to create the database via a single oneline call 

    

### 3.2. Tables load via a single one-liner
The developers should be able to load one or many tables to the database via a single oneline call.

    

#### 3.2.1. Testing one-liner call
The testers and the developers is able to trigger all the unit or integration tests via a single one-line call. 

    

#### 3.2.2. Test messages user
Each test obeys the following convention:
 - short message as descriptive within the context as possible - what is being tested
- a short technical example of the generated entry being tested ( for example a dynamic url )
- a uuid to search for from the Feature document what exactly is being tested within the context of the features description. 

    

## 4. RELIABILITY AND STABILITY


    

### 4.1. Daily backups
Daily backups are taken after the first shell action, run for the day, the daily backups oneliner could be scheduled via crontab as well. 

    

### 4.2. Logging
The application supports fully configurable logging to STDOUT and STDERR , logfile via a single per instance configuration file. 

    

### 4.3. Full backup to the cloud in less than 5 minutes
A full backup for the data for the qto and/or another project database is doable in less than 5 minutes. 

    

### 4.4. Stability based on operational experience on the cloud since 2019
The main qto application instance has been up-and-running since the beginning of 2019 with receiving new versions in an average of 2 weeks per sprint.

    

## 5. SCALABILITY


    

### 5.1. Feature scalability
The addition of new features is scalable, as almost all of the components have been implemented according to the SOLID principle. 

    

### 5.2. Setup scalability
The creation of instances running on docker is 3 lines, the full setup on blank OS is well documented and automated to the point of running 5 one-liners to have checks on whether or not a phase has completed successfully.

    

### 5.3. Projects databases scalability
Each instance of the qto application can connect via tcp to multiple postgres databases running on the same db host configured in the instance configuration file. 

    

## 6. PERFORMANCE


    

### 6.1. Page load times
Each page of the application containing less than 2000 loads for less than 0.5 seconds.
Any new feature which does not meet this requirement should be disregarded or implemented into a clone of the application with different name ( see the cloning / forking section bellow ). The qto has been operated on quite modest hardware ( check the second cheapest amazon ec2 instances for reference ), yet the page load times vary from 0.3 till 0.6 seconds for the smaller pages and up till 1.5 seconds for the pages having more than 2000 items ...

    

### 6.2. Login, logout
Every login and logout operation completes in less than 0.3 seconds in modern network environments.

    

## 7. MULTI-INSTANCE OPERABILITY AND DEPLOYABILITY


    

### 7.1. Environment type self-awareness
Each deployed and running instance of the qto "knows" its own environment type - dev,tst, qas or prd to comply with the multi-instance architecture on a single host. 
You could change the environment type of your current instance by issuing the following command:

    bash src/bash/qto/qto.sh -a to-tst

### 7.2. Oneliner for environment and version change. 
You could create a new instance of the qto having different version ( which becomes automatically a dev environment ) by issueing the following command: 

    bash src/bash/qto/qto.sh -a to-ver=0.7.4

## 8. USER INTERFACE FEATURES AND FUNCTIONALITIES


    

### 8.1. List page features


    

#### 8.1.1. Execution time
The full execution time of any crud operation ( create,update,delete,search) from the end-user of the UI point of view is than 0.3 seconds

    

#### 8.1.2. List page features
The System provides the needed UI interfaces to Create , Update , Delete and Search items in the system for the users having the privileges for those actions.

    

#### 8.1.3. Visual indication
The System should not show ok messages , but only error messages, yet the UI should be as responsive that the end-user would easily undertand when an item has been created,updated or deleted.

    

### 8.2. View page features


    

#### 8.2.1. CRUD in the view doc page ( beta )
The Qto application provides the needed UI interfaces to Create , Update , Delete items in the view documents UI for the users having the privileges for those actions.

    

#### 8.2.2. Add an item in the doc view page UI ( beta)
Users with the write privileges for the document can add an item in the doc view page just by right clicking on the title and selecting one of the 3 options:
 - add sibling node - add an item which is on the same level in the hierarchy 
 - add parent node - add an item which is on 1 level up in the hierarchy
 - add child node - add and item which is on 1 level bellow in the hierarchy
The new item appears straight after the origin title it was requested from.

    

#### 8.2.3. Update item
You can:
- update item title content
- update item description
- update item src code if visible ( if not has to be added via the db )

    

#### 8.2.4. Delete item ( beta )
You can right click on an item and choose the remove node from the right click men.

    

## 9. SECURITY


    

### 9.1. Authentication
The qto application supports the following 2 modes of security: 
 - non authentication mode
 - simple native authentication mode 

    

#### 9.1.1. Non-athentication mode
Any qto instance should support a non-authentication mode - that is all users having http access could perform all the actions on the UI without restrictions

    

#### 9.1.2. Simple native authentication mode
A qto instance running under the simple native authentication mode stores the user credentials in the instance db. The passwords are encrypted via the using the Blowfish-based Unix crypt() hash function, known as "bcrypt" encrypting mechanism. 

    

### 9.2. Authorisation
Only the SysAdmin of the System can add basic authentication and simple native mode users, thus regular users can see only their own credentials.

    

## 10. DOCUMENTATION


    

### 10.1. Documentation completeness
Each running instance has the following documentation set :
 - ReadMe
 - Features and Functionalities doc
 - End User Guide
 - DevOps Guide
 - SystemGuide
 - UserStories document
 - Installation and Configuration Guide
In both "native qto format" and md file format in the doc/md directory of the project.

    

### 10.2. Documentation and code base synchronization
Each running instance MUST have its required documentation set up-to-date. No undocumented or hidden features are allowed. Should any be missing or misreported a new issue must be created to correct those with top priority. 

    

