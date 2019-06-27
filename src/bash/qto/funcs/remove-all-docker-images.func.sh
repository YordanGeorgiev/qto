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
	doLog "INFO START removing all docker images !!! " 
   doLog "INFO Are you SURE ??!! You have 3 seconds to abort by Ctrl + C !!"
   sleep 3
   
   if test -z "$(docker images | grep '^<none>' | awk '{print $3}')"
   then
      doLog "INFO No docker images found. Nothing to do !!!"
   else
      docker rmi $(docker images | grep '^<none>' | awk '{print $3}')
      docker system prune -a
   fi

	doLog "INFO STOP removing all the docker images"
}


# eof file: src/bash/qto/funcs/remove-all-docker-images.sh
