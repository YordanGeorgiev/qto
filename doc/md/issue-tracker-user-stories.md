#  ISSUE-TRACKER USERSTORIES


Table of Contents

  * [1. USERSTORIES BIZ](#1-userstories-biz)
    * [1.1. Track issues history](#11-track-issues-history)
    * [1.2. Track issues progress](#12-track-issues-progress)
      * [1.2.1. Measure success](#121-measure-success)
      * [1.2.2. Monitor success](#122-monitor-success)
    * [1.3. Time management](#13-time-management)
    * [1.4. Track issues from different projects](#14-track-issues-from-different-projects)
  * [2. CLI USERSTORIES](#2-cli-userstories)
    * [2.1. Issues into single file](#21-issues-into-single-file)
      * [2.1.1. Issues directories naming conventions](#211-issues-directories-naming-conventions)
      * [2.1.2. Issues files naming conventions](#212-issues-files-naming-conventions)
      * [2.1.3. Issues file open](#213-issues-file-open)
      * [2.1.4. Issues files history](#214-issues-files-history)
      * [2.1.5. Issues files naming conventions](#215-issues-files-naming-conventions)
          * [2.1.5.1. Issues files naming conventions for the  project](#2151-issues-files-naming-conventions-for-the-project)
          * [2.1.5.2. Issues files naming conventions for current date](#2152-issues-files-naming-conventions-for-current-date)
          * [2.1.5.3. Issues files naming conventions for the time frame](#2153-issues-files-naming-conventions-for-the-time-frame)
    * [2.2. Issues file sorting](#22-issues-file-sorting)
      * [2.2.1. Load issues file from file system to db](#221-load-issues-file-from-file-system-to-db)
      * [2.2.2. Load issues file from db to file system](#222-load-issues-file-from-db-to-file-system)
    * [2.3. issues file filtering](#23-issues-file-filtering)
    * [2.4. Single shell call for projects switching](#24-single-shell-call-for-projects-switching)
  * [3. UI USERSTORIES](#3-ui-userstories)
    * [3.1. Issues listing](#31-issues-listing)
      * [3.1.1. Issues sorting in list view](#311-issues-sorting-in-list-view)
      * [3.1.2. issues re-ordering](#312-issues-re-ordering)
      * [3.1.3. Scenario 1: issues reordering by category](#313-scenario-1-issues-reordering-by-category)
      * [3.1.4. Scenario 2: issues reordering one-by-one](#314-scenario-2-issues-reordering-one-by-one)


## 1. USERSTORIES BIZ


### 1.1. Track issues history
As an issues-manager 
In order to keep track on what and when was planned 
I wanto to be able to keep track on daily basis what was planned on a project daily, weekly, monthly and yearly issues. 

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

### 1.3. Time management
As an issues-manager 
In order to be prepare for issues such as ( events , tasks ) which have start and stop time
I wanto to be able to save their start_time and stop_time in a standard manner

### 1.4. Track issues from different projects
As an issues-manager 
In order to manage issues from different projects  
I wanto to be able to switch between different projects quickly

## 2. CLI USERSTORIES
This section contains the userstories which could be accomplished by using the command line interface. 

### 2.1. Issues into single file
As a CLI user 
In order to be able quickly to view my issues
I wanto to be able to manage my daily issues by simply editing and viewing a single txt file

#### 2.1.1. Issues directories naming conventions
As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
I wanto to be able to store large quantity of issues txt files by their date on daily, weekly, monthly and yearly basis

#### 2.1.2. Issues files naming conventions
As a issues manager
In order to be able to manage lots of issues from different projects stored in plain txt files 
and open them quickly
I wanto to be able to just type the first letter in a text editor supporting select opened file by typing its first letter and jump to that file

#### 2.1.3. Issues file open
As a CLI user 
In order to be able quickly to access my issues ( daily , weekly, monthly , yearly )
I wanto to be able to view my daily issues by simply opening a single txt file

#### 2.1.4. Issues files history
As a CLI user 
In order to be able quickly to search trough old issues
I wanto to be able to access old issues files by their date held in their file names

#### 2.1.5. Issues files naming conventions
As a DevOps 
In order to be able quickly to access and manage programatically issues
I wanto to be able to quess the file paths of the issues file by their date 

##### 2.1.5.1. Issues files naming conventions for the  project
As a DevOps 
In order to be able quickly to switch between different projects
I wanto to have the project name of the issues file in its name as the first token as follows:
&lt;&lt;project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt;daily|weekly|monthly|yearly&gt;&gt;.txt

##### 2.1.5.2. Issues files naming conventions for current date
As a DevOps 
In order to be able quickly and programmatically to go back in the history
I wanto to have the current registration date in the file name and path
&lt;&lt;project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt;daily|weekly|monthly|yearly&gt;&gt;.txt

##### 2.1.5.3. Issues files naming conventions for the time frame
As a DevOps 
In order to be able quickly and programmatically to go back in the history
I wanto to have the current registration date in the file name and path
&lt;&lt;project&gt;&gt;-issues.&lt;&lt;current-iso-date&gt;&gt;.&lt;&lt; ( daily|weekly|monthly|yearly) &gt;&gt;.txt

### 2.2. Issues file sorting
As an cli user of the System I wanto to be able to write my issues in the txt file, quickly import them to a relational db. Sort and rearranged the data in the db and than quickly export the ready issue file. 

#### 2.2.1. Load issues file from file system to db
As an cli user of the System I want to be able to load any issue file with a single line shell call to a db. 

#### 2.2.2. Load issues file from db to file system
As an cli user of the System I want to be able to load any issue file with a single line shell call to a db
I wanto to be able to sort the issues in the db while doing the export. 

### 2.3. issues file filtering
As a CLI user 
In order to filter quickly my issues 
I wanto to be able to show the issues with their categories of only certain status

### 2.4. Single shell call for projects switching
As an issues-manager 
In order to be able to switch between different projects quickly
I wanto to be able to issue a single shell call for loading a project's configuration
and run the issue-handler against this pre-loaded configurtion

## 3. UI USERSTORIES
This section contains the userstories which could be accomplished by using an Graphical User Interface. 

### 3.1. Issues listing
As an ui user of the system I want to be able to list the issues stored in it. 

#### 3.1.1. Issues sorting in list view
As an ui user of the system I want to be able to sort the issues by :
- issue name
- issue priority
- issue start-time
- issue create-time
- issue update-time

#### 3.1.2. issues re-ordering
As a UI user 
In order to prioritize my issues 
I wanto to be able to drag and drop issues in the UI



#### 3.1.3. Scenario 1: issues reordering by category

Given that the issues are sorted by category
When I pick the whole category by the category title
and drag the category area containing all its items 
in front of another category 
Then the category should be displayed permanentry in this priority order
and this new order saved to the database.  



#### 3.1.4. Scenario 2: issues reordering one-by-one

Given that the issues are sorted by other per issue attributes
When I pick the issue area
and drag the issue area in front of another issue 
Then the issue list should be displayed permanently in this order
and this new order saved to the database.  



