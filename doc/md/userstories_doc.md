#  USERSTORIES AND SCENARIOS
* [1. COMMON UI PERSPECTIVE](#1-common-ui-perspective)
  * [1.1. UI PERFORMANCE](#11-ui-performance)
  * [1.2. THE LIST PAGE UI](#12-the-list-page-ui)
    * [1.2.1. Items listing](#121-items-listing)
    * [1.2.2. Items editing](#122-items-editing)
    * [1.2.3. Items creation](#123-items-creation)
    * [1.2.4. Items deletion](#124-items-deletion)
    * [1.2.5. Items export](#125-items-export)
    * [1.2.6. Items import](#126-items-import)
  * [1.3. THE VIEW PAGE UI](#13-the-view-page-ui)
    * [1.3.1. hierarchical items management](#131-hierarchical-items-management)
      * [1.3.1.1. Add Item](#1311-add-item)
      * [1.3.1.2. Update item](#1312-update-item)
          * [1.3.1.2.1. Update item's title](#13121-update-item's-title)
          * [1.3.1.2.2. Update item's description](#13122-update-item's-description)
          * [1.3.1.2.3. Update item's src_code](#13123-update-item's-src_code)
      * [1.3.1.3. Delete item](#1313-delete-item)
    * [1.3.2. Right menu navigation](#132-right-menu-navigation)
      * [1.3.2.1. Open close of right menu](#1321-open-close-of-right-menu)
      * [1.3.2.2. Search in the right menu](#1322-search-in-the-right-menu)
      * [1.3.2.3. Links in the right menu](#1323-links-in-the-right-menu)
    * [1.3.3. Left menu navigation](#133-left-menu-navigation)
  * [1.4. SEARCH](#14-search)
  * [1.5. LOBAL SEARCH MODAL DIALOG UI](#15-lobal-search-modal-dialog-ui)
  * [1.6. SEARCH-AUTOCOMPLETE ON MODAL SEARCH DIALOG](#16-search-autocomplete-on-modal-search-dialog)
  * [1.7. ITEMS MOVE](#17-items-move)
  * [1.8. MOBILE UI](#18-mobile-ui)
  * [1.9. UI FOR ACCESSING DIFFERENT PROJECTS](#19-ui-for-accessing-different-projects)
  * [1.10. UI FOR TIME MANAGEMENT IN GOOGLE CALENDAR](#110-ui-for-time-management-in-google-calendar)
  * [1.11. ITEMS DATA TRANSFER BETWEEN DIFFERENT PROJECTS](#111-items-data-transfer-between-different-projects)
  * [1.12. ISSUES IMPORT FROM GOOGLE CALENDAR](#112-issues-import-from-google-calendar)
  * [1.13. ACCESS ISSUES TXT FORMAT FROM EMAIL](#113-access-issues-txt-format-from-email)
  * [1.14. ACCESS ISSUES DATA FROM GOOGLE SHEET](#114-access-issues-data-from-google-sheet)
  * [1.15. THE NOTES PAGE](#115-the-notes-page)
  * [1.16. CHAT ](#116-chat-)
* [2. TEAM LEADER BIZ PERSPECTIVE](#2-team-leader-biz-perspective)
  * [2.1. ROLES MANAGEMENT](#21-roles-management)
  * [2.2. PROJECTS MANAGEMENT](#22-projects-management)
    * [2.2.1. Add new users to a project](#221-add-new-users-to-a-project)
  * [2.3. TIME MANAGEMENT](#23-time-management)
    * [2.3.1. Update existing users in a project](#231-update-existing-users-in-a-project)
    * [2.3.2. Delete existing users from a project](#232-delete-existing-users-from-a-project)
    * [2.3.3. Search for users in a project](#233-search-for-users-in-a-project)
    * [2.3.4. Users access management](#234-users-access-management)
      * [2.3.4.1. Grant access per project](#2341-grant-access-per-project)
      * [2.3.4.2. Personal data handling minimization](#2342-personal-data-handling-minimization)
  * [2.4. SECURITY MANAGEMENT](#24-security-management)
* [3. TEAM MEMBER BIZ PERSPECTIVE](#3-team-member-biz-perspective)
  * [3.1. ISSUES MANAGEMENT](#31-issues-management)
    * [3.1.1. Create new issues](#311-create-new-issues)
    * [3.1.2. Update existing issues](#312-update-existing-issues)
    * [3.1.3. Remove existing issues](#313-remove-existing-issues)
    * [3.1.4. Search for existing issues](#314-search-for-existing-issues)
    * [3.1.5. Track issues progress](#315-track-issues-progress)
    * [3.1.6. Track issues history](#316-track-issues-history)
  * [3.2. ITEMS MANAGEMENT](#32-items-management)
* [4. TEAM MEMBER BIZ PERSPECTIVE](#4-team-member-biz-perspective)
  * [4.1. ISSUES MANAGEMENT](#41-issues-management)
    * [4.1.1. Update existing Items](#411-update-existing-items)
    * [4.1.2. Remove existing Items](#412-remove-existing-items)
    * [4.1.3. Search for existing Items](#413-search-for-existing-items)
    * [4.1.4. Track Items progress](#414-track-items-progress)
    * [4.1.5. Track Items history](#415-track-items-history)
  * [4.2. TRACK ISSUES RELATIONS](#42-track-issues-relations)
    * [4.2.1. Generic search for items from a single entity ( table ) ](#421-generic-search-for-items-from-a-single-entity-(-table-)-)
  * [4.3. ITEMS MANAGEMENT](#43-items-management)
    * [4.3.1. Generic list for the searched items from a single entity ( table ) ](#431-generic-list-for-the-searched-items-from-a-single-entity-(-table-)-)
      * [4.3.1.1. Generic cloud list for the searched items from a single entity ( table ) ](#4311-generic-cloud-list-for-the-searched-items-from-a-single-entity-(-table-)-)
    * [4.3.2. Generic create capability from UI for new items from a single entity ( table ) ](#432-generic-create-capability-from-ui-for-new-items-from-a-single-entity-(-table-)-)
    * [4.3.3. Generic edit capability from UI for existing items from a single entity ( table ) ](#433-generic-edit-capability-from-ui-for-existing-items-from-a-single-entity-(-table-)-)
    * [4.3.4. Generic delete capability from UI for existing items from a single entity ( table ) ](#434-generic-delete-capability-from-ui-for-existing-items-from-a-single-entity-(-table-)-)
  * [4.4. MEASURE SUCCESS](#44-measure-success)
  * [4.5. MONITOR SUCCESS](#45-monitor-success)
  * [4.6. TRACK ISSUES RELATIONS](#46-track-issues-relations)
  * [4.7. TIME MANAGEMENT](#47-time-management)
    * [4.7.1. time centric planning](#471-time-centric-planning)
    * [4.7.2. time centric reporting](#472-time-centric-reporting)
  * [4.8. GENERIC CRUDS FOR ITEMS](#48-generic-cruds-for-items)
  * [4.9. PROJECT'S PERSONS ISSUE COMBINATIONS](#49-project's-persons-issue-combinations)
* [5. PROJECT OBSERVER BIZ PERSPECTIVE](#5-project-observer-biz-perspective)
  * [5.1. PROJECTS OBSERVATION](#51-projects-observation)
  * [5.2. MEASURE SUCCESS](#52-measure-success)
  * [5.3. ISSUES OBSERVATION](#53-issues-observation)
  * [5.4. MONITOR SUCCESS](#54-monitor-success)
* [6. SYSADMIN PERSPECTIVE](#6-sysadmin-perspective)
  * [6.1. TIME MANAGEMENT](#61-time-management)
  * [6.2. SYSTEM DEPLOYABILITY](#62-system-deployability)
  * [6.3. SYSTEM PERFORMANCE](#63-system-performance)
  * [6.4. SYSTEM STABILITY](#64-system-stability)
  * [6.5. GENERIC CRUDS FOR ITEMS](#65-generic-cruds-for-items)
  * [6.6. SYSTEM RELIABILITY](#66-system-reliability)
  * [6.7. PROJECT'S PERSONS ISSUE COMBINATIONS](#67-project's-persons-issue-combinations)
  * [6.8. EASE OF USE](#68-ease-of-use)
* [7. PROJECT OBSERVER BIZ PERSPECTIVE](#7-project-observer-biz-perspective)
  * [7.1. SECURITY](#71-security)
  * [7.2. PROJECTS OBSERVATION](#72-projects-observation)
    * [7.2.1. Who logged in and out when](#721-who-logged-in-and-out-when)
  * [7.3. ISSUES OBSERVATION](#73-issues-observation)
    * [7.3.1. Who changed what and why](#731-who-changed-what-and-why)
* [8. SYSADMIN PERSPECTIVE](#8-sysadmin-perspective)
* [9. ETL AND INTEGRATIONS PERSPECTIVE](#9-etl-and-integrations-perspective)
  * [9.1. SYSTEM DEPLOYABILITY](#91-system-deployability)
  * [9.2. DATABASE TO JSON FILES DATA LOAD](#92-database-to-json-files-data-load)
  * [9.3. SYSTEM PERFORMANCE](#93-system-performance)
  * [9.4. JSON FILES TO DB DATA LOAD](#94-json-files-to-db-data-load)
  * [9.5. SYSTEM STABILITY](#95-system-stability)
  * [9.6. XLS-TO-MYSQL-DB HIERARCHICAL DATA LOAD](#96-xls-to-mysql-db-hierarchical-data-load)
  * [9.7. SYSTEM RELIABILITY](#97-system-reliability)
  * [9.8. XLS-TO-POSTGRES-DB HIERARCHICAL DATA LOAD](#98-xls-to-postgres-db-hierarchical-data-load)
  * [9.9. EASE OF USE](#99-ease-of-use)
    * [9.9.1. error reporting in xls-to-postgres-db hierarchical data load ](#991-error-reporting-in-xls-to-postgres-db-hierarchical-data-load-)
  * [9.10. SECURITY](#910-security)
* [10. DEVOPS PERSPECTIVE](#10-devops-perspective)
  * [10.1. PROJECT DEPLOYMENT](#101-project-deployment)
  * [10.2. SYSTEM VERIFIABILITY AND TESTABILITY](#102-system-verifiability-and-testability)
* [11. ETL AND INTEGRATIONS PERSPECTIVE](#11-etl-and-integrations-perspective)
  * [11.1. CLARITY AND BREVITY OF THE END TO END TESTS](#111-clarity-and-brevity-of-the-end-to-end-tests)
  * [11.2. DATABASES - LOCAL TO REMOTE AND REMOTE TO LOCAL SYNC](#112-databases--local-to-remote-and-remote-to-local-sync)
    * [11.2.1. Abort end-to-end tests on single test fail](#1121-abort-end-to-end-tests-on-single-test-fail)
  * [11.3. DATABASE TO JSON FILES DATA LOAD](#113-database-to-json-files-data-load)
  * [11.4. LOGGING](#114-logging)
  * [11.5. JSON FILES TO DB DATA LOAD](#115-json-files-to-db-data-load)
    * [11.5.1. Control flow logging](#1151-control-flow-logging)
  * [11.6. XLS-TO-MYSQL-DB HIERARCHICAL DATA LOAD](#116-xls-to-mysql-db-hierarchical-data-load)
    * [11.6.1. Log entries format configuration](#1161-log-entries-format-configuration)
  * [11.7. XLS-TO-POSTGRES-DB HIERARCHICAL DATA LOAD](#117-xls-to-postgres-db-hierarchical-data-load)
    * [11.7.1. Single entry point for end to end tests](#1171-single-entry-point-for-end-to-end-tests)
    * [11.7.2. Tool run log to human readable description](#1172-tool-run-log-to-human-readable-description)
* [12. DEVOPS PERSPECTIVE](#12-devops-perspective)
  * [12.1. APPLICATION'S SOURCE CODE AND DOCUMENTATION INTEGRITY](#121-application's-source-code-and-documentation-integrity)
  * [12.2. SYSTEM DEPLOYMENT](#122-system-deployment)
    * [12.2.1. Userstories to test case relations](#1221-userstories-to-test-case-relations)
    * [12.2.2. UUID trackability for test files and userstories](#1222-uuid-trackability-for-test-files-and-userstories)
  * [12.3. SYSTEM VERIFIABILITY AND TESTABILITY](#123-system-verifiability-and-testability)
    * [12.3.1. Components start run message print](#1231-components-start-run-message-print)
    * [12.3.2. Tool exit with exit code and exit message](#1232-tool-exit-with-exit-code-and-exit-message)
    * [12.3.3. Execution path tracing by UUID's](#1233-execution-path-tracing-by-uuid's)
  * [12.4. LOGGING](#124-logging)
    * [12.4.1. Issues directories naming conventions](#1241-issues-directories-naming-conventions)
    * [12.4.2. Issues files naming conventions](#1242-issues-files-naming-conventions)
    * [12.4.3. Issues file open](#1243-issues-file-open)
    * [12.4.4. Issues files history](#1244-issues-files-history)
    * [12.4.5. Issues files naming conventions](#1245-issues-files-naming-conventions)
  * [12.5. APPLICATION'S SOURCE CODE AND DOCUMENTATION INTEGRITY](#125-application's-source-code-and-documentation-integrity)
    * [12.5.1. Issues files naming conventions for the  project](#1251-issues-files-naming-conventions-for-the-project)
  * [12.6. CONFIGURATION MANAGEMENT](#126-configuration-management)
    * [12.6.1. a single route to copy paste the appConfig in json format](#1261-a-single-route-to-copy-paste-the-appconfig-in-json-format)
    * [12.6.2. Issues files naming conventions for current date](#1262-issues-files-naming-conventions-for-current-date)
    * [12.6.3. Issues files naming conventions for current date](#1263-issues-files-naming-conventions-for-current-date)
    * [12.6.4. Issues files naming conventions for the time frame](#1264-issues-files-naming-conventions-for-the-time-frame)
  * [12.7. ISSUES TRANSFORMATIONS](#127-issues-transformations)
    * [12.7.1. 
Load by txt-to-db action](#1271-
load-by-txt-to-db-action)
      * [12.7.1.1. Load issues file from file system to db](#12711-load-issues-file-from-file-system-to-db)
    * [12.7.2. Load issues by db-to-xls action](#1272-load-issues-by-db-to-xls-action)
    * [12.7.3. Load issues by xls-to-db action](#1273-load-issues-by-xls-to-db-action)
      * [12.7.3.1. Load issues by xls-to-db action for insert or upset](#12731-load-issues-by-xls-to-db-action-for-insert-or-upset)
      * [12.7.3.2. Load issues by xls-to-db action by truncating or not the loadable table](#12732-load-issues-by-xls-to-db-action-by-truncating-or-not-the-loadable-table)
    * [12.7.4. Load issues by db-to-txt](#1274-load-issues-by-db-to-txt)
      * [12.7.4.1. xls-to-db action load sort by issues prio attribute](#12741-xls-to-db-action-load-sort-by-issues-prio-attribute)
      * [12.7.4.2. db-to-txt action load sort by issues start_time attribute](#12742-db-to-txt-action-load-sort-by-issues-start_time-attribute)
      * [12.7.4.3. db-to-txt action load sort by issues start_time attribute](#12743-db-to-txt-action-load-sort-by-issues-start_time-attribute)
    * [12.7.5. Load issues file from db to file system](#1275-load-issues-file-from-db-to-file-system)
  * [12.8. ISSUES FILE FILTERING](#128-issues-file-filtering)
  * [12.9. SINGLE SHELL CALL FOR PROJECTS SWITCHING](#129-single-shell-call-for-projects-switching)
  * [12.10. ISSUES PUBLISHING FROM SHELL CALLS](#1210-issues-publishing-from-shell-calls)
    * [12.10.1. Issues publishing in e-mail format](#12101-issues-publishing-in-e-mail-format)
    * [12.10.2. Issues handling in google sheet format](#12102-issues-handling-in-google-sheet-format)
    * [12.10.3. Issues publishing in google calendar format](#12103-issues-publishing-in-google-calendar-format)
  * [12.11. METADATA HANDLING](#1211-metadata-handling)
  * [12.12. ISSUES TRANSFORMATIONS](#1212-issues-transformations)
* [13. UI DEVELOPER PERSPECTIVE](#13-ui-developer-perspective)
  * [13.1. EASY SETUP FOR TESTABILITY](#131-easy-setup-for-testability)
  * [13.2. CODE TRACEABILITY BY UUID](#132-code-traceability-by-uuid)
  * [13.3. SINGLE SHELL CALL FOR PROJECTS SWITCHING](#133-single-shell-call-for-projects-switching)
  * [13.4. ISSUES PUBLISHING FROM SHELL CALLS](#134-issues-publishing-from-shell-calls)
  * [13.5. METADATA HANDLING](#135-metadata-handling)
* [14. UI DEVELOPER PERSPECTIVE](#14-ui-developer-perspective)
  * [14.1. EASY SETUP FOR TESTABILITY](#141-easy-setup-for-testability)




    

## 1. COMMON UI PERSPECTIVE
As an UI user of the qto application 
In order to manage my issues via the UI successfully  
I want to have a nice user experience while using the qto application.

    

### 1.1. UI Performance
As an UI user of the qto application 
In order to enjoy the usage of the tool and interact efficiently   
I wan to to  have responsive and quick UI.

    

### 1.2. The list page UI
As an UI user of the qto application 
in order to be able to efficiently process relational data for any project 
I want to be able to list all or part of the project's database table via a single UI

    

#### 1.2.1. Items listing
As an qto ui user 
In order to be able to quickly see as much items ( issues, problems, ideas etc. ) 
I want to list the items in a web page according to the filtering criteria I might have specified earlier on … 

    

#### 1.2.2. Items editing
As an UI user of the qto application 
In order to update the application data via the UI 
I wan to to be able to edit the data for ANY of the items in the application I have access to. 

    

#### 1.2.3. Items creation
As an UI user of the application 
I order to create new items in the application 
I want to be able to create them via the UI 
by clicking "create new button" and filling as few as possible data entries and clicking a Save button for ANY of the items in the application. 

    

#### 1.2.4. Items deletion
As an UI user of the application 
I order to delete existing items in the project
I want to  be able to delete them via the UI 
by clicking a "delete " button and confirming the deletion for the item

    

#### 1.2.5. Items export
As an UI user of the application 
I order to export the data  of the items in the application 
I want to be able to perform every possible export in the UI from a single button click or a single url access. 

    

#### 1.2.6. Items import
As an UI user of the application 
I order to import data  of the items in the application 
I want to  be able to perform every possible import in the UI from a single button click and pointing to the file path of a file

    

### 1.3. The view page UI
As an UI user of the qto application 
in order to be able to efficiently process hierarchical relational data for any project 
I want to be able to list all or part of the project's database table via a single UI

    

#### 1.3.1. hierarchical items management
As an the ui user
In order to manage the hierarchical items in the application
I want to be able to manage by actions (list, create, update, delete, search) ANY hierarchical items of the application in from a hierarchical doc format by simply right clicking on their titles and choosing from the menut the action which must have both image and text to indicate more 

    

##### 1.3.1.1. Add Item
I want to be able to add items to the view page by simply right clicking the upper title of the item and selecting add item

    

##### 1.3.1.2. Update item
I want to be able to update items data to the view page

    

###### 1.3.1.2.1. Update item's title
I want to be able to update item's title by simply clicking in it and starting to type the new contents ...

    

###### 1.3.1.2.2. Update item's description
I want to be able to update item's descrption by simply clicking in it and starting to type the new contents ...

    

###### 1.3.1.2.3. Update item's src_code
I want to be able to update item's src_code by simply clicking in it and starting to type the new contents ...

    

##### 1.3.1.3. Delete item
I want to be able to delete an item by right clicking it's title and choosing delete item.

    

#### 1.3.2. Right menu navigation
As an the ui user
In order to navigate quickly in the document structure
I want to be able to see the document structure by clicking a right menu 


    

##### 1.3.2.1. Open close of right menu
As an the ui user
In order to navigate quickly in the document structure
I want to be able to open and close the right menu quickly from both it's top and the bottom

    

##### 1.3.2.2. Search in the right menu
As an the ui user
In order to navigate quickly in the document structure
I want to be able filter quickly the right menu items by the means of right menu quick srch/filtering box which will filter the items containing the string I am typing for dynamically

    

##### 1.3.2.3. Links in the right menu
As an the ui user
In order to navigate quickly in the document structure by levels
I want to be able to simply click on the links ( level 1 , level-2 , level-3 etc. ) which will open the document

    

#### 1.3.3. Left menu navigation
As a QTO application UI user
In order to be able to quickly jump to a different document / listing 
I want to be able to click on the uppler left corner of the view page and access the hierarchichal project sturecture of the whole project from the left menu 

    

### 1.4. Search
As an qto ui user 
In order to be able to search ANY items ( issues, problems, ideas etc. ) 
I want to have a pop-up search SearchBox with dimmed background providing with interactive autocomplete, which would assist me in specifying the search criteria for any item I want to list. 

    

### 1.5. lobal search modal dialog ui
As an UI user 
In order to have the best possible search experience
I want to be able to search from a modal dialog UI which will pop-up on a dimmed background after the search-box is focused .. 

    

### 1.6. search-autocomplete on modal search dialog
As an UI user 
In order to get quickly to exactly the searched item I am searching for
I want the System to present me with autocomplete of the mostly occurring string I am searching for with the name of the item on the left and when clicking on it I want it to open the list as grid page with all the items having this item in the search ... 

    

### 1.7. Items move
As an UI user of the application 
I order to move the items into different tables
I want to  be able to move them from a button in the listing page by specifying the target table

    

### 1.8. Mobile UI
As an UI user of the qto application 
In order to enjoy to be able to access it quickly on the go
I want to  be able to use the same UI on an advanced mobile phones. 

    

### 1.9. UI for accessing different projects
As an qto ui user 
In order to be able to quickly switch between projects of the qto application instance I have access to
I want to  be able to access a web page providing autocomplete to preloaded configuration entries for the different projects

    

### 1.10. UI for Time management in Google Calendar
As an qto ui user 
In order to be prepare for issues such as ( events , tasks ) which have start and stop time
I want to  be able to view the issues with the same title, start_time and stop_time in google calendar

    

### 1.11. items data transfer between different projects
As the UI user of an qto instance 
In order to save be able to track my personal time usage between different projects and the different interdependencies 
I want to be able to move items data from one project to another via the UI.

    

### 1.12. Issues import from Google calendar
As the UI user of an qto instance 
In order to be able to visualise and manage my  start- and stop_time having issues better 
I want to  be able to import my Google calendar issues into my qto profile on an qto instance

    

### 1.13. Access issues txt format from email
As a user of the issue tracker tool 
In order to be able to access and read my issues from a mobile device
I want to be able to send each period txt file from the daily folder via gmail. 

    

### 1.14. Access issues data from Google sheet
As the biz user  of the issue tracker tool 
In order to be able to share and edit the data with multiple users authenticated within the Google eco system
I want to be able to access , edit and update the issues data from google sheet.

    

### 1.15. The notes page
The 7 sticky notes would be used for practising :
 - the cruds with web sockets
 - the per user data management

    

### 1.16. Chat 
As UI user
In order to : 
be able to quickly communicate an issue with other users of the qto applications 
I want to : 
be able to use a quick chat with other users within the application instance

    

## 2. TEAM LEADER BIZ PERSPECTIVE
As a team leader
In order to operate successfully one or many projects of my team(s)  
I want to have a nice user experience while using the qto tool.

    

### 2.1. Roles management
As the Instance Owner or Product Owner 
in order to have a finer granularity on the different data stored in my instance 
I want to be able to define roles and per roles visibility on : 
 - item page level 
 - item row level
 - item tag level

    

### 2.2. Projects management
As an team leader
In order to be able to manage multiple projects 
I want to  be able to create , update and remove projects.

    

#### 2.2.1. Add new users to a project
As an team leader
In order to be able to add new users into a project
I want to be able to add them via the UI only by their e-mail address. 

    

### 2.3. Time management
As an team leader
In order to be able the maximize the performance of the team for qto used periods 
I wanto to be able to manage time efficiently 
by accessing a simple page containing its value and the period it is related to.

    

#### 2.3.1. Update existing users in a project
As an team leader
In order to be able to update the existing users from a project
I want  to be able to update their details via the UI only by their e-mail address. 

    

#### 2.3.2. Delete existing users from a project
As an team leader
In order to be able to delete the existing users from a project
I want to be able to delete their details via the UI only by their e-mail address. 

    

#### 2.3.3. Search for users in a project
As an team leader
In order to be able to search the existing users from a project
I want to be able to search their details via the UI only by their e-mail address. 

    

#### 2.3.4. Users access management
As a team leader 
In order provide the persons and programs access to my project
I want to provide read, write access to the data and execute access ( run DDL's) per table

    

##### 2.3.4.1. Grant access per project
As a team leader 
In order to enroll authenticated users into the project I am responsible to 
I want to be able to grant them with access by only writing their e-mail into a text field and clicking invite button. 

    

##### 2.3.4.2. Personal data handling minimization
As a team leader 
In order to avoid legal obligations and complex procedures while handling personal data
I want to be able to handle the interpersonal exchange of data by collecting ONLY the e-mail of the persons or programs participating in the project

    

### 2.4. Security Management
As an team leader
In order to keep my business data secure 
I want to be able decide which users to which projects will have access to the data my qto application has access to. 

    

## 3. TEAM MEMBER BIZ PERSPECTIVE
As a team member
In order to operate successfully in the project  
I want to have a nice user experience while using the qto application
by being able to manage all the items in the application ( issues,questions,problems , etc. ) 

    

### 3.1. Issues management
As a team member of the qto
In order to achieve the best possible efficiency during the work on one or many projects
I want to be able to manage the issues in those projects. 

    

#### 3.1.1. Create new issues
As an team member
In order to be able to manage multiple issues 
I want to be able to create , update and remove issues.

    

#### 3.1.2. Update existing issues
As an team member
In order to be able to manage new issues 
I want to be able to create issues via the qto

    

#### 3.1.3. Remove existing issues
As an team member
In order to be able to stop the work on existing issues
I want to be able to remove issues via the qto

    

#### 3.1.4. Search for existing issues
As an team member
In order to be able to change attributes of the issues I am responsible for
I want to be able to update the issues' data. 

    

#### 3.1.5. Track issues progress
As an team member
In order to be able to quickly access existing issues
I want to be able to search the issues. 

    

#### 3.1.6. Track issues history
As a team member
In order to keep track on the changes of the issues
I want to be able to follow the history of the changes


    

### 3.2. Items management
As a team member of the qto
In order to achieve the best posible efficiency during the work on one or many projects
I want to be able to manage the Items in those projects, where items could be ( problems , questions etc.

    

## 4. TEAM MEMBER BIZ PERSPECTIVE
As a team member
In order to operate successfully in the project  
I want to have a nice user experience while using the qto application
by being able to manage all the items in the application ( issues,questions,problems , etc. ) 

    

### 4.1. Issues management
As a team member of the qto
In order to achieve the best possible efficiency during the work on one or many projects
I want to be able to manage the issues in those projects. 

    

#### 4.1.1. Update existing Items
As an team member
In order to be able to manage new Items 
I want  to be able to create Items via the qto

    

#### 4.1.2. Remove existing Items
As an team member
In order to be able to stop the work on existing Items
I want to be able to remove Items via the qto

    

#### 4.1.3. Search for existing Items
As an team member
In order to be able to change attributes of the Items I am responsible for
I want to be able to update the Items' data. 

    

#### 4.1.4. Track Items progress
As an team member
In order to be able to quickly access existing Items
I want to be able to search the Items. 

    

#### 4.1.5. Track Items history
As a team member
In order to keep track on what and when was planned on daily basis
I wanto to be able to keep track what was planned on a project term  - day,week,month,year,quinquennial or decade  


    

### 4.2. Track issues relations
As a team member of a project
In order to trace the issues relations to userstories, features and tests or any other objects
I want to be able to access the related objects to an issue by means of a link

    

#### 4.2.1. Generic search for items from a single entity ( table ) 
As a team member
In order to be able to find all the items from a single entity
I want to be search for those items from the UI of the application 
by using a single SearchBox UI interface. 

    

### 4.3. Items management
As a team member of the qto
In order to achieve the best posible efficiency during the work on one or many projects
I want to be able to manage the Items in those projects, where items could be ( problems , questions etc.

    

#### 4.3.1. Generic list for the searched items from a single entity ( table ) 
As a team member
In order to be able to list and review all the items from a single entity
I want to be able to review the searched items for those items from the UI of the application 
by using a single label forms like interface

    

##### 4.3.1.1. Generic cloud list for the searched items from a single entity ( table ) 
As a team member
In order to be able to list and review all the items from a single entity
I want to be able to review the searched items for those items from the UI of the application 
by using a single tag cloud like interface

    

#### 4.3.2. Generic create capability from UI for new items from a single entity ( table ) 
As a team member
In order to be able to create new items from a single entity
I want to be able to create new items from the UI of the application 
by using a simple form. 

    

#### 4.3.3. Generic edit capability from UI for existing items from a single entity ( table ) 
As a team member
In order to be able to edit existing items from a single entity
I want to be able to edit those  items from the UI of the application 
by using a simple form. 

    

#### 4.3.4. Generic delete capability from UI for existing items from a single entity ( table ) 
As a team member
In order to be able to delete existing items from a single entity
I want to be able to edit those  items from the UI of the application 
by using a simple form. 

    

### 4.4. Measure success
As a team member
In order to measure the success of the planned issues 
I want  to be able to measure the deliverables of each issue by comparable metrics.

    

### 4.5. Monitor success
As a team member 
In order to monitor the success of the planned issues 
I want to  be able to monitor the metrics of the issues. 

    

### 4.6. Track issues relations
As a team member of a project
In order to trace the issues relations to userstories, features and tests or any other objects
I want to be able to access the related objects to an issue by means of a link

    

### 4.7. Time management
As an issues-manager 
In order to be prepared for issues such as ( events , tasks ) which have start and stop time
I want to  be able to save their start time and stop time per issue in every possible interface

    

#### 4.7.1. time centric planning
As an issues-manager 
In order to be able to plan the issues data for a certain term - day,week,month,year,quinquennial or decade
I want to be able to perform all the features of the qto on that specific period regardless whether it is today , in the past or in the future

    

#### 4.7.2. time centric reporting
As an issues-manager 
In order to be able to report the issues data for  a certain term - day,week,month,year,quinquennial or decade
I want to be able to perform all the features of the qto on that specific day regardless whether it is today , in the past or in the future

    

### 4.8. Generic CRUDS for items
As a team member
In order to be able to manage all the items in the application I have access to
I want to be able to create,update,delete and search for those items from the UI of the application.

    

### 4.9. Project's persons issue combinations
As the project manager  of an qto project 
In order to be able to quickly and reliably combine the reported hours by the project's people
I want to be able to read their qto formatted google sheets and combine them into a single project's google qto sheet

    

## 5. PROJECT OBSERVER BIZ PERSPECTIVE
As a project observer 
In order to observe the advancement of a project  
I want to have a nice user experience while using the qto application.

    

### 5.1. Projects observation
As a project observer 
In order to observe the advancement of a project  
I want to be able to observe the project's data. 

    

### 5.2. Measure success
As a team member
In order to measure the success of the planned issues 
I want  to be able to measure the deliverables of each issue by comparable metrics.

    

### 5.3. Issues observation
As a project observer 
In order to observe the advancement of the project's issues  
I want to be able to observe the project's issues. 

    

### 5.4. Monitor success
As a team member 
In order to monitor the success of the planned issues 
I want to  be able to monitor the metrics of the issues. 

    

## 6. SYSADMIN PERSPECTIVE
As a sysadmin of the qto application 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 6.1. Time management
As an issues-manager 
In order to be prepared for issues such as ( events , tasks ) which have start and stop time
I want to  be able to save their start time and stop time per issue in every possible interface

    

### 6.2. System deployability
As the SysAdmin 
In order to be able to provide access to a new database driven application to my organization
I want to be able to deploy an instance of the qto application and spawn a new project out of it in less than a hour from a clean Linux host. 

    

### 6.3. System performance
As the SysAdmin 
In order to ensure the performance of the qto application
I want to the System containing the qto application to perform its functions within the defined performance criteria

    

### 6.4. System stability
As the SysAdmin
In order to minimize downtimes and ensure continuous operations 
I want to the System containing the qto application to perform its defined functions on request without interruptions or unknown side effects

    

### 6.5. Generic CRUDS for items
As a team member
In order to be able to manage all the items in the application I have access to
I want to be able to create,update,delete and search for those items from the UI of the application.

    

### 6.6. System reliability
As the SysAdmin
In order to be able to rely on the operations of the tool
I want to the System containing the qto application to perform its functions as specified consistently 

    

### 6.7. Project's persons issue combinations
As the project manager  of an qto project 
In order to be able to quickly and reliably combine the reported hours by the project's people
I want to be able to read their qto formatted google sheets and combine them into a single project's google qto sheet

    

### 6.8. Ease of use
As the SysAdmin
In order to be efficient and decrease the amount of errors
I want to generally perform any command the system within the sysadmin scope via clean and memorable oneliners 

    

## 7. PROJECT OBSERVER BIZ PERSPECTIVE
As a project observer 
In order to observe the advancement of a project  
I want to have a nice user experience while using the qto application.

    

### 7.1. Security
As the SysAdmin
In order to be able to provide the best possible security level of operation for the qto instance I am responsible for
I want to have pre-defined and clear set of tasks and activities to perform related to the security. 

    

### 7.2. Projects observation
As a project observer 
In order to observe the advancement of a project  
I want to be able to observe the project's data. 

    

#### 7.2.1. Who logged in and out when
As the SysAdmin
In order to provide the best possible security for the data of my organisation 
I want to be able to provide easily and quickly answer to the question :
Who logged in and out when?

    

### 7.3. Issues observation
As a project observer 
In order to observe the advancement of the project's issues  
I want to be able to observe the project's issues. 

    

#### 7.3.1. Who changed what and why
As the SysAdmin
In order to provide the best possible security for the data of my organisation 
I want to be able to provide easily and quickly answer to the question :
Who changed what and why?

    

## 8. SYSADMIN PERSPECTIVE
As a sysadmin of the qto application 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

## 9. ETL AND INTEGRATIONS PERSPECTIVE
As an ETL and integrations specialist 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 9.1. System deployability
As the SysAdmin 
In order to be able to provide access to a new database driven application to my organization
I want to be able to deploy an instance of the qto application and spawn a new project out of it in less than a hour from a clean Linux host. 

    

### 9.2. Database to json files data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data into a different storage format 
I want to be able to export the project db data into json files - one per table via a single shell call. 

    

### 9.3. System performance
As the SysAdmin 
In order to ensure the performance of the qto application
I want to the System containing the qto application to perform its functions within the defined performance criteria

    

### 9.4. Json files to db data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data from json files into the db tables
I want to be able to import the exported json files ( one per table ) into the database. 

    

### 9.5. System stability
As the SysAdmin
In order to minimize downtimes and ensure continuous operations 
I want to the System containing the qto application to perform its defined functions on request without interruptions or unknown side effects

    

### 9.6. Xls-to-mysql-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data 
I want to be able to
use a single shell call to load all or chosen table(s) to the mysql db 

    

### 9.7. System reliability
As the SysAdmin
In order to be able to rely on the operations of the tool
I want to the System containing the qto application to perform its functions as specified consistently 

    

### 9.8. Xls-to-postgres-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data
 I want to be able to
use a single shell call to load all or chosen table(s) to the postgres db 

    

### 9.9. Ease of use
As the SysAdmin
In order to be efficient and decrease the amount of errors
I want to generally perform any command the system within the sysadmin scope via clean and memorable oneliners 

    

#### 9.9.1. error reporting in xls-to-postgres-db hierarchical data load 
As the Data Integrator
In order to be efficient while troubleshooting data loading errors 
I want to be able to see : 
 - which table's load failed
 - what was the error in failed to 

    

### 9.10. Security
As the SysAdmin
In order to be able to provide the best possible security level of operation for the qto instance I am responsible for
I want to have pre-defined and clear set of tasks and activities to perform related to the security. 

    

## 10. DEVOPS PERSPECTIVE
As a devops operator of qto application 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 10.1. Project deployment
As a potential Developer of the qto or a qto application 
In order to have the easiest installation experience 
I want to be able to deploy fully functional development environment on a clean host in less than an hour with a single oneliner. 

    

### 10.2. System verifiability and testability
As an ITOPS 
In order to be able to rely on the operations of the tool 
 and manage easily its features and functionalities
I wanto the easily verify and  test parts or the whole System 
by issuing a single shell call.

    

## 11. ETL AND INTEGRATIONS PERSPECTIVE
As an ETL and integrations specialist 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 11.1. Clarity and brevity of the end to end tests
As an ITOPS 
In order to be able to verify all the features and functionalities of the tool within the System
I want to see the results of each test in 1 flow in the following format:.

    

### 11.2. Databases - local to remote and remote to local sync
As a DevOps Operator
In order to :
 - keep the dog-fooded local and remote db instances in sync
 - and have full mobile access via the web 
I wanto to :
 - be able to apply a full db dump remotely via a single one-liner 
 - both local to remote and remote to local



    

#### 11.2.1. Abort end-to-end tests on single test fail
As an ITOPS 
In order to be able to run continuously end-to-end tests and skip for several runs failing tests
I want to be able to configure the single e2e entry point script to skip certain tests, but report me what was skipped. 

    

### 11.3. Database to json files data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data into a different storage format 
I want to be able to export the project db data into json files - one per table via a single shell call. 

    

### 11.4. Logging
As a Full-Stack Developer
In order to quickly understand what is happening in the application
I want to have easy-to-use and highly customisable logging to both file and console.

    

### 11.5. Json files to db data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data from json files into the db tables
I want to be able to import the exported json files ( one per table ) into the database. 

    

#### 11.5.1. Control flow logging
As a CLI user 
In order to be able to understand what the issue tracker tool is executing
I want  to have configurable logging with stderr, stdout and file output

    

### 11.6. Xls-to-mysql-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data 
I want to be able to
use a single shell call to load all or chosen table(s) to the mysql db 

    

#### 11.6.1. Log entries format configuration
As a Full-Stack Developer
In order to be able to get the msg of any component of the application 
I want each log entry to content:
- the type of the entry - log , error, warn , fatal
- the timestamp of the log entry event 
- the name of the component issueing the msg and the line num of the src file 
- the msg as it was echoed by the application

    

### 11.7. Xls-to-postgres-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data
 I want to be able to
use a single shell call to load all or chosen table(s) to the postgres db 

    

#### 11.7.1. Single entry point for end to end tests
As an DevOps
In order to be able to verify all the features and functionalities of the tool within the System
I want to run a single shell call running all the end-to-end test of the application ensuring the specified features and functionalities.  

    

#### 11.7.2. Tool run log to human readable description
As a CLI user 
In order to be able to get a human readable description of the log of the specific run of the tool
I want to be able to translate the recorded uuid's in the execution run log to their respective records

    

## 12. DEVOPS PERSPECTIVE
As a devops operator of qto application 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 12.1. Application's source code and documentation integrity
As a Full-Stack Developer
In order to make easy the entry of other developers to the projects
I want to be able to point to written documentation for user-stories, issues, features and functionalities, which will be linked to parts of the source code. 

    

### 12.2. System deployment
As a potential Developer of the qto or a qto application 
In order to have the easiest installation experience 
I want to be able to deploy fully functional development environment on a clean host in less than an hour with a single oneliner. 

    

#### 12.2.1. Userstories to test case relations
As a Developer 
In order to ensure the stability and expandability of the application
I want to be able to run for each implemented user-story a single test

    

#### 12.2.2. UUID trackability for test files and userstories
As a Developer 
In order to identify each user-story to be tested with its according test
I want to be able to track each user-story or test code entry point file by UUID.

    

### 12.3. System verifiability and testability
As an ITOPS 
In order to be able to rely on the operations of the tool 
 and manage easily its features and functionalities
I wanto the easily verify and  test parts or the whole System 
by issuing a single shell call.

    

#### 12.3.1. Components start run message print
As a CLI user 
In order to know when a component has been started
I want to be able to see the "START &lt;&lt;COMPONENT NAME&gt;&gt; on either the STDOUT or the log file of the component

    

#### 12.3.2. Tool exit with exit code and exit message
As a CLI user or calling  automated component
In order to be able to understand whether or not the execution of the call to the tool was successful or not 
I want to get the exit code from the tool execution and see the exit message

    

#### 12.3.3. Execution path tracing by UUID's
As a DevOps operator
Foreach execution run of the tool
I want to be able to walk trough the execution path of the tool programmatically. 

    

### 12.4. Logging
As a Full-Stack Developer
In order to quickly understand what is happening in the application
I want to have easy-to-use and highly customisable logging to both file and console.

    

#### 12.4.1. Issues directories naming conventions
As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
I want to be able to store large quantity of issues txt files by their date on daily, weekly, monthly, yearly and decadally basis

    

#### 12.4.2. Issues files naming conventions
As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
and open them quickly
I want to be able to just type the first letter in a text editor supporting select opened file by typing its first letter and jump to that file

    

#### 12.4.3. Issues file open
As a CLI user 
In order to be able quickly to access my issues ( daily , weekly, monthly , yearly )
I want to be able to view my daily issues by simply opening a single txt file

    

#### 12.4.4. Issues files history
As a CLI user 
In order to be able quickly to search trough old issues 
I want to be able to access old issues files by their date held in their file names from the file system

    

#### 12.4.5. Issues files naming conventions
As a DevOps 
In order to be able quickly to access and manage programmatically issues
I want to be able to guess the file paths of the issues file by their date 

    

### 12.5. Application's source code and documentation integrity
As a Full-Stack Developer
In order to make easy the entry of other developers to the projects
I want to be able to point to written documentation for user-stories, issues, features and functionalities, which will be linked to parts of the source code. 

    

#### 12.5.1. Issues files naming conventions for the  project
As a DevOps 
In order to be able quickly to switch between different projects
I wanto to have the project name of the issues file in its name as the first token as follows:
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt;daily|weekly|monthly|yearly&gt;&gt;.txt

    

### 12.6. Configuration management


    

#### 12.6.1. a single route to copy paste the appConfig in json format
As a DevOps Operator 
In order to quickly dig out basic confs about the current project , I want to be able to have a route for that in the web ui ... so that I could quickly just copy paste that json ... or create another application.conf out of it ... 

    

#### 12.6.2. Issues files naming conventions for current date
As a DevOps Operator 
In order to quickly dig out basic confs about the current project , I want to be able to have a route for that in the web ui ... so that I could quickly just copy paste that json ... or create another application.conf out of it ... 

    

#### 12.6.3. Issues files naming conventions for current date
As a DevOps 
In order to be able quickly and programmatically to go back in the history
I wanto to have the current registration date in the file name and path
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt;daily|weekly|monthly|yearly&gt;&gt;.txt

    

#### 12.6.4. Issues files naming conventions for the time frame
As a DevOps 
In order to be able quickly and programmatically to go back in the history
I want to have the current registration date in the file name and path
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt; ( daily|weekly|monthly|yearly) &gt;&gt;.txt

    

### 12.7. Issues transformations
As a cli user of the qto application 
In order to be able to sort the issues according to their attributes 
and edit them in both txt file and xls file
I want to be able to perform the following loads: 
txt-to-db - to load a txt file with issues to an issues table in db
db-to-xls - to load a xls file from db table to xls
xls-to-db - to load a xls file with issues to an issues table in db
db-to-txt - to load a txt file from db table 

    

#### 12.7.1. 
Load by txt-to-db action
As a cli user of the qto application 
in order to store my issues in structured form to db for further processing
I want to be able to load any issue file with a single line shell call to a db 

    

##### 12.7.1.1. Load issues file from file system to db
As a cli user of the qto application 
- in order to be able to handle issues from different projects
- and load them to db for further processing
I want to:  
- pre-set the variables of the project 
- and than load any issue file with a single line shell call to a db
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default

    

#### 12.7.2. Load issues by db-to-xls action
As a cli user of the qto application 
in order to be able to sort and edit my issues in Excel
I want to be able to unload my issues from one or many tables in the db at once in a single shell call

    

#### 12.7.3. Load issues by xls-to-db action
As a cli user of the qto application 
in order to store my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load 

    

##### 12.7.3.1. Load issues by xls-to-db action for insert or upset
As a cli user of the qto application 
in order to insert or upsert my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load and specifying upsert by adding the guid column to the xls sheet 

    

##### 12.7.3.2. Load issues by xls-to-db action by truncating or not the loadable table
As a cli user of the qto application 
in order to store my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load 

    

#### 12.7.4. Load issues by db-to-txt
As a cli user of the qto application 
in order to store my issues in more structured data format for further processing
I want to :
- be able to load the issues for a period from the db to a file
- by choosing the names of the tables to load

    

##### 12.7.4.1. xls-to-db action load sort by issues prio attribute
As a cli user of the qto application 
during the db-to-txt action load
in order to understand the priority of my issues
I want to :
- be able to specify the order in the issues txt files lines to be based on the prio attribute 
by choosing the names of the tables to load

    

##### 12.7.4.2. db-to-txt action load sort by issues start_time attribute
As a cli user of the qto application 
during the db-to-txt action load
in order to understand the priority of my issues
I want to :
- be able to specify the order in the issues txt files lines to be based on the start_time attribute ( start_time could be in the following format YYYY-mm-dd HH:MM in start_time or HH:MM  )
by choosing the names of the tables to load

    

##### 12.7.4.3. db-to-txt action load sort by issues start_time attribute
As a cli user of the qto application 
during the db-to-txt action load
in order to view the issues by categories
I want to :
- be able to specify the order in the issues txt files lines to be based on the category attribute

    

#### 12.7.5. Load issues file from db to file system
As a cli user of the qto application 
in order to store my issues in more structured data format for further processing
I want to :
- be able to load the issues for a period from the db to a file
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default

    

### 12.8. issues file filtering
As a CLI user 
In order to filter quickly my issues 
I want to  be able to show the issues with their categories of only certain status

    

### 12.9. Single shell call for projects switching
As an issues-manager 
In order to be able to switch between different projects quickly
I want to be able to issue a single shell call for loading a project's configuration
and run the issue-handler against this pre-loaded configuration

    

### 12.10. Issues publishing from shell calls
As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I want to be able to issue a single shell call for copying the current items data to a medium by specifying the tables to be published

    

#### 12.10.1. Issues publishing in e-mail format
As a DevOps 
In order to be able to quickly share the current issues data in email format
I want  to be able to issue a single shell call for copying the current items data to email by specifying the tables to be published

    

#### 12.10.2. Issues handling in google sheet format
As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I want  to be able to issue a single shell call for copying the current items data to google sheet by specifying the tables to be published

    

#### 12.10.3. Issues publishing in google calendar format
As a DevOps 
In order to be able to quickly share the current issues data in google calendar format
I want  to be able to issue a single shell call for copying the current items data to google calendar by specifying the tables to be published for the items having set start_time and stop_time attributes. 

    

### 12.11. Metadata handling
As a DevOps operator
In order to be able to programatically manage all aspects of my data
I wan to to have a single entry point to manage the meta data per tables , columns and UI elements
so that even a table, column or whatever object is not populated in the meta still there will be default values for it usable by the application.

    

### 12.12. Issues transformations
As a cli user of the qto application 
In order to be able to sort the issues according to their attributes 
and edit them in both txt file and xls file
I want to be able to perform the following loads: 
txt-to-db - to load a txt file with issues to an issues table in db
db-to-xls - to load a xls file from db table to xls
xls-to-db - to load a xls file with issues to an issues table in db

    

## 13. UI DEVELOPER PERSPECTIVE
As the UI Developer
In order to be able to deliver working solutions for the UI 
I want to have user friendly development experience. 

    

### 13.1. Easy setup for testability
5b04d8fa-1ebb-4fe7-a9ad-700c40a57f3c

    

### 13.2. Code traceability by uuid
As the UI Developer 
In order to be able to grasp the inner working of the application
I want to be able to search by user-story uuid from the source code of the application

    

### 13.3. Single shell call for projects switching
As an issues-manager 
In order to be able to switch between different projects quickly
I want to be able to issue a single shell call for loading a project's configuration
and run the issue-handler against this pre-loaded configuration

    

### 13.4. Issues publishing from shell calls
As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I want to be able to issue a single shell call for copying the current items data to a medium by specifying the tables to be published

    

### 13.5. Metadata handling
As a DevOps operator
In order to be able to programatically manage all aspects of my data
I wan to to have a single entry point to manage the meta data per tables , columns and UI elements
so that even a table, column or whatever object is not populated in the meta still there will be default values for it usable by the application.

    

## 14. UI DEVELOPER PERSPECTIVE
As the UI Developer
In order to be able to deliver working solutions for the UI 
I want to have user friendly development experience. 

    

### 14.1. Easy setup for testability
As the UI Developer
In order to deliver working ui units 
I want  to be able to quickly setup the existing project with minimalistic default set of data

    

