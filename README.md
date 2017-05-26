#  issue-tracker


Table of Contents

  * [1. WHAT IS IT ?!](#1-what-is-it-)
  * [2. INSTALLATION AND CONFIGURATION](#2-installation-and-configuration)
    * [2.1. Prerequisites](#21-prerequisites)
    * [2.2. Fetch the source](#22-fetch-the-source)
    * [2.3. Build the first issue-tracker instance](#23-build-the-first-issue-tracker-instance)
    * [2.4. Create you local conf file](#24-create-you-local-conf-file)
    * [2.5. Install the required Perl modules](#25-install-the-required-perl-modules)
    * [2.6. Start hacking](#26-start-hacking)
  * [3. ADDITIONAL DOCS](#3-additional-docs)


    

## 1. What is it ?!
A tool to handle your projects issues programmatically in a simple manner: 

    

## 2. INSTALLATION AND CONFIGURATION
The issue-tracker instances and clones have been running on *Nix boxes with bash &gt; 3.0 … , but some actions require 4.0 and older …


    

### 2.1. Prerequisites
The must have binaries are:
 bash, perl, zip

The nice to have are:
 tmux, vim ,ctags

The examples are for Ubuntu - use you OS package manager …

    # use your OS package manager … if you are not on Ubuntu 
    
    sudo apt-get autoclean
    sudo apt-get install --only-upgrade bash
    
    sudo apt-get install -y perl
    
    # optionally 
    sudo apt-get install -y excuberant-ctags
    sudo apt-get install -y 7z
    
    sudo apt-get upgrade

### 2.2. Fetch the source
Fetch the source from git hub as follows:

    # create your product dir:
    mkdir -p /opt/csitea/issue-tracker
    cd /opt/csitea/issue-tracker/
    
    # fetch the source
    git clone git@github.com:YordanGeorgiev/issue-tracker.git

### 2.3. Build the first issue-tracker instance
When doing for first time do exactly as shown bellow, otherwise no joy ... 
Each issue-tracker instance has it's own version, environmnt type and owner. For now just follow the instruction - after half an hour you will be hacking this … 

    
    # build your product version dir - a kind of "this instance of the thingy dir"
    mv -v /opt/csitea/issue-tracker/issue-tracker /opt/csitea/issue-tracker/issue-tracker.0.1.8.dev.$USER
    

### 2.4. Create you local conf file
The default conf file provides only limited functionality ( this is by design ) , thus copy and configure the configuration file for your host

    # go to the product version dir
    cd /opt/csitea/issue-tracker/issue-tracker.0.1.8.dev.$USER
    
    # START -- search and replace recursively 
    export dir=`pwd`
    export to_srch="doc-pub-host"
    export to_repl="$(hostname -s)"
    
    #-- search and replace in file and dir paths
    find "$dir/" -type d |\
    perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
    find "$dir/" -type f |\
    perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'
    
    #-- search and replace in file contents
    find "$dir/" -type f -exec perl -pi -e "s#$to_srch#$to_repl#g" {} \;
    find "$dir/" -type f -name '*.bak' | xargs rm -f

### 2.5. Install the required Perl modules
Just run the prerequisites checker script which will provide you with copy pastable instructions

    sudo perl src/perl/issue_tracker/script/issue_tracker_preq_checker.pl

### 2.6. Start hacking
Start usage:

    
    cd /opt/csitea/issue-tracker/issue-tracker.0.1.8.dev.$USER
    
    # source the proj confs loading func into your bash shell 
    source lib/bash/funcs/parse-cnf-env-vars.sh
    
    doParseIniEnvVars cnf/ysg-issues.dev.doc-pub-host.cnf
    
    bash src/bash/issue-tracker/issue-tracker.sh -a txt-to-db
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-xls
    
    # now edit the files in the xls 
    bash src/bash/issue-tracker/issue-tracker.sh -a xls-to-db
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt
    export issues_order_by_attribute=start_time
    export issues_order_by_attribute=prio
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt

## 3. ADDITIONAL DOCS
Additonal docs could be found in the doc/md dir. 

    

