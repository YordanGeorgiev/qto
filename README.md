#  issue-tracker


Table of Contents

  * [1. WHY](#1-why)
  * [2. WHAT ](#2-what-)
  * [3. USAGE SCENARIO](#3-usage-scenario)
    * [3.1. Assumption and prerequisites](#31-assumption-and-prerequisites)
    * [3.2. Proposed capabilities](#32-proposed-capabilities)
    * [3.3. Bonus offer](#33-bonus-offer)
  * [4. DEMO ](#4-demo-)
  * [5. INSTALLATION AND CONFIGURATION](#5-installation-and-configuration)
  * [6. ADDITIONAL DOCS](#6-additional-docs)
  * [7. ACKNOWLEDGEMENTS](#7-acknowledgements)
  * [8. LICENSE](#8-license)


    

## 1. WHY
Why ?! Yet.  Another. App ?!

Because work should be inspiring and not overwhelming people. 
Because even good intentions without proper commitment, allocation and resourcing and most importantly a mean for tracking advancement of an endeavor in open way reflecting with the reality, might end-up making people less happy, when in fact a really simple solution could be applied for any bigger challenge requiring progress tracking and people communication and coordination... And tons of other reasons we all having been in project disasters know about ... Still here ?! Let's move on !


issue tracker objects polygon 
![The relations between the issue tracker objects ](https://raw.githubusercontent.com/YordanGeorgiev/issue-tracker/dev/doc/img/readme/what-is-is.png)    

## 2. WHAT 
An application to manage multiple projects' issues, store them in postgres db, present them into dynamic web pages, write them to txt files, xls files, and publish them into Google Sheets with a lot of cool functionalities. 
The full and extensive features and functionalities document cold be read from:
https://github.com/YordanGeorgiev/issue-tracker/blob/master/doc/md/issue-tracker-features-and-functionalities.md
And moreover this application is the reflection of the best practices and principles for tens of years in IT resulting into a product of the Multi-environment instance architecture and the Input-Output Controller Model architecture ( more about this in the DevOps guide:
https://github.com/YordanGeorgiev/issue-tracker/blob/master/doc/md/issue-tracker-features-and-functionalities.md

    

## 3. USAGE SCENARIO
We have stumbled into real life problem in a telco company's ETL works, which could have been solved even with the current version of the tool, which is FAR from ready as the current number 0.4.7 indicates … 

    

### 3.1. Assumption and prerequisites
Namely, if your organisation:
- has secured intranet access to a Linux box 
- full trust to the persons having http access for CRUD operations exists ( as no authentication is yet implemented )
- there is a need to load MANY tables into a postgres db 
- the API of having bigint id , and uid as PK is acceptable

    

### 3.2. Proposed capabilities
You could:
-  deploy an instance of the issue-tracker
-  provide access to the non-technical person via http for CRUD operations
-  provide them with initial links to grasp the "semi-sql" syntax
-  quickly define LOTS of tables DDL by using the existing examples and just changing the columns
 - load initial data via xls ( less than 10k rows per shee should be ok ) 

    

### 3.3. Bonus offer
We could provide you will free assistance for the deployment of the first instance in your organisation, although we consider the existing documentation good enough to deploy the application only by following the instructions.
In the real IT life however the mealage always varies, hence this last "bonus offer".

    

## 4. DEMO 
You can check the following running instance of the tool:

    

## 5. INSTALLATION AND CONFIGURATION
You could either try quickly to execute the instructions bellow this section or 
follow the installation instructions from the Installation and Configuration Guide in the docs/md dir:

https://github.com/YordanGeorgiev/issue-tracker/blob/master/doc/md/issue-tracker-installation-and-configuration-guide.md


    

## 6. ADDITIONAL DOCS
Additional docs could be found in the doc/md dir. 
A good starting point could be the "features doc:" : 

https://github.com/YordanGeorgiev/issue-tracker/blob/master/doc/md/issue-tracker-features-and-functionalities.md

The user-stories doc :
https://github.com/YordanGeorgiev/issue-tracker/blob/master/doc/md/issue-tracker-user-stories.md


The Requirements document contains the requirements for the application:

https://github.com/YordanGeorgiev/issue-tracker/blob/master/doc/md/issue-tracker-requirements.md

The SystemGuide contains the description of the existing issue-tracker System and it's architecture:

https://github.com/YordanGeorgiev/issue-tracker/blob/master/doc/md/issue-tracker-system-guide.md

The DevOps Guide contains the instructions for the devops operators:
https://github.com/YordanGeorgiev/issue-tracker/blob/master/doc/md/issue-tracker-devops-guide.md

    

## 7. ACKNOWLEDGEMENTS
This project would not have been possible without the work of the communities of the people working on the following frameworks/languages/OS listed in no particular order. 

 - Mojolicious
 - Vue 
 - Perl
 - GNU Linux

Deep gratitude's and thanks for all those people !
This application aims to contain the best practices of our former colleagues and collaborators and co-travelers in life, which also deserve huge thanks for their support and contributions !

    

## 8. LICENSE
All the trademarks mentioned in the documentation and in the source code belong to their owners. 
This application uses the Perl Artistic license, check the license.txt file or the following link :
https://dev.perl.org/licenses/artistic.html

Should any trademark attribution be missing, mistaken or erroneous, please contact us as soon as possible for rectification.


    

