#  README
* [1. WHY](#1-why)
* [2. SO, WHAT IS THIS ?!](#2-so-what-is-this-)
  * [2.1. WHAT CAN IT DO TO FOR ME AND/OR MY ORGANISATION ?](#21-what-can-it-do-to-for-me-and/or-my-organisation-)
  * [2.2. ASSUMPTION AND PREREQUISITES](#22-assumption-and-prerequisites)
  * [2.3. PROPOSED CAPABILITIES](#23-proposed-capabilities)
* [3. DEMO](#3-demo)
* [4. DOCUMENTATION](#4-documentation)
* [5. AUTOMATED FULL DEPLOYMENT ON AWS  IN 35 MINUTES](#5-automated-full-deployment-on-aws-in-35-minutes)
  * [5.1. PREREQUISITES](#51-prerequisites)
  * [5.2. DEPLOY AND PROVISION THE APPLICATION ON YOUR LOCAL UBUNTU 18.04 BOX](#52-deploy-and-provision-the-application-on-your-local-ubuntu-1804-box)
  * [5.3. CONFIGURE YOUR AWS CREDENTIALS - AWS KEYS AND  SSH KEYS](#53-configure-your-aws-credentials--aws-keys-and-ssh-keys)
  * [5.4. INITIALISE THE AWS INFRASTRUCTURE](#54-initialise-the-aws-infrastructure)
  * [5.5. ACCESS THE AWS HOST VIA SSH AND FETCH THE SOURCE CODE FROM GITHUB](#55-access-the-aws-host-via-ssh-and-fetch-the-source-code-from-github)
  * [5.6. BOOTSTRAP, DEPLOY AND PROVISION THE APPLICATION IN THE AWS INSTANCE](#56-bootstrap-deploy-and-provision-the-application-in-the-aws-instance)
  * [5.7. START THE WEB SERVER](#57-start-the-web-server)
  * [5.8. ACCESS THE QTO APPLICATION FROM THE WEB](#58-access-the-qto-application-from-the-web)
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

- has the need to constantly update comparably small ( less than 10k rows) (hierarchy) tables
- has full trust to the persons in the org for all, but users data related CRUD operations 
- has the a need to load MANY tables into a postgres db, which might be changing constantly DDL wise
- the API of having bigint id and uid as PK as well as default vals for nullable cols is acceptable
- might have the need to save technical documentation in versioned md format

    

### 2.3. Proposed capabilities
- deploy an instance of the qto, bare metal/vm/docker install should take no more than 40min
- provide access to the non-technical person via http for CRUD operations
- quickly define LOTS of tables DDL by using the existing examples and just changing the columns
- search the data from the db via the global search feature 
- load initial data via xls ( less than 10k rows per sheet should be ok )
- provide them with initial links to grasp the "semi-sql" syntax
- generate md docs format based on the qto native view docs programatically

    

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

    

## 5. AUTOMATED FULL DEPLOYMENT ON AWS  IN 35 MINUTES
This section WILL provide you will with ALL required steps to get a fully functional instance of the qto application in aws in about 35 min with 3 commands. Do just copy paste the commands into your shell and not cd into different directories - this deploymet has been tested more than 30 times succesfully by exactly reproducting those steps. 

    

### 5.1. Prerequisites
You need an aws account, capable of deploying micro instances. The costs for running the qto.fi is about 15 USD per month ( aka this aws deployment expense to Amazon would be less than a dollar ), but if you are going to use a free account, which does not allow the instantiation of the ami's specified in the src/terraform/tpl/qto/main.tf.tpl file, you should modify the template file to accommodate that. 

    

### 5.2. Deploy and provision the application on your LOCAL ubuntu 18.04 box
The bootstrap script will deploy ALL the required Ubuntu 18.04 binaries AND perl modules as well as perform the needed configurations and provisions to enable start of the web server WITHOUT manual configuration. Once done that you could also use this local box for running and/or developing the qto application. 
Clone the source under the ~/opt/ dir as shown bellow. 

    # in the shell of your local Ubuntu box
    mkdir -p ~/opt; cd $_ ; git clone https://github.com/YordanGeorgiev/qto.git ; cd ~/opt
    
    # run the bootstrap script and reload the bash env
    ./qto/src/bash/deployer/run.sh
    
    # IMPORTANT reload the bash shell
    bash
    
    # go to the product instance dir as suggested by the script output
    source $(find . -name '.env') && cd qto/qto.$VERSION.$ENV_TYPE.$USER
    
    # ensure application layer consistency, run db ddl's and load data from s3
    ./src/bash/qto/qto.sh -a check-perl-syntax -a run-qto-db-ddl -a load-db-data-from-s3

### 5.3. Configure your aws credentials - aws keys and  ssh keys
Generate NEW aws access- and secret-keys https://console.aws.amazon.com/iam/home?region=&lt;&lt;YOUR-AWS-REGION&gt;&gt;#/security_credentials. 
Store the keys in the qto's development environment configuration file - the cnf/env/dev.env.json file.
When the file path is suggested append a different string to avoid overwriting the default private key path!!!

    #create the a NEW public private key pair ( do not overwrite you existing one !! ) as follows 
    ssh-keygen -t rsa -b 4096 -C "your.name@your.org"

### 5.4. Initialise the aws infrastructure
To initialise the git aws infrastructure you need to clone the qto source code locally first. 

    # todo TEST THAT !!!
    clear ; bash ~/opt/qto/src/bash/qto/qto.sh -a init-aws-instance &

### 5.5. Access the aws host via ssh and fetch the source code from GitHub
To access the aws host via ssh you need to copy the provided elastic ip which was created by the terraform script. In your browser go to the following url:
https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=&lt;&lt;YOUR-AWS-REGION&gt;&gt;#Instances:sort=instanceId
You should see a listing of your aws instances one of which should be named dev-qto-ec2 ( that is the development instance of the qto application). Click on it's checkbox. Search for the "IPv4 Public IP" string and copy the value of the ip.

    # run locally 
    ssh -i <<path-to-your-private-key-file>> ubuntu@<<just-copied-IPv4-Public-IP>>
    
    # on the aws server
    mkdir -p ~/opt; cd $_ ; git clone https://github.com/YordanGeorgiev/qto.git ; cd ~/opt

### 5.6. Bootstrap, deploy and provision the application in the aws instance
The bootstrap script will deploy ALL the required Ubuntu 18.04 binaries AND perl modules as well as perform the needed configurations and provisions to enable start of the web server WITHOUT manual configuration. 

    # run the bootstrap script
    ./qto/src/bash/deployer/run.sh
    
    # IMPORTANT ! - reload the bash shell
    bash
    
    # go to the product instance dir as suggested by the script output
    source $(find . -name '.env') && cd qto/qto.$VERSION.$ENV_TYPE.$USER
    
    # ensure application layer consistency, run db ddl's and load data from s3
    ./src/bash/qto/qto.sh -a check-perl-syntax -a run-qto-db-ddl -a load-db-data-from-s3

### 5.7. Start the web server
Start the hypnotoad web server by issuing the following command

    ./src/bash/qto/qto.sh -a mojo-hypnotoad-start

### 5.8. Access the qto application from the web
The qto web application is available at the following address
http://&lt;&lt;just-copied-IPv4-Public-IP&gt;&gt;:8080

If you associate a DNS name with this ip you could already use it as well. You could run the production version of the app over https ( check the [doc/cheats](doc/cheats/qto-cheat-sheet.sh) for example how-to generate a free ssl cerftificate from Let's encrypt ).

The CertBot https://certbot.eff.org/lets-encrypt/ubuntubionic-other, which WILL BE implemented in qto v0.7.3 bootstrap, so stay tuned ;o)

    

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

    

