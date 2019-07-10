#  QTO SYSTEM GUIDE
* [1. INTRO](#1-intro)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. AUDIENCE](#12-audience)
* [2. ARCHITECTURE](#2-architecture)
  * [2.1. IOCM ARCHITECTURE DEFINITION](#21-iocm-architecture-definition)
    * [2.1.1. The Control components](#211-the-control-components)
    * [2.1.2. The Model components](#212-the-model-components)
    * [2.1.3. The Input Components](#213-the-input-components)
    * [2.1.4. The Output Components](#214-the-output-components)
    * [2.1.5. The Converter Components](#215-the-converter-components)
  * [2.2. MULTI-INSTANCE SETUP](#22-multi-instance-setup)
    * [2.2.1. Multi-environment naming convention](#221-multi-environment-naming-convention)
  * [2.3. SOFWARE ARCHITECTURE](#23-sofware-architecture)
    * [2.3.1. Front-End](#231-front-end)
    * [2.3.2. Back-End](#232-back-end)
* [3. APPLICATION CONTROL FLOW ](#3-application-control-flow-)
  * [3.1. SHELL CONTROL FLOW](#31-shell-control-flow)
    * [3.1.1. Front-End](#311-front-end)
    * [3.1.2. Back-End](#312-back-end)
* [4. SECURITY](#4-security)
  * [4.1. NON-SECURITY MODE](#41-non-security-mode)
  * [4.2. BASIC HTTP SECURITY MODE](#42-basic-http-security-mode)
  * [4.3. SIMPLE NATIVE SECURITY MODE ( EXPERIMENTAL )](#43-simple-native-security-mode-(-experimental-))




    

## 1. INTRO


    

### 1.1. Purpose
The purpose of this guide is to provide description of the qto systems and application architecture.

    

### 1.2. Audience
Architects and System designers of a potential or current system, comprised on deployed and operating qto instances. Developers and devops operators.

    

## 2. ARCHITECTURE


    

### 2.1. IOCM architecture definition
The Input-Output Control Model architecture is and application architecture providing the highest possible abstraction for almost any software artefact, by dividing its main executing components based on their abstract responsibilities - Input, Output , Control and Model. 

    

#### 2.1.1. The Control components
The Control components control the control flow in the application. The instantiate the Models and pass them to the Readers , Converters and Writers for output. 

    

#### 2.1.2. The Model components
The model components model the DATA of the application - that is no configuration, nor control flow nor anything else should be contained wihin the model. 
Should you encounter data, which is not modelled yet , you should expand the Model and NOT provide different data storage and passing techniques elsewhere in the code base ... 

    

#### 2.1.3. The Input Components
The Input Components are generally named as "Readers". Their responsibility is to read the application data into Model(s). 

    

#### 2.1.4. The Output Components
The Output Components are generally named as "Writers" Their responsibility is to write the already processed data from the Models into the output media . 

    

#### 2.1.5. The Converter Components
The Converters apply usually the business logic for converting the input data from the Models into the app specific data back to the Models. 

    

### 2.2. Multi-instance setup
The multi-instance setup refers to the capability of any installed and setup instance of the qto application to "know" its version , environment type  - development , testing and production ) and owner.


Figure: 1
qto multi-instance setup
![Figure: 1
qto multi-instance setup](https://github.com/YordanGeorgiev/qto/blob/v0.6.6/doc/img/system_guide/multi-env-setup.png?raw=true)

    

#### 2.2.1. Multi-environment naming convention
Each database used by the qto application has an &lt;&lt;environment abbreviation&gt;&gt; suffix referring to its environment type. Running application layers against different db versions should be supported as much as possible.  

    

### 2.3. Sofware architecture


    

#### 2.3.1. Front-End
The Mojolicious Web Framework runs on top of a perl instance, which serves the back-end requests and passes back and forth json, as well as the ui Mojo templates dynamically, which combined with the vue template create the generic ui. 

    

#### 2.3.2. Back-End
The id's of the tables which ARE VISIBLE to the end users ui are big integers, which are formed by the concatenation of the year, month, day, hour, minutes and second in which the row in the table is created. 

    

## 3. APPLICATION CONTROL FLOW 
This section provides a generic control flow description for the shell based and ui based control flows. 

    

### 3.1. Shell control flow
The shell control flow is based on the control model input output architecture. 

    

#### 3.1.1. Front-End
The Mojolicious Web Framework runs on top of a perl instance, which serves the back-end requests and passes back and forth json, as well as the ui Mojo templates dynamically, which combined with the vue template create the generic ui. 

    

#### 3.1.2. Back-End
The id's of the tables which ARE VISIBLE to the end users ui are big integers, which are formed by the concatenation of the year, month, day, hour, minutes and second in which the row in the table is created. 

    

## 4. SECURITY
This section provides an overview of the security of a system operating the qto application. 

    

### 4.1. Non-security mode
In the non-security mode the application does NOT authenticate any one. Both runs over https and ht

    

### 4.2. Basic http security mode
in this mode different http passwords can be registed. The following web page can be used for that : 
http://www.htaccesstools.com/htpasswd-generator/

    

### 4.3. Simple native security mode ( EXPERIMENTAL )
This feature is experimental as of v0.6.7. It simply means that it needs much more testing in real-life scenarios to provide the level of centainty promised by it. In this mode the user credentials - email and password are stored in the users table with a blowfish encryption. And all but the login page need a match for the e-mail with the respective password. 
Sessions are used for storing the state of the authentication, which is entirely handled by the Mojolicious web framework - all data gets serialized to json and stored Base64 encoded on the client-side, but is protected from unwanted changes with a HMAC-SHA1 signature. 

    

