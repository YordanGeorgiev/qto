# file: src/bash/qto/funcs/remove-all-docker-containers.func.sh

# v0.6.5
# ---------------------------------------------------------
# remove all the docker containers on the host with warning
# and inform if none exists
# ---------------------------------------------------------
doRemoveDockerContainers(){

   do_flush_screen
   do_log "INFO START removing all docker containers with the $product_version.$ENV tag !!! " 
   do_log "INFO Are you SURE ??!! You have 3 seconds to abort by Ctrl + C !!"
   sleep 3

   ret=$(docker ps -a|grep -i qto-image.$ENV|awk '{print $1}'|wc -l| perl -ne 's/\s+//g;print')
   if test $ret -eq 0 
   then
      do_log "INFO No docker containers found. Nothing to do !!!"
   else
      do_log "INFO stopping containers ..."
      docker stop $(docker ps -a|grep -i qto-image:$product_version.$ENV|awk '{print $1}')
      sleep 1
      do_log "INFO removing containers ..."
      docker rm $(docker ps -a|grep -i qto-image:$product_version.$ENV|awk '{print $1}')
   fi

	do_log "INFO STOP  removing all docker containers"
}
