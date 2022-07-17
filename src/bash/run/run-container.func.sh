# src/bash/qto/funcs/run-container.func.sh

# v0.6.7
doRunContainer(){
   do_log "DEBUG START doRunContainer"

   test -z ${qto_project:-} && \
      source "$PRODUCT_DIR/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars $PRODUCT_DIR/cnf/$RUN_UNIT.$ENV.$host_name.cnf

   tgt_PRODUCT_DIR='/opt/csitea/'"$RUN_UNIT/$environment_name"
   chmod 777 $PRODUCT_DIR/src/bash/qto/install/docker/docker-entry-point.sh

   container_name='qto-container-'$(date "+%Y%m%d_%H%M%S")

   docker run -d --name $container_name \
      -e PRODUCT_DIR=$tgt_PRODUCT_DIR \
      -e host_host_name=$(hostname -s) \
      -v $PRODUCT_DIR:$tgt_PRODUCT_DIR \
      -p  127.0.0.1:${MOJO_MORBO_PORT:-}:$MOJO_MORBO_PORT \
      'qto-image':${product_version:-}.$ENV
   
   # -p 127.0.0.1:${postgres_rdbms_port:-}:$postgres_rdbms_port \

   printf "\n"
   echo do check which containers are running 
   echo docker container ls
   printf "\n\n"
   echo "to attach to the running container run:"
   echo "docker exec -it  $container_name /bin/bash"
   printf "\n\n"
   echo do stop it run the following command
   echo docker container stop $container_name

   do_log "DEBUG STOP  doRunContainer"
}


# eof file: src/bash/qto/funcs/run-container.func.sh
