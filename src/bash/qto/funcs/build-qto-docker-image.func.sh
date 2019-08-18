# src/bash/qto/funcs/build-qto-docker-image.func.sh

# v1.0.9
# ---------------------------------------------------------
# build a multi-environement "aware" qto image
# ---------------------------------------------------------
doBuildQtoDockerImage(){

   doLog "DEBUG START doBuildQtoDockerImage"

   test -z ${qto_project:-} && \
      source "$PRODUCT_INSTANCE_DIR/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type."$(hostname -s)'.cnf'

   test -f "$PRODUCT_INSTANCE_DIR/src/docker/Dockerfile.deploy-$run_unit.$product_version" || \
      doExit 1 "create the src/docker/Dockerfile.deploy-$run_unit.$product_version"

   doFullCleanDocker
   doRemoveDockerContainers 
   doRemoveDockerImages          
   postgres_db_name="$env_type"'_'"$run_unit"
   cp -v "$PRODUCT_INSTANCE_DIR/src/docker/Dockerfile.deploy-$run_unit.$product_version" "$PRODUCT_INSTANCE_DIR/Dockerfile"

   # for quick tests uncomment ^^^ and use this one : 
   # cp -v "$PRODUCT_INSTANCE_DIR/src/docker/Dockerfile.deploy-quick-test" "$PRODUCT_INSTANCE_DIR/Dockerfile"

   # Action !!!
   docker build \
   --build-arg PRODUCT_INSTANCE_DIR=/opt/csitea/$run_unit/$environment_name \
   --build-arg postgres_db_name=$postgres_db_name \
   --build-arg TZ=${TZ:-} \
   --build-arg host_host_name=$(hostname -s) \
   -t qto-image:$product_version.$env_type .

   test $? -ne 0 && doLog "FATAL the docker image building failed !!!"
   rm -v "$PRODUCT_INSTANCE_DIR/Dockerfile"
   
   doLog "DEBUG STOP  doBuildQtoDockerImage"

   printf "\n\n"
   echo 'to instantiate a new container, run :'
   echo "bash $PRODUCT_INSTANCE_DIR/src/bash/qto/qto.sh -a run-container"
   printf "\n\n"

}

# eof file: src/bash/qto/funcs/build-qto-docker-image.func.sh
