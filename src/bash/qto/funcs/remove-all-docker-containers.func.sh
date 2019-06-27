# file: src/bash/qto/funcs/remove-all-docker-containers.func.sh

# v0.6.5
# ---------------------------------------------------------
# remove all the docker containers on the host with warning
# and inform if none exists
# ---------------------------------------------------------
doRemoveAllDockerContainers(){
   clearTheScreen
	doLog "INFO START removing all docker containers !!! " 
   doLog "INFO Are you SURE ??!! You have 3 seconds to abort by Ctrl + C !!"
   sleep 3

   if test $(docker ps -a -q| wc -l|awk '{print $1}') -eq 0 
   then
      doLog "INFO No docker containers found. Nothing to do !!!"
   else
      doLog "INFO stopping containers ..."
      docker stop $(docker ps -aq)
      sleep 1
      doLog "INFO removing containers ..."
      docker rm $(docker ps -aq)
   fi

	doLog "INFO STOP  removing all docker containers"
}


# eof file: src/bash/qto/funcs/remove-all-docker-containers.func.sh
