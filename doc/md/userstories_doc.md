#  USERSTORIES AND SCENARIOS
* [1. INTRO](#1-intro)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
  * [1.3. RELATED DOCUMENTATION](#13-related-documentation)
* [2. COMMON UI PERSPECTIVE](#2-common-ui-perspective)
  * [2.1. UI PERFORMANCE](#21-ui-performance)
  * [2.2. FORM FACTORS](#22-form-factors)
    * [2.2.1. Desktop PC form factor UI](#221-desktop-pc-form-factor-ui)
    * [2.2.2. Tablets form factor UI](#222-tablets-form-factor-ui)
    * [2.2.3. Advanced Mobile phones form factor UI](#223-advanced-mobile-phones-form-factor-ui)
  * [2.3. THE OMNI-SEARCH FEATURE](#23-the-omni-search-feature)
    * [2.3.1. List as grid page quick filtering](#231-list-as-grid-page-quick-filtering)
    * [2.3.2. View page quick filtering](#232-view-page-quick-filtering)
    * [2.3.3. Search results page quick filtering](#233-search-results-page-quick-filtering)
  * [2.4. THE LEFT MENU UI - ORGANISING THE STRUCTURE OF THE PROJECT](#24-the-left-menu-ui--organising-the-structure-of-the-project)
    * [2.4.1. Opening and closing of the left menu](#241-opening-and-closing-of-the-left-menu)
    * [2.4.2. Managing listings from the left menu](#242-managing-listings-from-the-left-menu)
    * [2.4.3. Managing documents from the left menu](#243-managing-documents-from-the-left-menu)
    * [2.4.4. Managing folders on the left menu](#244-managing-folders-on-the-left-menu)
  * [2.5. THE LIST PAGE UI](#25-the-list-page-ui)
    * [2.5.1. Search in the list page](#251-search-in-the-list-page)
    * [2.5.2. Items listing](#252-items-listing)
    * [2.5.3. Items editing](#253-items-editing)
      * [2.5.3.1. Items editing inline](#2531-items-editing-inline)
      * [2.5.3.2. Items editing via a modal dialog](#2532-items-editing-via-a-modal-dialog)
      * [2.5.3.3. Items editing via dropbox](#2533-items-editing-via-dropbox)
      * [2.5.3.4. Items editing via calendar control](#2534-items-editing-via-calendar-control)
    * [2.5.4. Items creation](#254-items-creation)
    * [2.5.5. Items deletion](#255-items-deletion)
    * [2.5.6. Items export](#256-items-export)
    * [2.5.7. Items import](#257-items-import)
  * [2.6. THE VIEW DOC PAGE UI](#26-the-view-doc-page-ui)
    * [2.6.1. View page navigation](#261-view-page-navigation)
      * [2.6.1.1. Title numbers link navigation and sharing](#2611-title-numbers-link-navigation-and-sharing)
      * [2.6.1.2. Title numbers link navigation and sharing](#2612-title-numbers-link-navigation-and-sharing)
      * [2.6.1.3. Access items by theirs ids](#2613-access-items-by-theirs-ids)
      * [2.6.1.4. Keyboard navigation and editing](#2614-keyboard-navigation-and-editing)
          * [2.6.1.4.1. Tabbing direction flow of tabbing](#26141-tabbing-direction-flow-of-tabbing)
          * [2.6.1.4.2. TOC keyboard navigation](#26142-toc-keyboard-navigation)
          * [2.6.1.4.3. Faster text editing when tabbing](#26143-faster-text-editing-when-tabbing)
    * [2.6.2. View doc page print preview](#262-view-doc-page-print-preview)
      * [2.6.2.1. Disable editing in print preview mode but keep the links](#2621-disable-editing-in-print-preview-mode-but-keep-the-links)
      * [2.6.2.2. Disable the right and left menus in print preview mode](#2622-disable-the-right-and-left-menus-in-print-preview-mode)
    * [2.6.3. Quick search in the view page ](#263-quick-search-in-the-view-page-)
    * [2.6.4. Hierarchical items management](#264-hierarchical-items-management)
      * [2.6.4.1. Add Item](#2641-add-item)
      * [2.6.4.2. Update item](#2642-update-item)
          * [2.6.4.2.1. Update item's title](#26421-update-item's-title)
          * [2.6.4.2.2. Update item's description](#26422-update-item's-description)
              * [2.6.4.2.2.1. Add interlinking in description](#264221-add-interlinking-in-description)
          * [2.6.4.2.3. Update item's src_code](#26423-update-item's-src_code)
      * [2.6.4.3. Delete item](#2643-delete-item)
    * [2.6.5. Move item in the hierarchy by drag and drop](#265-move-item-in-the-hierarchy-by-drag-and-drop)
      * [2.6.5.1. Move item in the hierarchy](#2651-move-item-in-the-hierarchy)
      * [2.6.5.2. Search in the right menu](#2652-search-in-the-right-menu)
      * [2.6.5.3. Links in the right menu](#2653-links-in-the-right-menu)
    * [2.6.6. Left menu navigation](#266-left-menu-navigation)
    * [2.6.7. Hierarchy management](#267-hierarchy-management)
      * [2.6.7.1. Single item move in the hierarchy ](#2671-single-item-move-in-the-hierarchy-)
      * [2.6.7.2. Single item move in the hierarchy ](#2672-single-item-move-in-the-hierarchy-)
    * [2.6.8. Pictures management in the view doc page](#268-pictures-management-in-the-view-doc-page)
      * [2.6.8.1. Add picture](#2681-add-picture)
      * [2.6.8.2. Edit picture](#2682-edit-picture)
          * [2.6.8.2.1. Resize picture](#26821-resize-picture)
          * [2.6.8.2.2. Move picture left and right in the item's paragraph](#26822-move-picture-left-and-right-in-the-item's-paragraph)
      * [2.6.8.3. Delete picture](#2683-delete-picture)
    * [2.6.9. Multimedia links management](#269-multimedia-links-management)
      * [2.6.9.1. Edit embedded multimedia link](#2691-edit-embedded-multimedia-link)
      * [2.6.9.2. Edit embedded multimedia link](#2692-edit-embedded-multimedia-link)
      * [2.6.9.3. Delete embedded multimedia link](#2693-delete-embedded-multimedia-link)
  * [2.7. THE GLOBAL SEARCH PAGE / THE SEARCH UI](#27-the-global-search-page-/-the-search-ui)
    * [2.7.1. Global search from the list page](#271-global-search-from-the-list-page)
    * [2.7.2. Global search from the view page](#272-global-search-from-the-view-page)
    * [2.7.3. Global search modal dialog ui](#273-global-search-modal-dialog-ui)
      * [2.7.3.1. Search-autocomplete on modal search dialog](#2731-search-autocomplete-on-modal-search-dialog)
  * [2.8. THE REPORT PAGE](#28-the-report-page)
  * [2.9. THE NOTES PAGE / UI](#29-the-notes-page-/-ui)
  * [2.10. THE CHAT UI](#210-the-chat-ui)
  * [2.11. MULTI-PROJECT AWARE UI](#211-multi-project-aware-ui)
    * [2.11.1. Items data transfer between different projects](#2111-items-data-transfer-between-different-projects)
    * [2.11.2. Items move](#2112-items-move)
  * [2.12. ISSUES IMPORT FROM GOOGLE CALENDAR](#212-issues-import-from-google-calendar)
* [3. TEAM LEADER BIZ PERSPECTIVE](#3-team-leader-biz-perspective)
  * [3.1. SECURITY](#31-security)
    * [3.1.1. Data security](#311-data-security)
    * [3.1.2. Roles management](#312-roles-management)
    * [3.1.3. Users management](#313-users-management)
      * [3.1.3.1. Users management in a project](#3131-users-management-in-a-project)
      * [3.1.3.2. Users management in a project](#3132-users-management-in-a-project)
      * [3.1.3.3. Personal data handling minimisation](#3133-personal-data-handling-minimisation)
  * [3.2. PROJECTS MANAGEMENT](#32-projects-management)
    * [3.2.1. Grant access per project](#321-grant-access-per-project)
  * [3.3. SECURE ACCESS TO DATA](#33-secure-access-to-data)
    * [3.3.1. Role based secure access to data per table or report for role](#331-role-based-secure-access-to-data-per-table-or-report-for-role)
    * [3.3.2. Role based secure access to data per row](#332-role-based-secure-access-to-data-per-row)
  * [3.4. TIME MANAGEMENT](#34-time-management)
    * [3.4.1. Closing of a period](#341-closing-of-a-period)
* [4. TEAM MEMBER BIZ PERSPECTIVE](#4-team-member-biz-perspective)
  * [4.1. ISSUES MANAGEMENT](#41-issues-management)
    * [4.1.1. Remove existing issues](#411-remove-existing-issues)
    * [4.1.2. Search for existing issues](#412-search-for-existing-issues)
    * [4.1.3. Track issues progress](#413-track-issues-progress)
    * [4.1.4. Track issues history](#414-track-issues-history)
  * [4.2. ITEMS MANAGEMENT](#42-items-management)
  * [4.3. ISSUES MANAGEMENT](#43-issues-management)
    * [4.3.1. Update existing Items](#431-update-existing-items)
    * [4.3.2. Remove existing Items](#432-remove-existing-items)
    * [4.3.3. Search for existing Items](#433-search-for-existing-items)
    * [4.3.4. Track Items progress](#434-track-items-progress)
    * [4.3.5. Track Items history](#435-track-items-history)
  * [4.4. TRACK ISSUES RELATIONS](#44-track-issues-relations)
  * [4.5. ITEMS MANAGEMENT](#45-items-management)
  * [4.6. MEASURE SUCCESS](#46-measure-success)
  * [4.7. MONITOR SUCCESS](#47-monitor-success)
  * [4.8. TRACK ISSUES RELATIONS](#48-track-issues-relations)
  * [4.9. TIME MANAGEMENT](#49-time-management)
    * [4.9.1. time centric planning](#491-time-centric-planning)
    * [4.9.2. time centric reporting](#492-time-centric-reporting)
  * [4.10. PROJECT'S PERSONS ISSUE COMBINATIONS](#410-project's-persons-issue-combinations)
* [5. PROJECT OBSERVER BIZ PERSPECTIVE](#5-project-observer-biz-perspective)
  * [5.1. PROJECTS OBSERVATION](#51-projects-observation)
  * [5.2. MEASURE SUCCESS](#52-measure-success)
  * [5.3. ISSUES OBSERVATION](#53-issues-observation)
  * [5.4. MONITOR SUCCESS](#54-monitor-success)
* [6. SYSADMIN PERSPECTIVE](#6-sysadmin-perspective)
  * [6.1. SYSTEM DEPLOYABILITY](#61-system-deployability)
  * [6.2. TIME MANAGEMENT](#62-time-management)
  * [6.3. SYSTEM STABILITY](#63-system-stability)
  * [6.4. GENERIC CRUDS FOR ITEMS](#64-generic-cruds-for-items)
  * [6.5. SYSTEM RELIABILITY](#65-system-reliability)
  * [6.6. PROJECT'S PERSONS ISSUE COMBINATIONS](#66-project's-persons-issue-combinations)
  * [6.7. EASE OF USE](#67-ease-of-use)
* [7. PROJECT OBSERVER BIZ PERSPECTIVE](#7-project-observer-biz-perspective)
  * [7.1. SECURITY](#71-security)
  * [7.2. PROJECTS OBSERVATION](#72-projects-observation)
    * [7.2.1. Who logged in and out when](#721-who-logged-in-and-out-when)
  * [7.3. ISSUES OBSERVATION](#73-issues-observation)
    * [7.3.1. Who changed what and why](#731-who-changed-what-and-why)
* [8. ETL AND INTEGRATIONS PERSPECTIVE](#8-etl-and-integrations-perspective)
  * [8.1. DATABASE TO JSON FILES DATA LOAD](#81-database-to-json-files-data-load)
  * [8.2. DATABASE METADATA EXPORT](#82-database-metadata-export)
  * [8.3. SYSTEM PERFORMANCE](#83-system-performance)
  * [8.4. JSON FILES TO DB DATA LOAD](#84-json-files-to-db-data-load)
  * [8.5. XLS-TO-POSTGRES-DB HIERARCHICAL DATA LOAD](#85-xls-to-postgres-db-hierarchical-data-load)
    * [8.5.1. error reporting in xls-to-postgres-db hierarchical data load ](#851-error-reporting-in-xls-to-postgres-db-hierarchical-data-load-)
  * [8.6. PROJECT DEPLOYMENT](#86-project-deployment)
* [9. DEVOPS ENGINEER PERSPECTIVE](#9-devops-engineer-perspective)
  * [9.1. DOCUMENTATION](#91-documentation)
    * [9.1.1. Quick start documentation](#911-quick-start-documentation)
    * [9.1.2. Application's source code and documentation integrity](#912-application's-source-code-and-documentation-integrity)
  * [9.2. INSTALLATION](#92-installation)
    * [9.2.1. A single shell call installation](#921-a-single-shell-call-installation)
    * [9.2.2. A reliable installation documentation](#922-a-reliable-installation-documentation)
  * [9.3. TESTING](#93-testing)
    * [9.3.1. Clarity and brevity of the end to end tests](#931-clarity-and-brevity-of-the-end-to-end-tests)
    * [9.3.2. Databases - local to remote and remote to local sync](#932-databases--local-to-remote-and-remote-to-local-sync)
    * [9.3.3. Abort end-to-end tests on single test fail](#933-abort-end-to-end-tests-on-single-test-fail)
    * [9.3.4. Userstories to test case relations](#934-userstories-to-test-case-relations)
    * [9.3.5. Single shell call for e2e testing](#935-single-shell-call-for-e2e-testing)
  * [9.4. ETL](#94-etl)
    * [9.4.1. Database to json files data load](#941-database-to-json-files-data-load)
    * [9.4.2. Items data transformations](#942-items-data-transformations)
    * [9.4.3. Json files to db data load](#943-json-files-to-db-data-load)
    * [9.4.4. Xls-to-postgres-db hierarchical data load](#944-xls-to-postgres-db-hierarchical-data-load)
    * [9.4.5. Log entries format configuration](#945-log-entries-format-configuration)
    * [9.4.6. Tool run log to human readable description](#946-tool-run-log-to-human-readable-description)
    * [9.4.7. UUID trackability for test files and userstories](#947-uuid-trackability-for-test-files-and-userstories)
    * [9.4.8. Components start run message print](#948-components-start-run-message-print)
    * [9.4.9. Tool exit with exit code and exit message](#949-tool-exit-with-exit-code-and-exit-message)
  * [9.5. RUN-TIME MANAGEMENT](#95-run-time-management)
    * [9.5.1. Logging](#951-logging)
    * [9.5.2. Single shell call for projects switching](#952-single-shell-call-for-projects-switching)
    * [9.5.3. Start and Stop of the Application](#953-start-and-stop-of-the-application)
  * [9.6. SECURITY](#96-security)
    * [9.6.1. Security modes](#961-security-modes)
* [10. UI DEVELOPER PERSPECTIVE](#10-ui-developer-perspective)
  * [10.1. FOREIGN KEYS (FK) CONFIGURABILITY](#101-foreign-keys-(fk)-configurability)
  * [10.2. CODE TRACEABILITY BY UUID](#102-code-traceability-by-uuid)
  * [10.3. SINGLE SHELL CALL FOR PROJECTS SWITCHING](#103-single-shell-call-for-projects-switching)
  * [10.4. ISSUES PUBLISHING FROM SHELL CALLS](#104-issues-publishing-from-shell-calls)
  * [10.5. METADATA HANDLING](#105-metadata-handling)
  * [10.6. EASY SETUP FOR TESTABILITY](#106-easy-setup-for-testability)




    

## 1. INTRO


    

### 1.1. Purpose
The purpose of this document is to present the userstories  in the qto application for the version of this instance. Simply stated this is the document, in which any user gets to express their wishes towards the qto application, but in structurized  manner.

    

### 1.2. Audience
This document is aimed for any potential and actual users of the qto application. Product Owners, Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for the application. 

    

### 1.3. Related documentation
This document is part of the QTO application documentation-set, which contains the following documents:
 - readme_doc-0 - the initial landing readme doc for the project
 - userstories_doc-0 - the collection of user-stories used to describe "what is desired"
 - requirements_doc-0 - the structured collection of the requirements 
 - system_guide_doc-0 - architecture and System description
 - devops_guide_doc-0 - a guide for the developers and devops operators
 - installations_doc-0 - a guide for installation of the application
 - enduser_guide_doc-0 - the guide for the usage of the UI ( mainly ) for the end-users
 - concepts_doc-0 - the concepts doc 

You can access all the latest  qto documentation from qto site: 
https://qto.fi
in it's native format.
All the documents are updated and redistributed in combination of the current version of the application in both md and pdf file format and can be found under the following directories:
 - doc/md
 - doc/pdf

    

## 2. COMMON UI PERSPECTIVE
As an UI user of the qto application 
In order to manage my issues via the UI successfully  
I want to have a nice user experience while using the qto application.

    

### 2.1. UI Performance
As an UI user of the qto application 
In order to enjoy the usage of the tool and interact efficiently   
I wan to to  have responsive and quick UI.

    

### 2.2. Form factors
As an UI user of the qto application 
In order to be able to be able to access from anywhere and anytime
I want to be able to use it with different form factor devices

    

#### 2.2.1. Desktop PC form factor UI
As an UI user of the qto application 
In order to be able to use it fully on the work-place
I want to it to work primarily on Desktop for every UI feature

    

#### 2.2.2. Tablets form factor UI
As an UI user of the qto application 
In order to be able to access it quickly on the go 
I want to  be able to use the same UI on an advanced tablets

    

#### 2.2.3. Advanced Mobile phones form factor UI
As an UI user of the qto application 
In order to be able to access it quickly on the go
I want to  be able to use the same UI on an advanced mobile phones. 

    

### 2.3. The Omni-search feature
As an UI user of the qto application
In order to have a consistent experience around all the user interfaces for search and get quickly to the information on EACH page and/or each table of the database
I want to be able to perform quick filtering on ALL the UI elements from the page from a single omni search-box placed at the top bar of the screen.

    

#### 2.3.1. List as grid page quick filtering
As an UI user of the qto application
In order to get quickly to the information on the listing as grid page
I want to be able to perform quick filtering on both the grid and the left menu.

    

#### 2.3.2. View page quick filtering
As an UI user of the qto application
In order to get quickly to the information on the view page
I want to be able to perform quick filtering on both the information on the view page and the left menu.

    

#### 2.3.3. Search results page quick filtering
As an UI user of the qto application
In order to get quickly to the information on the search as grid page
I want to be able to perform quick filtering on both the grid and the left and right menu.

    

### 2.4. The left menu UI - organising the structure of the project
As an UI user of the qto application
in order to be able to manage the whole structure of my project
I want to have access to a left menu from each page.

    

#### 2.4.1. Opening and closing of the left menu
As an UI user of the qto application
in order to be able to quickly get to different pages of the project
I want to be able to open the left menu by clicking on the top menu button and close it by clicking anywhere else in the document.

    

#### 2.4.2. Managing listings from the left menu
As an UI user of the qto application
in order to be able to store and track data from different listings or in different documents 
I want to be able to create new listings by simple right click on the left menu and selecting "add listing".

    

#### 2.4.3. Managing documents from the left menu
As an UI user of the qto application
in order to be able to store and track data from different listings or in different documents 
I want to be able to create new documents by simple right click on the right menu and selecting "add document".

    

#### 2.4.4. Managing folders on the left menu
As an UI user of the qto application
in order to be able to be able to organise the structure of my project
I want to be able to add, update and delete folders from the left menu

    

### 2.5. The list page UI
As an UI user of the qto application 
in order to be able to efficiently process relational data for any project 
I want to be able to list all or part of the project's database table via a single UI

    

#### 2.5.1. Search in the list page
As an UI user of the qto application
In order to be able to quickly and effortlessly search the content of the loaded document in the list page
I want to be able to focus the search-box with a single shortcut / click on the left menu, so that after typing 3 letters the left menu will get filtered by the search string and the table content will get filtered as well.

    

#### 2.5.2. Items listing
As an qto ui user 
In order to be able to quickly see as much items ( issues, problems, ideas etc. ) 
I want to list the items in a web page according to the filtering criteria I might have specified earlier on … 

    

#### 2.5.3. Items editing
aAs an UI user of the qto application 
In order to update the application data via the UI 
I wan to to be able to edit the data for ANY of the items in the application I have access to. 

    

##### 2.5.3.1. Items editing inline
As an UI user of the qto application 
In order to be able to quickly update the items data in a listing UI
I wan to to be able to edit it Excel table like by quickly navigating trough an grid and type the new values to update.

    

##### 2.5.3.2. Items editing via a modal dialog
As an UI user of the qto application 
In order to be able update the application data via the UI by using a more familiar form-like interface
I want to to be able to edit the data for any item by clicking on an edit button, and filling the fields of a form

    

##### 2.5.3.3. Items editing via dropbox
As an UI user of the qto application 
In order to be able to update foreign key tables data via the UI 
I want to to be able to edit the data for any item by : 
 - clicking on an a dropbox and either choosing or searching and choosing the human readable value

    

##### 2.5.3.4. Items editing via calendar control
As an UI user of the qto application 
In order to be able to update date-time data in the listing page via the UI
I want to to be able to edit the data for any item by : 
 - clicking on an a calendar control and choosing the date and the time from it

    

#### 2.5.4. Items creation
As an UI user of the application 
I order to create new items in the application 
I want to be able to create them via the UI 
by clicking "create new button" and filling as few as possible data entries and clicking a Save button for ANY of the items in the application. 

    

#### 2.5.5. Items deletion
As an UI user of the application 
I order to delete existing items in the project
I want to  be able to delete them via the UI 
by clicking a "delete " button and confirming the deletion for the item

    

#### 2.5.6. Items export
As an UI user of the application 
I order to export the data  of the items in the application 
I want to be able to perform the following data export from a single button click on the UI or a single url access:
 - export to md docs ( github , azure )
 - export to pdf docs
 - export to xls files
 - export to msft docx docs
 - export to json dump files 

    

#### 2.5.7. Items import
As an UI user of the application 
I order to import data  of the items in the application 
I want to  be able to perform the following data imports in the UI from a single button click and pointing to the file path of a file
 - import from md docs
 - import from pdf docs
 - import from xls files
 - import from msft docx docs
 - import from json dump files 

    

### 2.6. The view doc page UI
As an UI user of the qto application 
in order to be able to efficiently process hierarchical relational data for any project 
I want to be able to list all or part of the project's database table via a single UI

    

#### 2.6.1. View page navigation
As an UI user 
In order to quickly grasp the content of a view doc 
I want to be able to quickly and effortlessly navigate the view doc page.

    

##### 2.6.1.1. Title numbers link navigation and sharing
As an UI user 
In order to read the the current item in the top of the screen and to be able to refer it exactly with a link 
I want to be able on click the system to move it on the top of the screen and to change the url pointing to the exactly chosen item.

    

##### 2.6.1.2. Title numbers link navigation and sharing
As an UI user 
In order to read the the current item in the top of the screen and to be able to refer it exactly with a link 
I want to be able on click the system to move it on the top of the screen and to change the url so that when the link is copied one could refer to it by sending it.

    

##### 2.6.1.3. Access items by theirs ids
As an UI user
In order to be able to quickly access the content of a particular item
I want the System to be capable to scroll to it on the top of the view port of the page after I have clicked a link to it.

    

##### 2.6.1.4. Keyboard navigation and editing
As an UI user
In order to be able to quickly navigate throughout the whole page once loaded
I want to be able to cycle every manageable element of the page with the keyboard in a logical order from the top till the bottom

    

###### 2.6.1.4.1. Tabbing direction flow of tabbing
As an UI user
In order to be able to quickly navigate throughout the whole page once loaded
I want the cycling order to go from the omni-search box to the right-toc menu than to the titles and paragraphs of the document

    

###### 2.6.1.4.2. TOC keyboard navigation
As an UI user
In order to be able to quickly navigate throughout the Table Of Contents section on the right page menu
I want to be able to cycle every manageable element in the TOC menu with the keyboard in a logical order from the top till the bottom and get visual indication for the selected / active links from the UI.

    

###### 2.6.1.4.3. Faster text editing when tabbing
As an UI user
In order to be able to quickly delete text from the titles and/or the paragraphs
I want the UI to select the whole text of the title and the paragraphs while active, so that I could quickly copy or remove the text from the keyboard.

    

#### 2.6.2. View doc page print preview
As an UI user
In order to be able to share the documents of a qto application in pdf format or even physically print them
I want to be able to see the whole document or just a branch of it in print-preview mode

    

##### 2.6.2.1. Disable editing in print preview mode but keep the links
As an UI user 
In order to have as clean entity as possible to a pdf document I do not want to be able to add,edit or delete items from the print preview mode, however so that the clickable links should remain as part of the content

    

##### 2.6.2.2. Disable the right and left menus in print preview mode
As an UI User
In order to have as clean and easily printable document as possible in a pdf format I do not want to either see or access the right and left menu links.

    

#### 2.6.3. Quick search in the view page 
As an UI user of the qto application
In order to be able to quickly and effortlessly search the content of the loaded document in the view doc page
I want to be able to focus the search-box with a single shortcut / click and the document to be filtered by the content of the input search box, by highlighting the search item.

    

#### 2.6.4. Hierarchical items management
As an the ui user
In order to manage the hierarchical items in the application
I want to be able to manage by actions (list, create, update, delete, search) ANY hierarchical items of the application in from a hierarchical doc format by simply right clicking on their titles and choosing from the menut the action which must have both image and text to indicate more 

    

##### 2.6.4.1. Add Item
I want to be able to add items to the view page by simply right clicking the upper title of the item and selecting add item

    

##### 2.6.4.2. Update item
I want to be able to update items data to the view page

    

###### 2.6.4.2.1. Update item's title
I want to be able to update item's title by simply clicking in it and starting to type the new contents ...

    

###### 2.6.4.2.2. Update item's description
I want to be able to update item's descrption by simply clicking in it and starting to type the new contents ...

    

####### 2.6.4.2.2.1. Add interlinking in description


    

###### 2.6.4.2.3. Update item's src_code
I want to be able to update item's src_code by simply clicking in it and starting to type the new contents ...

    

##### 2.6.4.3. Delete item
As an UI user of the qto application
In order to quickly edit the structure of a hierarchical doc 
I want to be able to move item by drag and drop from the left menu.

    

#### 2.6.5. Move item in the hierarchy by drag and drop
As an the ui user
In order to navigate quickly in the document structure
I want to be able to see the document structure by clicking a right menu containing the Table of Contents of this document with a clickable links.


    

##### 2.6.5.1. Move item in the hierarchy
As an UI user of the qto application
In order to quickly edit the structure of a hierarchical doc 
I want to be able to move item by drag and drop from the left menu.

    

##### 2.6.5.2. Search in the right menu
As an the ui user
In order to navigate quickly in the document structure
I want to be able filter quickly the right menu items by the means of right menu quick srch/filtering box which will filter the items containing the string I am typing for dynamically

    

##### 2.6.5.3. Links in the right menu
As an the ui user
In order to navigate quickly in the document structure by levels
I want to be able to simply click on the links ( level 1 , level-2 , level-3 etc. ) which will open the document

    

#### 2.6.6. Left menu navigation
As an UI user of the qto application 
In order to be able to quickly jump to a different document / listing 
I want to be able to click on the upper left corner of the view page and access the hierarchical project structure of the whole project from the left menu.

    

#### 2.6.7. Hierarchy management
As an UI user of the qto application 
In order to be able to quickly jump to a different document / listing 
I want to be able to click on the upper left corner of the view page and access the hierarchical project structure of the whole project from the left menu.

    

##### 2.6.7.1. Single item move in the hierarchy 
As a qto application UI user 
In order to be able to move a single item anywhere in the hierarchy
I want to be able to move it by drag and drop on the left side of the document.

    

##### 2.6.7.2. Single item move in the hierarchy 
As a qto application UI user 
In order to be able to move a single item and all it's descendants anywhere in the hierarchy
I want to be able to move it by drag and drop on the left side of the document.

    

#### 2.6.8. Pictures management in the view doc page


    

##### 2.6.8.1. Add picture
As a qto application UI user 
In order to have pictures in the documents
I want to be able to add pictures by ...

    

##### 2.6.8.2. Edit picture
As a qto application UI user 
In order to have pictures in the documents
I want to be able to add pictures by ...

    

###### 2.6.8.2.1. Resize picture
As a qto application UI user 
In order to have a better visualisation of the pictures in the document
I want to be able to resize the pictures  pictures by simply dragging their corners

    

###### 2.6.8.2.2. Move picture left and right in the item's paragraph
As a qto application UI user 
In order to have a better visualisation of the pictures in the document
I want to be able to move the  pictures by simply dragging them left or right.

    

##### 2.6.8.3. Delete picture
As a qto application UI user 
In order to have pictures in the documents
I want to be able to delete pictures by ...

    

#### 2.6.9. Multimedia links management


    

##### 2.6.9.1. Edit embedded multimedia link


    

##### 2.6.9.2. Edit embedded multimedia link


    

##### 2.6.9.3. Delete embedded multimedia link


    

### 2.7. The global search page / the search UI
As an qto ui user 
In order to be able to search ANY items ( issues, problems, ideas etc. ) 
I want to have a pop-up search SearchBox with dimmed background providing with interactive autocomplete, which would assist me in specifying the search criteria for any item I want to list. 

    

#### 2.7.1. Global search from the list page
As an qto ui user 
In order to be able to search ANY items ( issues, problems, ideas etc. ) from the list page
I want to be able to search from the list page by simply clicking on a search textbox on the top left of the page, typing the search phrase I want to search for and getting the results by hitting enter or clicking the search icon on the right of the search box ...

    

#### 2.7.2. Global search from the view page
As an qto ui user 
In order to be able to search ANY items ( issues, problems, ideas etc. ) from the view page
I want to be able to search from the view page by simply clicking on a search icon ( might be the / shortcut as well ) , the system should bring up a modal dialog with the global search ui, than I should be able to type the search phrase I want to search for and hit enter, when the System should present me the search results.

    

#### 2.7.3. Global search modal dialog ui
As an UI user 
In order to have the best possible search experience
I want to be able to search from a modal dialog UI which will pop-up on a dimmed background after the search-box is focused .. 

    

##### 2.7.3.1. Search-autocomplete on modal search dialog
As an UI user 
In order to get quickly to exactly the searched item I am searching for
I want the System to present me with autocomplete of the mostly occurring string I am searching for with the name of the item on the left and when clicking on it I want it to open the list as grid page with all the items having this item in the search ... 

    

### 2.8. The report page
As the UI of the qto application
In order to be able to quickly view the results of predefined reports ( which are actually stored_procedures in the product databases ) 
I want to be able to execute an report by providing the following syntax

     <<server>>:<<port>>/<<proj-db>>/report/<<stored-procedure-name>>?p_01=<<parameter-01-value>>&?p_02=<<parameter-02-value>> ... 

### 2.9. The notes page / UI
The 7 sticky notes would be used for practising :
 - the cruds with web sockets
 - the per user data management

    

### 2.10. The chat UI
As UI user
In order to be able to quickly communicate on anything with other qto users of the qto applications 
I want to be able to use a quick chat with other users within the application instance

    

### 2.11. Multi-project aware UI
As the UI user of an qto instance 
In order to save be able to track my personal time usage between different projects and the different interdependencies 
I want to be able to move items data from one project to another via the UI.

    

#### 2.11.1. Items data transfer between different projects
As the UI user of an qto instance 
In order to manage multiple projects efficiently
I want to be able to move items data from one project to another via the UI in a trusted manner.

    

#### 2.11.2. Items move
As an UI user of the application 
I order to move the items into different tables
I want to  be able to move them from a button in the listing page by specifying the target table

    

### 2.12. Issues import from Google calendar
As the UI user of an qto instance 
In order to be able to visualise and manage my  start- and stop_time having issues better 
I want to  be able to import my Google calendar issues into my qto profile on an qto instance

    

## 3. TEAM LEADER BIZ PERSPECTIVE
As a team leader
In order to operate successfully one or many projects of my team(s)  
I want to have a nice user experience while using the qto tool.

    

### 3.1. Security


    

#### 3.1.1. Data security
As the biz team leader In order to protect the data of the project, which is vital for its existence \nI don't want any person but me to have full visibility and control of the data in a project.

    

#### 3.1.2. Roles management
As the Instance Owner or Product Owner 
in order to have a finer granularity on the different data stored in my instance 
I want to be able to define roles and per roles visibility on : 
 - item page level 
 - item row level
 - item tag level

    

#### 3.1.3. Users management
As a team leader 
In order provide the persons and programs access to my project
I want to provide read, write access to the data and execute access ( run DDL's) per table

    

##### 3.1.3.1. Users management in a project
As an team leader
In order to be able to efficiently allocate human resources to a project
I want to be able manage ( create , update , delete and search ) users for each project.

    

##### 3.1.3.2. Users management in a project
As an team leader
In order to be able to efficiently allocate human resources to a project
I want to be able manage ( create , update , delete and search ) users for each project.

    

##### 3.1.3.3. Personal data handling minimisation
As a team leader 
In order to avoid legal obligations and complex procedures, while handling personal data
I want to be able to handle the interpersonal exchange of data by collecting ONLY the e-mail of the persons or programs participating in the project.

    

### 3.2. Projects management
As an team leader
In order to be able to manage multiple projects 
I want to  be able to create , update and remove projects.

    

#### 3.2.1. Grant access per project
As a team leader 
In order to enrol authenticated users into the project I am responsible to 
I want to be able to grant them with access by only writing their e-mail into a text field and clicking invite button. 

    

### 3.3. Secure access to data
As the team leader of a qto project
In order 
I want to be able to grant separate read, write and execute access per table and role

    

#### 3.3.1. Role based secure access to data per table or report for role
As the team leader of a qto project
In order to restrict the certain operations to certain tables for the authenticated roles
I want to be able to grant separate read, write and execute access per table and role.

    

#### 3.3.2. Role based secure access to data per row
As the team leader of a qto project
In order 
I want to be able to grant separate read, write and execute access per table and role

    

### 3.4. Time management
As an team leader
In order to be able the maximise the performance of the team for qto used periods 
I want to to be able to manage time efficiently 
by accessing a simple page containing its value and the period it is related to.

    

#### 3.4.1. Closing of a period
As the team leader of a qto project
In order to keep track the history of 
I want to to be able to manage time efficiently 
by accessing a simple page containing its value and the period it is related to.

    

## 4. TEAM MEMBER BIZ PERSPECTIVE
As a team member
In order to operate successfully in the project  
I want to have a nice user experience while using the qto application
by being able to manage all the items in the application ( issues,questions,problems , etc. ) 

    

### 4.1. Issues management
As a team member of the qto
In order to achieve the best possible efficiency during the work on one or many projects
I want to be able to manage the issues in those projects. 

    

#### 4.1.1. Remove existing issues
As an team member
In order to be able to stop the work on existing issues
I want to be able to remove issues via the qto

    

#### 4.1.2. Search for existing issues
As an team member
In order to be able to change attributes of the issues I am responsible for
I want to be able to update the issues' data. 

    

#### 4.1.3. Track issues progress
As an team member
In order to be able to quickly access existing issues
I want to be able to search the issues. 

    

#### 4.1.4. Track issues history
As a team member
In order to keep track on the changes of the issues
I want to be able to follow the history of the changes


    

### 4.2. Items management
As a team member of the qto
In order to achieve the best posible efficiency during the work on one or many projects
I want to be able to manage the Items in those projects, where items could be ( problems , questions etc.

    

### 4.3. Issues management
As a team member of the qto
In order to achieve the best possible efficiency during the work on one or many projects
I want to be able to manage the issues in those projects. 

    

#### 4.3.1. Update existing Items
As an team member
In order to be able to manage new Items 
I want  to be able to create Items via the qto

    

#### 4.3.2. Remove existing Items
As an team member
In order to be able to stop the work on existing Items
I want to be able to remove Items via the qto

    

#### 4.3.3. Search for existing Items
As an team member
In order to be able to change attributes of the Items I am responsible for
I want to be able to update the Items' data. 

    

#### 4.3.4. Track Items progress
As an team member
In order to be able to quickly access existing Items
I want to be able to search the Items. 

    

#### 4.3.5. Track Items history
As a team member
In order to keep track on what and when was planned on daily basis
I wanto to be able to keep track what was planned on a project term  - day,week,month,year,quinquennial or decade  


    

### 4.4. Track issues relations
As a team member of a project
In order to trace the issues relations to userstories, features and tests or any other objects
I want to be able to access the related objects to an issue by means of a link

    

### 4.5. Items management
As a team member of the qto
In order to achieve the best posible efficiency during the work on one or many projects
I want to be able to manage the Items in those projects, where items could be ( problems , questions etc.

    

### 4.6. Measure success
As a team member
In order to measure the success of the planned issues 
I want  to be able to measure the deliverables of each issue by comparable metrics.

    

### 4.7. Monitor success
As a team member 
In order to monitor the success of the planned issues 
I want to  be able to monitor the metrics of the issues. 

    

### 4.8. Track issues relations
As a team member of a project
In order to trace the issues relations to userstories, features and tests or any other objects
I want to be able to access the related objects to an issue by means of a link

    

### 4.9. Time management
As an issues-manager 
In order to be prepared for issues such as ( events , tasks ) which have start and stop time
I want to  be able to save their start time and stop time per issue in every possible interface

    

#### 4.9.1. time centric planning
As an issues-manager 
In order to be able to plan the issues data for a certain term - day,week,month,year,quinquennial or decade
I want to be able to perform all the features of the qto on that specific period regardless whether it is today , in the past or in the future

    

#### 4.9.2. time centric reporting
As an issues-manager 
In order to be able to report the issues data for  a certain term - day,week,month,year,quinquennial or decade
I want to be able to perform all the features of the qto on that specific day regardless whether it is today , in the past or in the future

    

### 4.10. Project's persons issue combinations
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

    

### 6.1. System deployability
As the SysAdmin 
In order to be able to provide access to a new database driven application to my organization
I want to be able to deploy an instance of the qto application and spawn a new project out of it in less than a hour from a clean Linux host including AWS.

    

### 6.2. Time management
As an issues-manager 
In order to be prepared for issues such as ( events , tasks ) which have start and stop time
I want to  be able to save their start time and stop time per issue in every possible interface

    

### 6.3. System stability
As the SysAdmin
In order to minimize downtimes and ensure continuous operations 
I want to the System containing the qto application to perform its defined functions on request without interruptions or unknown side effects

    

### 6.4. Generic CRUDS for items
As a team member
In order to be able to manage all the items in the application I have access to
I want to be able to create,update,delete and search for those items from the UI of the application.

    

### 6.5. System reliability
As the SysAdmin
In order to be able to rely on the operations of the tool
I want to the System containing the qto application to perform its functions as specified consistently 

    

### 6.6. Project's persons issue combinations
As the project manager  of an qto project 
In order to be able to quickly and reliably combine the reported hours by the project's people
I want to be able to read their qto formatted google sheets and combine them into a single project's google qto sheet

    

### 6.7. Ease of use
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

    

## 8. ETL AND INTEGRATIONS PERSPECTIVE
As an ETL and integrations specialist 
In order to complete the tasks and activities of my role
I want to have a nice user experience while using the qto application.

    

### 8.1. Database to json files data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data into a different storage format 
I want to be able to export the project db data into json files - one per table via a single shell call. 

    

### 8.2. Database metadata export
As the ETL and Integration Specialists
In order to be able to show, communicate and store the meta-data of my application
I want to be able to export the project's database meta-data into an xls file.

    

### 8.3. System performance
As the SysAdmin 
In order to ensure the performance of the qto application
I want to the System containing the qto application to perform its functions within the defined performance criteria.

    

### 8.4. Json files to db data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data from json files into the db tables
I want to be able to import the exported json files ( one per table ) into the database. 

    

### 8.5. Xls-to-postgres-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data
 I want to be able to
use a single shell call to load all or chosen table(s) to the postgres db 

    

#### 8.5.1. error reporting in xls-to-postgres-db hierarchical data load 
As the Data Integrator
In order to be efficient while troubleshooting data loading errors 
I want to be able to see : 
 - which table's load failed
 - what was the error in failed to 

    

### 8.6. Project deployment
As a potential Developer of the qto or a qto application 
In order to have the easiest installation experience 
I want to be able to deploy fully functional development environment on a clean host in less than an hour with a single oneliner. 

    

## 9. DEVOPS ENGINEER PERSPECTIVE
As a qto devops engineer
In order to be efficient and decrease the amount of errors
I want to generally perform any command the system within the sysadmin scope via clean and memorable oneliners 

    

### 9.1. Documentation


    

#### 9.1.1. Quick start documentation
As a Full-Stack Developer
In order to be able to quickly start on my own hacking the project
I want to have a quick start documentation, which will simply guide me to start on my own.

    

#### 9.1.2. Application's source code and documentation integrity
As a Full-Stack Developer
In order to make easy the entry of other developers to the projects
I want to be able to point to written documentation for user-stories, issues, features and functionalities, which will be linked to parts of the source code. 

    

### 9.2. Installation


    

#### 9.2.1. A single shell call installation
As a potential Developer of the qto or a qto application 
In order to have the easiest installation experience 
I want to be able to deploy fully functional development environment on a clean host in less than an hour with a single oneliner. 

    

#### 9.2.2. A reliable installation documentation
As a potential DevOps engineer of the qto or a qto application 
In order to have the easiest installation experience 
I want to have a reliable documentation, which will have short commands 

    

### 9.3. Testing
As a qto devops engineer 
In order to be able to rely on the operations of the tool 
 and manage easily its features and functionalities
I want to the easily verify and  test parts or the whole System 
by issuing a single shell call.

    

#### 9.3.1. Clarity and brevity of the end to end tests
As an ITOPS 
In order to be able to verify all the features and functionalities of the tool within the System
I want to see the results of each test in 1 flow in the following format:.

    

#### 9.3.2. Databases - local to remote and remote to local sync
As a DevOps Operator
In order to :
 - keep the dog-fooded local and remote db instances in sync
 - and have full mobile access via the web 
I wanto to :
 - be able to apply a full db dump remotely via a single one-liner 
 - both local to remote and remote to local



    

#### 9.3.3. Abort end-to-end tests on single test fail
As an ITOPS 
In order to be able to run continuously end-to-end tests and skip for several runs failing tests
I want to be able to configure the single e2e entry point script to skip certain tests, but report me what was skipped. 

    

#### 9.3.4. Userstories to test case relations
As a Developer 
In order to ensure the stability and expandability of the application
I want to be able to run for each implemented user-story a single test.

    

#### 9.3.5. Single shell call for e2e testing
As an DevOps
In order to be able to verify all the features and functionalities of the tool within the System
I want to run a single shell call running all the end-to-end test of the application ensuring the specified features and functionalities.  

    

### 9.4. ETL


    

#### 9.4.1. Database to json files data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data into a different storage format 
I want to be able to export the project db data into json files - one per table via a single shell call. 

    

#### 9.4.2. Items data transformations
As a cli user of the qto application 
In order to be able to sort the issues according to their attributes 
and edit them in both txt file and xls file
I want to be able to perform the following loads: 
txt-to-db - to load a txt file with issues to an issues table in db
db-to-xls - to load a xls file from db table to xls
xls-to-db - to load a xls file with issues to an issues table in db
db-to-txt - to load a txt file from db table 

    

#### 9.4.3. Json files to db data load
As the ETL and Integration Specialist 
In order to be able to quickly move all the project data from json files into the db tables
I want to be able to import the exported json files ( one per table ) into the database. 

    

#### 9.4.4. Xls-to-postgres-db hierarchical data load
As the Data Integrator
In order to be efficient while handling the System's hierarchical data 
I want to be able to
use a single shell call to load all or chosen table(s) to the mysql db 

    

#### 9.4.5. Log entries format configuration
As a Full-Stack Developer
In order to be able to get the msg of any component of the application 
I want each log entry to content:
- the type of the entry - log , error, warn , fatal
- the timestamp of the log entry event 
- the name of the component issueing the msg and the line num of the src file 
- the msg as it was echoed by the application

    

#### 9.4.6. Tool run log to human readable description
As a CLI user 
In order to be able to get a human readable description of the log of the specific run of the tool
I want to be able to translate the recorded uuid's in the execution run log to their respective records

    

#### 9.4.7. UUID trackability for test files and userstories
As a Developer 
In order to identify each user-story to be tested with its according test
I want to be able to track each user-story or test code entry point file by UUID.

    

#### 9.4.8. Components start run message print
As a CLI user 
In order to know when a component has been started
I want to be able to see the "START &lt;&lt;COMPONENT NAME&gt;&gt; on either the STDOUT or the log file of the component

    

#### 9.4.9. Tool exit with exit code and exit message
As a CLI user or calling  automated component
In order to be able to understand whether or not the execution of the call to the tool was successful or not 
I want to get the exit code from the tool execution and see the exit message

    

### 9.5. Run-time management


    

#### 9.5.1. Logging
As a Full-Stack Developer
In order to quickly understand what is happening in the application
I want to have easy-to-use and highly customisable logging to both file and console.

    

#### 9.5.2. Single shell call for projects switching
As a qto DevOps engineer
In order to be able to switch between different projects quickly in the shell 
I want to be able to issue a single shell call for loading a project's configuration
and run the qto tool against the predefined configuration of an qto project's configuration.

    

#### 9.5.3. Start and Stop of the Application
As a qto DevOps engineer
In order to be able to quickly start and stop the qto application
I want to have a single shell call for those actions, with no other configuration, run-time or binary dependencies.

    

### 9.6. Security


    

#### 9.6.1. Security modes
As a qto DevOps engineer
In order to be able to effortlessly develop the application
I want to have 3 Security Modes, which could be changed during the restart of the application, by a simple ENV var:
 - No Auth - no auth whatsoever - so that I could be able to concentrate on non-security issues
 - Simple Native Auth mode - every team member can do anything on each item ( excepts the users)
 - RBAC Native Auth mode - configurability via db for which role, can perform what action on which item 

    

## 10. UI DEVELOPER PERSPECTIVE
As the UI Developer
In order to be able to deliver working solutions for the UI 
I want to have user friendly development experience. 

    

### 10.1. Foreign Keys (FK) configurability
As the UI Developer 
In order to be able to be able to quickly display FK table values as drop boxes 
I want to be able to configure from the meta_columns table :
 - the table from which the drop box will fetch it's values ( if not defined use the &lt;&lt;table&gt;&gt;_guid
 - the attribute name from which the drop down list will be built

    

### 10.2. Code traceability by uuid
As the UI Developer 
In order to be able to grasp the inner working of the application
I want to be able to search by user-story uuid from the source code of the application

    

### 10.3. Single shell call for projects switching
As an issues-manager 
In order to be able to switch between different projects quickly
I want to be able to issue a single shell call for loading a project's configuration
and run the issue-handler against this pre-loaded configuration

    

### 10.4. Issues publishing from shell calls
As a DevOps 
In order to be able to quickly share the current issues data in tabular format
I want to be able to issue a single shell call for copying the current items data to a medium by specifying the tables to be published

    

### 10.5. Metadata handling
As a DevOps operator
In order to be able to programatically manage all aspects of my data
I wan to to have a single entry point to manage the meta data per tables , columns and UI elements
so that even a table, column or whatever object is not populated in the meta still there will be default values for it usable by the application.

    

### 10.6. Easy setup for testability
As the UI Developer
In order to deliver working ui units 
I want  to be able to quickly setup the existing project with minimalistic default set of data

    

