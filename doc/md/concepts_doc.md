#  QTO APPLICATION CONCEPTS
* [1. INTRO](#1-intro)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
  * [1.3. RELATED DOCUMENTATION](#13-related-documentation)
* [2. BUSINESS LOGIC](#2-business-logic)
  * [2.1. PROJECTS MANAGEMENT](#21-projects-management)
  * [2.2. ISSUES / ISSUE ITEMS / ITEMS](#22-issues-/-issue-items-/-items)
    * [2.2.1. Categories](#221-categories)
    * [2.2.2. Issues status](#222-issues-status)
    * [2.2.3. Issues management via time intervals](#223-issues-management-via-time-intervals)
  * [2.3. QUESTIONS](#23-questions)
  * [2.4. IDEAS](#24-ideas)
  * [2.5. PROBLEMS](#25-problems)
* [3. DEFINITIONS](#3-definitions)
  * [3.1. RELEASE](#31-release)
* [4. DOCUMENTATION](#4-documentation)
  * [4.1. THE CONCEPTS DOC ](#41-the-concepts-doc-)
  * [4.2. THE USERSTORIES DOC](#42-the-userstories-doc)
  * [4.3. THE SYSTEM GUIDE](#43-the-system-guide)
  * [4.4. THE DEVOPS GUIDE](#44-the-devops-guide)
  * [4.5. THE MAINTENANCE AND OPERATIONS GUIDE](#45-the-maintenance-and-operations-guide)




    

## 1. INTRO


    

### 1.1. Purpose
The purpose of this document is to present the concepts and the business logic of the qto application for this current version.

    

### 1.2. Audience
This document could be of interest for any potential and actual users of the application. Key-users must read, understand and even be able to present and explain the contents of this document. 
Developers and Architects working on the application MUST read and understand this document at least to the extend of their own contribution for the application. 

    

### 1.3. Related documentation
This document is part of the qto application documentation-set, which contains the following documents:
 - readme_doc-0 - the initial landing readme doc for the project
 - userstories_doc-0 - the collection of user-stories used to describe "what is desired"
 - requirements_doc-0 - the structured collection of the requirements 
 - system_guide_doc-0 - architecture and System description
 - devops_guide_doc-0 - a guide for the developers and devops operators
 - installations_doc-0 - a guide for installation of the application
 - enduser_guide_doc-0 - the guide for the usage of the UI ( mainly ) for the end-users
 - concepts_doc-0 - the concepts doc 

All the documents should be updated and redistributed in combination of the current version of the application and should be found under the doc/md directory.


    

## 2. BUSINESS LOGIC


    

### 2.1. Projects management
Any undertaking or endeavour, carried out individually or collaboratively and possibly involving research or design, that is carefully planned, usually by a project team, to achieve a particular aim could be considered a project. The main purpose of the qto application is to manage one or more projects from a single User Interface.


    

### 2.2. Issues / Issue items / items
Issue item is the shortest possible description of task, activity, note or anything requiring distinguishable and preferably measurable action or producing verifiable outcome.
Issues could be of different types - tasks, activities, notes etc. 
Simply said the issues are the split by deliverable items of work to be done by the project team.
Each issue MUST BE assigned to one and only one person, to foster responsibility and accountability

    

#### 2.2.1. Categories
Each issue item could be categorised under one and only one category. One category might have 1 or more issues. 
The issues can be split into different categories. You can define your categories from the https://qto.fi/qto/list/category page.

    

#### 2.2.2. Issues status
Each issue could be in a different status. You can define the different statuses for an issue from the issue_status list page : https://qto.fi/qto/list/issues_status

    

#### 2.2.3. Issues management via time intervals
The issues are basically organised into the following time intervals:
 - release_issues - the issues to be handled till the next release ( usually, but not always a 2 weeks period)
 - monthly_issues - the issues to be handled during the next month
 - yearly - the issues to be handled during the next year
 - quinquennially
 - decadally

So that in the end of each previous time period you could go trough the issues of that period and transfer up and down in the time scale.
The product instance owners have an automated way of transferring the issues from one table to another described in the maintenance_guide_doc-200111060442 document.

    

### 2.3. Questions
Sometimes during the workings of your project you encounter problems, which are complex enough not to allows the definition of an issue. In those cases it would be more rational to just register a question, a problem, an idea, discuss it or review it later on, and define the issue as soon as the problem domain is understood and even possible issue solution could be proposed.

    

### 2.4. Ideas
Your organisation might collect, sort and evaluate ideas so that they could be later one used as the row data for issues ( aka concrete work descriptions to be followed).

    

### 2.5. Problems
Sometimes during the workings of your project you encounter problems, which are complex enough not to allows the definition of an issue. In those cases it would be more rational to just register a question, a problem, an idea, discuss it or review it later on, and define the issue as soon as the problem domain is understood and even possible issue solution could be proposed.
Quite often the row input material for the issues are the problems encountered - the better you collect, describe and prioritise the list of problems to tackle the better you will be able to organise the issues to be completed. 

    

## 3. DEFINITIONS
This section contains definitions of terms within the context of the qto application.

    

### 3.1. Release
A qto release is the artefact you can download from the following GitHub page:
https://github.com/YordanGeorgiev/qto/releases.

    

## 4. DOCUMENTATION


    

### 4.1. The Concepts doc 


    

### 4.2. The UserStories doc
The user stories doc contains the structurized and formal description of the user stories for the application.

    

### 4.3. The System Guide
The System Guide describes the current and factual state of the System you are actually using.

    

### 4.4. The DevOps Guide
The DevOps Guide contains information on how-to develop, operate and maintain the Application from a devops / developer perpective.

    

### 4.5. The Maintenance and Operations Guide
The Maintenance and operations Guide contains information on how-to maintain and operate the Application.

    

