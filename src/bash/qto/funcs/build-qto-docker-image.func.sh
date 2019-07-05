# src/bash/qto/funcs/build-qto-docker-image.func.sh

# v1.0.9
# ---------------------------------------------------------
# build a multi-environement "aware" qto image
# ---------------------------------------------------------
doBuildQtoDockerImage(){

   doLog "DEBUG START doBuildQtoDockerImage"

   test -z ${qto_project:-} && \
      source "$product_instance_dir/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$product_instance_dir/cnf/$run_unit.$env_type."$(hostname -s)'.cnf'

   test -f "$product_instance_dir/src/docker/Dockerfile.deploy-$run_unit.$product_version" || \
      doExit 1 "create the src/docker/Dockerfile.deploy-$run_unit.$product_version"

   # doFullCleanDocker
   doRemoveDockerContainers 
   doRemoveDockerImages          
   postgres_db_name="$env_type"'_'"$run_unit"
   cp -v "$product_instance_dir/src/docker/Dockerfile.deploy-$run_unit.$product_version" "$product_instance_dir/Dockerfile"

   # for quick tests uncomment ^^^ and use this one : 
   # cp -v "$product_instance_dir/src/docker/Dockerfile.deploy-quick-test" "$product_instance_dir/Dockerfile"

   # Action !!!
   docker build \
   --build-arg product_instance_dir=/opt/csitea/$run_unit/$environment_name \
   --build-arg postgres_db_name=$postgres_db_name \
   --build-arg TZ=${TZ:-} \
   --build-arg host_host_name=$(hostname -s) \
   -t qto-image:$product_version.$env_type .

   test $? -ne 0 && doLog "FATAL the docker image building failed !!!"
   rm -v "$product_instance_dir/Dockerfile"
   
   doLog "DEBUG STOP  doBuildQtoDockerImage"

   printf "\n\n"
   echo 'to instantiate a new container, run :'
   echo "bash $product_instance_dir/src/bash/qto/qto.sh -a run-container"
   printf "\n\n"

}

# eof file: src/bash/qto/funcs/build-qto-docker-image.func.sh
