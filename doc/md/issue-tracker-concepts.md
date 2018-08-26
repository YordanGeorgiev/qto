#  ISSUE-TRACKER CONCEPTS


Table of Contents

  * [1. INTRO](#1-intro)
    * [1.1. Purpose](#11-purpose)
    * [1.2. Audience](#12-audience)
    * [1.3. Related documentation](#13-related-documentation)
  * [2. CORE CONCEPTS](#2-core-concepts)
    * [2.1. Time intervals based time-management](#21-time-intervals-based-time-management)
    * [2.2. Personal responsibility](#22-personal-responsibility)
  * [3. BUSINESS LOGIC](#3-business-logic)
    * [3.1. Projects management](#31-projects-management)
    * [3.2. Increase the date for all projects](#32-increase-the-date-for-all-projects)
    * [3.3. Categories](#33-categories)
      * [3.3.1. Issues / Issue items / items](#331-issues-/-issue-items-/-items)
      * [3.3.2. to search for the project daily file](#332-to-search-for-the-project-daily-file)


    

## 1. INTRO


    

### 1.1. Purpose
The purpose of this document is to present the concepts and the business logic of the Issue-Tracker application for this current version.

    

### 1.2. Audience
This document could be of interest for any potential and actual users of the application. Keyusers must read, understand and even be able to present and explain the contents of this document. 
Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for the application. 

    

### 1.3. Related documentation
This document is part of the Issue-Tracker application documentation-set, which contains the following documents:
 - UserStories - the collection of userstories used to describe "what is desired"
 - SystemGuide - architecture and System description
 - DevOps Guide - a guide for the developers and devops operators
 - Installation Guide - a guide for installation of the application
 - Features and Functionalities - description of the current features and functionalities

All the documents should be updated and redistributed in combination of the current version of the appilication and should be found under the following directories:
doc/md
doc/pdf
doc/xls
according to the file format used for the documentation storage.

    

## 2. CORE CONCEPTS


    

### 2.1. Time intervals based time-management
The time rules our lifes. Issue-tracker is aimed to help you and your organisation to manage your time and resources in the best possible way YOU CAN. You must make sure that you clearly define and state your issues and update their information based on the events from the real world.

    

### 2.2. Personal responsibility
You should assign 0 or 1 persons responsible for an issue at a time. Of course if you keep tool long an issue to be assigned to nobody it simply means that you are not fully committed to its completion. 

    

## 3. BUSINESS LOGIC


    

### 3.1. Projects management
You can manage multiple projects with the issue-tracker tool. Each project has its own data directories, database storage and configurations. You could also have different envornments named dev,tst,prd for each project separately. 
As the tool is backwards compatible you could have differrrent instances of the issue-tracker projects with different versions ( and set of features ) operatiing against differrent project ( each one in its own version).
You must pre-set the configuration variables of an issue-tracker project each time you start working on a project from the shell

    doParseIniEnvVars /vagrant/csitea/cnf/projects/isg-pub/isg-pub.issue-tracker.doc-pub-host.conf

### 3.2. Increase the date for all projects
to increase the date for all the projects at once use the following oneliner.

    while read -r f ; do doParseIniEnvVars $f ; bash src/bash/issue-tracker/issue-tracker.sh -a increase-date ; done < <(find doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/ -type f)

### 3.3. Categories
Each issue item could be categorized under one and only one category. One category might have 1 or more issues. 
The categories could contain letters ,numbers, dashes

    Examples:
    organisation-it
    organisation-it-operations

#### 3.3.1. Issues / Issue items / items
Issue item is the shortest possible description of task , activity , note or anything requiring distinguishable and prerferable measurable action or producing verfifiable outcome.
Issues could be of different types - tasks, activities, notes etc. 

    Examples:
    go get the milk
    do the homework
    procurement e-mail discussion follow-up

#### 3.3.2. to search for the project daily file
to search for the project daily file run the following liner first to start the dev server of the react mini-app.
Than point your broser at the following url:
http://doc-pub-host:3307/
( Hardcoded for now … ) 

    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start

