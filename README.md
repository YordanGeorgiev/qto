#  README
* [1. WHY](#1-why)
* [2. SO, WHAT IS THIS ?!](#2-so,-what-is-this-)
  * [2.1. WHAT CAN IT DO TO MY ORGANISATION ?](#21-what-can-it-do-to-my-organisation-)
  * [2.2. ASSUMPTION AND PREREQUISITES](#22-assumption-and-prerequisites)
  * [2.3. PROPOSED CAPABILITIES](#23-proposed-capabilities)
  * [2.4. DEPLOYMENT AND INSTALLATION ASSISTANCE](#24-deployment-and-installation-assistance)
* [3. DEMO](#3-demo)
* [4. INSTALLATION AND CONFIGURATION](#4-installation-and-configuration)
* [5. DOCUMENTATION](#5-documentation)
  * [5.1. THE ENDUSER GUIDE DOC](#51-the-enduser-guide-doc)
  * [5.2. THE CONCEPTS DOC](#52-the-concepts-doc)
  * [5.3. THE USERSTORIES DOC](#53-the-userstories-doc)
  * [5.4. THE REQUIREMENTS DOC](#54-the-requirements-doc)
  * [5.5. THE DEVOPS GUIDE DOC](#55-the-devops-guide-doc)
  * [5.6. THE INSTALLATIONS DOC](#56-the-installations-doc)
* [6. ACKNOWLEDGEMENTS](#6-acknowledgements)
* [7. LICENSE](#7-license)




    

## 1. WHY
Why ?! Yet! Another App ?!

Because work should be inspiring and not overwhelming people. 
Because even good intentions without transparency, proper commitment, allocation and resourcing and most importantly, a mean for tracking advancement of an endeavour in open way reflecting the reality, might end-up making people less happy, when in fact a really simple solution could be applied for any bigger challenge requiring progress tracking, communication and coordination ... And tons of other reasons we all having been in project disasters know about ... Still here ?! Let's move on !


Figure: 1 
the 7 main entities of the qto app
![Figure: 1 
the 7 main entities of the qto app](https://raw.githubusercontent.com/YordanGeorgiev/qto/master/doc/img/readme/what-is-is.png)

    

## 2. SO, WHAT IS THIS ?!
A generic postgres CRUDs ( s stands for search ) web based app for managing multiple databases from the same web application layer by means of simplest possible UI and/or shell tools for xls/md export, import etc. An included example application is the "qto application", which is used to manage multiple projects' issues, including itself ;o). 
The full and extensive  http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/features_doc must contain all the features and functionalities of this released version. This application is the reflection of the best practices and principles for tens of years in IT resulting into a product of the Multi-environment instance architecture, which is in a way a reflection of the simple axiom in IT - "if there is one there will be many" ...

    

### 2.1. What can it do to my organisation ?
We have stumbled into real life problem in the ETL integrations of a big Scandinavian telco, which could have been solved even with the current version of the tool, although the versioning starts with the mighty zero … Of course next versions will provide much more scenarios in real-life, but this description applies to this current version, that is you can start using it as soon as you deploy your own instance ...

    

### 2.2. Assumption and prerequisites
Your organisation:

- has the need to constantly update comparably small ( less than 10k rows) hierarchy tables
- has secured intranet access to a Linux box
- has full trust to the persons in the org having http access for CRUD operations, as only basic auth over http exists
- has the a need to load MANY tables into a postgres db, which might be changing constantly DDL wise
- the API of having bigint id and uid as PK as well as default vals for nullable cols is acceptable
- might have the need to save technical documentation in versioned md format

    

### 2.3. Proposed capabilities
You could:

- deploy an instance of the qto, bare metal/docker install should take no more than 2h
- demo the simple search feature ( working only with name and description cols , but you could ddl hack-it)
- provide access to the non-technical person via http for CRUD operations
- provide them with initial links to grasp the "semi-sql" syntax
- quickly define LOTS of tables DDL by using the existing examples and just changing the columns
- load initial data via xls ( less than 10k rows per sheet should be ok )

    

### 2.4. Deployment and installation assistance
We could provide you with free assistance for the deployment of the first instance in your organisation, even we consider the existing documentation good enough to deploy the application only by following the instructions in the http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/installations_doc In the real IT life however the milage always varies, hence this last "bonus offer".


    

## 3. DEMO
You can check the following http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/enduser_guide_doc of the web app, additionally every doc bellow has it's "it-doc" link aka the "native" qto document format …

    

## 4. INSTALLATION AND CONFIGURATION
You could either try quickly to execute the instructions bellow this section or follow the installation instructions : 
 - in https://github.com/YordanGeorgiev/qto/blob/master/doc/md/installations_doc.md
 - in http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/readme_doc

    

## 5. DOCUMENTATION
QTO IS about documentation, we do all the doc-fooding on our docs, which are aimed to be as up-to-date to the current release version as possible. Thus you get the following documentation set:

    

### 5.1. The EndUser Guide doc
The enduser guide contains mostly UI usage instructions:
 - https://github.com/YordanGeorgiev/qto/blob/master/doc/md/enduser_guide_doc.md
 - http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/concepts_doc

    

### 5.2. The Concepts doc
General level concepts of the applicaton. 
 - https://github.com/YordanGeorgiev/qto/blob/master/doc/md/concepts_doc.md
 - http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/concepts_doc

    

### 5.3. The UserStories doc
Naturally contains the userstories of the app. 
- in https://github.com/YordanGeorgiev/qto/blob/master/doc/md/userstories_doc.md 
 - http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/userstories_doc

    

### 5.4. The Requirements doc
Contains the specs and requirements, which can be defined at the current stage of the development:
 - https://github.com/YordanGeorgiev/qto/blob/master/doc/md/requirements_doc.md
 - http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/requirements_doc

    

### 5.5. The DevOps Guide doc
Contains content on how to develop the application + general devops info.
- https://github.com/YordanGeorgiev/qto/blob/master/doc/md/devops_guide_doc.md
- http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/devops_guide_doc

    

### 5.6. The Installations doc
Contains the tasks and activities to perform to get a fully operational instance of the qto application:
 - https://github.com/YordanGeorgiev/qto/blob/master/doc/md/installations_doc.md
 - http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/view/installations_doc

    

## 6. ACKNOWLEDGEMENTS
This project would NOT have been possible without the work of the people working on the following frameworks/languages/OS communities listed in no particular order.
Perl
Mojolicious
GNU Linux
Vue
FreeBSD

Deep gratitudes and thanks to all those people ! This application aims to contain the best practices of our former colleagues and collaborators and fellow travellers in life, which also deserve huge thanks for their support and contributions ! We tend to incorporate and re-use a lot of code snippets from the Stackoverflow and Codepen sites, should you consider that you were the author of those code snippets and you deserve mentioning of the source please let us know ...

    

## 7. LICENSE
All the trademarks mentioned in the documentation and in the source code belong to their owners. This application uses the Perl Artistic license, check the license.txt file or the following link : https://dev.perl.org/licenses/artistic.html

Should any trademark attribution be missing, mistaken or erroneous, please contact us as soon as possible for rectification.

    

