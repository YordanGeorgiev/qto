#  REQUIREMENTS
* [1. INTRO](#1-intro)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
  * [1.3. RELATED DOCUMENTATION](#13-related-documentation)
* [2. DEPLOYABILITY](#2-deployability)
  * [2.1. FULL DEPLOYMENT IN LESS THAN AN HOUR](#21-full-deployment-in-less-than-an-hour)
    * [2.1.1. A working instance deployment by simple unzip command](#211-a-working-instance-deployment-by-simple-unzip-command)
    * [2.1.2. Binary prerequisites check script](#212-binary-prerequisites-check-script)
    * [2.1.3. Required Perl modules checker script](#213-required-perl-modules-checker-script)
    * [2.1.4. Installation documentation](#214-installation-documentation)
  * [2.2. A FULL APPLICATION CLONE SHOULD BE READY FOR LESS THAN 5 MINUTES](#22-a-full-application-clone-should-be-ready-for-less-than-5-minutes)
    * [2.2.1. Shell script for postgres db creation](#221-shell-script-for-postgres-db-creation)
    * [2.2.2. One liner for single restore](#222-one-liner-for-single-restore)
* [3. USER-FRIENDLINESS](#3-user-friendliness)
  * [3.1. ONELINER SHELL CALLS](#31-oneliner-shell-calls)
    * [3.1.1. Database recreation and DDL scripts run one-liners](#311-database-recreation-and-ddl-scripts-run-one-liners)
    * [3.1.2. Table(s) load via aa single one-liner](#312-table(s)-load-via-aa-single-one-liner)
    * [3.1.3. Testing one-liner call](#313-testing-one-liner-call)
    * [3.1.4. Test messages user](#314-test-messages-user)
* [4. RELIABILITY AND STABILITY](#4-reliability-and-stability)
  * [4.1. ZERO TOLLERANCE TOWARDS CRASHING](#41-zero-tollerance-towards-crashing)
  * [4.2. ZERO TOLLERANCE TOWARDS BUGS](#42-zero-tollerance-towards-bugs)
  * [4.3. DAILY BACKUPS](#43-daily-backups)
  * [4.4. LOGGING](#44-logging)
  * [4.5. FULL BACKUP TO THE CLOUD IN LESS THAN 5 MINUTES](#45-full-backup-to-the-cloud-in-less-than-5-minutes)
* [5. SCALABILITY](#5-scalability)
  * [5.1. FEATURE SCALABILITY](#51-feature-scalability)
  * [5.2. SETUP SCALABILITY](#52-setup-scalability)
  * [5.3. PROJECTS DATABASES SCALABILITY](#53-projects-databases-scalability)
* [6. PERFORMANCE](#6-performance)
  * [6.1. PAGE LOAD MAXIMUM TIME](#61-page-load-maximum-time)
  * [6.2. LOGIN, LOGOUT](#62-login,-logout)
* [7. MULTI-INSTANCE OPERABILITY AND DEPLOYABILITY](#7-multi-instance-operability-and-deployability)
  * [7.1. ENVIRONMENT TYPE SELF-AWARENESS](#71-environment-type-self-awareness)
  * [7.2. CROSS RUNNING BETWEEN INSTANCES OF DIFFERENT TYPES](#72-cross-running-between-instances-of-different-types)
* [8. UI REQUIREMENTS](#8-ui-requirements)
  * [8.1. CRUDS](#81-cruds)
    * [8.1.1. Execution time](#811-execution-time)
    * [8.1.2. Visual indication](#812-visual-indication)
  * [8.2. CLARITY ON ERRORS](#82-clarity-on-errors)
* [9. SECURITY](#9-security)
  * [9.1. AUTHENTICATION](#91-authentication)
    * [9.1.1. Non-authentication mode](#911-non-authentication-mode)
    * [9.1.2. Basic authentication mode ( to be deprecated )](#912-basic-authentication-mode-(-to-be-deprecated-))
    * [9.1.3. Simple Native authentication ( experimental )](#913-simple-native-authentication-(-experimental-))
    * [9.1.4. JSON web token authentication](#914-json-web-token-authentication)
  * [9.2. AUTHRORISATION](#92-authrorisation)
* [10. DOCUMENTATION](#10-documentation)
  * [10.1. DOCUMENTATION COMPLETENESS](#101-documentation-completeness)
  * [10.2. DOCUMENTATION AND CODE BASE SYNCHRONIZATION](#102-documentation-and-code-base-synchronization)
    * [10.2.1. Requirements push](#1021-requirements-push)
* [11. WORKING PRINCIPLES](#11-working-principles)
  * [11.1. PERSONAL RESPONSIBILITY](#111-personal-responsibility)




    

## 1. INTRO


    

### 1.1. Purpose
The purpose of this document is to present the requirements set to the qto application for the version of this instance.

    

### 1.2. Audience
This document could be of interest for any potential and actual users of the application. Product Owners, Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for the application. 

    

### 1.3. Related documentation
This document is part of the QTO application documentation-set, which contains the following documents:
 - ReadMe - the initial landing readme doc for the project
 - UserStories - the collection of user-stories used to describe "what is desired"
 - Requirements - the structured collection of the requirements 
 - SystemGuide - architecture and System description
 - DevOps Guide - a guide for the developers and devops operators
 - Installation Guide - a guide for installation of the application
 - End-User Guide - the guide for the usage of the UI ( mainly ) for the end-users
 - Concepts - the concepts doc 

All the documents should be updated and redistributed in combination of the current version of the application and should be found under the following directories:
doc/md
doc/pdf
doc/xls
according to the file format used for the documentation storage.

    

## 2. DEPLOYABILITY
The qto must be easily deployable on any Unix like OS. 
Windows family based OS'es are explicitly out of the scope of the qto tool. Any qto instance should be configurable as easily as possible for the version it has.  

    

### 2.1. Full deployment in less than an hour
The full System should be ready for use by end-users in a "blank" modern Unix like OS in less than an hour. An instance running on top of Docker should be ready within 10 minutes. 

    

#### 2.1.1. A working instance deployment by simple unzip command
The qto tool could be deployed by a simply unzip of the full package, which must have all of the documentation and scripts to provide assistance for the setup and the configuration of the tool as well as the initial data to populate the qto database. 

    

#### 2.1.2. Binary prerequisites check script
All the binaries which are required for the running of the tool must be checked by a user-friendly binaries prerequisites check script. 


    

#### 2.1.3. Required Perl modules checker script
All the required Perl modules, must be verifiable via a single runnable perl script. The DockerScript file should contain all the perl modules installations.

    

#### 2.1.4. Installation documentation
The installation of the required Postgres db must be documented in the DevOps guide, which should have the markdown version in the doc directory of the deployment package.

    

### 2.2. A full application clone should be ready for less than 5 minutes
A DevOps operator should be able to perform an application clone ( having app-name changed to new-app-name etc. ) of the Qto application in less than 5 minutes. 

    

#### 2.2.1. Shell script for postgres db creation
The creation of the Postgres database of a qto project should be doable via a single shell call. 

    

#### 2.2.2. One liner for single restore
The full data example of a cloned from the qto db should be loadable with a single shell call. _

    

## 3. USER-FRIENDLINESS
The interaction with each endpoint and interface of an application instance should be as user-friendly as possible. 
As abstract as it may sound the tool must be multi-dimensionally and vertically integrated regarding the questions what, how and why towards a new person interacting with the tool by the usage of code comments , links from the documentations and uuids to be used for simple greping from the docs till the source code. 

    

### 3.1. Oneliner shell calls
The interaction of the application on the shell should be designed and implemented so that most of the features and bigger entry points should be accessible via one-liners on the shell - for example the testers should be able to lunch all the unit-tests via a single one line call. The integration tests should be triggerable via single oneline call. 

    

#### 3.1.1. Database recreation and DDL scripts run one-liners
The developers should be able to create the database via a single oneline call 

    

#### 3.1.2. Table(s) load via aa single one-liner
The developers should be able to load a table to the database via a single oneline call.

    

#### 3.1.3. Testing one-liner call
The testers and the developers should be able to trigger all the unit or integration tests via a single one-line call. 

    

#### 3.1.4. Test messages user
Each test should obey the following convention:
 - short message as descriptive within the context as possible - what is being tested
- a short technical example of the generated entry being tested ( for example a dynamic url )
- a uuid to search for from the Feature document what exactly is being tested within the context of the features description. 

    

## 4. RELIABILITY AND STABILITY


    

### 4.1. Zero tollerance towards crashing
Crashing in normally configured and operating environment must not be tolerated, as soon as any crash has occurred a bug must be registered and the bug set with the highest possible prio towards the features pipeline. 

    

### 4.2. Zero tollerance towards bugs
All bugs and inconsistencies must be dealt with top priority by passing new features implementation.  Should the average amount of bugs increase after a release a purely bug fixing release should follow.

    

### 4.3. Daily backups
Daily backups should be show-stopper for the normal operation of the application - that is if an instance is to be considered as normally operating , the daily backups of all instance project databases data and secrets should be performed automatically as indispensable part of the functioning of the application. 

    

### 4.4. Logging
The application should support configurable logging to STDOUT and STDERR for the following levels - debug, info, warn, trace. 

    

### 4.5. Full backup to the cloud in less than 5 minutes
A full backup of the software, configuration and data for the qto and/or another project database should be doable in less than 5 minutes. The backup should be easily searchable from the cloud as well. 

    

## 5. SCALABILITY
 

    

### 5.1. Feature scalability
The addition of new features should be as scalable as possible. 

    

### 5.2. Setup scalability
The creation of new instances of the application should be as easy as possible. 

    

### 5.3. Projects databases scalability
Each instance of the qto application must be able to connect to one or many project databases which DDL schemas matching the current api of the application.

    

## 6. PERFORMANCE


    

### 6.1. Page load maximum time
Each page of the application containing less than 2000 items MUST load for less than 0.3 seconds.
Any new feature which does not meet this requirement should be disregarded or implemented into a clone of the application with different name ( see the cloning / forking section bellow ). 

    

### 6.2. Login, logout
Every login and logout operation MUST complete in less than 0.3 seconds in modern network environments. 

    

## 7. MULTI-INSTANCE OPERABILITY AND DEPLOYABILITY


    

### 7.1. Environment type self-awareness
Each deployed and running instance of the qto must "know" its own environment type - dev, tst, qas or prd to comply with the multi-instance architecture on a single host. 

    

### 7.2. Cross running between instances of different types
The application layers should support as much as possible cross running between different application layer instances and database instances - for example a dev application layer should be able to fetch data from a prd database.

    

## 8. UI REQUIREMENTS


    

### 8.1. CRUDs
The System must provide the needed UI interfaces to Create , Update , Delete and Search items in the system for the users having the privileges for those actions
Any modelled item in the database must be capable for:
 - create 
 - update
 - delete
 - search

    

#### 8.1.1. Execution time
The full execution time of any crud operation ( create, update, delete, search) from the end-user of the UI point of view should be less than 0.3 seconds

    

#### 8.1.2. Visual indication
The System should not show the so called ok messages, but only error messages ( with added verbosity on the console level ), yet the UI should be as responsive that the end-user would easily understand when an item has been created, updated or deleted.

    

### 8.2. Clarity on errors
The UI must present every error in a clear and concise way, so that the end-user would understand that an error has occurred, however no msgs should be displayed when the data is saved properly. 

    

## 9. SECURITY
A well operated instance of the qto application should have security corresponding to the data sensitivity it is operating on. 


    

### 9.1. Authentication
There should be the following 4 modes of authentication: 



    

#### 9.1.1. Non-authentication mode
Any qto instance should support a non-authentication mode - that is all users having http and/or https access could perform all the actions on the UI without any restrictions, that is the customer organisation wanting own custom solution for authentication and authorisation should be able to run an instance with non-authorisation mode.

    

#### 9.1.2. Basic authentication mode ( to be deprecated )
An qto instance running under basic authentication mode should support single system user per project database authentication, which must have full access for the all the available actions via the web ui. 
It is worth noting that each qto instance having access to data resources should meet the requirements on organisation's level for data access - i.e. if instance dev has full access to the dev, tst, prd project databases there is no reason of having basic authentication on the prd instance having access to the same dev, tst, prd databases.

    

#### 9.1.3. Simple Native authentication ( experimental )
The application must match the passwords via blowfish encryption and store the authentication details into the session of default of 10h.
Users should login with email and password. Users' names and other personal data MUST NOT be tracked by the application. 
All registered users should have access to all but users related data. 
Unregistered users should have access to the login page only. 
If a user is not registered the error msg to the login should prompt him which e-mail to contact to be registered ( which will be the e-mail of the product owner instance ). 
All login error msgs should be clear and displayed with red colour. 
The regular users should see only their credentials. Only the admin user should see all the users credentials , but with the passwords encrypted.
If the admin user is able to impersonate another user it must simply mean that he/she has done that on purpose ( aka maliciously )
The sessions of different dev, tst and prod app layer instances should not intermix within the multiple open processes / threads of the same browser of the same user.


    

#### 9.1.4. JSON web token authentication
The qto application should support native web tokens based authentication, by using as login a valid user e-mail and password, stored in the qto instance database. 

The qto should support SSO authentication as described in the following RFC's. 
The Users should be authenticated by means of the most simplest OAauth2.0 authentication flow: 
https://tools.ietf.org/html/rfc6749#section-5.1

    

### 9.2. Authrorisation
The Qto application should have authorisation as described in the RFC 6749.

    

## 10. DOCUMENTATION


    

### 10.1. Documentation completeness
Each running instance MUST have the following documentation set :
 - End User Guide 
 - DevOps Guide doc
 - Requirements doc
 - System Guide doc
 - UserStories doc
 - Installation and Configuration Guide doc

in the following formats: 
 - native qto view-doc page format ( as soon as the instance is up-and-running )
 - md format - as soon as the source code is downloaded 


    

### 10.2. Documentation and code base synchronization
Each running instance MUST have its required documentation set up-to-date for it's release version. No undocumented or hidden features are allowed. Should any be missing or misreported a new issue must be created to correct those with top priority. 

    

#### 10.2.1. Requirements push
Whenever a project database meta-data is updated a new "do reload the current page" should be pushed on all the clients having currently session in the application …

    

## 11. WORKING PRINCIPLES


    

### 11.1. Personal responsibility
The whole design of the application as well as each system containing a running instance of it must support the principle for "personal responsibility" - aka for each error and / or faulty behaviour a concrete person must be available to whom the issue will be assigned. 

    

