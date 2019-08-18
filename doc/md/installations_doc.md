#  QTO INSTALLATIONS AND CONFIGURATION GUIDE
* [1. INTRODUCTION](#1-introduction)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. DOCUMENT STATUS](#12-document-status)
  * [1.3. AUDIENCE](#13-audience)
  * [1.4. MASTER STORAGE AND STORAGE FORMAT](#14-master-storage-and-storage-format)
  * [1.5. VERSION CONTROL](#15-version-control)
  * [1.6. PROCESS](#16-process)
* [2. CONTAINERIZED INSTALL WITH DOCKER](#2-containerized-install-with-docker)
  * [2.1. PREREQUISITES](#21-prerequisites)
  * [2.2. FETCH THE SOURCE](#22-fetch-the-source)
  * [2.3. RUN THE BOOT-STRAP SCRIPT](#23-run-the-boot-strap-script)
  * [2.4. BUILD THE DOCKER IMAGE](#24-build-the-docker-image)
  * [2.5. ATTACH TO THE CONTAINER](#25-attach-to-the-container)
* [3. NON-CONTAINERIZED INSTALL](#3-non-containerized-install)
  * [3.1. OS LEVEL ACCESS](#31-os-level-access)
    * [3.1.1. OS level access via aws](#311-os-level-access-via-aws)
      * [3.1.1.1. Launch a new instance](#3111-launch-a-new-instance)
          * [3.1.1.1.1. Choose an Ubuntu AMI](#31111-choose-an-ubuntu-ami)
          * [3.1.1.1.2. Select the type of instance](#31112-select-the-type-of-instance)
      * [3.1.1.2. Open ports ](#3112-open-ports-)
      * [3.1.1.3. Create a key-pair to access the instance via ssh](#3113-create-a-key-pair-to-access-the-instance-via-ssh)
      * [3.1.1.4. Access the running instance via ssh.](#3114-access-the-running-instance-via-ssh)
  * [3.2. LIBS AND BINARIES INSTALLATIONS ON OS LEVEL](#32-libs-and-binaries-installations-on-os-level)
    * [3.2.1. Check you can sudo with the ubuntu user](#321-check-you-can-sudo-with-the-ubuntu-user)
    * [3.2.2. Add the qto application OS user's group](#322-add-the-qto-application-os-user's-group)
    * [3.2.3. Add the qto application OS user](#323-add-the-qto-application-os-user)
    * [3.2.4. Add the qto app user to the sudoers group](#324-add-the-qto-app-user-to-the-sudoers-group)
    * [3.2.5. Allow sudo without having to type password ](#325-allow-sudo-without-having-to-type-password-)
    * [3.2.6. Install the git binary](#326-install-the-git-binary)
    * [3.2.7. Fetch the source](#327-fetch-the-source)
    * [3.2.8. run the boot-strap script](#328-run-the-boot-strap-script)
    * [3.2.9. Install the OS libs listed in the prereq sh script](#329-install-the-os-libs-listed-in-the-prereq-sh-script)
    * [3.2.10. Install the Perl modules listed in the preq pl scriipt](#3210-install-the-perl-modules-listed-in-the-preq-pl-scriipt)
    * [3.2.11. Disable the warnings in the OAuth2.pm](#3211-disable-the-warnings-in-the-oauth2pm)
    * [3.2.12. Check that the project source code ](#3212-check-that-the-project-source-code-)
  * [3.3. POSTGRES RELATED INSTALLATIONS AND CONFIGURATIONS](#33-postgres-related-installations-and-configurations)
    * [3.3.1. Configure the Ubuntu repositories](#331-configure-the-ubuntu-repositories)
    * [3.3.2. Add the media keys](#332-add-the-media-keys)
    * [3.3.3. Install the postgres package with apt](#333-install-the-postgres-package-with-apt)
    * [3.3.4. Change the postgres user password](#334-change-the-postgres-user-password)
      * [3.3.4.1. start the PostgreSQL](#3341-start-the-postgresql)
      * [3.3.4.2. Start the pgsql client as the postgres shell user](#3342-start-the-pgsql-client-as-the-postgres-shell-user)
      * [3.3.4.3. Create the pgsql user ](#3343-create-the-pgsql-user-)
      * [3.3.4.4. add the uuid generation capability enabling extension](#3344-add-the-uuid-generation-capability-enabling-extension)
      * [3.3.4.5. Install the dblink extension as follows](#3345-install-the-dblink-extension-as-follows)
    * [3.3.5. Install the perl modules](#335-install-the-perl-modules)
  * [3.4. LOAD THE QTO PROJECT DATA](#34-load-the-qto-project-data)
    * [3.4.1. Edit and pre-load the project env vars configuration file](#341-edit-and-pre-load-the-project-env-vars-configuration-file)
    * [3.4.2. Create the database and run the DDL scrripts](#342-create-the-database-and-run-the-ddl-scrripts)
    * [3.4.3. Start the mojo and hypno servers](#343-start-the-mojo-and-hypno-servers)
    * [3.4.4. Load the data from the xls file](#344-load-the-data-from-the-xls-file)
    * [3.4.5. Verify that the app layer and the db work together](#345-verify-that-the-app-layer-and-the-db-work-together)




    

## 1. INTRODUCTION


    

### 1.1. Purpose
The purpose of this document is to provide a description for the tasks and activities to be performed in order to achieve a fully operational qto application instance. 

    

### 1.2. Document status
This document is updated constantly in every release of the qto. Each version however is considered to be a complete version regarding the qto version it situated in.

    

### 1.3. Audience
This document is aimed for everyone, who shall, will or even would like to install  a qto application instance. Although this guide is aimed to be fully implementable via copy paste by following top to bottom, you need to have basic understanding of networking, protocols and Linux in order to complete the full installation, as your mileage will vary...

    

### 1.4. Master storage and storage format
The master storage of this document is the master branch of the qto release you are interested in. The main storage format is Markdown. 

    

### 1.5. Version control
The contents of this document MUST be updated according to the EXISTING features, functionalities and capabilities of the qto version, in which this document residues.

    

### 1.6. Process
The qto provides a mean for tracking of this documentation contents to the source code per feature/functionality, thus should you find inconsistencies in the behaviour of the application and the content of this document you should create a bug issue and assign it to the owner of your product instance.

    

## 2. CONTAINERIZED INSTALL WITH DOCKER
This section describes the installation of a dockerized instance ... Skip to the installations_doc-14 Non dockerized installation section if you are deploying on a "bare metal" or VM ... 

    

### 2.1. Prerequisites
You must have non-older than 2 years Docker run-time. 

    

### 2.2. Fetch the source
Fetch the source from git hub as follows:

    # run with your own OS user
    
    # got to the ~/opt dir you have write permissions to, for example:
    mkdir -p ~/opt/; cd ~/opt/
    
    # fetch the source
    git clone https://github.com/YordanGeorgiev/qto.git
    
    # check it
    ls -la 
    

### 2.3. Run the boot-strap script
The bootstrap script will interpolate change the git deployment dir to a "PRODUCT_INSTANCE_DIR" ( your instance of the qto, having the same version as this one, but running on a different host with different owner - your )

    # defiine the latest and greates product_version
    export product_version=$(cd qto;git tag|sort -nr| head -n 1;cd ..)
    
    # check it 
    echo "product_version: $product_version"
    
    # run the bootstrap script : 
    bash qto/src/bash/qto/bootstrap-qto.sh

### 2.4. Build the docker image
For now only a single image containing both the Application Layer and the database have been developed, thus your whole System will be contained in a single docker. 
Build the docker image with the following one-liner. Wait till the the execution succeeds ... If error occur contact either your product instance owner or troubleshoot with google ...
Note that you might need to hit enter or provide a simple yes/no answers as some of the modules might have changed versions with interactive questions during installations ... 

    clear ; bash src/bash/qto/qto.sh -a build-qto-docker-image

### 2.5. Attach to the container
Attach to the running container as follows: 

docker exec -it qto-container-01 /bin/bash

    

## 3. NON-CONTAINERIZED INSTALL
This section contains the instruction to deploy the qto app on "bare metal" without underlying Docker run-time

    

### 3.1. OS LEVEL ACCESS
The qto has been deployed on Ubuntu OS running virtual machines , physical hosts and aws instances. 

    

#### 3.1.1. OS level access via aws
This section will provide you with the instructions to instantiate an Ubuntu 17 micro instance in AWS. Should create an AWS account if you have not yet one … 

    

##### 3.1.1.1. Launch a new instance
Go to your management console's by clicking Services-EC2 ( note I am using the region=eu-west-1, you might be using a different one ) :
https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=eu-west-1#Instances:sort=monitoring
Click on the blue "launch instance" button. 

    

###### 3.1.1.1.1. Choose an Ubuntu AMI
Scroll down the list. Choose the "Canonical, Ubuntu, 16.04 LTS, amd64 xenial image build on 2018-05-22" AMI. Click on select

    

###### 3.1.1.1.2. Select the type of instance
Choose the type of instance - I am using t2.micro, which is supposed to be free "freetire eligible". Click on the review and Launch ( you could continue configuring till the end of the wizard but you should be ok with the defaults by now

    

##### 3.1.1.2. Open ports 
In the AWS menu click Services - EC2. Click on the left on the security groups. If you configured an explicit security group, select it by clicking on the check box next to it, if you did not that click on the check box to the default security group created something like "launch-wizard-1 created 2018-07-03T14:39:25.644+03:00", where the latest string is the time when you launched the instance. 
Click on Actions - edit inbound rules - open the 3000 and 8080 tcp ports ( the default ones used by the mojo and hypnotoad malicious web servers) 

    

##### 3.1.1.3. Create a key-pair to access the instance via ssh
Click on the key-pairs in the left. Create a new one. Download the file in a path you could navigate later on to. I am using for example the following path:

    ~/key-pair-qto.pem

##### 3.1.1.4. Access the running instance via ssh.
Run the following commands, by replacing the ssh_server with the value taken from the "Private DNS" of the running instance. 

    export ssh_user=ubuntu
    export ssh_server=ec2-31-223-97-157.eu-west-1.compute.amazonaws.com
    export key_pair_file=~/key-pair-qto.pem
    
    ssh -i $key_pair_file $ssh_user@$ssh_server

### 3.2. LIBS AND BINARIES INSTALLATIONS ON OS LEVEL


    

#### 3.2.1. Check you can sudo with the ubuntu user
You should be able to sudo with your ubuntu user. 

    # set a nice informative prompt
    export PS1="\h [\d \t] [\w] $ \n\n  "
    
    sudo su - 

#### 3.2.2. Add the qto application OS user's group
The current "as simpliest as possible" setup is to use a separate OS group for the user of the qto application. 
The name of the group could be anything, as well it's gid , use those values if you do not want to make additional own configurations. 

    export group=grp_it
    export gid=10001
    sudo groupadd -g "$gid" "$group"
    sudo cat /etc/group | grep --color "$group"

#### 3.2.3. Add the qto application OS user
Add the user as shown bellow. The name of the user could be also anyting, as log as it belongs to the above configured group. 

    export user=usr_it
    export uid=10001
    export home_dir=/home/$user
    export desc="the qto group"
    #how-to add an user
    sudo useradd --uid "$uid" --home-dir "$home_dir" --gid "$group" \
    --create-home --shell /bin/bash "$user" \
    --comment "$desc"
    sudo cat /etc/passwd | grep --color "$user"
    groups "$user"

#### 3.2.4. Add the qto app user to the sudoers group
Edit the /etc/group

    sudo:x:27:ubuntu,usr_it

#### 3.2.5. Allow sudo without having to type password 
Add the following text to the /etc/sudoers file:

    # See sudoers(5) for more information on "#include" directives:
    
    
    
    

#### 3.2.6. Install the git binary
You will need the git binary to fetch the qto source - you could alternatively download its zip fille. 

    sudo apt-get install build-essential git

#### 3.2.7. Fetch the source
Fetch the source from git hub as follows:

    # run as usr_it
    sudo su - usr_it
    
    # got to a dir you have write permissions , for example:
    mkdir -p ~/opt/; cd ~/opt/
    
    # fetch the source
    git clone https://github.com/YordanGeorgiev/qto.git
    
    # checkit
    ls -la 
    

#### 3.2.8. run the boot-strap script
The bootstrap script will interpolate change the git deployment dir to a "PRODUCT_INSTANCE_DIR" ( your instance of the qto, having the same version as this one, but running on a different host with different owner - your )

    # defiine the latest and greates product_version
    export product_version=$(cd qto;git tag|sort -nr| head -n 1;cd ..)
    
    # check it 
    echo $product_version
    
    # run the bootstrap script : 
    bash qto/src/bash/qto/bootstrap-qto.sh

#### 3.2.9. Install the OS libs listed in the prereq sh script
The "prereq"script contains the listing of the binaries to be installed. Run the script. 

    # go to your product instance dir - 
    cd ~/opt/csitea/qto/qto.$product_version.dev.$USER
    sudo bash src/bash/qto/install-prerequisites-on-ubuntu.sh

#### 3.2.10. Install the Perl modules listed in the preq pl scriipt
The Perl modules installation looks ALWAYS, yet it usually goes trough without any googling of sessions etc. 

    # go to your product instance dir - 
    cd /opt/csitea/qto/qto.$product_version.dev.$USER
    sudo perl src/perl/qto/script/qto_preq_checker.pl

#### 3.2.11. Disable the warnings in the OAuth2.pm
As many of the actions in the qto this is simply a one-liner. 

    vim /usr/local/share/perl/5.22.1/Net/Google/DataAPI/Auth/OAuth2.pm
    # edit the use Any::Moose; line as follows:
    
    no warnings 'deprecated';
    use Any::Moose;
    use warnings 'deprecated' ;

#### 3.2.12. Check that the project source code 
As many of the actions in the qto this is simply a one-liner. You should not get any errors after the execution of this one , if there are probably some prerequisite module has not been included in the prerequisite script ( although we have tested those several times ... ). So you would either have to install it by yourself or troubleshoot why it does not install. 

    bash src/bash/qto/qto.sh -a check-perl-syntax

### 3.3. POSTGRES RELATED INSTALLATIONS AND CONFIGURATIONS


    

#### 3.3.1. Configure the Ubuntu repositories
Configure the Ubuntu repositories

    sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"

#### 3.3.2. Add the media keys
Add the media keys as follows:

    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

#### 3.3.3. Install the postgres package with apt
Install the postgres package with apt

    # update your repos
    sudo apt-get clean 
    sudo apt-get update
    
    sudo apt-get clean 
    sudo apt-get update
    apt-get install -f -y postgresql-server-dev-11 postgresql-client-11 postgresql-contrib-11
    
    # enable postgre
    sudo update-rc.d postgresql enable

#### 3.3.4. Change the postgres user password
Configure the Ubuntu repositories

    sudo passwd postgres
    # Type a pw - add to your password manager !!!
    
    # and verify 
    su - postgres

##### 3.3.4.1. start the PostgreSQL
Start the PostgreSQL by issuing the following command

    sudo /etc/init.d/postgresql start

##### 3.3.4.2. Start the pgsql client as the postgres shell user
Start the pgsql client as the postgres shell user
source:
http://dba.stackexchange.com/a/54253/1245

    sudo su - postgres
    # start the psql client
    psql
    
    # the psql prompt should appear as
    # postgres=# 
    
    # list the databases
    \l
    #and quit
    \q

##### 3.3.4.3. Create the pgsql user 
Create the pgsql user and grant him the privileges to create dbs and to connect to the postgres db. 
You could alternatively configure different way of authentication according to the options provided in this stackoverflow answer:
http://stackoverflow.com/a/9736231/65706

    # create the pgsql user to be the same as the shell 
    # user you are going to execute the scripts with 
    sudo su - postgres  -c "psql -c 'CREATE USER '$USER' ;'"
    
    # grant him the priviledges
    sudo su - postgres  -c "psql -c 'grant all privileges on database postgres to '$USER' ;'"
    
    # grant him the privilege to create db's 
    sudo su - postgres  -c "psql -c 'ALTER USER '$USER' CREATEDB;'"
    
    sudo su - postgres  -c 'psql -c "select * from information_schema.role_table_grants
     where grantee='"'"$USER"'"';"'

##### 3.3.4.4. add the uuid generation capability enabling extension
add the uuid generation capability enabling extension

    clear ; export tables=`curl -s -k http://$web_host:8080/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/qto/script/qto.pl --tables $tables --do xls-to-db
    
    

##### 3.3.4.5. Install the dblink extension as follows
Install the dblink extension as follows

    sudo su - postgres  -c "psql template1 -c 'CREATE EXTENSION IF NOT EXISTS \"dblink\";' "

#### 3.3.5. Install the perl modules
Install the perl module by first installing the server development package.

    
    # check which server development packages are available
    sudo apt-cache search postgres | grep -i server-dev | sort
    
    # install it
    sudo apt-get install -y postgresql-server-dev-9.6
    
    # install the DBD::Pg module
    sudo perl -MCPAN -e 'install DBD::Pg'
    
    sudo perl -MCPAN -e 'Tie::Hash::DBD'

### 3.4. LOAD THE QTO PROJECT DATA


    

#### 3.4.1. Edit and pre-load the project env vars configuration file
As the qto supports loading data for multiple instances of itself - dev,tst,prd AND multiple pre-configured projects, YOU MUST have a shell with the pre-configured set of environmental variables in order to achieve ANY of the actions.

    # load the bash func to parse the conf files
    source lib/bash/funcs/parse-cnf-env-vars.sh
    
    doParseCnfEnvVars cnf/qto.dev.$(hostname -s).cnf

#### 3.4.2. Create the database and run the DDL scrripts


    bash src/bash/qto/qto.sh -a run-pgsql-scripts

#### 3.4.3. Start the mojo and hypno servers
The morbo dev server is listening on the 3000 port by default and the hypnotoad on the 8080 by default. You will need to use either one when loading the tables in the next step. 

    bash src/bash/qto/qto.sh -a mojo-morbo-stop ; bash src/bash/qto/qto.sh -a mojo-morbo-start
    
    bash src/bash/qto/qto.sh -a mojo-hypnotoad-stop ; bash src/bash/qto/qto.sh -a mojo-hypnotoad-start

#### 3.4.4. Load the data from the xls file
Load the data to the db from the xls file

    clear ; export tables=`curl -s -k http://$web_host:8080/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/qto/script/qto.pl --tables $tables --do xls-to-db

#### 3.4.5. Verify that the app layer and the db work together
In the aws menu click Services - EC2. Click on the instances on the left. Check the public DNS name of your instance and use it for the URL as follows:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_qto/list/monthly_issues

    

