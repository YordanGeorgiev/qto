#  FEATURES AND FUNCTIONALITIES 
* [1. INTRO](#1-intro)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
  * [1.3. RELATED DOCUMENTATION](#13-related-documentation)
  * [1.4. RELATED PROCESS AND WAY OF WORKING](#14-related-process-and-way-of-working)
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
    * [3.1.2. Testing one-liner call](#312-testing-one-liner-call)
  * [3.2. TABLES LOAD VIA A SINGLE ONE-LINER](#32-tables-load-via-a-single-one-liner)
    * [3.2.1. Test messages user](#321-test-messages-user)
* [4. STABILITY AND RELIABILITY](#4-stability-and-reliability)
  * [4.1. ABSENCE OF APPLICATION CRASHING](#41-absence-of-application-crashing)
  * [4.2. DAILY BACKUPS](#42-daily-backups)
  * [4.3. LOGGING](#43-logging)
  * [4.4. FULL BACKUP TO THE CLOUD IN LESS THAN 5 MINUTES](#44-full-backup-to-the-cloud-in-less-than-5-minutes)
  * [4.5. STABILITY BASED ON ACTUAL RUNNING IN THE CLOUD SINCE 2019-01-01](#45-stability-based-on-actual-running-in-the-cloud-since-2019-01-01)
* [5. SCALABILITY](#5-scalability)
  * [5.1. FEATURE SCALABILITY](#51-feature-scalability)
  * [5.2. MULTI-INSTANCE SCALABILITY](#52-multi-instance-scalability)
  * [5.3. DOCUMENTATION GENERATION AND DATA EXPORT](#53-documentation-generation-and-data-export)
  * [5.4. PROJECTS DATABASES SCALABILITY](#54-projects-databases-scalability)
* [6. PERFORMANCE](#6-performance)
  * [6.1. PAGE LOAD TIMES](#61-page-load-times)
    * [6.1.1. Page load times](#611-page-load-times)
    * [6.1.2. Server requirements for performance](#612-server-requirements-for-performance)
    * [6.1.3. Performance on mobile devices ](#613-performance-on-mobile-devices-)
    * [6.1.4. Loaded pages controls performance](#614-loaded-pages-controls-performance)
  * [6.2. AJAX CALLS TO BACK-END](#62-ajax-calls-to-back-end)
    * [6.2.1. Metadata caching via Redis](#621-metadata-caching-via-redis)
    * [6.2.2. Foreign Key data for Drop Down controls caching](#622-foreign-key-data-for-drop-down-controls-caching)
  * [6.3. LOGIN, LOGOUT](#63-login-logout)
  * [6.4. CRUDS OPERATIONS](#64-cruds-operations)
* [7. DEPLOYABILITY](#7-deployability)
  * [7.1. NEW HOSTS BINARY PROVISIONING](#71-new-hosts-binary-provisioning)
  * [7.2. ONELINER FOR VERSION CHANGE ON PROVISIONED HOST](#72-oneliner-for-version-change-on-provisioned-host)
  * [7.3. ONELINER FOR ENVIRONMENT CHANGE](#73-oneliner-for-environment-change)
* [8. WEB USER INTERFACE FEATURES AND FUNCTIONALITIES](#8-web-user-interface-features-and-functionalities)
  * [8.1. SINGLE CODE BASE FOR ALL DEVICE FORMATS](#81-single-code-base-for-all-device-formats)
  * [8.2. GLOBAL UI ELEMENTS FOR ALL THE PAGES](#82-global-ui-elements-for-all-the-pages)
    * [8.2.1. The global and quick search textbox - the omnibox](#821-the-global-and-quick-search-textbox--the-omnibox)
    * [8.2.2. The Left Menu](#822-the-left-menu)
  * [8.3. LIST PAGE FEATURES AND FUNCTIONALITIES](#83-list-page-features-and-functionalities)
    * [8.3.1. List page performance](#831-list-page-performance)
    * [8.3.2. Navigating the list page](#832-navigating-the-list-page)
    * [8.3.3. Filtering the result set from a single item](#833-filtering-the-result-set-from-a-single-item)
      * [8.3.3.1. Filtering the result with the "with" url parameter](#8331-filtering-the-result-with-the-"with"-url-parameter)
      * [8.3.3.2. Filtering the result with the "like-by" and "like-val" url parameters](#8332-filtering-the-result-with-the-"like-by"-and-"like-val"-url-parameters)
    * [8.3.4. Managing items - full CRUD](#834-managing-items--full-crud)
    * [8.3.5. Managing FK values](#835-managing-fk-values)
      * [8.3.5.1. CRUD via the smart grid](#8351-crud-via-the-smart-grid)
      * [8.3.5.2. CRUD via the generic edit form](#8352-crud-via-the-generic-edit-form)
    * [8.3.6. Quick search and filtering items](#836-quick-search-and-filtering-items)
    * [8.3.7. Global text search from the view page](#837-global-text-search-from-the-view-page)
      * [8.3.7.1. Visual indication for ok cases](#8371-visual-indication-for-ok-cases)
    * [8.3.8. Visual indication](#838-visual-indication)
      * [8.3.8.1. Visual indication when no data is received on correct request](#8381-visual-indication-when-no-data-is-received-on-correct-request)
      * [8.3.8.2. Visual indication on erroneous requests](#8382-visual-indication-on-erroneous-requests)
    * [8.3.9. Items interlinking](#839-items-interlinking)
    * [8.3.10. Print to pdf](#8310-print-to-pdf)
  * [8.4. VIEW PAGE FEATURES](#84-view-page-features)
    * [8.4.1. Viewing documents](#841-viewing-documents)
      * [8.4.1.1. OK load for a view doc page](#8411-ok-load-for-a-view-doc-page)
      * [8.4.1.2. NOK load for view doc page](#8412-nok-load-for-view-doc-page)
      * [8.4.1.3. NOK load for a view doc page](#8413-nok-load-for-a-view-doc-page)
    * [8.4.2.  Managing items ( beta )](#842--managing-items-(-beta-))
      * [8.4.2.1. Add an item in the doc view page UI ( beta)](#8421-add-an-item-in-the-doc-view-page-ui-(-beta))
      * [8.4.2.2. Update item ( gamma )](#8422-update-item-(-gamma-))
      * [8.4.2.3. Delete item ( gamma )](#8423-delete-item-(-gamma-))
    * [8.4.3. Printing view doc documents](#843-printing-view-doc-documents)
* [9. SECURITY](#9-security)
  * [9.1. AUTHENTICATION](#91-authentication)
    * [9.1.1. Non-athentication mode](#911-non-athentication-mode)
    * [9.1.2. Simple native authentication mode](#912-simple-native-authentication-mode)
  * [9.2. AUTHORISATION](#92-authorisation)
    * [9.2.1. Roles based access control list](#921-roles-based-access-control-list)
* [10. DOCUMENTATION](#10-documentation)
  * [10.1. DOCUMENTATION SET](#101-documentation-set)
  * [10.2. DOCUMENTATION FORMATS](#102-documentation-formats)
  * [10.3. DOCUMENTATION AND CODE BASE SYNCHRONIZATION](#103-documentation-and-code-base-synchronization)




    

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


All the documents are updated and redistributed in combination of the current version of the application and could be found under the following directories:
doc/md
doc/pdf
according to the file format used for the documentation storage.

    

### 1.4. Related process and way of working
Read this document carefully - it IS the contract between you AND the qto instance of your instance, such there be any inconsistencies between the promised features and functionalities in this document and the ACTUAL behaviour of your instance create an issue to the instance owner, describing clearly what the inconsistencies are.
If you are the instance owner, and the issue has clearly arisen from the source code of qto instance you derived your instance from create an issue to the source qto instance owner into his/her own qto instance.

    

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

    

#### 3.1.2. Testing one-liner call
The testers and the developers is able to trigger all the unit or integration tests via a single one-line call. 

    

### 3.2. Tables load via a single one-liner
The developers should be able to load one or many tables to the database via a single oneline call.

    

#### 3.2.1. Test messages user
Each test obeys the following convention:
 - short message as descriptive within the context as possible - what is being tested
- a short technical example of the generated entry being tested ( for example a dynamic url )
- a uuid to search for from the Feature document what exactly is being tested within the context of the features description. 

    

## 4. STABILITY AND RELIABILITY


    

### 4.1. Absence of application crashing
Qto is a vertically integrated application - from the OS till the client side libraries, which has been designed from the ground up to have stable architecture component wise and to rely on the best frameworks (Mojolicious, VueJS), libraries and tools out there, without creating too much interdependencies, thus the qto crashes experienced during the last years of operation have been extremely rare.

    

### 4.2. Daily backups
Daily backups are taken after the first shell action, run for the day, the daily backups oneliner could be scheduled via crontab as well. 

    

### 4.3. Logging
The application supports fully configurable audit logging to both console ( STDOUT, STDERR ) and file.

    

### 4.4. Full backup to the cloud in less than 5 minutes
A full backup for the data for the qto and/or another project database is doable in less than 5 minutes. 

    

### 4.5. Stability based on actual running in the cloud since 2019-01-01
The main qto application instance has been up-and-running since the beginning of 2019 with receiving new versions in an average of 2 weeks per sprint.

    

## 5. SCALABILITY


    

### 5.1. Feature scalability
The addition of new features is scalable, as almost all of the components have been implemented according to the SOLID principle. 

    

### 5.2. Multi-instance scalability
You can operated multiple versions of the qto on the same host, which will not interrupt each other because of the configurability of the application.

    

### 5.3. Documentation generation and data export
Single shell actions exist for : 
 - configurable pdf documentation generation
 - configurable mdf documentation generation
 - configurable microsoft docx documentation generation
 - configurable xls tables export

    

### 5.4. Projects databases scalability
Each instance of the qto application can connect via tcp to multiple postgres databases running on the same db host configured in the instance configuration file. 

    

## 6. PERFORMANCE


    

### 6.1. Page load times
Although the qto has not been explicitly designed for mobile devices the page load times on higher end phones on 4G networks are comparable with the upper 20% of the pages in the web, while running both the application layer and the db on a single aws instance based in Ireland ...

    

#### 6.1.1. Page load times
The qto has been operated on quite modest hardware ( check the second cheapest amazon ec2 instances for reference ), yet the page load times vary from 0.3 till 0.6 seconds for the smaller pages and up till 1.5 seconds for the pages having more than 2000 items ...
List pages with 7-10 items load in 0.3-0.35 seconds.
View Pages with one image and less than 7 pages load in 0.3-0.45 seconds, View pages with 20 pages might take up till 0.8 seconds to load.

    

#### 6.1.2. Server requirements for performance
The qto has been operated on quite modest hardware ( check the second cheapest amazon ec2 instances for reference ), yet the performance of the application has been amazingly good, considered that both the application server and the databases are deployed on the ec2 instance.

    

#### 6.1.3. Performance on mobile devices 
Qto is NOT explicitly optimised for mobile use ( how old fashioned is that ?!), yet it has been from the ground-up designed in way allowing this optimisation to occur at a later point of time of the development of the application. 

    

#### 6.1.4. Loaded pages controls performance
Once a page is loaded, more than 99% of the time the controls response quickly and effortlessly on different keyboard or mouse events.

    

### 6.2. Ajax calls to back-end
Each back-end update from the UI takes no longer than 0.2 s. in a non-stressed qto instance, thus the look and feel of an qto instance is more like a desktop app and less like web app.

    

#### 6.2.1. Metadata caching via Redis
All the meta data of the application during each request is fetched from Redis ( and can be re-load into Redis by loading the meta_tables or the meta_columns item in the browser)

    

#### 6.2.2. Foreign Key data for Drop Down controls caching
The drop down controls which fetch the human readable data with the foreign keys of a normalised item table is cached to the localStorage. The localStorage is cleared once the users access the login page. 
Thus a qto DevOps engineer could both easily modilfy the data for the dropdowns ( for example different statuses and their codes without having to restart the whole application layer), but the users get a faster and non-blinking list page loads once they have loaded the list page with the specific cached dropdowns data once.

    

### 6.3. Login, Logout
Every login and logout operation completes in less than 0.3 seconds in modern network environments.

    

### 6.4. CRUDs operations
The Create, Update, Delete and Search operations with their respective roundtrips are 99% of the times extremely fast - less than 0.1.

    

## 7. DEPLOYABILITY


    

### 7.1. New hosts binary provisioning
You can spawn new instances in the cloud from a client having the src code and needed terraform binary 

    

### 7.2. Oneliner for version change on provisioned host
You could create a new instance of the qto having different version ( which becomes automatically a dev environment ) by issuing the following command: 

    bash src/bash/qto/qto.sh -a to-ver=0.8.2

### 7.3. Oneliner for environment change
You could change the environment type of your current instance by issuing the following command:

    bash src/bash/qto/qto.sh -a to-env=tst

## 8. WEB USER INTERFACE FEATURES AND FUNCTIONALITIES


    

### 8.1. Single code base for all device formats
Although qto has not been explicitly designed for mobile phones and / or tablets it renders well on both high end mobile phones, and tablets over 4G networks. 

    

### 8.2. Global UI elements for all the pages
The global UI elements are accessible from each page

    

#### 8.2.1. The global and quick search textbox - the omnibox
The users can quick filter the content of any page - lists ( including the drop downs chosen values), reports and view docs by just typing strings to filter by in the omnibox in the top bar WITHOUT hitting enter or clicking on the search button. 
After hitting enter or clicking on the search button the application performs global search from the project database and redirects to the search page with the actual result set from the search. Most of the pages are done so that hitting the back button on the browser goes directly to the previous view.
A global keyboard shortcut - the "/" forward slash can be used to focus the omnibox from any non editable control on the page.

    

#### 8.2.2. The Left Menu
The left menu is accessible from all the pages. The users can navigate from a folders tree like structure from the left menu to different pages in the application.
The left menu contains information on the current instance of the application and a logout button, which clears out the user session data ( both session and local storage data).

    

### 8.3. List page features and functionalities
The list page is simply a slice of the data from ANY postgres table filtered on any criteria defined in the url of the browser.

    

#### 8.3.1. List page performance
The full execution time of any crud operation ( create, update, delete, search) from the end-user of the UI point of view is less than 0.5 seconds usually right around 0.4 s for faster servers.
Dropdown controls' data is cached in the browsers' local storage thus ones a page is accessed during an user session ( as the storage is cleared during login ), the next retrieval of their data is about 0.90-0.12 seconds faster - and their rendering is not actually noticeable.

    

#### 8.3.2. Navigating the list page
After the load of the list page the user can quickly cycle trough all the element of the page with the tab key on the keyboard. Focus on the search 

    

#### 8.3.3. Filtering the result set from a single item
The qto list page uses a SQL like syntax to translate the url parameters of the list page 

    

##### 8.3.3.1. Filtering the result with the "with" url parameter
The naming conventions is as follows: 
with=&lt;&lt;attribute-name&gt;&gt;-&lt;&lt;operator&gt;&gt;-&lt;&lt;value&gt;

For example:
https://qto.fi:442/qto/list/ideas?&with=owner-eq-jrs

This translates into "where &lt;&lt;attribute-name&gt;&gt; = '&lt;&lt;attribute-value&gt;&gt;' in the sql query to the database.

    

##### 8.3.3.2. Filtering the result with the "like-by" and "like-val" url parameters
The naming conventions is as follows: 
with=&lt;&lt;attribute-name&gt;&gt;-&lt;&lt;operator&gt;&gt;-&lt;&lt;value&gt;

For example:
https://qto.fi:442/qto/list/ideas?&with=owner-eq-jrs

    

#### 8.3.4. Managing items - full CRUD
The System provides the needed UI interfaces to Create , Update , Delete and Search items in the database. DateDate values could be presented with calendar controls.

    

#### 8.3.5. Managing FK values
The Foreign key values could be managed via drop box ui controls. For now the fetch is performed on the "name" attribute from the PK table, based on &lt;&lt;pk_table&gt;&gt;_guid naming convention in the FK column of the items.

    

##### 8.3.5.1. CRUD via the smart grid
The Create, Update, Delete operations could be performed by simply typing the new values in the smart grid - or picking the values for the drop downs or the calendar controls.

    

##### 8.3.5.2. CRUD via the generic edit form
The Create, Update, Delete operations could be performed by clicking in the edit button of the smart grid and editing the text in the modal dialog form.

    

#### 8.3.6. Quick search and filtering items
The user can quickly filter the items from the presented listing by typing in the omnisearch box ... The System will shrink the table so that only the rows having the string in the search omnibox will be presented. Once the string is deleted from the search omnibox the table data is restored to its original state.

    

#### 8.3.7. Global text search from the view page
The user can initiate a global text search from the view page, by simply typing on the global search text box and hitting enter or clicking on the global search button. Should the search yield results they will be displayed in the search page, thus the user could quickly return back in the exact same spot of the document by clicking the back button.

    

##### 8.3.7.1. Visual indication for ok cases
In the ok cases no msgs are presented, but just the requested data shown.

    

#### 8.3.8. Visual indication
The Systems does not present any ok messages for the operation of the list page, only errors are presented clearly on the top of the page ( for example when one tries to update a string value into a cell with column accepting only integer values ... )

    

##### 8.3.8.1. Visual indication when no data is received on correct request
Should the request in terms of url parameters be correct a warning msg at the bottom of the page in grey colour is presented

    

##### 8.3.8.2. Visual indication on erroneous requests
Should the request be erroneous - un existing, tables , columns , ds , wrong syntax etc. an error of the top of the page is presented and the full technical error is displayed at the bottom of the page. 

    

#### 8.3.9. Items interlinking
The users can link to any items by simply typing &lt;&lt;item&gt;&gt;-&lt;&lt;id&gt;&gt; in the description. For example requirements_doc-4

    

#### 8.3.10. Print to pdf
You can print any of the queries from the list page by adding / changing the as url parameter from as=grid to as=print-table. Use the browser print to pdf feature to save the listing page into a pdf file.

    

### 8.4. View page features


    

#### 8.4.1. Viewing documents
The "view doc" page presents a single "doc" table from any qto db instance having the nested set api in it. The nested set api means simply that the table has the additional attributes needed for the data to be presented in hierarchical format aka the view doc format, which is the format of this type of document you are reading right now.

    

##### 8.4.1.1. OK load for a view doc page
Should a proper url format by requested from the browser a simple view doc page is presented with no msgs - the left menu will present the meta data of the project menu and the right menu will present the structure of the document.

    

##### 8.4.1.2. NOK load for view doc page
Should the user request an un existing view doc page and error snackbar pop-up message appears on the top of the page. The error message can be pinned for easier copy paste or snapshot taking

    

##### 8.4.1.3. NOK load for a view doc page
Should the browser request a non-existing table or erroneous url parameters from the application layer the system will present the error in a snackbar at the top of the page. The snackbar can be freezed by clicking on the top right corner of it. 

    

#### 8.4.2.  Managing items ( beta )
The Qto application provides the needed UI interfaces to Create , Update , Delete items in the view documents UI for the users having the privileges for those actions.
This feature in in beta mode as it certain rare cases it might not work as expected ( and those are recognised as separate issues and being worked out ). The easiest way to work around in case of a bug is found is to reload the whole page.

    

##### 8.4.2.1. Add an item in the doc view page UI ( beta)
Users with the write privileges for the document can add an item in the doc view page just by right clicking on the title and selecting one of the 3 options:
 - add sibling node - add an item which is on the same level in the hierarchy 
 - add parent node - add an item which is on 1 level up in the hierarchy
 - add child node - add and item which is on 1 level bellow in the hierarchy
The new item appears straight after the origin title it was requested from.
This feature in in beta mode as it certain rare cases it might not work as expected ( and those are recognised as separate issues and being worked out ). The easiest way to work around in case of a bug is found is to reload the whole page.

    

##### 8.4.2.2. Update item ( gamma )
You can:
- update item title content
- update item description
- update item src code if visible ( you can make it visible by adding any non space content to it in the list page by right clicking the item number and choosing open in list )
This feature in in gamma mode as it certain rare cases it might not work as expected ( and those are recognised as separate issues and being worked out ). The easiest way to work around in case of a bug is found is to reload the whole page.

    

##### 8.4.2.3. Delete item ( gamma )
You can right click on an item and choose the remove node from the right click men.
This feature in in gamma mode as it certain rare cases it might not work as expected ( and those are recognised as separate issues and being worked out ). The easiest way to work around in case of a bug is found is to reload the whole page.

    

#### 8.4.3. Printing view doc documents
You can print ANY branch including the whole documents by right clicking the branch or node and choosing "print-preview" and than use the browser's print functionality.

    

## 9. SECURITY


    

### 9.1. Authentication
The qto application supports the following 2 modes of security: 
 - non authentication mode
 - simple native authentication mode 

    

#### 9.1.1. Non-athentication mode
Any qto instance supports a non-authentication mode - that is all users having http access could perform all the actions on the UI without restrictions

    

#### 9.1.2. Simple native authentication mode
A qto instance running under the simple native authentication mode stores the user credentials in the instance db. The passwords are encrypted via the using the Blowfish-based Unix crypt() hash function, known as "bcrypt" encrypting mechanism. 

    

### 9.2. Authorisation
Only the SysAdmin of the System can add basic authentication and simple native mode users, thus regular users can see only their own credentials.

    

#### 9.2.1. Roles based access control list
The qto application has a centralised roles based access control list accessible from the following url: 
&lt;&lt;proj-db&gt;&gt;/list/items_roles_permissions. 
This list will define who ( which roles ) , can or cannot do what and why - the description field. The actual application of this Access Control List has NOT been yet implemented ...

    

## 10. DOCUMENTATION


    

### 10.1. Documentation set
Each running instance has the following documentation set :
 - ReadMe
 - Features and Functionalities doc
 - End User Guide
 - DevOps Guide
 - SystemGuide
 - UserStories document
 - Installation and Configuration Guide
In both "native qto format" and md file format in the doc/md directory of the project.

    

### 10.2. Documentation formats
The qto documentation is available in both md and pdf formats. 

    

### 10.3. Documentation and code base synchronization
Each running instance has it's required documentation set up-to-date. No undocumented or hidden features are allowed. Should any be missing or misreported a new issue must be created to correct those with top priority. 

    

