#  QTO CONCEPTS
* [1. INTRO](#1-intro)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
  * [1.3. RELATED DOCUMENTATION](#13-related-documentation)
* [2. CORE CONCEPTS](#2-core-concepts)
  * [2.1. FULL REUSABILITY OF BUSINESS OBJECT](#21-full-reusability-of-business-object)
  * [2.2. TRUST AND CLARITY](#22-trust-and-clarity)
  * [2.3. PERSONAL RESPONSIBILITY](#23-personal-responsibility)
* [3. BUSINESS LOGIC](#3-business-logic)
  * [3.1. PROJECTS MANAGEMENT](#31-projects-management)
  * [3.2. ISSUES / ISSUE ITEMS / ITEMS](#32-issues-/-issue-items-/-items)
    * [3.2.1. Categories](#321-categories)
    * [3.2.2. Issues status](#322-issues-status)
    * [3.2.3. Issues management via time intervals](#323-issues-management-via-time-intervals)
  * [3.3. QUESTIONS](#33-questions)
  * [3.4. IDEAS](#34-ideas)
  * [3.5. PROBLEMS](#35-problems)
* [4. DEFINITIONS](#4-definitions)
  * [4.1. RELEASE](#41-release)




    

## 1. INTRO


    

### 1.1. Purpose
The purpose of this document is to present the concepts and the business logic of the Issue-Tracker application for this current version.

    

### 1.2. Audience
This document could be of interest for any potential and actual users of the application. Keyusers must read, understand and even be able to present and explain the contents of this document. 
Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for the application. 

    

### 1.3. Related documentation
This document is part of the qto application documentation-set, which contains the following documents:
 - ReadMe - the initial readme file of the project
 - Concepts - contains the concepts of the application
 - UserStories - the collection of userstories used to describe "what is desired"
 - SystemGuide - architecture and System description
 - DevOps Guide - a guide for the developers and devops operators
 - Installation Guide - a guide for installation of the application
 - Features and Functionalities - description of the current features and functionalities
 - Requirements - description of the Requirements for the application


All the documents should be updated and redistributed in combination of the current version of the application and should be found under the doc/md directory.


    

## 2. CORE CONCEPTS


    

### 2.1. Full reusability of business object
The qto is fully generic - that is ANY of the entities in the business logic of the qto INSTANCE APPLICATION could be replaced with the one suitable for your organisation.

    

### 2.2. Trust and clarity


    

### 2.3. Personal responsibility
You should assign 0 or 1 persons responsible for an issue at a time. Of course if you keep tool long an issue to be assigned to nobody it simply means that you are not fully committed to its completion. 

    

## 3. BUSINESS LOGIC


    

### 3.1. Projects management
You can manage multiple projects with the qto tool. Each project has its own data directories, database storage and configurations. You could also have different environments named dev, tst, prd for each project separately. 
As the tool is backwards compatible you could have different instances of the issue-tracker projects with different versions ( and set of features ) operating against different project ( each one in its own version).
You must pre-set the configuration variables of an issue-tracker project each time you start working on a project from the shell

    

### 3.2. Issues / Issue items / items
Issue item is the shortest possible description of task , activity , note or anything requiring distinguishable and preferably measurable action or producing verifiable outcome.
Issues could be of different types - tasks, activities, notes etc. 
Each issue MUST BE assigned to one and only one person.

    

#### 3.2.1. Categories
Each issue item could be categorized under one and only one category. One category might have 1 or more issues. 
The categories could contain letters ,numbers, dashes

    

#### 3.2.2. Issues status
You could define whatever statuses you like. As issue-tracker has been built to develop itself ( how sarcastic could that be ;o), that is for tracing the progress of a software project the following "default" statuses have been used: 
01-eval - for evaluate the issue
02-todo - for decided to do the issue
03-wip - for the issue is being in work in progress mode
04-diss - for discard the issue
05-tst - for the issue is being in testing like mode
06-onhold - for the issue is being kept onhold for the time period
07-qas - for the issue is being quality assured 
09-done - for the issue is being done / completed. 

    

#### 3.2.3. Issues management via time intervals
The issues are basically organised into the following periods:
 - daily
 - weekly
 - monthly
 - yearly
 - quinquennially
 - decadally

So that in the end of each previous time period you could go trough the issues of that period and transfer up and down in the time scale. 

    

### 3.3. Questions
Sometimes during the workings of your project you encounter problems, which are complex enough not to allows the definition of an issue. In those cases it would be more rational to just register the problem, discuss it or review it later on, and define the issue as soon as the problem domain is understood and even possible issue solution could be proposed

    

### 3.4. Ideas
Your organisation might collect, sort and evaluate ideas so that they could be later one used as the row data for issues ( aka concrete work descriptions to be followed).

    

### 3.5. Problems
Quite often the row input material for the issues are the problems encountered - the better you collect, describe and prioritise the list of problems to tackle the better you will be able to organise the issues to be completed. 

    

## 4. DEFINITIONS
This section contains definitions of terms within the context of the Issue-Tracker application.

    

### 4.1. Release
An issue-tracker release is the artifact you can download from the following GitHub page:
https://github.com/YordanGeorgiev/issue-tracker/releases
The word is also used for the actual release of the latest source code into a working instance available in the web ... 

    

