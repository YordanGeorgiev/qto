#  APPRIEN-SPARK INSTALLATIONS AND CONFIGURATION GUIDE
* [1. INTRODUCTION](#1-introduction)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. DOCUMENT STATUS](#12-document-status)
  * [1.3. AUDIENCE](#13-audience)
  * [1.4. MASTER STORAGE AND STORAGE FORMAT](#14-master-storage-and-storage-format)
  * [1.5. VERSION CONTROL](#15-version-control)
* [2. QUICK INSTALL](#2-quick-install)
* [3. DOCKER INSTALLATION](#3-docker-installation)
  * [3.1. RUN THE BOOTSTRAP SCRIPT (OPTIONAL)](#31-run-the-bootstrap-script-(optional))
  * [3.2. RUN THE LOCALLY PUBLISHED JARS](#32-run-the-locally-published-jars)
  * [3.3. CREATE AND ATTACH TO A CONTAINER](#33-create-and-attach-to-a-container)
  * [3.4. BUILD THE SCALA PROJECT](#34-build-the-scala-project)
* [4. INSTALLATION ON A PHYSICAL HOST](#4-installation-on-a-physical-host)
  * [4.1. OPEN THE SCALA PROJECT](#41-open-the-scala-project)
  * [4.2. PUBLISH THE SCALA PROJECT OUTPUT JARS INTO LOCAL REPOSITORY](#42-publish-the-scala-project-output-jars-into-local-repository)
  * [4.3. INSTALL OPENJDK 1.8](#43-install-openjdk-18)
* [5. JENKINS CI SETUP](#5-jenkins-ci-setup)
  * [5.1. CHECK THE OWNERSHIP OF THE JENKINS HOME DIR](#51-check-the-ownership-of-the-jenkins-home-dir)
  * [5.2. ENSURE THE JENKINS EXPORTS THE FILE PERMISSIONS RELATED ENV VARS](#52-ensure-the-jenkins-exports-the-file-permissions-related-env-vars)
  * [5.3. ENSURE THE JENKINS JARS CACHE DIR PERMISSIONS](#53-ensure-the-jenkins-jars-cache-dir-permissions)




    

## 1. INTRODUCTION


    

### 1.1. Purpose
The purpose of this document is to provide a description for the tasks and activities to be performed in order to achieve a fully operational apprien-spark application instance. 

    

### 1.2. Document status
This document is updated constantly in every release of the qto. Each version however is considered to be a complete version regarding the qto version it situated in.

    

### 1.3. Audience
This document is aimed for everyone, who shall, will or even would like to install an apprien-spark application instance. Although this guide is aimed to be fully implementable via copy paste by following top to bottom, you need to have basic understanding of networking, protocols and Unix-like OS's in order to complete the full installation, as your mileage will vary...

    

### 1.4. Master storage and storage format
The master storage of this document is the master branch of the qto release you are interested in. The main storage format is Markdown. 

    

### 1.5. Version control
The contents of this document MUST be updated according to the EXISTING features, functionalities and capabilities of the apprien-spark version, in which this document residues.

    

## 2. QUICK INSTALL
Fetch the source on your local machine, which will be use to run the container onto a dir your user has full read, write and execute permissions:

    mkdir -p ~/workspaces/ ; cd ~/workspaces
    git clone git@git.in.phz.fi:phz/apprien-spark.git
    git checkout dev
    # by using the docker compose
    docker-compose up --build --always-recreate-deps --remove-orphans --renew-anon-volumes --force-recreate

## 3. DOCKER INSTALLATION
The following subsections are actually subparts which are used in the docker-compose up - that is if you want to better understand and edit the actual deployment process you should go through them. 

    docker-compose

### 3.1. Run the bootstrap script (optional)
This step is optional as it basically allows you to compare and run different instances of different versions of the project on the same host...
In the qto realm each deployment INSTANCE is "self-aware" of the type of environment it represents -  dev, tst , prd. To bootstrap to the dev environment run the following command:

    bash apprien-spark/src/bash/apprien-spark/bootstrap-apprien-spark.sh

### 3.2. Run the locally published jars
Attach to the running container. Run the pre-generated submit-spark-app script as shown bellow:

    # on the docker 
    /opt/apprien-spark/src/docker/bash/spark/submit-spark-app.sh
    

### 3.3. Create and attach to a container
Create a container as shown bellow. Check the latest output of the script on how-to attach to the running container.

    bash src/bash/apprien-spark/apprien-spark.sh -a create-container
    
    # check the running containers
    docker container ls
    
    # attach to a container ( adjust the container name from ^^^ )
    docker exec -it  apprien-spark005devphz_spark-master_1 /bin/bash

### 3.4. Build the scala project
Build the scala project by editing the sbt-runner.sh script or from the Build menu in idea or by running the build from the IDEA IDE.

    # edit this utiliy script to choose which sbt command you would run
    bash src/bash/sbt-runner.sh

## 4. INSTALLATION ON A PHYSICAL HOST
The target setup enables development on a local physical host and docker, that is you could publish you jars locally and run them against a local sparkcluster running on the docker. 
The need for this setup is dictated by the fact that the complexity of the Scala code requires that your IDE at least understands all the project dependencies to be able to both compile and provide you with intellisense. 

    

### 4.1. Open the scala project
Open the IDEA IDE.
File-New-Project from Existing folders - Navigate to the ~/workspaces/apprien-spark/&lt;&lt;apprien-spark-env-dir&gt;&gt;/src/scala/apprien-spark. 

    

### 4.2. Publish the scala project output jars into local repository
The wrapper call around the sbt publish, which would produce the jars to be run on the spark cluster via the submit script looks as follows:

    bash src/bash/apprien-spark/apprien-spark.sh -a create-local-jars

### 4.3. Install OpenJDK 1.8
Install OpenJDK 1.8 for your OS. Note NOT Oracle jdk 1.8 , but open jdk. 

    

## 5. JENKINS CI SETUP
Use the following actions 

    

### 5.1. Check the ownership of the jenkins home dir
_

    

### 5.2. Ensure the jenkins exports the file permissions related ENV vars
_

    _

### 5.3. Ensure the jenkins jars cache dir permissions
_

    

