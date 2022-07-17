#  QTO INSTALLATIONS AND CONFIGURATION GUIDE
* [1. INTRODUCTION](#1-introduction)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. DOCUMENT STATUS](#12-document-status)
  * [1.3. AUDIENCE](#13-audience)
  * [1.4. MASTER STORAGE AND STORAGE FORMAT](#14-master-storage-and-storage-format)
  * [1.5. VERSION CONTROL](#15-version-control)
  * [1.6. PROCESS](#16-process)
* [2. LOCAL DEPLOYMENT](#2-local-deployment)
  * [2.1. PREREQUISITES](#21-prerequisites)
  * [2.2. TARGET SETUP](#22-target-setup)
  * [2.3. ENSURE YOU HAVE PASSWORDLESS SUDO ](#23-ensure-you-have-passwordless-sudo-)
  * [2.4. CLONE QTO REPOSITORY TO YOUR GITHUB ACCOUNT](#24-clone-qto-repository-to-your-github-account)
  * [2.5. INSTALL AND TMUX, VIM, GIT AND BASH CONFS (OPTIONAL)](#25-install-and-tmux-vim-git-and-bash-confs-(optional))
  * [2.6. INSTALL VB+VAGRANT VIRTUAL MACHINE FOR A LOCAL UBUNTU HOST (OPTIONAL) ](#26-install-vb+vagrant-virtual-machine-for-a-local-ubuntu-host-(optional)-)
  * [2.7. ADD TRUST BETWEEN LOCAL HOST AND GITHUB SERVER](#27-add-trust-between-local-host-and-github-server)
  * [2.8. BOOTSTRAP AND DEPLOY THE APPLICATION LOCALLY](#28-bootstrap-and-deploy-the-application-locally)
  * [2.9. PROVISION THE APPLICATION LOCALLY](#29-provision-the-application-locally)
  * [2.10. START THE APPLICATION LAYER ON THE DEV INSTANCE](#210-start-the-application-layer-on-the-dev-instance)
  * [2.11. CREATE AND START THE TST INSTANCE](#211-create-and-start-the-tst-instance)
  * [2.12. CHECK APPLICATION LAYER SYNTAX, LOAD DB DATA](#212-check-application-layer-syntax-load-db-data)
  * [2.13. START THE TST INSTANCE](#213-start-the-tst-instance)
* [3. FIRST TIME AWS DEPLOYMENT](#3-first-time-aws-deployment)
  * [3.1. AWS CENTRIC INFRASTRUCTURE AS A CODE RELATED INTRO](#31-aws-centric-infrastructure-as-a-code-related-intro)
  * [3.2. PREREQUISITES](#32-prerequisites)
    * [3.2.1. Configure the AdminEmail](#321-configure-the-adminemail)
    * [3.2.2. Create a pem file for deployment](#322-create-a-pem-file-for-deployment)
    * [3.2.3. Create AWS instance deployment keys](#323-create-aws-instance-deployment-keys)
    * [3.2.4. Configure your AWS credentials - AWS keys](#324-configure-your-aws-credentials--aws-keys)
  * [3.3. INITIALISE AWS INFRASTRUCTURE](#33-initialise-aws-infrastructure)
  * [3.4. SET IP ADDRESS FOR THE HOST IN DNS (OPTIONAL) ](#34-set-ip-address-for-the-host-in-dns-(optional)-)
  * [3.5. ACCESS AWS HOST VIA SSH](#35-access-aws-host-via-ssh)
  * [3.6. FETCH THE SOURCE CODE FROM GITHUB ON THE AWS SERVER](#36-fetch-the-source-code-from-github-on-the-aws-server)
  * [3.7. BOOTSTRAP AND DEPLOY THE APPLICATION ON AWS INSTANCE](#37-bootstrap-and-deploy-the-application-on-aws-instance)
  * [3.8. PROVISION APPLICATION IN AWS INSTANCE IN DEV](#38-provision-application-in-aws-instance-in-dev)
  * [3.9. EDIT THE CONFIGURATION FILE AND START WEB SERVER](#39-edit-the-configuration-file-and-start-web-server)
  * [3.10. ACCESS THE QTO APPLICATION FROM WEB](#310-access-the-qto-application-from-web)
  * [3.11. CONFIGURE DNS](#311-configure-dns)
  * [3.12. PROVISION QTO WEB USERS](#312-provision-qto-web-users)
  * [3.13. CREATE THE TST PRODUCT INSTANCE](#313-create-the-tst-product-instance)
  * [3.14. PROVISION THE TST DATABASE](#314-provision-the-tst-database)
  * [3.15. FORK PRODUCTION INSTANCE](#315-fork-production-instance)
  * [3.16. PROVISION PRD DB](#316-provision-prd-db)
* [4. PROVISION HTTPS (ONLY IF DNS IS CONFIGURED)](#4-provision-https-(only-if-dns-is-configured))
  * [4.1. FORK LATEST STABLE DEV TO TST](#41-fork-latest-stable-dev-to-tst)
  * [4.2. GO TO YOUR PREVIOUS ENVIRONMENT](#42-go-to-your-previous-environment)
* [5. NON-FIRST TIME AWS DEPLOYMENT](#5-non-first-time-aws-deployment)
  * [5.1. CREATE AWS INSTANCE](#51-create-aws-instance)
  * [5.2. SETUP BASH & VIM](#52-setup-bash-&-vim)
  * [5.3. CLONE PROJECT TO GUEST SERVER](#53-clone-project-to-guest-server)
* [6. PHYSICAL HOST OS INSTALLATIONS](#6-physical-host-os-installations)
  * [6.1. MACOS](#61-macos)
    * [6.1.1. Install QtPass](#611-install-qtpass)
* [7. POTENTIAL PROBLEMS AND TROUBLESHOOTING](#7-potential-problems-and-troubleshooting)
  * [7.1. POSTGRES ADMIN USER PASSWORD IS WRONG](#71-postgres-admin-user-password-is-wrong)
  * [7.2. AWS WAS NOT ABLE TO VALIDATE THE PROVIDED ACCESS CREDENTIALS](#72-aws-was-not-able-to-validate-the-provided-access-credentials)
  * [7.3. REDIS REFUSES TO START ](#73-redis-refuses-to-start-)
  * [7.4. COULD NOT CONNECT TO REDIS SERVER](#74-could-not-connect-to-redis-server)
  * [7.5. YOU HAVE REACHED THE HW PROVISIONING LIMITS OF YOUR AWS ACCOUNT](#75-you-have-reached-the-hw-provisioning-limits-of-your-aws-account)
  * [7.6. CANNOT LOGIN IN WEB INTERFACE WITH ADMIN USER](#76-cannot-login-in-web-interface-with-admin-user)
  * [7.7. MISMATCH IN THE AWS](#77-mismatch-in-the-aws)
  * [7.8. THE PROBLEM OCCURRED IS NOT MENTIONED HERE ?!](#78-the-problem-occurred-is-not-mentioned-here-)




    

## 1. INTRODUCTION
The QTO installation could be compressed to four oneliners, yet if you are installing it for the first time you should read this guide thoroughly and CAREFULLY or at least jump through the code sections from the top till the bottom, simply because the stack is huge - PostgreSQL, Perl application layer with a lot of modules and dependencies and you will be deploying the whole stack.

    

### 1.1. Purpose
The purpose of this document is to provide a description for the tasks and activities to be performed in order to achieve a fully operational QTO application instance, such as the one running on the https://qto.fi site. 

    

### 1.2. Document status
This document is reviewed for the current QTO version it is generated from. The document is updated and reviewed after each QTO release.

    

### 1.3. Audience
This document is aimed for everyone, who shall, will or even would like to install a QTO application instance. Although this guide is aimed to be fully implementable via copy paste by following top to bottom, you need to have basic understanding of networking, protocols and Linux in order to complete the full installation, as your mileage will vary.
This document might be of interest for people from architectural or even business app_roles to the extend to verify the claims for easy deployability states in other parts of the QTO application documentation set.

    

### 1.4. Master storage and storage format
The master storage of this document is the master branch of the latest QTO release. The main storage format is Markdown. 

    

### 1.5. Version control
The contents of this document ARE updated according to the EXISTING features, functionalities and capabilities of the QTO version, in which this document residues. Thus the git commit hash of a release QTO version contains the md format of this document.

    

### 1.6. Process
The QTO provides a mean for tracking of this documentation contents to the source code per feature/functionality, thus should you find inconsistencies in the behaviour of the application and the content of this document, please create a bug issue and assign it to the owner of your product instance.

    

## 2. LOCAL DEPLOYMENT


    

### 2.1. Prerequisites
You need hardware, which is powerful enough to run a virtual machine with at least 2GB of RAM, preferably more, and at least 20GB of hard disk space. 

    

### 2.2. Target setup
The target setup of both the LOCAL an the AWS deployments is a system comprised of dev, tst, qas and prd instances of QTO locally and dev, tst, qas and prd instances in AWS. 
The target setup in this section is the "satellite-host" depicted as "dev-mac" in the below diagram.
The following diagram illustrates that setup. Naturally you will be deploying only the dev.&lt;&lt;site&gt;&gt;.com, when performing the installation for the first time. Thus, in the spirit of QTO, you will be moving fast and destroying in dev, reinforcing skills in tst and do it at once in prd.


    

### 2.3. Ensure you have passwordless sudo 
The next command check whether or not your Linux user can execute sudo commands without having to provide password by checking whether or not the:
"&lt;&lt;your-linux-accont&gt;&gt; ALL=(ALL) NOPASSWD: ALL"
line without the quotes is found in your /etc/sudoers file and if it is not it adds it to it. Make sure you copy paste the whole line, because if you brake the syntax of your /etc/sudoers file you would have to boot in safe mode and manually add the line into your /etc/sudoers file. 

    test $(grep `whoami` /etc/sudoers|wc -l) -ne 1 && echo $(whoami)' ALL=(ALL) NOPASSWD: ALL'|sudo tee -a /etc/sudoers

### 2.4. Clone QTO repository to your GitHub account
Fork the QTO repository to your GitHub account from the GitHub UI by clicking on the fork button. After several seconds you should be able to access the qto project instead from an url like this: 
https://github.com/YordanGeorgiev/qto
from the 
https://github.com/%YourGitHubUserName%/qto

This action will enable the Merge Requests creation according to the qto development process described in the devops guide out of the box.

    

### 2.5. Install and tmux, vim, git and bash confs (optional)
This step is optional - it will deploy tmux, vim and git with some default configurations, which you could omit. Replace the email and the initials passed as $1 and $2 to the script with your email and initials and not those below.

    # on the AWS server
    export your_git_user_name=YordanGeorgiev
    export your_email=yordan.georgiev@gmail.com
    export your_initials=ysg
    
    curl https://raw.githubusercontent.com/$your_git_user_name/qto/master/src/bash/qto/scripts/setup-bash-tmux-vim.sh | bash -s $your_email $your_initials
    
    # on the AWS server
    mkdir -p ~/opt; cd $_ ;  git clone git@github.com:<<YourGitHubUserName>>/qto.git; cd ~/opt

### 2.6. Install VB+Vagrant virtual machine for a local Ubuntu host (optional) 
If your physical host OS is not Ubuntu 18.04 OS, you could install the latest version of the Oracle VirtualBox with Guest additions and HashiCorp Vagrant and run the deploy-vagrant-vm.sh bootstrapper script on the Host to get a fully provisioned Guest setup with all the binaries and configurations. This step might take around 30 min depending on the hardware of your host machine and the VirtualBox configurations in your setup.

     # in the shell of your OS bash shell of your host machine
    mkdir -p ~/opt; cd $_ ; git clone git@github.com:<<YourGitHubUserName>>/qto.git ; cd ~/opt/qto
    
    # run the vagrant provisioning script
    ./src/bash/deploy-vagrant-vm.sh
    
    # now go to the vagrant guest
    vagrant ssh
    
    # go to the qto project in the 
    cd /home/vagrant/opt/qto/

### 2.7. Add trust between local host and github server
To add the trust between the locahost andl the GitHub server you must paste your public ssh keys into the GitHub UserSettings , as described in the following link:
https://www.inmotionhosting.com/support/website/ssh/how-to-add-ssh-keys-to-your-github-account/

And it would look something as follows:

    # check the ~/.ssh dir, of course you will have a different output 
    find ~/.ssh|sort
    /home/ubuntu/.ssh
    /home/ubuntu/.ssh/authorized_keys
    /home/ubuntu/.ssh/id_rsa.ysg.ip-10-0-46-110
    /home/ubuntu/.ssh/id_rsa.ysg.ip-10-0-46-110.pub
    
    # get the full string of the public key of your local OS account
    # of course this line will look different to you ... so don't copy it ... 
    cat /home/ubuntu/.ssh/id_rsa.ysg.ip-10-0-46-110.pub
    
    # copy carefully from EXACTLY the beginning of the next line till the end of the email address
    # of course YOUR public ssh key WILL look different
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1dEuQqFp+4yUDAGwLCf8YxsHCaWD/by+yyOYh85loZw1TTm51dqEjsFDWgNKE9e8hLeX5AuyJGfz4dOTT81/Wrj3OBeF8fc3Lvu4IdXQaXxaEHGTdXtuOdD/uYXnVcnO3rQd8BFuPnqBZbu5nD1ROWdRPBLPE4x5dZ/P/UqUkHfOxq1cFIMHtus2tG+WboCRxRL0Ft5QGMAZM9DgLWr+IH/HI9fzgiRykmoaCwX2fy4m18lf2opFj+fr1BAsRDZduBS7btBjRuTtJejVjS2Ulzjh/6vEKcJWospwKX/5C9ndGyayk+xmG7ZCnycM9PBxzgmhEE9l+UfubODzRfxk5Gl7DqxGfXNiHjK2Kark6fvTWifuF7DL4/ZHmRZ3SLQRVRbpjLnogJyTIxIOKs3b175ZEBvkL7l0Ioe5EyFQcBv0L3lxIJABFqJnB8so21W7tqmuRANnAUP5ncZVOhwAV6+nlQAXrvA8k4HZOmCsFB4ArTD0K4NLdd2HLbw+N7UTRT7arfGz1fHeTKKAWlVvIkE/NnqIlDkJ+8+INAQDkk2cClnXx9GUMD26IObUmH9K9kIKQx60YahS6Jfi3YNUhfP9+Vd7qvPLHRjjaIsPg1Y3gph0+v6DOewTrv4YQ47kp1mo8q+X2vagH/18dJMTe4fETpC1evOqzdWfHvCinjw== yordan.georgiev@gmail.com
    

### 2.8. Bootstrap and deploy the application locally
This step might not be needed if you used the deploy-vagrant-vm.sh vagrant provisioning script as described above, yet should the vagrant provisioning have failed you could run it on the Vagrant Guest once again and it WILL NOT if you have proper network connectivity and read/write access to your host file system from the Guest.
The bootstrap script will deploy ALL the required Ubuntu 18.04 binaries AND Perl modules as well as perform the needed configurations to enable the creation and load of the QTO database. This step will take 20 min at least. The bootstrapping script will:
  - install all the required binaries
  - install all the required Perl modules as non-root
  - install and provision PostgreSQL
  - install and provision the nginx proxy server 


Check the main method in the run.sh and uncomment entities you do not want to install locally, should you have any.

    # in the shell of your local Ubuntu box, skip this cmd if you are on vagrant
    mkdir -p ~/opt; cd $_ ;  git clone git@github.com:<<YourGitHubUserName>>/qto.git ; cd ~/opt
    
    # run the bootstrap script and IMPORTANT !!! reload the bash env
    ./qto/src/bash/deployer/run.sh ; bash ; 
    # copy this line too !!! to ensure you reload the bash from the ^^^ line

### 2.9. Provision the application locally
The run of the following "shell actions" will create the QTO database and load it with a snapshot of it's data from an SQL dump stored in s3. If you start getting a lot of Perl "cannot not find module" syntax check error, you probably did not reload the bash shell, by typing "bash" and hitting Enter in the previous step.

     # go to the product instance dir 
    source $(find . -name '.env') && cd qto/qto.$VERSION.$ENV.$USER
    
    # ensure application layer consistency, run db ddl's and load data from s3
    ./src/bash/qto/qto.sh -a check-perl-syntax -a scramble-confs -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3

### 2.10. Start the application layer on the dev instance
Start the application layer by issuing the following command. The hypnotoad starting script ALWAYS checks whether or not you have public and private files for the JWT auth and if you do not have them if will create them basically only once. So hit Enter or type a password, when executing the action for the first time.

    # ALWAYS run any shell-action from the product instance dir 
    cd ~/opt/qto/qto.$VERSION.$ENV.$USER
    
    # start the web server
    bash src/bash/qto/qto.sh -a mojo-hypnotoad-start

### 2.11. Create and start the tst instance
The development product instance dir is aimed for development on that machine. You would need at least a testing and production environments according to QTO's (and a lot more applications out there) best practices.

    bash ./src/bash/qto/qto.sh -a to-env=tst
    
    # now to to the TST product instance directory
    cd ~/opt/qto/qto.$VERSION.tst.$USER

### 2.12. Check application layer syntax, load DB data
You can concatenate multiple shell-actions with the -a &lt;&lt;shell-action-01&gt;&gt; -a &lt;&lt;shell-action-02&gt;&gt; and so on.
This actions will:
 - check the application layer syntax 
 - provision the DB admin credentials in Postgres 
 - run all the DDL's of the db
 - load the DB data from s3

    ./src/bash/qto/qto.sh -a check-perl-syntax -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3

### 2.13. Start the tst instance
The hypnotoad starting script ALWAYS checks whether or not you have public and private files for the JWT auth and, if you do not have them, it will create them only once. So hit Enter or type a password when executing the action for the first time.

    bash src/bash/qto/qto.sh -a mojo-hypnotoad-start

## 3. FIRST TIME AWS DEPLOYMENT
This section WILL provide you will with ALL required steps to get a fully functional instance of the QTO application in AWS in about 35 min with automated shell commands. Do just copy paste the commands into your shell. Do NOT cd into different directories - this deployment has been tested more than 40 times by multiple professionals and successfully by exactly reproducing those steps, yet the variables in such a complex deployment are many, thus should you encounter new issues do directly contact the owner of the instance you got this deployment package from, that is the person owning the GitHub repository you fetched the source code from.


    

### 3.1. AWS centric infrastructure as a code related intro

This installation is not truly idempotent, meaning that not all infra resources with the same names are deleted - you might need to go and manually delete objects from the AWS admin console, IF you are running this installation for more than two times on the same environments. If you are using the same AWS account for all your environments - that is dev, tst and prd - you can be sure that this installation has been tested for FULL logical and physical separation of your provisioned QTO resources by environment - simply said whatever you deploy to dev, will not brake anything in tst and/or prod.

    

### 3.2. Prerequisites
You should have a local instance of QTO as far as you could issue the terraform shell action - DB and site configuration are not must have for the AWS deployment to succeed.

    

#### 3.2.1. Configure the AdminEmail
The AdminEmail value stored in the cnf/env/*.env.json files is the e-mail of the QTO product instance owner - aka the only user being able to edit other users' details.


    

#### 3.2.2. Create a pem file for deployment
Point your browser at the following URL:
https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=&lt;&lt;your-region&gt;&gt;#KeyPairs:
Click on the create key-pair button. For the name of the file add the following : 
key-pair-qto-amzn. Download the file and save it into the ~/.ssh dir of the satellite host:

    ls -la ~/.ssh/key-pair-qto-amzn.pem
    chmod 0400 ~/.ssh/key-pair-qto-amzn.pem
    -r-------- 1 ysg vboxsf 1670 maali 30 11:00 /home/ysg/.ssh/key-pair-qto-amzn.pem

#### 3.2.3. Create AWS instance deployment keys
You will use those deployment keys later on when you later on ssh -i &lt;&lt;full-deployment-key&gt;&gt; ubuntu@&lt;&lt;instance-dns&gt;&gt;

    # run on the satellite host
    # create the dev instance deployment key
    # of course you should use your own e-mail and NOT mine ;o)
    ssh-keygen -t rsa -b 4096 -C "yordan.georgiev@gmail.com" -f ~/.ssh/id_rsa.aws-ec2.qto.dev
    # hit enter twice preferably , to not set up passwords .. 
    
    # create the tst instance deployment key
    ssh-keygen -t rsa -b 4096 -C "yordan.georgiev@gmail.com" -f ~/.ssh/id_rsa.aws-ec2.qto.tst
    # hit enter twice preferably , to not set up passwords .. 
    
    # create the prd instance deployment key
    ssh-keygen -t rsa -b 4096 -C "yordan.georgiev@gmail.com" -f ~/.ssh/id_rsa.aws-ec2.qto.prd
    # hit enter twice preferably , to not set up passwords .. 

#### 3.2.4. Configure your AWS credentials - AWS keys
Generate NEW AWS access- and secret-keys https://console.aws.amazon.com/iam/home?region=&lt;&lt;YOUR-AWS-REGION&gt;&gt;#/security_credentials. 
Make sure both the aws_access_key_id and the aws_secret_access_key do NOT have the "+" and "-" chars in them, as the terraform binary will throw an error (chk: installations_doc-200330074044).
Store the keys in the QTO's development environment configuration file - the cnf/env/dev.env.json file. Either configure your AWS with the AWS configure command or add the YOUR AWS access key id and AWS secret key id to the ~/.aws/credentials, which should look something like this:


      cat ~/.aws/credentials
    [prd-qto]
    aws_access_key_id = AKIBJRRQPXQO56AS6TMA
    aws_secret_access_key = Wt2VNn3qmh0rA76TGKsgJEmFS2e3yK3pxjeVPmla
    
    [tst-qto]
    aws_access_key_id = AKIBJRRQPXQO56AK6TMA
    aws_secret_access_key = Wt2VNn3qmh0rA76TGKsgJEmFS2e3yK3pxjeVPmla
    
    [dev-qto]
    aws_access_key_id = AKIBJRRQPXQO56AK6TMA
    aws_secret_access_key = Wt2VNn3qmh0rA76TGKsgJEmFS2e3yK3pxjeVPmla

### 3.3. Initialise AWS infrastructure
To initialise the git AWS infrastructure you need to clone the QTO source code locally first. If you are repeating this task all over, you might need to remove from the AWS web UI duplicating VPCs and elastic IPs.

    # go to the product instance dir
    cd ~/opt/qto/qto.0.8.5.dev.$USER
    
    # apply the infra terraform in the src/terraform/tpl/qto/main.tf.tpl 
    clear ; bash qto/src/bash/qto/qto.sh -a init-aws-instance

### 3.4. Set IP address for the host in DNS (optional) 
If you have registered your own DNS name, you should configure now the public IP address found in the Amazon ec2 instances section of the newly created host to the dns name you have registered with your DNS provider, as it usually takes some time for the DNS to replicate (with the qto.fi domain it takes about 5 min max, some DNS providers suggest even hours to be reserved, your mileage might vary).
If you do not have a registered DNS, you could either use directly the IP address or the DNS name provided by amazon in the ec2 settings of the newly created host, in this case you should configure the same DNS in the cnf/etc/dev.env.json file (env-&gt;app-&gt;web_host variable) for nginx to be able to pick it in its own configuration.

    

### 3.5. Access AWS host via SSH
To access the AWS host via SSH you need to copy the provided elastic IP which was created by the terraform script. In your browser go to the following URL:
https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=&lt;&lt;YOUR-AWS-REGION&gt;&gt;#Instances:sort=instanceId
You should see a listing of your AWS instances one of which should be named dev-qto-ec2 (that is the development instance of the QTO application). Click on its checkbox. Search for the "IPv4 Public IP" string and copy the value of the IP.

    # run locally 
    ssh -i ~/.ssh/id_rsa.aws-ec2.qto.dev ubuntu@<<just-copied-IPv4-Public-IP>>
    # for example: 
    # ssh  -i ~/.ssh/id_rsa.aws-ec2.qto.dev ubuntu@31.249.74.222
    
    

### 3.6. Fetch the source code from GitHub on the aws server
If you have not yet forked the qto to your GitHub do it now by forking it from the product instance owner's GitHub account - to be able to submit changes to YOUR OWN git repository during the installation.
To fetch the source code from GitHub you need to have a full trust between the aws host and your GitHub account via public private ssh keys. In order to achieve that you need to put a public open-ssh key in the ssh keys section of your GitHub account in the GitHub web UI.
If you know how-to do this you could skip the following automated run, but if you don't know than first run this script and do all the steps in the following this instruction:
https://www.inmotionhosting.com/support/website/ssh/how-to-add-ssh-keys-to-your-github-account/



    # on the AWS server
    export your_git_user_name=YordanGeorgiev #the one visible 
    export your_email=yordan.georgiev@gmail.com
    export your_initials=ysg
    
    # optionally run a provisioning script installing tmux, vim and automating the ssh keys creation
    curl https://raw.githubusercontent.com/$your_git_user_name/qto/master/src/bash/qto/scripts/setup-bash-tmux-vim.sh | bash -s $your_email $your_initials
    
    # if you know what tmux is start it now ... 
    tmux
    
    # on the AWS server
    my_private_ssh_key_file=~/.ssh/id_rsa.$your_initials.`hostname -s`
    
    # each time you issue the git command in THIS shell, it will be referring to your private key file
    # which is the trusted one by GitHub because you added it's public key file to your settings ...
    alias git='GIT_SSH_COMMAND="ssh -i $my_private_ssh_key_file" git'
    
    # now you must be able to clone the project , without being asked for passwords
    mkdir -p ~/opt; cd $_ ;  git clone git@github.com:$your_git_user_name/qto.git; cd ~/opt
    
    
    

### 3.7. Bootstrap and deploy the application on AWS instance
The bootstrap script will deploy ALL the required Ubuntu 18.04 binaries AND Perl modules as well as perform the needed configurations to enable the creation and load of the QTO database. This step will take at least 20 min. The bootstrap script will perform the following actions:
 - install all the required binaries
 - install all the required Perl modules as non-root
 - install and provision Postgres
 - install and provision the nginx proxy server

Copy paste the full command below - this is IMPORTANT !!!

    # run the bootstrap script and IMPORTANT !!! reload the bash shell 
    bash ./qto/src/bash/deployer/run.sh ; bash ; 
    # copy THIS line as well !!! Just to make sure the enter and ; from ^^^ line are copied too
    
    

### 3.8. Provision application in AWS instance in dev
The run of the following "shell actions" will create the QTO database and load it with a snapshot of its data from a SQL dump stored in s3. 

     # go to the product instance dir 
    source $(find . -name '.env') && cd qto/qto.$VERSION.$ENV.$USER
    
    # ensure application layer consistency, run db ddl's and load data from s3
    bash ./src/bash/qto/qto.sh -a check-perl-syntax -a scramble-confs -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3

### 3.9. Edit the configuration file and start web server
You need to set the web_host variable in the configuration files to the IP address or DNS name, if you have configured one for this IP address, otherwise your nginx configuration will be broken.
The following command will both start the Mojolicious hypnotoad server initiating the QTO application layer and the nginx reverse proxy, which will listen on the app-&gt;port port defined in the cnf/env/dev.env.json file.

    # start the web server
    ./src/bash/qto/qto.sh -a mojo-hypnotoad-start

### 3.10. Access the QTO application from web
The QTO web application is available at the following address
http://&lt;&lt;just-copied-IPv4-Public-IP&gt;&gt;:8078 This should redirect you to the dev_qto/login page - this is the end-point via Mojolicious over http (NOT safe).

http://&lt;&lt;just-copied-IPv4-Public-IP&gt;&gt;:78 This should redirect you to the dev_qto/login page - via the nginx proxy (SAFE)


    

### 3.11. Configure DNS
Configure the DNS server name in the UI of your DNS provider.

    

### 3.12. Provision QTO web users
Open the cnf/env/dev.env.json, change the env-&gt;AdminEmail with an e-mail you have access to. Restart the web servers as shown below. Login via web interface.

    # the start action performs restart as well, if the web servers are running
    ./src/bash/qto/qto.sh -a mojo-hypnotoad-start

### 3.13. Create the tst product instance
If you revisit the target architecture picture(@installations_doc-10), the actions so far have been only the installations of the dev instance, which you should have be now up and running. 
QTO is designed around the idea of developing in dev (aka doing things for the first time and possibly with some errors), testing in tst (more of a testing and configuration allowed, but not developing with minor errors) and prd (where no errors are allowed and everything should go smoothly). 
Thus by now you have achieved only the dev instance deployment.

    ./src/bash/qto/qto.sh -a to-env=tst

### 3.14. Provision the tst database
If you revisit the target architecture picture(installations_doc-10), the actions so far have been only the installations of the dev instance, which you should have be now up and running. 
QTO is designed around the idea of developing in dev (aka doing things for the first time and possibly with some errors), testing in tst (more of a testing and configuration allowed, but not developing with minor errors and prd (where no errors are allowed and everything should go smoothly). 
Thus by now you have achieved only the dev instance deployment

    

### 3.15. Fork production instance
The creation of this one should succeed at once, as it is performed exactly in the same way as the creation of the testing (tst) instance.
You "fork" the production instance by issuing the following command:

    # for the tst product instance into the prd product instance
    ./src/bash/qto/qto.sh -a to-env=prd
    
    # thus the 
    find ~/opt/csitea/qto/ -type d -mindepth 1 -maxdepth 
    
    /home/ubuntu/opt/csitea/qto/qto.0.7.8.dev.ysg
    /home/ubuntu/opt/csitea/qto/qto.0.7.8.tst.ysg
    /home/ubuntu/opt/csitea/qto/qto.0.7.8.prd.ysg

### 3.16. Provision prd DB
The creation of prd instance should succeed at once, as it is performed exactly in the same way as the creation of the testing (tst) instance.
You "fork" the production instance by issuing the following command:

    ./src/bash/qto/qto.sh -a check-perl-syntax -a scramble-confs -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3

## 4. PROVISION HTTPS (ONLY IF DNS is configured)
This section is separated, as it is optional. If you have configured DNS, you could provision https for the nginx server by issuing the following command:


    ./src/bash/qto/qto.sh -a provision-https
    
    sudo certbot --nginx -d <<your.organisation.com>>
    
    
    # you should get the following output 
    #IMPORTANT NOTES:
    # - Unable to install the certificate
    # - Congratulations! Your certificate and chain have been saved at:
    #  /etc/letsencrypt/live/qto.fi/fullchain.pem
    #   Your key file has been saved at:
    
    # now re-run the 
    bash src/bash/qto/qto.sh -a provision-nginx -a provision-https
    
    
    

### 4.1. Fork latest stable dev to tst
By this point all obvious bugs within the scope of THIS release MUST be cleared out, if that is NOT the case, you are wasting your time by gaining wrong velocity to demonstrate some new cool features, which you WILL pay for later.

    # on your local dev box go the latest stable environment
    /hos/opt/csitea/qto/qto.0.7.9.dev.ysg
    
    bash src/bash/qto/qto.sh -a to-env=tst
    
    # now prepare the configuration in this environment on your local dev box
    cp -r /hos/opt/csitea/qto/qto.0.7.9.tst.ysg /hos/opt/csitea/qto/qto.0.7.9.tst.deploy
    
    # ensure you copy your non-hash and SECRET configuration to this instance
    cp -v ~/.qto/cnf/* cnf/env/

### 4.2. Go to your previous environment
Go to your old environment: it contains your configuration at least you could spare yourself for copy paste for the creating of the RIGHT configuration for your ENTIRELY new deployment built with the infrastructure as a code.
Open the admin console:

    ssh -i /home/ysg/.ssh/id_rsa.prd.qto  ubuntu@ec2-52-209-247-245.eu-west-1.compute.amazonaws.com

## 5. NON-FIRST TIME AWS DEPLOYMENT
This section is aimed for the fortuned folks, who have already deployed at least one fully functional up-and-running instance of qto, thus it will assume already some familiarity. 

    

### 5.1. Create AWS instance


    bash src/bash/qto/qto.sh -a init-aws-instance
    
    # after that ssh to -it
    ssh -i ~/.ssh/id_rsa.prd.qto ubuntu@ec2-52-209-247-245.eu-west-1.compute.amazonaws.com

### 5.2. Setup bash & vim
This deployment script sets RATHER personal bash and tmux settings, which are NOT part of the QTO setup, but merely personal tools to navigate more easily in the terminal with bash, tmux and vim.

    curl https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/src/bash/deployer/setup-bash-n-vim.sh | bash -s yordan.georgiev@gmail.com
    
    cat ~/

### 5.3. Clone project to Guest server
Connect via SSH to the target server and clone QTO Github repository as follows:

    cat ~/.ssh/
    
    mkdir -p ~/opt; cd $_ ;  git clone git@github.com:<<YourGitHubUserName>>/qto.git ; cd ~/opt

## 6. PHYSICAL HOST OS INSTALLATIONS


    

### 6.1. MacOs
QTO has been developed mostly by using MacOs as the physical host OS. The next code section is probably obsolete, as you most probably have installed it as described here: https://treehouse.github.io/installation-guides/mac/homebrew

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#### 6.1.1. Install QtPass
QtPass is a password manager. Installing it is optional.

https://sourceforge.net/p/gpgosx/docu/Download/

    brew cask install qtpass

## 7. POTENTIAL PROBLEMS AND TROUBLESHOOTING
As a rule of thumb, whatever errors you are encountering, they are most probably NOT source code errors, but configuration errors. Thus ALWAYS try to change configuration entries from the dev, tst or prd environment configuration files and restart the web server with the mojo-hypnotoad-start shell action.

    

### 7.1. Postgres admin user password is wrong
Some of the newly created tables might not have their permissions in the DDLs. Or you might have run some of the SQL scripts ad-hoc / manually and they do not contain grant statements.

The DB security is passed from OS root to Postgres user to QTO admin to QTO app, thus to fix it, run the following command, which will reprovision your Postgres and change DB user permissions.
You will also need to restart the web server after.

     ./src/bash/qto/qto.sh -a provision-db-admin -a run-qto-db-ddl -a load-db-data-from-s3 -a fix-db-permissions

### 7.2. AWS was not able to validate the provided access credentials
If that error occurs check your AWS credentials. Ensure that the AWS keys do not have the "+", "-" or "/" characters, as terraform does not support these symbols.

    data.aws_ami.ubuntu: Refreshing state...
    
    Error: AuthFailure: AWS was not able to validate the provided access credentials
            status code: 401, request id: 76ea7781-0bb5-4782-b358-f062c3de0a8b
    
      on main.tf line 8, in data "aws_ami" "ubuntu":
       8: data "aws_ami" "ubuntu" {

### 7.3. Redis refuses to start 
Redis should be configured to have bind on the IP address of the first eth. Also the bind to the ipv6 should be commented out ( ## bind 127.0.0.1 ::1). You should have also the correct IP configured in the cnf/env/&lt;&lt;env&gt;&gt;.env.json files. Because otherwise the application cannot connect and store correctly the DB metadata during application startup. There might be still some bugs during the Redis provisioning in the src/bash/deployer/check-install-redis.func.sh file, run the installation from the top to bottom command by command.

It may be worth checking redis.conf and make sure it is bound to a private IP, not a public one or localhost.

    sudo tail -n 10 /etc/redis/redis.conf
    
    # do not bind to ipv6 on the localhost 
    # bind 127.0.0.1 ::1
    
    # bind on the first eth0 ip address looking like 10.0.2.15 
    bind 10.0.62.82
    
    # enable service mode 
    supervised systemd
    
    ### -- Save redis.conf and return back to the Terminal
    
    # then restart Redis using this command in the terminal:
    sudo systemctl restart redis
    
    # you can verify that Redis is running in the following way:
    sudo systemctl status redis
    

### 7.4. Could not connect to Redis server
Uncaught exception from user code: Can't load application from file "...": Could not connect to Redis server at host-name:6379.
	
To fix this, first learn IPs of the current machine by running this command in the terminal:

ifconfig -a | grep inet

	
When working with virtual machines, search for the private IP that looks similar to 10.0.2.15.
When working with AWS ec2 instance, IP will look like 172.31.25.82.
	
Change Redis server IP inside %path-to-qto%/cnf/env/dev.env.json from host-name to the private IP. Then run mojo-hypnotoad again.
	
./src/bash/qto/qto.sh -a mojo-hypnotoad-start

	

    

### 7.5. You have reached the hw provisioning limits of your AWS account
If you get one of the errors below, go the UI of the AWS admin console and delete non-used resources. Fortunately, all resources have the &lt;&lt;env&gt;&gt;_&lt;&lt;resource_name&gt;&gt; naming convention either in the object or in their Tags, which means you will know what you are deleting.

    Error: Error creating VPC: VpcLimitExceeded: The maximum number of VPCs has been reached.
            status code: 400, request id: 06dbd26c-d7b2-46e1-853f-a9131c6ad9bd
    
      on main.tf line 41, in resource "aws_vpc" "tst-vpc":
      41: resource "aws_vpc" "tst-vpc" {
    
    # another one might be elastic ip's limits
    Error: Error creating EIP: AddressLimitExceeded: The maximum number of addresses has been reached.
            status code: 400, request id: 079d1264-8d2a-4dd3-9251-354634beda5c
    
      on main.tf line 203, in resource "aws_eip" "tst-ip-test":
     203: resource "aws_eip" "tst-ip-test" {

### 7.6. Cannot login in web interface with admin user
The password hashing in the users table is activated ALWAYS on blur even that the UI is not showing it (yes, that is more of a bug, than a feature).
The solution is to restart the application layer WITHOUT any authentication, change the admin user password from the UI and restart the application layer with authentication once again.

    export QTO_NO_AUTH=1
    bash src/bash/qto/qto.sh -a mojo-hypnotoad-start
    
    # now change the AdminEmail user password from the UI, delete the test users
    # as they all have the convenient "secret" password
    export QTO_NO_AUTH=0
    bash src/bash/qto/qto.sh -a mojo-hypnotoad-start
    

### 7.7. Mismatch in the AWS
The AWS web UI contains fancy Ajax calls and in our experience it does not always update properly, if are bombarding it with terraform deployments onto the same resources. Make sure you always hit F5 in your browser, when starting the work on new ec2 instance.

    

### 7.8. The problem occurred is not mentioned here ?!
Try to Google it first. If it took too long, send an e-mail / chat invitation to the instance owner you got the source code from and you WILL get help sooner or later.

    

