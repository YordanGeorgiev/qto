#  README
* [1. WHY](#1-why)
* [2. SO, WHAT IS THIS ?!](#2-so-what-is-this-)
  * [2.1. WHAT CAN IT DO TO FOR ME AND/OR MY ORGANISATION ?](#21-what-can-it-do-to-for-me-and/or-my-organisation-)
  * [2.2. ASSUMPTION AND PREREQUISITES](#22-assumption-and-prerequisites)
  * [2.3. PROPOSED CAPABILITIES](#23-proposed-capabilities)
* [3. DEMO](#3-demo)
* [4. DOCUMENTATION](#4-documentation)
* [5. AUTOMATED DEPLOYMENT LOCALLY AND AWS IN 35 MINUTES](#5-automated-deployment-locally-and-aws-in-35-minutes)
* [6. ACKNOWLEDGEMENTS](#6-acknowledgements)
* [7. LICENSE](#7-license)




    

## 1. WHY
Why ?! Yet! Another App ?! ... 

Software development is prohibitively expensive. In fact any endeavour with group of people aiming towards common goal in any field is expensive, even solely based on persons' time spent. 
If you have a great idea for a web application, but you want to keep a full vertical control on the stack, avoid the initial costs and efforts of setting up the infrastructure and just focus on the data and business logic of your application, you must read further ...
If you want to simply manage your (software) endeavour the qto application will provide your organisation with the answers who does/did what, when, how and why in open manner, but ONLY if your organisation has the courage and commitment to do it.  
Still here ?! Let's move on !

    

## 2. SO, WHAT IS THIS ?!
A generic and simplistic db centric content management system, build on postgres CRUDs ( s stands for search ) and hierarchical nested data-sets MULTIPLE databases from the same web application.An included example application is the "qto application", which is used to manage multiple projects' issues, including itself ;o). 
The full and extensive https://qto.fi/qto/view/features_doc contains all the features and functionalities of THIS released version. 



Figure: 1 
the 7 main entities of the qto app
![Figure: 1 
the 7 main entities of the qto app](https://raw.githubusercontent.com/YordanGeorgiev/qto/master/doc/img/readme/what-is-is.png)

    

### 2.1. What can it do to for me and/or my organisation ?
With qto you could either re-use the existing items for management available from the home page or you could in less than 5 minutes per item define your own - that is create entirely new data-driven application.

    

### 2.2. Assumption and prerequisites
Your organisation:

- needs a data driven web app with secure access via https
- has the need to constantly update comparably small ( less than 10k rows) (hierarchy) tables
- has full trust to the persons in the org for all, but users data related CRUD operations 
- has the a need to load MANY tables into a postgres db, which might be changing constantly DDL wise
- the API of having bigint id and uid as PK as well as default vals for nullable cols is acceptable
- might have the need to save technical documentation in versioned md format

    

### 2.3. Proposed capabilities
With qto you will gain the following capabilities:
- instance deployment to bare metal/vm install, which should take no more than 40min
- provide db based authentication and restricted access to the app via http(s)
- provide access to the non-technical person via http(s) for CRUD operations
- quickly define LOTS of tables DDL by using the existing examples and just changing the columns
- search the data from the db via the global search feature 
- load initial data via xls ( less than 10k rows per sheet should be ok )
- provide them with initial links to grasp the "semi-sql" syntax
- define multiple md docs structure by xls loads to db
- generate md docs format based on the qto native view docs programatically
- lots of automated sysadmin capabilities ( check the docs in the doc/md dir )

    

## 3. DEMO
You can check the following https://qto.fi/qto/view/enduser_guide_doc of the web app, additionally every doc bellow has it's "it-doc" link aka the "native" qto document format …
Use the "test.user@gmail.com" and "secret" credentials to login ( simple click of the login button would do it as well ;o) OR even better try to login with your own e-mail and request access from the admin e-mail displayed to the error msg ...
Still here ?! Interested to get your own instance up-and-running in the cloud exposed to the Internet ?!
Follow simply the instructions in the next section.

    

## 4. DOCUMENTATION

Qto IS about documentation , which are aimed to be as up-to-date to the current release version as possible. Thus you get the following documentation set:
 - ReadMe - the initial landing readme doc for the project
 - UserStories - the collection of user-stories used to describe "what is desired"
 - Requirements - the structured collection of the requirements 
 - SystemGuide - architecture and System description
 - DevOps Guide - a guide for the developers and devops operators
 - Installation Guide - a guide for installation of the application
 - End-User Guide - the guide for the usage of the UI ( mainly ) for the end-users
 - Concepts - the concepts doc 
Check the doc/md directory where the generated from the db documents residue in md format.

    

## 5. AUTOMATED DEPLOYMENT LOCALLY AND AWS IN 35 MINUTES
The installation guide https://github.com/YordanGeorgiev/qto/blob/master/doc/md/installations_doc.md contains the instructions on how-to deploy both a local instance AND and an aws instance exposed to the Internet in 35 minutes for instance.

    

## 6. ACKNOWLEDGEMENTS
This project would NOT have been possible without the work of the people working on the following frameworks/languages/OS communities listed in no particular order.
 - Perl
 - Mojolicious
 - GNU Linux
 - Vue
 - FreeBSD

Deep gratitudes and thanks to all those people ! This application aims to contain the best practices of our former colleagues and collaborators and fellow travellers in life, which also deserve huge thanks for their support and contributions ! We tend to incorporate and re-use a lot of code snippets from the Stackoverflow and Codepen sites, should you consider that you were the author of those code snippets and you deserve mentioning of the source please let us know ...

    

## 7. LICENSE
All the trademarks mentioned in the documentation and in the source code belong to their owners. This application uses the Perl Artistic license, check the license.txt file or the following link : https://dev.perl.org/licenses/artistic.html

Should any trademark attribution be missing, mistaken or erroneous, please contact us as soon as possible for rectification.

    

