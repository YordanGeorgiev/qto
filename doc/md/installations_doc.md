#  QTO INSTALLATIONS AND CONFIGURATION GUIDE
* [1. INTRODUCTION](#1-introduction)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. DOCUMENT STATUS](#12-document-status)
  * [1.3. AUDIENCE](#13-audience)
  * [1.4. MASTER STORAGE AND STORAGE FORMAT](#14-master-storage-and-storage-format)
  * [1.5. VERSION CONTROL](#15-version-control)
  * [1.6. PROCESS](#16-process)
* [2. AUTOMATED FULL DEPLOYMENT ON AWS  IN 35 MINUTES](#2-automated-full-deployment-on-aws-in-35-minutes)
  * [2.1. PREREQUISITES](#21-prerequisites)
  * [2.2. TARGET SETUP](#22-target-setup)
  * [2.3. BOOTSTRAP AND DEPLOY THE APPLICATION LOCALLY](#23-bootstrap-and-deploy-the-application-locally)
  * [2.4. PROVISION THE APPLICATION LOCALLY](#24-provision-the-application-locally)
  * [2.5. CONFIGURE YOUR AWS CREDENTIALS - AWS KEYS AND  SSH KEYS](#25-configure-your-aws-credentials--aws-keys-and-ssh-keys)
  * [2.6. INITIALISE THE AWS INFRASTRUCTURE](#26-initialise-the-aws-infrastructure)
  * [2.7. SET THE IP ADDRESS FOR THE HOST IN DNS ( OPTIONAL ) ](#27-set-the-ip-address-for-the-host-in-dns-(-optional-)-)
  * [2.8. ACCESS THE AWS HOST VIA SSH AND FETCH THE SOURCE CODE FROM GITHUB](#28-access-the-aws-host-via-ssh-and-fetch-the-source-code-from-github)
  * [2.9. BOOTSTRAP AND DEPLOY THE APPLICATION ON THE AWS INSTANCE](#29-bootstrap-and-deploy-the-application-on-the-aws-instance)
  * [2.10. PROVISION THE APPLICATION IN THE AWS INSTANCE](#210-provision-the-application-in-the-aws-instance)
  * [2.11. START THE WEB SERVER](#211-start-the-web-server)
  * [2.12. ACCESS THE QTO APPLICATION FROM THE WEB](#212-access-the-qto-application-from-the-web)
  * [2.13. CONFIGURE DNS AND HTTPS](#213-configure-dns-and-https)
  * [2.14. PROVISION QTO USERS](#214-provision-qto-users)
* [3. POTENTIAL PROBLEMS](#3-potential-problems)
  * [3.1. THE POSTGRES ADMIN USER PASSWORD IS WRONG](#31-the-postgres-admin-user-password-is-wrong)




    

## 1. INTRODUCTION


    

### 1.1. Purpose
The purpose of this document is to provide a description for the tasks and activities to be performed in order to achieve a fully operational qto application instance. 

    

### 1.2. Document status
This document is updated constantly in every release of the qto. Each version however is considered to be a complete version regarding the qto version it situated in.

    

### 1.3. Audience
This document is aimed for everyone, who shall, will or even would like to install  a qto application instance. Although this guide is aimed to be fully implementable via copy paste by following top to bottom, you need to have basic understanding of networking, protocols and Linux in order to complete the full installation, as your mileage will vary...

    

### 1.4. Master storage and storage format
The master storage of this document is the master branch of the latest qto release. The main storage format is Markdown. 

    

### 1.5. Version control
The contents of this document MUST be updated according to the EXISTING features, functionalities and capabilities of the qto version, in which this document residues.

    

### 1.6. Process
The qto provides a mean for tracking of this documentation contents to the source code per feature/functionality, thus should you find inconsistencies in the behaviour of the application and the content of this document you should create a bug issue and assign it to the owner of your product instance.

    

## 2. AUTOMATED FULL DEPLOYMENT ON AWS  IN 35 MINUTES
This section WILL provide you will with ALL required steps to get a fully functional instance of the qto application in aws in about 35 min with 3 commands. Do just copy paste the commands into your shell and not cd into different directories - this deployment has been tested more than 30 times successfully by exactly reproducing those steps, yet the variables in such a complex deployment are many, thus should you encounter new issues do directly contact the owner of the instance you got this deployment package from, that is the person owning the github repository you fetched the source code from.

    

### 2.1. Prerequisites
You need an aws account, capable of deploying micro instances. The costs for running the qto.fi is about 15 USD per month ( aka this aws deployment expense to Amazon would be less than a dollar ), but if you are going to use a free account, which does not allow the instantiation of the ami's specified in the src/terraform/tpl/qto/main.tf.tpl file, you should modify the template file to accommodate that. 

    

### 2.2. Target setup
The target setup is a system comprised of dev, tst, qas and prd instances of qto locally and dev, tst , qas and prd instances in aws. 
The following diagram illustrates that setup. 


Figure 1: 
The target setup for the qto appliction
![Figure 1: 
The target setup for the qto appliction](https://github.com/YordanGeorgiev/qto/blob/master/doc/img/system_guide/qto-infra.jpg?raw=true)

    

### 2.3. Bootstrap and deploy the application LOCALLY
The bootstrap script will deploy ALL the required Ubuntu 18.04 binaries AND perl modules as well as perform the needed configurations to enable the creation and load of the qto database. This step will take 20 min at least. The bootstrapping script will :
 - install all the required binaries
 - install all the required perl modules as non-root
 - install and provision postgres
 - install and provision the nginx proxy server 
Check the main method in the run.sh and uncomment entities you do not want to install locally, should you have any ...

    # in the shell of your local Ubuntu box
    mkdir -p ~/opt; cd $_ ; git clone https://github.com/YordanGeorgiev/qto.git ; cd ~/opt
    
    # run the bootstrap script and IMPORTANT !!! reload the bash env
    ./qto/src/bash/deployer/run.sh ; bash ; 
    

### 2.4. Provision the application LOCALLY
The run of the following "shell actions" will create the qto database and load it with a snapshot of it's data from a sql dump stored in s3. 

    # go to the product instance dir as suggested by the script output
    source $(find . -name '.env') && cd qto/qto.$VERSION.$ENV_TYPE.$USER
    
    # ensure application layer consistency, run db ddl's and load data from s3
    touch bootrapping &&  ./src/bash/qto/qto.sh -a check-perl-syntax -a scramble-confs -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3 && rm -v bootrapping

### 2.5. Configure your aws credentials - aws keys and  ssh keys
Generate NEW aws access- and secret-keys https://console.aws.amazon.com/iam/home?region=&lt;&lt;YOUR-AWS-REGION&gt;&gt;#/security_credentials. 
Store the keys in the qto's development environment configuration file - the cnf/env/dev.env.json file.
When the file path is suggested append a different string to avoid overwriting the default private key path!!!

    #create the a NEW public private key pair ( do not overwrite you existing one !! ) as follows 
    ssh-keygen -t rsa -b 4096 -C "your.name@your.org"

### 2.6. Initialise the aws infrastructure
To initialise the git aws infrastructure you need to clone the qto source code locally first. 

    # apply the infra terraform in the src/terraform/tpl/qto/main.tf.tpl 
    clear ; bash ~/opt/qto/src/bash/qto/qto.sh -a init-aws-instance

### 2.7. Set the ip address for the host in DNS ( optional ) 
If you have registered your own DNS name you should configure now the public ip address found in the amamazon ec2 instances section of the newly created host to the dns name you have registered with your DNS provider, as it usually takes some time for the DNS to replicate ( with the qto.fi domain it takes about 5 min, even hours are suggested to be reserved ...).
If you do not have a registered DNS, you could either use directly the ip address or the dns name provided by amazon in the ec2 settings of the newly created host, in this case you should configure the same DNS in the cnf/etc/dev.env.json file ( env-&gt;app-&gt;web_host variable ) for ngix to be able to pick it in its own configuration.

    

### 2.8. Access the aws host via ssh and fetch the source code from GitHub
To access the aws host via ssh you need to copy the provided elastic ip which was created by the terraform script. In your browser go to the following url:
https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=&lt;&lt;YOUR-AWS-REGION&gt;&gt;#Instances:sort=instanceId
You should see a listing of your aws instances one of which should be named dev-qto-ec2 ( that is the development instance of the qto application). Click on it's checkbox. Search for the "IPv4 Public IP" string and copy the value of the ip.

    # run locally 
    ssh -i <<path-to-your-private-key-file>> ubuntu@<<just-copied-IPv4-Public-IP>>
    
    # on the aws server
    mkdir -p ~/opt; cd $_ ; git clone https://github.com/YordanGeorgiev/qto.git ; cd ~/opt

### 2.9. Bootstrap and deploy the application on the aws instance
The bootstrap script will deploy ALL the required Ubuntu 18.04 binaries AND perl modules as well as perform the needed configurations to enable the creation and load of the qto database. This step will take at least 20 min. The bootstrap script will perform the following actions:
 - install all the required binaries
 - install all the required perl modules as non-root
 - install and provision postgres
 - install and provision the nginx proxy server


    # run the bootstrap script and IMPORTANT !!! reload the bash shell
    ./qto/src/bash/deployer/run.sh ; bash ; 

### 2.10. Provision the application in the aws instance
The run of the following "shell actions" will create the qto database and load it with a snapshot of it's data from a sql dump stored in s3. 

    # go to the product instance dir 
    source $(find . -name '.env') && cd qto/qto.$VERSION.$ENV_TYPE.$USER
    
    # ensure application layer consistency, run db ddl's and load data from s3
    touch bootrapping &&  ./src/bash/qto/qto.sh -a check-perl-syntax -a scramble-confs -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3 && rm -v bootrapping

### 2.11. Start the web server
The following command will both start the Mojolicious hyphotoad server initiating the qto application layer and the nginx reverse proxy, which will listen on the app-&gt;port port defined in the cnf/env/dev.env.json file.

    ./src/bash/qto/qto.sh -a mojo-hypnotoad-start

### 2.12. Access the qto application from the web
The qto web application is available at the following address
http://&lt;&lt;just-copied-IPv4-Public-IP&gt;&gt;:8078 should redirect you to the dev_qto/login page - this is the end-point via mojolicious over http ( NOT safe ).
The qto web application is available at the following address
http://&lt;&lt;just-copied-IPv4-Public-IP&gt;&gt;:78 should redirect you to the dev_qto/login page - via the nginx proxy ( SAFE )






    

### 2.13. Configure DNS and HTTPS
Configure the DNS server name in the UI of your DNS provider.

    

### 2.14. Provision qto users
Open the cnf/env/dev.env.json, change the env-&gt;AdminEmail with an e-mail you have access to. Restart the web servers as shown bellow. Login via the 

    # the start action performs restart as well, if the web servers are running
    ./src/bash/qto/qto.sh -a mojo-hypnotoad-start

## 3. POTENTIAL PROBLEMS


    

### 3.1. The postgres admin user password is wrong
This error is somewhat mystical and has occurred several time - the most probable root cause for it is execution of the steps in wrong order - basically the db security is passed from OS root to postgres user to qto admin to qto app, thus to fix it issue the following command, which will basically re-provision your postgres.
You would need to restart the web server after executing this command.

     ./src/bash/qto/qto.sh -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3

