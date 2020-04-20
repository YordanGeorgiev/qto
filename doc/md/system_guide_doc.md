#  QTO SYSTEM GUIDE
* [1. INTRO](#1-intro)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
* [2. THE INFORMATION SYSTEM AS CYBERNETIC ORGANISM ABSTRACTION](#2-the-information-system-as-cybernetic-organism-abstraction)
  * [2.1. THE QTO INFORMATION SYSTEM - DEFINITION](#21-the-qto-information-system--definition)
  * [2.2. INFORMATION SYSTEM - DIAGRAM](#22-information-system--diagram)
* [3. THE QTO SYSTEM INFRASTRUCTURE](#3-the-qto-system-infrastructure)
  * [3.1. SYSTEM ARCHITECTURAL OVERVIEW BY SIWA DIA](#31-system-architectural-overview-by-siwa-dia)
  * [3.2. INFRASTRUCTURAL COMPONENTS](#32-infrastructural-components)
    * [3.2.1. End-user clients](#321-end-user-clients)
    * [3.2.2. Application Layer and databases hosted in AWS](#322-application-layer-and-databases-hosted-in-aws)
    * [3.2.3. Local Development and testing](#323-local-development-and-testing)
    * [3.2.4. Source code in GitHub](#324-source-code-in-github)
* [4. ARCHITECTURE](#4-architecture)
  * [4.1. ICOCM ARCHITECTURE DEFINITION](#41-icocm-architecture-definition)
    * [4.1.1. The Control components](#411-the-control-components)
    * [4.1.2. The Model components](#412-the-model-components)
    * [4.1.3. The Input Components](#413-the-input-components)
    * [4.1.4. The Output Components](#414-the-output-components)
    * [4.1.5. The Conversion Components](#415-the-conversion-components)
    * [4.1.6. The Converter Components](#416-the-converter-components)
  * [4.2. MULTI-INSTANCE SETUP](#42-multi-instance-setup)
    * [4.2.1. Multi-environment naming convention](#421-multi-environment-naming-convention)
  * [4.3. SOFWARE ARCHITECTURE](#43-sofware-architecture)
    * [4.3.1. Front-End](#431-front-end)
    * [4.3.2. Back-End](#432-back-end)
  * [4.4. HOT META DATA RELOAD FUNCTIONALITY](#44-hot-meta-data-reload-functionality)
* [5. FULL STACK DESCRIPTION](#5-full-stack-description)
  * [5.1. OS STACK](#51-os-stack)
  * [5.2. THE APPLICATION LAYER STACK](#52-the-application-layer-stack)
    * [5.2.1. Perl](#521-perl)
    * [5.2.2. The perl modules](#522-the-perl-modules)
  * [5.3. THE MOJOLICIOUS WEB FRAMEWORK](#53-the-mojolicious-web-framework)
  * [5.4. THE BROWSER RUN-TIME](#54-the-browser-run-time)
    * [5.4.1. HTML 5](#541-html-5)
    * [5.4.2. JavaScript ](#542-javascript-)
      * [5.4.2.1. Vue](#5421-vue)
* [6. APPLICATION CONTROL FLOW ](#6-application-control-flow-)
  * [6.1. SHELL CONTROL FLOW](#61-shell-control-flow)
    * [6.1.1. Front-End](#611-front-end)
    * [6.1.2. Back-End](#612-back-end)
* [7. SECURITY](#7-security)
  * [7.1. NON-SECURITY MODE](#71-non-security-mode)
  * [7.2. SIMPLE NATIVE SECURITY MODE](#72-simple-native-security-mode)




    

## 1. INTRO


    

### 1.1. Purpose
The purpose of this guide is to provide description of the qto system and application architecture.

    

### 1.2. Audience
Target audience of this document is comprised of the architects and System designers of a potential or current system, comprised on deployed and operating qto instances. Developers and devops operators.

    

## 2. THE INFORMATION SYSTEM AS CYBERNETIC ORGANISM ABSTRACTION
This section is essential for you to understand the very basic motives and principles behind the design of the qto applications and systems. Elon Musk stated in several interviews, that any organisation might be viewed as a cybernetic organism, ran to a certain degree by an Artificial Intelligence Instance... 
Qto has nothing to do with the modern AI definition, yet it's design is inspired by this cybernetic organism or biome metaphor. 

    

### 2.1. The qto Information System - definition
There are multiple definitions for "Information System" - most of those apply to the qto information system, yet the following definition provides additional content, which might not necessary be applicable to any other non-qto IS. 
The qto information system is the interactive combination of the people , processes & policies, hardware & networks , source code, binaries, configuration and data managed by any running instance of the qto application.

    

### 2.2. Information System - diagram
The following diagram depicts the mention above definition.

    

## 3. THE QTO SYSTEM INFRASTRUCTURE
This section describes the current system infrastructure.

    

### 3.1. System architectural overview by SIWA dia
The following diagram implements the Simplest Possible Way of describing Architecture principle - it's sole purpose is to quickly provide an overview of the existing infrastructure built with the help of the qto application as well as provide visual tool for communication related to thejyot application. 


Figure 1:
The qto insfrastructure
![Figure 1:
The qto insfrastructure](https://github.com/YordanGeorgiev/qto/blob/master/doc/img/system_guide/qto-infra.jpg?raw=true)

    

### 3.2. Infrastructural components


    

#### 3.2.1. End-user clients
The end-users can access any qto application via their browsers. All of the functionalities are available in mobile browsers ( smart-phones or tablets not older than 2 years)

    

#### 3.2.2. Application Layer and databases hosted in AWS
Both the application layer and the database(s) are hosted on the same amazon ec2 host ( this will change in the future, as the architecture supports databases hosting in RDS or in separate hosts with TCP data channel)

    

#### 3.2.3. Local Development and testing
The development and testing are done in an ubuntu 18.04 vm running on top of mac - the binary configuration for the vm in described in the bootstrap script.
You could also develop and test in other Unix-like OS('s) - GentOs, MacOS etc, as long as you could figure out how-to install and provision postgres , the required OS binaries and the Perl modules for the application layer, as the provided deployment script has been aimed and tested only for the latest Ubuntu LTS.

    

#### 3.2.4. Source code in GitHub
The source code for the qto project is hosted in GitHub with the most open licensing possible:
https://github.com/YordanGeorgiev/qto



    

## 4. ARCHITECTURE


    

### 4.1. ICOCM architecture definition
The Input-Output Control Model architecture is and application architecture providing the highest possible abstraction for almost any software artefact, by dividing its main executing components based on their abstract responsibilities - Input, Conversion, Output , Control and Model. 

    

#### 4.1.1. The Control components
The Control components control the control flow in the application. The instantiate the Models and pass them to the Readers , Converters and Writers for output. 

    

#### 4.1.2. The Model components
The model components model the global DATA of the application - that is no configuration, nor control flow nor anything else should be contained within the model. 
Should you encounter data, which is not modelled yet , you should expand the Model and NOT provide different data storage and passing techniques elsewhere in the code base ... 

    

#### 4.1.3. The Input Components
The Input Components are generally named as "Readers". Their responsibility is to read the application data into Model(s). 

    

#### 4.1.4. The Output Components
The Output Components are generally named as "Writers" Their responsibility is to write the already processed data from the Models into the output media . 

    

#### 4.1.5. The Conversion Components
The Conversion components are generally called "converters". Their responsibility is to convert from one run-time data structure to another.

    

#### 4.1.6. The Converter Components
The Converters apply usually the business logic for converting the input data from the Models into the app specific data back to the Models. 

    

### 4.2. Multi-instance setup
The multi-instance setup refers to the capability of any installed and setup instance of the qto application to "know" its version , environment type  - development , testing and production ) and owner.


Figure: 2
qto multi-instance setup
![Figure: 2
qto multi-instance setup](https://github.com/YordanGeorgiev/qto/blob/master/doc/img/system_guide/multi-env-setup.png?raw=true)

    

#### 4.2.1. Multi-environment naming convention
Each database used by the qto application has an &lt;&lt;environment abbreviation&gt;&gt; suffix referring to its environment type. Running application layers against different db versions should be supported as much as possible.  

    

### 4.3. Sofware architecture


    

#### 4.3.1. Front-End
The Mojolicious Web Framework runs on top of a perl instance, which serves the back-end requests and passes back and forth json, as well as the ui Mojo templates dynamically, which combined with the vue template create the generic ui. 

    

#### 4.3.2. Back-End
The id's of the tables which ARE VISIBLE to the end users ui are big integers, which are formed by the concatenation of the year, month, day, hour, minutes and second in which the row in the table is created. 

    

### 4.4. Hot meta data reload functionality
In most of the modern applications using databases as main data storage, the changes in the Entity models mean in most of the cases full release of the application. Qto simplistic UI interfaces and the hot meta-data reload functionality enable all the changes to the db, which do not break the qto table api ( basically guid and id columns), to be performed only without even having to restart the application layer, but only by reloading one of the following meta-data tables - items_doc, app_items, app_item_attributes

    

## 5. FULL STACK DESCRIPTION


    

### 5.1. OS stack
The Qto Application supports ONLY Ubuntu 18.04 as of v0.7.9. - that is all the deployment automations have been tested ONLY against this OS. 
Any middle level full stack developer should be able to deploy and operate the Qto Application on most of the reason Linux distributions and even probably BSD, yet this will require substantial rewrite of the existing deployment scripts as the aim is to have single code base for those scripts and configurability if multiple OS's will be supported.

    

### 5.2. The Application Layer stack


    

#### 5.2.1. Perl
The Application Layer is written in Perl, which is the best possible return on invested time suiting for the philosophy of the qto application. 

    

#### 5.2.2. The perl modules


    

### 5.3. The Mojolicious web framework
Mojolicious is non-arguably the best web-framework out there in almost any criteria, most notably speed, stability, deployment time, scalability, security and tons of other features you can read about in the framework's web page @: https://mojolicious.org/

    

### 5.4. The browser run-time
Qto support all modern browsers. Internet Explorer / other Microsoft browsers ARE NOT supported, due to their notorious time-burning compliance with web standards. 
Mobile browsers albeit supported are NOT priority ( for now ).

    

#### 5.4.1. HTML 5


    

#### 5.4.2. JavaScript 


    

##### 5.4.2.1. Vue


    

## 6. APPLICATION CONTROL FLOW 
This section provides a generic control flow description for the shell based and ui based control flows. 

    

### 6.1. Shell control flow
The shell control flow is based on the control model input output architecture. The usual pattern is to call a single &lt;&lt;doSomeAction&gt;&gt; shell function, which is stored in a some-action.func.sh file and loaded dynamically based on this naming convention. Maximun of 2 level nesting is used in the functional calls, that is once an shell action is evoked it could call only 1 funtion, which might or might be not a shell action function , BUT not more, to address unneeded complexity written in bash. 

    

#### 6.1.1. Front-End
The Mojolicious Web Framework runs on top of a perl instance, which serves the back-end requests and passes back and forth json, as well as the ui Mojo templates dynamically, which combined with the vue template create the generic ui loaded in modern html 5, web sockets and ajax capable browsers.
That said the html,js , vue code is mixed with some perl Mojolicious template code several times per file unit and the logic of building the file units into html pages in defined by the Mojolicious templating system, but once one could grasp the concept the developing of the front-end is more or less html,javascript , vue centric. 

    

#### 6.1.2. Back-End
The id's of the tables which ARE VISIBLE to the end users ui are big integers, which are formed by the concatenation of the year, month, day, hour, minutes and second in which the row in the table is created. 
The primary keys are however GUID's to provide the underlying expandability for cross-domain, cross-db data transfers. 

    

## 7. SECURITY
This section provides an overview of the security of a system operating the qto application. 

    

### 7.1. Non-security mode
In the non-security mode the application does NOT authenticate any one. Both run over https and http. Of course if you use http all the traffic will be in plain text ...

    

### 7.2. Simple native security mode
In this mode the authentication is performed against the project defined in the login page ( where project is actually the database to which the application layer can connect to ). This means that one user can have access to multiple project databases and be authenticated agains some of them thus being able to navigate with the same browser from project to project. In this mode the user credentials - email and password are stored in the users table with a blowfish encryption.
Sessions are used for storing the state of the authentication, which is handled by the Mojolicious web framework - all data gets serialized to json and stored Base64 encoded on the client-side, but is protected from unwanted changes with a HMAC-SHA1 signature. 

    

