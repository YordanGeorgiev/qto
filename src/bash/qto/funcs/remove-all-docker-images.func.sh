# file: src/bash/qto/funcs/remove-all-docker-images.sh

# v0.6.5
# ---------------------------------------------------------
# remove all the docker images on the host with warning
# and inform if none exists
#$ docker system prune -a --volumes
#$ docker image prune
#$ docker container prune
#$ docker volume prune
#$ docker network prune
# ---------------------------------------------------------
doRemoveAllDockerImages(){
   clearTheScreen
	doLog "INFO START doRemoveAllDockerImages !!! " 
   doLog "INFO Are you SURE ??!! You have 3 seconds to abort by Ctrl + C !!"
   sleep 3
   
   if test -z "$(docker images | grep '^<none>' | awk '{print $3}')"
   then
      doLog "INFO No docker images found. Nothing to do !!!"
   else
      echo docker rmi $(docker images | grep '^<none>' | awk '{print $3}')
   fi

	doLog "INFO STOP  doRemoveAllDockerImages"
}


# eof file: src/bash/qto/funcs/remove-all-docker-images.sh
