doBuildQtoDockerImage(){
   
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   test -z ${proj_conf_file:-} && export proj_conf_file="$proj_instance_dir/cnf/env/$env_type.env.json"
   do_export_json_section_vars $proj_conf_file '.env.db'

   test -f "$product_instance_dir/src/docker/Dockerfile.deploy-$RUN_UNIT.$product_version" || \
      do_exit 1 "the src/docker/Dockerfile.deploy-$RUN_UNIT.$product_version cannot be found !!!"

   #doRemoveDockerContainers 
   test ${DOCKER_NUCLEAR_OPTION_PURGE:-0} -eq 1 && doFullCleanDocker # obs clears all docker stuff !!!
   #doRemoveDockerImages          
   cp -v "$product_instance_dir/src/docker/Dockerfile.deploy-$RUN_UNIT.$product_version" "$product_instance_dir/Dockerfile"

   # for quick tests uncomment ^^^ and use this one : 
   # cp -v "$product_instance_dir/src/docker/Dockerfile.deploy-quick-test" "$product_instance_dir/Dockerfile"

   docker build \
   --build-arg product_instance_dir=$product_instance_dir \
   --build-arg postgres_db_name=$postgres_db_name \
   --build-arg TZ=${TZ:-} \
   --build-arg ENV_TYPE=$ENV_TYPE \
   --build-arg USER=$USER \
   --build-arg UID=$UID \
   --build-arg GROUP=$GROUP \
   --build-arg GID=$GID \
   --build-arg postgres_db_name=$postgres_db_name \
   --build-arg postgres_db_useradmin=$postgres_db_useradmin \
   --build-arg root_pwd=$root_pwd \
   --build-arg app_user_pwd=$app_user_pwd \
   -t qto-image:$product_version.$env_type .

   test $? -ne 0 && do_log "FATAL the docker image building failed !!!"
   rm -v "$product_instance_dir/Dockerfile"
   
   echo -e "\n\n to instantiate a new container, run: \n"
   echo -e "bash $product_instance_dir/src/bash/qto/qto.sh -a run-container\n\n"

}

