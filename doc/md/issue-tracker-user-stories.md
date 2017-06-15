#  ISSUE-TRACKER USERSTORIES AND SCENARIOIS


Table of Contents

  * [1. USERSTORIES BIZ](#1-userstories-biz)
    * [1.1. switch betweeen projects](#11-switch-betweeen-projects)
      * [1.1.1. current project visibility](#111-current-project-visibility)
    * [1.2. Track issues progress](#12-track-issues-progress)
      * [1.2.1. Measure success](#121-measure-success)
      * [1.2.2. Monitor success](#122-monitor-success)
    * [1.3. Track issues history](#13-track-issues-history)
    * [1.4. Time management](#14-time-management)
    * [1.5. Track issues relations](#15-track-issues-relations)
    * [1.6. access issues txt format from email](#16-access-issues-txt-format-from-email)
  * [2. DEVOPS USERSTORIES](#2-devops-userstories)
    * [2.1. System performance](#21-system-performance)
    * [2.2. System stability](#22-system-stability)
    * [2.3. System reliability](#23-system-reliability)
    * [2.4. System verifiability and testability](#24-system-verifiability-and-testability)
      * [2.4.1. Clarity and breavity of the end to end tests](#241-clarity-and-breavity-of-the-end-to-end-tests)
      * [2.4.2. Abort end-to-end tests on single test fail](#242-abort-end-to-end-tests-on-single-test-fail)
      * [2.4.3. control flow logging](#243-control-flow-logging)
      * [2.4.4. Single entry point for end to end tests](#244-single-entry-point-for-end-to-end-tests)
      * [2.4.5. tool run log to human readable description](#245-tool-run-log-to-human-readable-description)
      * [2.4.6. userstories to test case relations](#246-userstories-to-test-case-relations)
          * [2.4.6.1. UUID tracability for test files and userstories](#2461-uuid-tracability-for-test-files-and-userstories)
      * [2.4.7. components start run message print](#247-components-start-run-message-print)
      * [2.4.8. tool exit with exit code and exit message](#248-tool-exit-with-exit-code-and-exit-message)
      * [2.4.9. execution path tracing by UUID's](#249-execution-path-tracing-by-uuid's)
    * [2.5. Manage issues with a single txt file](#25-manage-issues-with-a-single-txt-file)
      * [2.5.1. Issues directories naming conventions](#251-issues-directories-naming-conventions)
      * [2.5.2. Issues files naming conventions](#252-issues-files-naming-conventions)
      * [2.5.3. Issues file open](#253-issues-file-open)
      * [2.5.4. Issues files history](#254-issues-files-history)
      * [2.5.5. Issues files naming conventions](#255-issues-files-naming-conventions)
          * [2.5.5.1. Issues files naming conventions for the  project](#2551-issues-files-naming-conventions-for-the-project)
          * [2.5.5.2. Issues files naming conventions for current date](#2552-issues-files-naming-conventions-for-current-date)
          * [2.5.5.3. Issues files naming conventions for the time frame](#2553-issues-files-naming-conventions-for-the-time-frame)
    * [2.6. Issues transformations](#26-issues-transformations)
      * [2.6.1. 
txt-to-db action load](#261-
txt-to-db-action-load)
          * [2.6.1.1. Load issues file from file system to db](#2611-load-issues-file-from-file-system-to-db)
      * [2.6.2. db-to-xls action load](#262-db-to-xls-action-load)
      * [2.6.3. xls-to-db action load](#263-xls-to-db-action-load)
      * [2.6.4. db-to-txt action load](#264-db-to-txt-action-load)
          * [2.6.4.1. xls-to-db action load sort by issues prio attribute](#2641-xls-to-db-action-load-sort-by-issues-prio-attribute)
          * [2.6.4.2. db-to-txt action load sort by issues start_time attribute](#2642-db-to-txt-action-load-sort-by-issues-start_time-attribute)
          * [2.6.4.3. db-to-txt action load sort by issues start_time attribute](#2643-db-to-txt-action-load-sort-by-issues-start_time-attribute)
      * [2.6.5. Load issues file from db to file system](#265-load-issues-file-from-db-to-file-system)
    * [2.7. issues file filtering](#27-issues-file-filtering)
    * [2.8. Single shell call for projects switching](#28-single-shell-call-for-projects-switching)
  * [3. UI USERSTORIES](#3-ui-userstories)
    * [3.1. Time management](#31-time-management)
    * [3.2. Issues listing](#32-issues-listing)
      * [3.2.1. Issues sorting in list view](#321-issues-sorting-in-list-view)
      * [3.2.2. issues re-ordering](#322-issues-re-ordering)
          * [3.2.2.1. issues re-ordering by category](#3221-issues-re-ordering-by-category)
          * [3.2.2.2. issues re-ordering by single issue](#3222-issues-re-ordering-by-single-issue)


## 1. USERSTORIES BIZ
This section contains the userstories from the business point of view. 

### 1.1. switch betweeen projects
As an issues-manager 
In order to manage issues from different projects  
I wanto to be able to switch between different projects easily and quickly

#### 1.1.1. current project visibility
As an issues-manager 
In order to avoid confusion betweeen different projects 
I wanto to be able to see the current project name from any interface I am working in quickly and esily. 

### 1.2. Track issues progress
As an issues-manager 
In order to keep track on what and when was accomplished vs. what was planned 
I wanto to be able to keep track on daily basis what was planned and what whas accomplished on a project daily, weekly, monthly and yearly issues. 

#### 1.2.1. Measure success
As an issues-manager 
In order to measure the success of the planned issues 
I wanto to be able to measure the deliverables of each issue by comparable metrics.

#### 1.2.2. Monitor success
As an issues-manager 
In order to monitor the success of the planned issues 
I wanto to be able to monitor the metrics of the issues. 

### 1.3. Track issues history
As an issues-manager 
In order to keep track on what and when was planned 
I wanto to be able to keep track on daily basis what was planned on a project daily, weekly, monthly and yearly issues. 

### 1.4. Time management
As an issues-manager 
In order to be prepare for issues such as ( events , tasks ) which have start and stop time
I wanto to be able to save their start_time and stop_time per issue in every possible interface

### 1.5. Track issues relations
As an issues-manager of a software related project 
In order to trace the issues relations to userstories, features and tests 
I wanto to be able to access the related objects to an issue by means of a link

### 1.6. access issues txt format from email
As a user of the issue tracker tool 
In order to be able to access and read my issues from a mobile device
I wanto to be able to send each period txt file from the daily folder via gmail. 

## 2. DEVOPS USERSTORIES
This section contains the userstories which could be accomplished by using the command line interface. 

### 2.1. System performance
As an ITOPS 
In order to ensure the performance of the System
I wanto the System containing the issue-tracker tool to perform its functions within the defined performance criteria

### 2.2. System stability
As an ITOPS 
In order to minimize downtimes and ensure continuous operations 
I wanto the System containing the issue-tracker tool to perform its defined functions on request without interruptions or unknown side effects

### 2.3. System reliability
As an ITOPS 
In order to be able to rely on the operations of the tool
I wanto the System containing the issue-tracker tool to perform its functions as specified consistently 

### 2.4. System verifiability and testability
As an ITOPS 
In order to be able to rely on the operations of the tool 
 and manage easily its features and functionalities
I wanto the easily verify and  test parts or the whole System

#### 2.4.1. Clarity and breavity of the end to end tests
As an ITOPS 
In order to be able to verify all the features and functionalities of the tool within the System
I want to see the results of each test in 1 fow in the following format:.

#### 2.4.2. Abort end-to-end tests on single test fail
As an ITOPS 
In order to be able to run continuously end-to-end tests and skip for several runs failing teists
I want to be able to configure the single e2e entry point script to skip certain tests, but report me what was skipped. 

#### 2.4.3. control flow logging
As a CLI user 
In order to be able to understand what the issue tracker tool is executing
I wanto to have configurable logging with stderr, stdout and file output

#### 2.4.4. Single entry point for end to end tests
As an ITOPS 
In order to be able to verify all the features and functionalities of the tool within the System
I want to run a single shell call running all the end-to-end test of the application ensuring the prespecified features and functionalities.  

#### 2.4.5. tool run log to human readable description
As a CLI user 
In order to be able to get a human readable description of the log of the specific run of the tool
I wanto to be able to translate the recorded uuid's in the execution run log to their respective records

#### 2.4.6. userstories to test case relations
As a Developer 
In order to ensure the stability and expandability of the application
I want to be able to run for each implemented userstory a single test

##### 2.4.6.1. UUID tracability for test files and userstories
As a Developer 
In order to identify each userstory to be tested with its according test
I want to be able to track each userstory or test code entry point file by UUID.

#### 2.4.7. components start run message print
As a CLI user 
In order to know when a component has been started
I wanto to be able to see the "START &lt;&lt;COMPONENT_NAME&gt;&gt; on either the STDOUT or the log file of the component

#### 2.4.8. tool exit with exit code and exit message
As a CLI user or calling calling automated component
In order to be able to understand whether or not the execution of the call to the tool was successful or not 
I wanto to get the exit code from the tool execution and see the exit message

#### 2.4.9. execution path tracing by UUID's
As a DevOps operator
Foreach execution run of the tool
I want to be able to walk trough the execution path of the tool programatically. 

### 2.5. Manage issues with a single txt file
As a CLI user 
In order to be able quickly to view my issues
I wanto to be able to manage my daily,weekly,monthly and yearly issues by simply editing and viewing a single txt file

#### 2.5.1. Issues directories naming conventions
As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
I wanto to be able to store large quantity of issues txt files by their date on daily, weekly, monthly and yearly basis

#### 2.5.2. Issues files naming conventions
As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
and open them quickly
I wanto to be able to just type the first letter in a text editor supporting select opened file by typing its first letter and jump to that file

#### 2.5.3. Issues file open
As a CLI user 
In order to be able quickly to access my issues ( daily , weekly, monthly , yearly )
I wanto to be able to view my daily issues by simply opening a single txt file

#### 2.5.4. Issues files history
As a CLI user 
In order to be able quickly to search trough old issues 
I wanto to be able to access old issues files by their date held in their file names from the file system

#### 2.5.5. Issues files naming conventions
As a DevOps 
In order to be able quickly to access and manage programatically issues
I wanto to be able to quess the file paths of the issues file by their date 

##### 2.5.5.1. Issues files naming conventions for the  project
As a DevOps 
In order to be able quickly to switch between different projects
I wanto to have the project name of the issues file in its name as the first token as follows:
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt;daily|weekly|monthly|yearly&gt;&gt;.txt

##### 2.5.5.2. Issues files naming conventions for current date
As a DevOps 
In order to be able quickly and programmatically to go back in the history
I wanto to have the current registration date in the file name and path
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt;daily|weekly|monthly|yearly&gt;&gt;.txt

##### 2.5.5.3. Issues files naming conventions for the time frame
As a DevOps 
In order to be able quickly and programmatically to go back in the history
I wanto to have the current registration date in the file name and path
&lt;&lt;issue_tracker_project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt; ( daily|weekly|monthly|yearly) &gt;&gt;.txt

### 2.6. Issues transformations
As an cli user of the System 
In order to be able to sort the issues according to their attributes 
and edit them in both txt file and xls filee
I wanto to be able to perform the following loads: 
txt-to-db - to load a txt file with issues to an issues table in db
db-to-xls - to load a xls file from db table to xls
xls-to-db - to load a xls file with issues to an issues taable in db
db-to-txt - to load a txt file from db table 

#### 2.6.1. 
txt-to-db action load
As an cli user of the System 
in order to store my issues in structured form to db for further processing
I want to be able to load any issue file with a single line shell call to a db 

##### 2.6.1.1. Load issues file from file system to db
As an cli user of the System 
- in order to be able to handle issues from different projects
- and load them to db for further processing
I want to:  
- pre-set the variables of the project 
- and than load any issue file with a single line shell call to a db
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default

#### 2.6.2. db-to-xls action load
As an cli user of the System 
in order to be able to sort and edit my issues in Excel
I want to be able to unload my issues from the issue relational table from db 

#### 2.6.3. xls-to-db action load
As an cli user of the System 
in order to store my issues in structured form to db for further processing after being sorted in Excel
I want to be able to load my latest xls file with a single line shell call to a db 

#### 2.6.4. db-to-txt action load
As an cli user of the System 
in order to store my isssues in more structurized data format for further procesing
I want to :
- be able to load the issues for a period from the db to a file
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default

##### 2.6.4.1. xls-to-db action load sort by issues prio attribute
As an cli user of the System 
during the db-to-txt action load
in order to understand the priority of my issues
I want to :
- be able to specify the order in the issues txt files lines to be based on the prio attribute 

##### 2.6.4.2. db-to-txt action load sort by issues start_time attribute
As an cli user of the System 
during the db-to-txt action load
in order to understand the priority of my issues
I want to :
- be able to specify the order in the issues txt files lines to be based on the start_time attribute ( start_time could be in the following format YYYY-mm-dd HH:MM in start_time or HH:MM  )

##### 2.6.4.3. db-to-txt action load sort by issues start_time attribute
As an cli user of the System 
during the db-to-txt action load
in order to view the issues by categories
I want to :
- be able to specify the order in the issues txt files lines to be based on the category attribute

#### 2.6.5. Load issues file from db to file system
As an cli user of the System 
in order to store my isssues in more structurized data format for further procesing
I want to :
- be able to load the issues for a period from the db to a file
- and optionally specify the period of the issues file ( daily , weekly , monthly , yearly ) with daily as default

### 2.7. issues file filtering
As a CLI user 
In order to filter quickly my issues 
I wanto to be able to show the issues with their categories of only certain status

### 2.8. Single shell call for projects switching
As an issues-manager 
In order to be able to switch between different projects quickly
I wanto to be able to issue a single shell call for loading a project's configuration
and run the issue-handler against this pre-loaded configurtion

## 3. UI USERSTORIES
This section contains the userstories which could be accomplished by using an Graphical User Interface. 

### 3.1. Time management
As an issues-manager 
In order to be prepare for issues such as ( events , tasks ) which have start and stop time
I wanto to be able to view the issues with the same title, start_time and stop_time in google calendar

### 3.2. Issues listing
As an UI user of the system I want to be able to list the issues stored in it. 

#### 3.2.1. Issues sorting in list view
As an UI user of the system I want to be able to sort the issues by :
- issue name
- issue priority
- issue start-time
- issue create-time
- issue update-time

#### 3.2.2. issues re-ordering
As a UI user 
In order to prioritize my issues 
I wanto to be able to drag and drop issues in the UI

##### 3.2.2.1. issues re-ordering by category
As a UI user 
In order to prioritize my issues 
I wanto to be able to drag and drop issues in the UI by category

##### 3.2.2.2. issues re-ordering by single issue
As a UI user 
In order to prioritize my issues 
I wanto to be able to drag and drop issues in the UI by single issue

