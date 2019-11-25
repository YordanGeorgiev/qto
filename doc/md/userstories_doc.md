#  USERSTORIES AND SCENARIOS
* [1. COMMON UI PERSPECTIVE](#1-common-ui-perspective)
  * [1.1. UI PERFORMANCE](#11-ui-performance)
  * [1.2. FORM FACTORS](#12-form-factors)
    * [1.2.1. Desktop UI](#121-desktop-ui)
    * [1.2.2. Table UI](#122-table-ui)
    * [1.2.3. Mobile UI](#123-mobile-ui)
  * [1.3. THE OMNI-SEARCH FEATURE](#13-the-omni-search-feature)
    * [1.3.1. List as grid page quick filtering](#131-list-as-grid-page-quick-filtering)
    * [1.3.2. View page quick filtering](#132-view-page-quick-filtering)
    * [1.3.3. Search results page quick filtering](#133-search-results-page-quick-filtering)
  * [1.4. THE LEFT MENU UI - ORGANISING THE STRUCTURE OF THE PROJECT](#14-the-left-menu-ui--organising-the-structure-of-the-project)
    * [1.4.1. Managing listings from the left menu](#141-managing-listings-from-the-left-menu)
    * [1.4.2. Managing documents from the left menu](#142-managing-documents-from-the-left-menu)
    * [1.4.3. Managing folders on the left menu](#143-managing-folders-on-the-left-menu)
  * [1.5. THE LIST PAGE UI](#15-the-list-page-ui)
    * [1.5.1. Search in the list page](#151-search-in-the-list-page)
    * [1.5.2. Items listing](#152-items-listing)
    * [1.5.3. Items editing](#153-items-editing)
      * [1.5.3.1. Items editing inline](#1531-items-editing-inline)
      * [1.5.3.2. Items editing via a modal dialog](#1532-items-editing-via-a-modal-dialog)
    * [1.5.4. Items creation](#154-items-creation)
    * [1.5.5. Items deletion](#155-items-deletion)
    * [1.5.6. Items export](#156-items-export)
    * [1.5.7. Items import](#157-items-import)
  * [1.6. THE VIEW PAGE UI](#16-the-view-page-ui)
    * [1.6.1. View page navigation](#161-view-page-navigation)
      * [1.6.1.1. Title numbers link navigation and sharing](#1611-title-numbers-link-navigation-and-sharing)
      * [1.6.1.2. Title numbers link navigation and sharing](#1612-title-numbers-link-navigation-and-sharing)
    * [1.6.2. View doc page print preview](#162-view-doc-page-print-preview)
      * [1.6.2.1. Disable editing in print preview mode but keep the links](#1621-disable-editing-in-print-preview-mode-but-keep-the-links)
      * [1.6.2.2. Disable the right and left menus in print preview mode](#1622-disable-the-right-and-left-menus-in-print-preview-mode)
    * [1.6.3. Search in the view page ](#163-search-in-the-view-page-)
    * [1.6.4. Hierarchical items management](#164-hierarchical-items-management)
      * [1.6.4.1. Add Item](#1641-add-item)
      * [1.6.4.2. Update item](#1642-update-item)
          * [1.6.4.2.1. Update item's title](#16421-update-item's-title)
          * [1.6.4.2.2. Update item's description](#16422-update-item's-description)
          * [1.6.4.2.3. Update item's src_code](#16423-update-item's-src_code)
          * [1.6.4.2.4. Move item in the hierarchy](#16424-move-item-in-the-hierarchy)
      * [1.6.4.3. Delete item](#1643-delete-item)
    * [1.6.5. Right TOC menu navigation](#165-right-toc-menu-navigation)
      * [1.6.5.1. Open and close of right menu](#1651-open-and-close-of-right-menu)
      * [1.6.5.2. Search in the right menu](#1652-search-in-the-right-menu)
      * [1.6.5.3. Links in the right menu](#1653-links-in-the-right-menu)
    * [1.6.6. Left menu navigation](#166-left-menu-navigation)
  * [1.7. THE GLOBAL SEARCH PAGE / THE SEARCH UI](#17-the-global-search-page-/-the-search-ui)
    * [1.7.1. Global search from the list page](#171-global-search-from-the-list-page)
    * [1.7.2. Global search from the view page](#172-global-search-from-the-view-page)
    * [1.7.3. Global search modal dialog ui](#173-global-search-modal-dialog-ui)
      * [1.7.3.1. Search-autocomplete on modal search dialog](#1731-search-autocomplete-on-modal-search-dialog)
  * [1.8. THE NOTES PAGE / UI](#18-the-notes-page-/-ui)
  * [1.9. THE CHAT PAGE / UI](#19-the-chat-page-/-ui)
  * [1.10. MULTI-PROJECT AWARE UI](#110-multi-project-aware-ui)
    * [1.10.1. Items data transfer between different projects](#1101-items-data-transfer-between-different-projects)
  * [1.11. ITEMS MANAGEMENT](#111-items-management)
    * [1.11.1. Items move](#1111-items-move)
  * [1.12. ISSUES IMPORT FROM GOOGLE CALENDAR](#112-issues-import-from-google-calendar)
  * [1.13. ACCESS ISSUES DATA FROM GOOGLE SHEET ( DEPRECATING )](#113-access-issues-data-from-google-sheet-(-deprecating-))
* [2. TEAM LEADER BIZ PERSPECTIVE](#2-team-leader-biz-perspective)
  * [2.1. ROLES MANAGEMENT](#21-roles-management)
  * [2.2. PROJECTS MANAGEMENT](#22-projects-management)
    * [2.2.1. Users management in a project](#221-users-management-in-a-project)
    * [2.2.2. Users access management](#222-users-access-management)
      * [2.2.2.1. Grant access per project](#2221-grant-access-per-project)
      * [2.2.2.2. Personal data handling minimization](#2222-personal-data-handling-minimization)
  * [2.3. SECURITY MANAGEMENT](#23-security-management)
  * [2.4. TIME MANAGEMENT](#24-time-management)
* [3. TEAM MEMBER BIZ PERSPECTIVE](#3-team-member-biz-perspective)
  * [3.1. ISSUES MANAGEMENT](#31-issues-management)
    * [3.1.1. Remove existing issues](#311-remove-existing-issues)
    * [3.1.2. Search for existing issues](#312-search-for-existing-issues)
    * [3.1.3. Track issues progress](#313-track-issues-progress)
    * [3.1.4. Track issues history](#314-track-issues-history)
  * [3.2. ITEMS MANAGEMENT](#32-items-management)
  * [3.3. ISSUES MANAGEMENT](#33-issues-management)
    * [3.3.1. Update existing Items](#331-update-existing-items)
    * [3.3.2. Remove existing Items](#332-remove-existing-items)
    * [3.3.3. Search for existing Items](#333-search-for-existing-items)
    * [3.3.4. Track Items progress](#334-track-items-progress)
    * [3.3.5. Track Items history](#335-track-items-history)
  * [3.4. TRACK ISSUES RELATIONS](#34-track-issues-relations)
  * [3.5. ITEMS MANAGEMENT](#35-items-management)
  * [3.6. MEASURE SUCCESS](#36-measure-success)
  * [3.7. MONITOR SUCCESS](#37-monitor-success)
  * [3.8. TRACK ISSUES RELATIONS](#38-track-issues-relations)
  * [3.9. TIME MANAGEMENT](#39-time-management)
    * [3.9.1. time centric planning](#391-time-centric-planning)
    * [3.9.2. time centric reporting](#392-time-centric-reporting)
  * [3.10. PROJECT'S PERSONS ISSUE COMBINATIONS](#310-project's-persons-issue-combinations)
* [4. PROJECT OBSERVER BIZ PERSPECTIVE](#4-project-observer-biz-perspective)
  * [4.1. PROJECTS OBSERVATION](#41-projects-observation)
  * [4.2. MEASURE SUCCESS](#42-measure-success)
  * [4.3. ISSUES OBSERVATION](#43-issues-observation)
  * [4.4. MONITOR SUCCESS](#44-monitor-success)
* [5. SYSADMIN PERSPECTIVE](#5-sysadmin-perspective)
  * [5.1. SYSTEM DEPLOYABILITY](#51-system-deployability)
  * [5.2. TIME MANAGEMENT](#52-time-management)
  * [5.3. SYSTEM STABILITY](#53-system-stability)
  * [5.4. GENERIC CRUDS FOR ITEMS](#54-generic-cruds-for-items)
  * [5.5. SYSTEM RELIABILITY](#55-system-reliability)
  * [5.6. PROJECT'S PERSONS ISSUE COMBINATIONS](#56-project's-persons-issue-combinations)
  * [5.7. EASE OF USE](#57-ease-of-use)
* [6. PROJECT OBSERVER BIZ PERSPECTIVE](#6-project-observer-biz-perspective)
  * [6.1. SECURITY](#61-security)
  * [6.2. PROJECTS OBSERVATION](#62-projects-observation)
    * [6.2.1. Who logged in and out when](#621-who-logged-in-and-out-when)
  * [6.3. ISSUES OBSERVATION](#63-issues-observation)
    * [6.3.1. Who changed what and why](#631-who-changed-what-and-why)
* [7. ETL AND INTEGRATIONS PERSPECTIVE](#7-etl-and-integrations-perspective)
  * [7.1. SYSTEM DEPLOYABILITY](#71-system-deployability)
  * [7.2. DATABASE TO JSON FILES DATA LOAD](#72-database-to-json-files-data-load)
  * [7.3. SYSTEM PERFORMANCE](#73-system-performance)
  * [7.4. JSON FILES TO DB DATA LOAD](#74-json-files-to-db-data-load)
  * [7.5. SYSTEM STABILITY](#75-system-stability)
  * [7.6. SYSTEM RELIABILITY](#76-system-reliability)
  * [7.7. XLS-TO-POSTGRES-DB HIERARCHICAL DATA LOAD](#77-xls-to-postgres-db-hierarchical-data-load)
    * [7.7.1. error reporting in xls-to-postgres-db hierarchical data load ](#771-error-reporting-in-xls-to-postgres-db-hierarchical-data-load-)
  * [7.8. EASE OF USE](#78-ease-of-use)
  * [7.9. SECURITY](#79-security)
  * [7.10. PROJECT DEPLOYMENT](#710-project-deployment)
  * [7.11. SYSTEM VERIFIABILITY AND TESTABILITY](#711-system-verifiability-and-testability)
* [8. DEVOPS PERSPECTIVE](#8-devops-perspective)
  * [8.1. CLARITY AND BREVITY OF THE END TO END TESTS](#81-clarity-and-brevity-of-the-end-to-end-tests)
  * [8.2. DATABASES - LOCAL TO REMOTE AND REMOTE TO LOCAL SYNC](#82-databases--local-to-remote-and-remote-to-local-sync)
    * [8.2.1. Abort end-to-end tests on single test fail](#821-abort-end-to-end-tests-on-single-test-fail)
  * [8.3. DATABASE TO JSON FILES DATA LOAD](#83-database-to-json-files-data-load)
  * [8.4. LOGGING](#84-logging)
  * [8.5. JSON FILES TO DB DATA LOAD](#85-json-files-to-db-data-load)
    * [8.5.1. Control flow logging](#851-control-flow-logging)
  * [8.6. XLS-TO-POSTGRES-DB HIERARCHICAL DATA LOAD](#86-xls-to-postgres-db-hierarchical-data-load)
    * [8.6.1. Log entries format configuration](#861-log-entries-format-configuration)
  * [8.7. XLS-TO-POSTGRES-DB HIERARCHICAL DATA LOAD](#87-xls-to-postgres-db-hierarchical-data-load)
    * [8.7.1. Single entry point for end to end tests](#871-single-entry-point-for-end-to-end-tests)
    * [8.7.2. Tool run log to human readable description](#872-tool-run-log-to-human-readable-description)
  * [8.8. APPLICATION'S SOURCE CODE AND DOCUMENTATION INTEGRITY](#88-application's-source-code-and-documentation-integrity)
  * [8.9. SYSTEM DEPLOYMENT](#89-system-deployment)
    * [8.9.1. Userstories to test case relations](#891-userstories-to-test-case-relations)
    * [8.9.2. UUID trackability for test files and userstories](#892-uuid-trackability-for-test-files-and-userstories)
  * [8.10. SYSTEM VERIFIABILITY AND TESTABILITY](#810-system-verifiability-and-testability)
    * [8.10.1. Components start run message print](#8101-components-start-run-message-print)
    * [8.10.2. Tool exit with exit code and exit message](#8102-tool-exit-with-exit-code-and-exit-message)
    * [8.10.3. Execution path tracing by UUID's](#8103-execution-path-tracing-by-uuid's)
  * [8.11. LOGGING](#811-logging)
    * [8.11.1. Issues directories naming conventions](#8111-issues-directories-naming-conventions)
    * [8.11.2. Issues files naming conventions](#8112-issues-files-naming-conventions)
    * [8.11.3. Issues files history](#8113-issues-files-history)
    * [8.11.4. Issues files naming conventions](#8114-issues-files-naming-conventions)
  * [8.12. APPLICATION'S SOURCE CODE AND DOCUMENTATION INTEGRITY](#812-application's-source-code-and-documentation-integrity)
    * [8.12.1. Issues files naming conventions for the  project](#8121-issues-files-naming-conventions-for-the-project)
  * [8.13. CONFIGURATION MANAGEMENT](#813-configuration-management)
    * [8.13.1. a single route to copy paste the appConfig in json format](#8131-a-single-route-to-copy-paste-the-appconfig-in-json-format)
    * [8.13.2. Issues files naming conventions for current date](#8132-issues-files-naming-conventions-for-current-date)
    * [8.13.3. Issues files naming conventions for the time frame](#8133-issues-files-naming-conventions-for-the-time-frame)
  * [8.14. ISSUES TRANSFORMATIONS](#814-issues-transformations)
    * [8.14.1. 
Load by txt-to-db action](#8141-
load-by-txt-to-db-action)
      * [8.14.1.1. Load issues file from file system to db](#81411-load-issues-file-from-file-system-to-db)
    * [8.14.2. Load issues by db-to-xls action](#8142-load-issues-by-db-to-xls-action)
    * [8.14.3. Load issues by xls-to-db action](#8143-load-issues-by-xls-to-db-action)
      * [8.14.3.1. Load issues by xls-to-db action for insert or upset](#81431-load-issues-by-xls-to-db-action-for-insert-or-upset)
      * [8.14.3.2. Load issues by xls-to-db action by truncating or not the loadable table](#81432-load-issues-by-xls-to-db-action-by-truncating-or-not-the-loadable-table)
    * [8.14.4. Load issues by db-to-txt](#8144-load-issues-by-db-to-txt)
      * [8.14.4.1. xls-to-db action load sort by issues prio attribute](#81441-xls-to-db-action-load-sort-by-issues-prio-attribute)
    * [8.14.5. Load issues file from db to file system](#8145-load-issues-file-from-db-to-file-system)
  * [8.15. ISSUES FILE FILTERING](#815-issues-file-filtering)
  * [8.16. SINGLE SHELL CALL FOR PROJECTS SWITCHING](#816-single-shell-call-for-projects-switching)
  * [8.17. ISSUES PUBLISHING FROM SHELL CALLS](#817-issues-publishing-from-shell-calls)
    * [8.17.1. Issues publishing in e-mail format](#8171-issues-publishing-in-e-mail-format)
    * [8.17.2. Issues handling in google sheet format](#8172-issues-handling-in-google-sheet-format)
    * [8.17.3. Issues publishing in google calendar format](#8173-issues-publishing-in-google-calendar-format)
  * [8.18. ISSUES TRANSFORMATIONS](#818-issues-transformations)
* [9. UI DEVELOPER PERSPECTIVE](#9-ui-developer-perspective)
  * [9.1. EASY SETUP FOR TESTABILITY](#91-easy-setup-for-testability)
  * [9.2. CODE TRACEABILITY BY UUID](#92-code-traceability-by-uuid)
  * [9.3. SINGLE SHELL CALL FOR PROJECTS SWITCHING](#93-single-shell-call-for-projects-switching)
  * [9.4. ISSUES PUBLISHING FROM SHELL CALLS](#94-issues-publishing-from-shell-calls)
  * [9.5. METADATA HANDLING](#95-metadata-handling)
  * [9.6. EASY SETUP FOR TESTABILITY](#96-easy-setup-for-testability)




    

## 1. COMMON UI PERSPECTIVE
As an UI user of the qto application 
In order to manage my issues via the UI successfully  
I want to have a nice user experience while using the qto application.

    

### 1.1. UI Performance
As an UI user of the qto application 
In order to enjoy the usage of the tool and interact efficiently   
I wan to to  have responsive and quick UI.

    

### 1.2. Form factors
As an UI user of the qto application 
In order to be able to be able to access from anywhere and anytime
I want to be able to use it with different form factor devices

    

#### 1.2.1. Desktop UI
As an UI user of the qto application 
In order to be able to use it fully on the work-place
I want to it to work primarily on Desktop for every UI feature

    

#### 1.2.2. Table UI
As an UI user of the qto application 
In order to be able to access it quickly on the go 
I want to  be able to use the same UI on an advanced tablets

    

#### 1.2.3. Mobile UI
As an UI user of the qto application 
In order to be able to access it quickly on the go
I want to  be able to use the same UI on an advanced mobile phones. 

    

### 1.3. The Omni-search feature
As an UI user of the qto application
In order to have a consistent experience around all the user interfaces for search and get quickly to the information on EACH page 
I want to be able to perform quick filtering on ALL the UI elements from the page from a single omin search-box placed at the top bar of the screen

    

#### 1.3.1. List as grid page quick filtering
As an UI user of the qto application
In order to get quickly to the information on the listing as grid page
I want to be able to perform quick filtering on both the grid and the left menu

    

#### 1.3.2. View page quick filtering


    

#### 1.3.3. Search results page quick filtering


    

### 1.4. The left menu UI - organising the structure of the project
As an UI user of the qto application
in order to be able to manage the whole structure of my project
 I want to have access to a left menu from each page

    

#### 1.4.1. Managing listings from the left menu
As an UI user of the qto application
in order to be able to store and track data from different listings or in different documents 
I want to be able to create new listings by simple right click on the left menu and selecting "add listing".

    

#### 1.4.2. Managing documents from the left menu
As an UI user of the qto application
in order to be able to store and track data from different listings or in different documents 
I want to be able to create new documents by simple right click on the right menu and selecting "add document".

    

#### 1.4.3. Managing folders on the left menu
As an UI user of the qto application
in order to be able to be able to organise the structure of my project
I want to be able to add, update and delete folders from the left menu

    

### 1.5. The list page UI
As an UI user of the qto application 
in order to be able to efficiently process relational data for any project 
I want to be able to list all or part of the project's database table via a single UI

    

#### 1.5.1. Search in the list page
As an UI user of the qto application
In order to be able to quickly and effortlessly search the content of the loaded document in the list page
I want to be able to focus the search-box with a single shortcut / click on the left menu, so that after typing 3 letters the left menu will get filtered by the search string and the table content will get filtered as well.

    

#### 1.5.2. Items listing
As an qto ui user 
In order to be able to quickly see as much items ( issues, problems, ideas etc. ) 
I want to list the items in a web page according to the filtering criteria I might have specified earlier on … 

    

#### 1.5.3. Items editing
aAs an UI user of the qto application 
In order to update the application data via the UI 
I wan to to be able to edit the data for ANY of the items in the application I have access to. 

    

##### 1.5.3.1. Items editing inline
As an UI user of the qto application 
In order to be able to quickly update the items data in a listing UI
I wan to to be able to edit it Excel table like by quickly navigating trough an grid and type the new values to update.

    

##### 1.5.3.2. Items editing via a modal dialog
As an UI user of the qto application 
In order to be able update the application data via the UI by using a more familiar form-like interface
I want to to be able to edit the data for any item by clicking on an edit button, and filling the fields of a form

    

#### 1.5.4. Items creation
As an UI user of the application 
I order to create new items in the application 
I want to be able to create them via the UI 
by clicking "create new button" and filling as few as possible data entries and clicking a Save button for ANY of the items in the application. 

    

#### 1.5.5. Items deletion
As an UI user of the application 
I order to delete existing items in the project
I want to  be able to delete them via the UI 
by clicking a "delete " button and confirming the deletion for the item

    

#### 1.5.6. Items export
As an UI user of the application 
I order to export the data  of the items in the application 
I want to be able to perform every possible export in the UI from a single button click or a single url access. 

    

#### 1.5.7. Items import
As an UI user of the application 
I order to import data  of the items in the application 
I want to  be able to perform every possible import in the UI from a single button click and pointing to the file path of a file

    

### 1.6. The view page UI
As an UI user of the qto application 
in order to be able to efficiently process hierarchical relational data for any project 
I want to be able to list all or part of the project's database table via a single UI

    

#### 1.6.1. View page navigation
As an UI user 
In order to quickly grasp the content of a view doc 
I want to be able to quickly and effortlessly navigate the view doc page.

    

##### 1.6.1.1. Title numbers link navigation and sharing
As an UI user 
In order to read the the current item in the top of the screen and to be able to refer it exactly with a link 
I want to be able on click the system to move it on the top of the screen and to change the url pointing to the exactly chosen item.

    

##### 1.6.1.2. Title numbers link navigation and sharing
As an UI user 
In order to read the the current item in the top of the screen and to be able to refer it exactly with a link 
I want to be able on click the system to move it on the top of the screen and to change the url so that when the link is copied one could refer to it by sending it.

    

#### 1.6.2. View doc page print preview
As an UI user
In order to be able to share the documents of a qto application in pdf format or even physically print them
I want to be able to see the whole document or just a branch of it in print-preview mode

    

##### 1.6.2.1. Disable editing in print preview mode but keep the links
As an UI user 
In order to have as clean entity as possible to a pdf document I do not want to be able to add,edit or delete items from the print preview mode, however so that the clickable links should remain as part of the content

    

##### 1.6.2.2. Disable the right and left menus in print preview mode
As an UI User
In order to have as clean and easily printable document as possible in a pdf format I do not want to either see or access the right and left menu links.

    

#### 1.6.3. Search in the view page 
As an UI user of the qto application
In order to be able to quickly and effortlessly search the content of the loaded document in the view doc page
I want to be able to focus the search-box with a single shortcut / click on the left menu, so that after typing 3 letters the left menu will get filtered by the search string.

    

#### 1.6.4. Hierarchical items management
As an the ui user
In order to manage the hierarchical items in the application
I want to be able to manage by actions (list, create, update, delete, search) ANY hierarchical items of the application in from a hierarchical doc format by simply right clicking on their titles and choosing from the menut the action which must have both image and text to indicate more 

    

##### 1.6.4.1. Add Item
I want to be able to add items to the view page by simply right clicking the upper title of the item and selecting add item

    

##### 1.6.4.2. Update item
I want to be able to update items data to the view page

    

###### 1.6.4.2.1. Update item's title
I want to be able to update item's title by simply clicking in it and starting to type the new contents ...

    

###### 1.6.4.2.2. Update item's description
I want to be able to update item's descrption by simply clicking in it and starting to type the new contents ...

    

###### 1.6.4.2.3. Update item's src_code
I want to be able to update item's src_code by simply clicking in it and starting to type the new contents ...

    

###### 1.6.4.2.4. Move item in the hierarchy
In order to quickly edit the structure of a hierarchical doc 
I want to be able to move item by drag and drop from the left menu

    

##### 1.6.4.3. Delete item
I want to be able to delete an item by right clicking it's title and choosing delete item.

    

#### 1.6.5. Right TOC menu navigation
As an the ui user
In order to navigate quickly in the document structure
I want to be able to see the document structure by clicking a right menu containing the Table of Contents of this document with a clickable links.


    

##### 1.6.5.1. Open and close of right menu
As an the ui user
In order to navigate quickly in the document structure
I want to be able to open and close the right menu quickly from both it's top and the bottom

    

##### 1.6.5.2. Search in the right menu
As an the ui user
In order to navigate quickly in the document structure
I want to be able filter quickly the right menu items by the means of right menu quick srch/filtering box which will filter the items containing the string I am typing for dynamically

    

##### 1.6.5.3. Links in the right menu
As an the ui user
In order to navigate quickly in the document structure by levels
I want to be able to simply click on the links ( level 1 , level-2 , level-3 etc. ) which will open the document

    

#### 1.6.6. Left menu navigation
As a QTO application UI user
In order to be able to quickly jump to a different document / listing 
I want to be able to click on the upper left corner of the view page and access the hierarchichal project structure of the whole project from the left menu.

    

### 1.7. The global search page / the search UI
As an qto ui user 
In order to be able to search ANY items ( issues, problems, ideas etc. ) 
I want to have a pop-up search SearchBox with dimmed background providing with interactive autocomplete, which would assist me in specifying the search criteria for any item I want to list. 

    

#### 1.7.1. Global search from the list page
As an qto ui user 
In order to be able to search ANY items ( issues, problems, ideas etc. ) from the list page
I want to be able to search from the list page by simply clicking on a search textbox on the top left of the page, typing the search phrase I want to search for and getting the results by hitting enter or clicking the search icon on the right of the search box ...

    

#### 1.7.2. Global search from the view page
As an qto ui user 
In order to be able to search ANY items ( issues, problems, ideas etc. ) from the view page
I want to be able to search from the view page by simply clicking on a search icon ( might be the / shortcut as well ) , the system should bring up a modal dialog with the global search ui, than I should be able to type the search phrase I want to search for and hit enter, when the System should present me the search results.

    

#### 1.7.3. Global search modal dialog ui
As an UI user 
In order to have the best possible search experience
I want to be able to search from a modal dialog UI which will pop-up on a dimmed background after the search-box is focused .. 

    

##### 1.7.3.1. Search-autocomplete on modal search dialog
As an UI user 
In order to get quickly to exactly the searched item I am searching for
I want the System to present me with autocomplete of the mostly occurring string I am searching for with the name of the item on the left and when clicking on it I want it to open the list as grid page with all the items having this item in the search ... 

    

### 1.8. The notes page / UI
The 7 sticky notes would be used for practising :
 - the cruds with web sockets
 - the per user data management

    

### 1.9. The chat page / UI
As UI user
In order to : 
be able to quickly communicate an issue with other users of the qto applications 
I want to : 
be able to use a quick chat with other users within the application instance

    

### 1.10. Multi-project aware UI
As the UI user of an qto instance 
In order to save be able to track my personal time usage between different projects and the different interdependencies 
I want to be able to move items data from one project to another via the UI.

    

#### 1.10.1. Items data transfer between different projects
As the UI user of an qto instance 
In order to manage multiple projects efficiently
I want to be able to move items data from one project to another via the UI in a trusted manner.

    

### 1.11. Items management
As an UI user of the application 
In order to be able to manage multiple different items and entities 
I want to be able to perform multiple actions on items easily and efficiently.

    

#### 1.11.1. Items move
As an UI user of the application 
I order to move the items into different tables
I want to  be able to move them from a button in the listing page by specifying the target table

    

### 1.12. Issues import from Google calendar
As the UI user of an qto instance 
In order to be able to visualise and manage my  start- and stop_time having issues better 
I want to  be able to import my Google calendar issues into my qto profile on an qto instance

    

### 1.13. Access issues data from Google sheet ( deprecating )
As the biz user  of the issue tracker tool 
In order to be able to share and edit the data with multiple users authenticated within the Google eco system
I want to be able to access , edit and update the issues data from google sheet.

    

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

    

#### 2.2.1. Users management in a project
As an team leader
In order to be able to efficiently allocate human resources to a project
I want to be able manage ( create , update , delete and search ) users for each project.

    

#### 2.2.2. Users access management
As a team leader 
In order provide the persons and programs access to my project
I want to provide read, write access to the data and execute access ( run DDL's) per table

    

##### 2.2.2.1. Grant access per project
As a team leader 
In order to enroll authenticated users into the project I am responsible to 
I want to be able to grant them with access by only writing their e-mail into a text field and clicking invite button. 

    

##### 2.2.2.2. Personal data handling minimization
As a team leader 
In order to avoid legal obligations and complex procedures while handling personal data
I want to be able to handle the interpersonal exchange of data by collecting ONLY the e-mail of the persons or programs participating in the project

    

### 2.3. Security Management
As an team leader
In order to keep my business data secure 
I want to be able decide which users to which projects will have access to the data my qto application has access to. 

    

### 2.4. Time management
As an team leader
In order to be able the maximize the performance of the team for qto used periods 
I wanto to be able to manage time efficiently 
by accessing a simple page containing its value and the period it is related to.

    

## 3. TEAM MEMBER BIZ PERSPECTIVE
As a team member
In order to operate successfully in the project  
I want to have a nice user experience while using the qto application
by being able to manage all the items in the application ( issues,questions,problems , etc. ) 

    

### 3.1. Issues management
As a team member of the qto
In order to achieve the best possible efficiency during the work on one or many projects
I want to be able to manage the issues in those projects. 

    

#### 3.1.1. Remove existing issues
As an team member
In order to be able to stop the work on existing issues
I want to be able to remove issues via the qto

    

#### 3.1.2. Search for existing issues
As an team member
In order to be able to change attributes of the issues I am responsible for
I want to be able to update the issues' data. 

    

#### 3.1.3. Track issues progress
As an team member
In order to be able to quickly access existing issues
I want to be able to search the issues. 

    

#### 3.1.4. Track issues history
As a team member
In order to keep track on the changes of the issues
I want to be able to follow the history of the changes


    

### 3.2. Items management
As a team member of the qto
In order to achieve the best posible efficiency during the work on one or many projects
I want to be able to manage the Items in those projects, where items could be ( problems , questions etc.

    

### 3.3. Issues management
As a team member of the qto
In order to achieve the best possible efficiency during the work on one or many projects
I want to be able to manage the issues in those projects. 

    

#### 3.3.1. Update existing Items
As an team member
In order to be able to manage new Items 
I want  to be able to create Items via the qto

    

#### 3.3.2. Remove existing Items
As an team member
In order to be able to stop the work on existing Items
I want to be able to remove Items via the qto

    

#### 3.3.3. Search for existing Items
As an team member
In order to be able to change attributes of the Items I am responsible for
I want to be able to update the Items' data. 

    

#### 3.3.4. Track Items progress
As an team member
In order to be able to quickly access existing Items
I want to be able to search the Items. 

    

#### 3.3.5. Track Items history
As a team member
In order to keep track on what and when was planned on daily basis
I wanto to be able to keep track what was planned on a project term  - day,week,month,year,quinquennial or decade  


    

### 3.4. Track issues relations
As a team member of a project
In order to trace the issues relations to userstories, features and tests or any other objects
I want to be able to access the related objects to an issue by means of a link

    

### 3.5. Items management
As a team member of the qto
In order to achieve the best posible efficiency during the work on one or many projects
I want to be able to manage the Items in those projects, where items could be ( problems , questions etc.

    

### 3.6. Measure success
As a team member
In order to measure the success of the planned issues 
I want  to be able to measure the deliverables of each issue by comparable metrics.

    

### 3.7. Monitor success
As a team member 
In order to monitor the success of the planned issues 
I want to  be able to monitor the metrics of the issues. 

    

### 3.8. Track issues relations
As a team member of a project
In order to trace the issues relations to userstories, features and tests or any other objects
I want to be able to access the related objects to an issue by means of a link

    

### 3.9. Time management
As an issues-manager 
In order to be prepared for issues such as ( events , tasks ) which have start and stop time
I want to  be able to save their start time and stop time per issue in every possible interface

    

#### 3.9.1. time centric planning
As an issues-manager 
In order to be able to plan the issues data for a certain term - day,week,month,year,quinquennial or decade
I want to be able to perform all the features of the qto on that specific period regardless whether it is today , in the past or in the future

    

#### 3.9.2. time centric reporting
As an issues-manager 
In order to be able to report the issues data for  a certain term - day,week,month,year,quinquennial or decade
I want to be able to perform all the features of the qto on that specific day regardless whether it is today , in the past or in the future

    

### 3.10. Project's persons issue combinations
As the project manager  of an qto project 
In order to be able to quickly and reliably combine the reported hours by the project's people
I want to be able to read their qto formatted google sheets and combine them into a single project's google qto sheet

    

## 4. PROJECT OBSERVER BIZ PERSPECTIVE
As a project observer 
In order to observe the advancement of a project  
I want to have a nice user experience while using the qto application.

    

### 4.1. Projects observation
As a project observer 
In order to observe the advancement of a project  
I want to be able to observe the project's data. 

    

### 4.2. Measure success
As a team member
In order to measure the success of the planned issues 
I want  to be able to measure the deliverables of each issue by comparable metrics.

    

### 4.3. Issues observation
As a project observer 
In order to observe the advancement of the project's issues  
I want to be able to observe the project's issues. 

    

### 4.4. Monitor success
As a team member 
In order to monitor the success of the planned issues 
I want to  be able to monitor the metrics of the issues. 

    

## 5. SYSADMIN PERSPECTIVE
As a sysadmin of the qto application 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 5.1. System deployability
As the SysAdmin 
In order to be able to provide access to a new database driven application to my organization
I want to be able to deploy an instance of the qto application and spawn a new project out of it in less than a hour from a clean Linux host including AWS.

    

### 5.2. Time management
As an issues-manager 
In order to be prepared for issues such as ( events , tasks ) which have start and stop time
I want to  be able to save their start time and stop time per issue in every possible interface

    

### 5.3. System stability
As the SysAdmin
In order to minimize downtimes and ensure continuous operations 
I want to the System containing the qto application to perform its defined functions on request without interruptions or unknown side effects

    

### 5.4. Generic CRUDS for items
As a team member
In order to be able to manage all the items in the application I have access to
I want to be able to create,update,delete and search for those items from the UI of the application.

    

### 5.5. System reliability
As the SysAdmin
In order to be able to rely on the operations of the tool
I want to the System containing the qto application to perform its functions as specified consistently 

    

### 5.6. Project's persons issue combinations
As the project manager  of an qto project 
In order to be able to quickly and reliably combine the reported hours by the project's people
I want to be able to read their qto formatted google sheets and combine them into a single project's google qto sheet

    

### 5.7. Ease of use
As the SysAdmin
In order to be efficient and decrease the amount of errors
I want to generally perform any command the system within the sysadmin scope via clean and memorable oneliners 

    

## 6. PROJECT OBSERVER BIZ PERSPECTIVE
As a project observer 
In order to observe the advancement of a project  
I want to have a nice user experience while using the qto application.

    

### 6.1. Security
As the SysAdmin
In order to be able to provide the best possible security level of operation for the qto instance I am responsible for
I want to have pre-defined and clear set of tasks and activities to perform related to the security. 

    

### 6.2. Projects observation
As a project observer 
In order to observe the advancement of a project  
I want to be able to observe the project's data. 

    

#### 6.2.1. Who logged in and out when
As the SysAdmin
In order to provide the best possible security for the data of my organisation 
I want to be able to provide easily and quickly answer to the question :
Who logged in and out when?

    

### 6.3. Issues observation
As a project observer 
In order to observe the advancement of the project's issues  
I want to be able to observe the project's issues. 

    

#### 6.3.1. Who changed what and why
As the SysAdmin
In order to provide the best possible security for the data of my organisation 
I want to be able to provide easily and quickly answer to the question :
Who changed what and why?

    

## 7. ETL AND INTEGRATIONS PERSPECTIVE
As an ETL and integrations specialist 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 7.1. System deployability
As the SysAdmin 
In order to be able to provide access to a new database driven application to my organization
I want to be able to deploy an instance of the qto application and spawn a new project out of it in less than a hour from a clean Linux host including AWS.

    

### 7.2. Database to json files data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data into a different storage format 
I want to be able to export the project db data into json files - one per table via a single shell call. 

    

### 7.3. System performance
As the SysAdmin 
In order to ensure the performance of the qto application
I want to the System containing the qto application to perform its functions within the defined performance criteria.

    

### 7.4. Json files to db data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data from json files into the db tables
I want to be able to import the exported json files ( one per table ) into the database. 

    

### 7.5. System stability
As the SysAdmin
In order to minimize downtimes and ensure continuous operations 
I want to the System containing the qto application to perform its defined functions on request without interruptions or unknown side effects

    

### 7.6. System reliability
As the SysAdmin
In order to be able to rely on the operations of the tool
I want to the System containing the qto application to perform its functions as specified consistently 

    

### 7.7. Xls-to-postgres-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data
 I want to be able to
use a single shell call to load all or chosen table(s) to the postgres db 

    

#### 7.7.1. error reporting in xls-to-postgres-db hierarchical data load 
As the Data Integrator
In order to be efficient while troubleshooting data loading errors 
I want to be able to see : 
 - which table's load failed
 - what was the error in failed to 

    

### 7.8. Ease of use
As the SysAdmin
In order to be efficient and decrease the amount of errors
I want to generally perform any command the system within the sysadmin scope via clean and memorable oneliners 

    

### 7.9. Security
As the SysAdmin
In order to be able to provide the best possible security level of operation for the qto instance I am responsible for
I want to have pre-defined and clear set of tasks and activities to perform related to the security. 

    

### 7.10. Project deployment
As a potential Developer of the qto or a qto application 
In order to have the easiest installation experience 
I want to be able to deploy fully functional development environment on a clean host in less than an hour with a single oneliner. 

    

### 7.11. System verifiability and testability
As an ITOPS 
In order to be able to rely on the operations of the tool 
 and manage easily its features and functionalities
I wanto the easily verify and  test parts or the whole System 
by issuing a single shell call.

    

## 8. DEVOPS PERSPECTIVE
As an ETL and integrations specialist 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 8.1. Clarity and brevity of the end to end tests
As an ITOPS 
In order to be able to verify all the features and functionalities of the tool within the System
I want to see the results of each test in 1 flow in the following format:.

    

### 8.2. Databases - local to remote and remote to local sync
As a DevOps Operator
In order to :
 - keep the dog-fooded local and remote db instances in sync
 - and have full mobile access via the web 
I wanto to :
 - be able to apply a full db dump remotely via a single one-liner 
 - both local to remote and remote to local



    

#### 8.2.1. Abort end-to-end tests on single test fail
As an ITOPS 
In order to be able to run continuously end-to-end tests and skip for several runs failing tests
I want to be able to configure the single e2e entry point script to skip certain tests, but report me what was skipped. 

    

### 8.3. Database to json files data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data into a different storage format 
I want to be able to export the project db data into json files - one per table via a single shell call. 

    

### 8.4. Logging
As a Full-Stack Developer
In order to quickly understand what is happening in the application
I want to have easy-to-use and highly customisable logging to both file and console.

    

### 8.5. Json files to db data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data from json files into the db tables
I want to be able to import the exported json files ( one per table ) into the database. 

    

#### 8.5.1. Control flow logging
As a CLI user 
In order to be able to understand what the issue tracker tool is executing
I want  to have configurable logging with stderr, stdout and file output

    

### 8.6. Xls-to-postgres-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data 
I want to be able to
use a single shell call to load all or chosen table(s) to the mysql db 

    

#### 8.6.1. Log entries format configuration
As a Full-Stack Developer
In order to be able to get the msg of any component of the application 
I want each log entry to content:
- the type of the entry - log , error, warn , fatal
- the timestamp of the log entry event 
- the name of the component issueing the msg and the line num of the src file 
- the msg as it was echoed by the application

    

### 8.7. Xls-to-postgres-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data
 I want to be able to
use a single shell call to load all or chosen table(s) to the postgres db 

    

#### 8.7.1. Single entry point for end to end tests
As an DevOps
In order to be able to verify all the features and functionalities of the tool within the System
I want to run a single shell call running all the end-to-end test of the application ensuring the specified features and functionalities.  

    

#### 8.7.2. Tool run log to human readable description
As a CLI user 
In order to be able to get a human readable description of the log of the specific run of the tool
I want to be able to translate the recorded uuid's in the execution run log to their respective records

    

### 8.8. Application's source code and documentation integrity
As a Full-Stack Developer
In order to make easy the entry of other developers to the projects
I want to be able to point to written documentation for user-stories, issues, features and functionalities, which will be linked to parts of the source code. 

    

### 8.9. System deployment
As a potential Developer of the qto or a qto application 
In order to have the easiest installation experience 
I want to be able to deploy fully functional development environment on a clean host in less than an hour with a single oneliner. 

    

#### 8.9.1. Userstories to test case relations
As a Developer 
In order to ensure the stability and expandability of the application
I want to be able to run for each implemented user-story a single test

    

#### 8.9.2. UUID trackability for test files and userstories
As a Developer 
In order to identify each user-story to be tested with its according test
I want to be able to track each user-story or test code entry point file by UUID.

    

### 8.10. System verifiability and testability
As an ITOPS 
In order to be able to rely on the operations of the tool 
 and manage easily its features and functionalities
I wanto the easily verify and  test parts or the whole System 
by issuing a single shell call.

    

#### 8.10.1. Components start run message print
As a CLI user 
In order to know when a component has been started
I want to be able to see the "START &lt;&lt;COMPONENT NAME&gt;&gt; on either the STDOUT or the log file of the component

    

#### 8.10.2. Tool exit with exit code and exit message
As a CLI user or calling  automated component
In order to be able to understand whether or not the execution of the call to the tool was successful or not 
I want to get the exit code from the tool execution and see the exit message

    

#### 8.10.3. Execution path tracing by UUID's
As a DevOps operator
Foreach execution run of the tool
I want to be able to walk trough the execution path of the tool programmatically. 

    

### 8.11. Logging
As a Full-Stack Developer
In order to quickly understand what is happening in the application
I want to have easy-to-use and highly customisable logging to both file and console.

    

#### 8.11.1. Issues directories naming conventions
As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
I want to be able to store large quantity of issues txt files by their date on daily, weekly, monthly, yearly and decadally basis

    

#### 8.11.2. Issues files naming conventions
As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
and open them quickly
I want to be able to just type the first letter in a text editor supporting select opened file by typing its first letter and jump to that file

    

#### 8.11.3. Issues files history
As a CLI user 
In order to be able quickly to search trough old issues 
I want to be able to access old issues files by their date held in their file names from the file system

    

#### 8.11.4. Issues files naming conventions
As a DevOps 
In order to be able quickly to access and manage programmatically issues
I want to be able to guess the file paths of the issues file by their date 

    

### 8.12. Application's source code and documentation integrity
As a Full-Stack Developer
In order to make easy the entry of other developers to the projects
I want to be able to point to written documentation for user-stories, issues, features and functionalities, which will be linked to parts of the source code. 

    

#### 8.12.1. Issues files naming conventions for the  project
As a DevOps 
In order to be able quickly to switch between different projects
I wanto to have the project name of the issues file in its name as the first token as follows:
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt;daily|weekly|monthly|yearly&gt;&gt;.txt

    

### 8.13. Configuration management


    

#### 8.13.1. a single route to copy paste the appConfig in json format
As a DevOps Operator 
In order to quickly dig out basic confs about the current project , I want to be able to have a route for that in the web ui ... so that I could quickly just copy paste that json ... or create another application.conf out of it ... 

    

#### 8.13.2. Issues files naming conventions for current date
As a DevOps 
In order to be able quickly and programmatically to go back in the history
I wanto to have the current registration date in the file name and path
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt;daily|weekly|monthly|yearly&gt;&gt;.txt

    

#### 8.13.3. Issues files naming conventions for the time frame
As a DevOps 
In order to be able quickly and programmatically to go back in the history
I want to have the current registration date in the file name and path
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt; ( daily|weekly|monthly|yearly) &gt;&gt;.txt

    

### 8.14. Issues transformations
As a cli user of the qto application 
In order to be able to sort the issues according to their attributes 
and edit them in both txt file and xls file
I want to be able to perform the following loads: 
txt-to-db - to load a txt file with issues to an issues table in db
db-to-xls - to load a xls file from db table to xls
xls-to-db - to load a xls file with issues to an issues table in db
db-to-txt - to load a txt file from db table 

    

#### 8.14.1. 
Load by txt-to-db action
As a cli user of the qto application 
in order to store my issues in structured form to db for further processing
I want to be able to load any issue file with a single line shell call to a db 

    

##### 8.14.1.1. Load issues file from file system to db
As a cli user of the qto application 
- in order to be able to handle issues from different projects
- and load them to db for further processing
I want to:  
- pre-set the variables of the project 
- and than load any issue file with a single line shell call to a db
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default

    

#### 8.14.2. Load issues by db-to-xls action
As a cli user of the qto application 
in order to be able to sort and edit my issues in Excel
I want to be able to unload my issues from one or many tables in the db at once in a single shell call

    

#### 8.14.3. Load issues by xls-to-db action
As a cli user of the qto application 
in order to store my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load 

    

##### 8.14.3.1. Load issues by xls-to-db action for insert or upset
As a cli user of the qto application 
in order to insert or upsert my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load and specifying upsert by adding the guid column to the xls sheet 

    

##### 8.14.3.2. Load issues by xls-to-db action by truncating or not the loadable table
As a cli user of the qto application 
in order to store my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 
by choosing the names of the tables to load 

    

#### 8.14.4. Load issues by db-to-txt
As a cli user of the qto application 
in order to store my issues in more structured data format for further processing
I want to :
- be able to load the issues for a period from the db to a file
- by choosing the names of the tables to load

    

##### 8.14.4.1. xls-to-db action load sort by issues prio attribute
As a cli user of the qto application 
during the db-to-txt action load
in order to understand the priority of my issues
I want to :
- be able to specify the order in the issues txt files lines to be based on the prio attribute 
by choosing the names of the tables to load

    

#### 8.14.5. Load issues file from db to file system
As a cli user of the qto application 
in order to store my issues in more structured data format for further processing
I want to :
- be able to load the issues for a period from the db to a file
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default

    

### 8.15. issues file filtering
As a CLI user 
In order to filter quickly my issues 
I want to  be able to show the issues with their categories of only certain status

    

### 8.16. Single shell call for projects switching
As an issues-manager 
In order to be able to switch between different projects quickly
I want to be able to issue a single shell call for loading a project's configuration
and run the issue-handler against this pre-loaded configuration

    

### 8.17. Issues publishing from shell calls
As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I want to be able to issue a single shell call for copying the current items data to a medium by specifying the tables to be published

    

#### 8.17.1. Issues publishing in e-mail format
As a DevOps 
In order to be able to quickly share the current issues data in email format
I want  to be able to issue a single shell call for copying the current items data to email by specifying the tables to be published

    

#### 8.17.2. Issues handling in google sheet format
As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I want  to be able to issue a single shell call for copying the current items data to google sheet by specifying the tables to be published

    

#### 8.17.3. Issues publishing in google calendar format
As a DevOps 
In order to be able to quickly share the current issues data in google calendar format
I want  to be able to issue a single shell call for copying the current items data to google calendar by specifying the tables to be published for the items having set start_time and stop_time attributes. 

    

### 8.18. Issues transformations
As a cli user of the qto application 
In order to be able to sort the issues according to their attributes 
and edit them in both txt file and xls file
I want to be able to perform the following loads: 
txt-to-db - to load a txt file with issues to an issues table in db
db-to-xls - to load a xls file from db table to xls
xls-to-db - to load a xls file with issues to an issues table in db

    

## 9. UI DEVELOPER PERSPECTIVE
As the UI Developer
In order to be able to deliver working solutions for the UI 
I want to have user friendly development experience. 

    

### 9.1. Easy setup for testability
5b04d8fa-1ebb-4fe7-a9ad-700c40a57f3c

    

### 9.2. Code traceability by uuid
As the UI Developer 
In order to be able to grasp the inner working of the application
I want to be able to search by user-story uuid from the source code of the application

    

### 9.3. Single shell call for projects switching
As an issues-manager 
In order to be able to switch between different projects quickly
I want to be able to issue a single shell call for loading a project's configuration
and run the issue-handler against this pre-loaded configuration

    

### 9.4. Issues publishing from shell calls
As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I want to be able to issue a single shell call for copying the current items data to a medium by specifying the tables to be published

    

### 9.5. Metadata handling
As a DevOps operator
In order to be able to programatically manage all aspects of my data
I wan to to have a single entry point to manage the meta data per tables , columns and UI elements
so that even a table, column or whatever object is not populated in the meta still there will be default values for it usable by the application.

    

### 9.6. Easy setup for testability
As the UI Developer
In order to deliver working ui units 
I want  to be able to quickly setup the existing project with minimalistic default set of data

    

