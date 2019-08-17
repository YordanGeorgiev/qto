#  README
* [1. WHAT IS THIS ?!](#1-what-is-this-)
* [2. INSTALLATION ON A PHYSICAL HOST](#2-installation-on-a-physical-host)
  * [2.1. FETCH THE SOURCE](#21-fetch-the-source)
  * [2.2. INSTALL OPENJDK 1.8](#22-install-openjdk-18)
  * [2.3. RUN THE BOOTSTRAP SCRIPT (OPTIONAL)](#23-run-the-bootstrap-script-(optional))
  * [2.4. OPEN THE SCALA PROJECT](#24-open-the-scala-project)
  * [2.5. BUILD THE SCALA PROJECT](#25-build-the-scala-project)
  * [2.6. PUBLISH THE SCALA PROJECT OUTPUT JARS INTO LOCAL REPOSITORY](#26-publish-the-scala-project-output-jars-into-local-repository)
* [3. DOCKER INSTALLATION](#3-docker-installation)
  * [3.1. BUILD THE IMAGE](#31-build-the-image)
  * [3.2. CREATE A CONTAINER](#32-create-a-container)
  * [3.3. RUN THE APPRIEN-SPARK ENGINE.JAR](#33-run-the-apprien-spark-enginejar)




    

## 1. WHAT IS THIS ?!
A Proof of Concept for a minimalistic yet fully end-to-end integrated spark application ready for local development.

    

## 2. INSTALLATION ON A PHYSICAL HOST


    

### 2.1. Fetch the source
Fetch the source on your local machine, which will be use to run the container onto a dir your user has full read, write and execute permissions:

    mkdir -p ~/workspaces/ ; cd ~/workspaces
    git clone https://github.com/YordanGeorgiev/qto

### 2.2. Install OpenJDK 1.8
Install OpenJDK 1.8 for your OS. Note NOT Oracle jdk 1.8 , but open jdk. 

    

### 2.3. Run the bootstrap script (optional)
This step is optional as it basically allows you to compare and run different instances of different versions of the project on the same host...
In the qto realm each deployment INSTANCE is "self-aware" of the type of environment it represents -  dev, tst , prd. To bootstrap to the dev environment run the following command:

    bash apprien-spark/src/bash/apprien-spark/bootstrap-apprien-spark.sh

### 2.4. Open the scala project
File-New-Project from Existing folders - Navigate to the ~/workspaces/apprien-spark/&lt;&lt;apprien-spark-env-dir&gt;&gt;/src/scala/apprien-spark. 

    

### 2.5. Build the scala project
Build the scala project by editing the sbt-runner.sh script or from the Build menu in idea.

    bash src/bash/sbt-runner.sh

### 2.6. Publish the scala project output jars into local repository
Build the scala project by editing the sbt-runner.sh script or from the Build menu in idea.

    bash src/bash/apprien-spark/apprien-spark.sh -a create-local-jars

## 3. DOCKER INSTALLATION
Those will be replaced by the docker compose setup ...

    

### 3.1. Build the image
Build the image as follows:

    bash src/bash/apprien-spark/apprien-spark.sh -a build-docker-image

### 3.2. Create a container
Create a container as shown bellow. Check the latest output of the script on how-to attach to the running container.

    bash src/bash/apprien-spark/apprien-spark.sh -a create-container

### 3.3. Run the apprien-spark engine.jar
Attach to the running container. Run the pre-generated submit-spark-app script as shown bellow:

    # check the name of the running container by:
    docker container ls
    docker exec -it  as-container-20190807_124924 /opt/apprien-spark/src/bash/apprien-spark/submit-spark-app.sh

