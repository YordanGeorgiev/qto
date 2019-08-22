#  APPRIEN-SPARK README
* [1. WHAT IS THIS ?!](#1-what-is-this-)
* [2. INSTALLATION](#2-installation)




    

## 1. WHAT IS THIS ?!
A Proof of Concept for a minimalistic yet fully end-to-end integrated spark application ready for local development. For more info check the doc/md dir.

    

## 2. INSTALLATION
Fetch the source on your local machine, which will be use to run the container onto a dir your user has full read, write and execute permissions:

    mkdir -p ~/workspaces/ ; cd ~/workspaces
    git clone git@git.in.phz.fi:phz/apprien-spark.git
    git checkout dev
    # by using the docker compose
    docker-compose up --build --always-recreate-deps --remove-orphans --renew-anon-volumes --force-recreate

