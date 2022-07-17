doBuildQtoDockerImage(){

   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   #
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json"
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'

   test -f "$PRODUCT_DIR/src/docker/Dockerfile.deploy-$RUN_UNIT.$product_version" || \
      do_exit 1 "the src/docker/Dockerfile.deploy-$RUN_UNIT.$product_version cannot be found !!!"

   #doRemoveDockerContainers
   test ${DOCKER_NUCLEAR_OPTION_PURGE:-0} -eq 1 && doFullCleanDocker # obs clears all docker stuff !!!
   #doRemoveDockerImages
   cp -v "$PRODUCT_DIR/src/docker/Dockerfile.deploy-$RUN_UNIT.$product_version" "$PRODUCT_DIR/Dockerfile"

   # for quick tests uncomment ^^^ and use this one :
   # cp -v "$PRODUCT_DIR/src/docker/Dockerfile.deploy-quick-test" "$PRODUCT_DIR/Dockerfile"

   docker build \
   --build-arg PRODUCT_DIR=$PRODUCT_DIR \
   --build-arg postgres_app_db=$postgres_app_db \
   --build-arg TZ=${TZ:-} \
   --build-arg ENV=$ENV \
   --build-arg USER=$USER \
   --build-arg UID=$UID \
   --build-arg GROUP=$GROUP \
   --build-arg GID=$GID \
   --build-arg postgres_app_db=$postgres_app_db \
   --build-arg postgres_sys_usr_admin=$postgres_sys_usr_admin \
   --build-arg root_pwd=$root_pwd \
   --build-arg app_user_pwd=$app_user_pwd \
   -t qto-image:$product_version.$ENV .

   test $? -ne 0 && do_log "FATAL the docker image building failed !!!"
   rm -v "$PRODUCT_DIR/Dockerfile"

   echo -e "\n\n to instantiate a new container, run: \n"
   echo -e "bash $PRODUCT_DIR/src/bash/qto/qto.sh -a run-container\n\n"

}

