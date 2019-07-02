# src/bash/qto/funcs/build-qto-docker-image.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/build-qto-docker-image.func.txt
# ---------------------------------------------------------
doBuildQtoDockerImage(){

   doLog "DEBUG START doBuildQtoDockerImage"

   set -x
   test -z ${qto_project:-} && \
      source "$product_instance_dir/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$product_instance_dir/cnf/$run_unit.$env_type."$(hostname -s)'.cnf'

   # doFullCleanDocker
   # doRemoveAllDockerContainers 
   # doRemoveAllDockerImages             # todo:ysg rem !!!
   postgres_db_name="$env_type"'_'"$run_unit"
   cp -v "$product_instance_dir/src/docker/Dockerfile.deploy-$run_unit.$product_version" "$product_instance_dir/Dockerfile"
   # cp -v "$product_instance_dir/src/docker/Dockerfile.deploy-quick-test" "$product_instance_dir/Dockerfile"

   # Action !!!
   docker build \
   --build-arg product_instance_dir=/opt/csitea/$run_unit/$environment_name \
   --build-arg postgres_db_name=$postgres_db_name \
   --build-arg TZ=${TZ:-} \
   -t qto-image:$product_version .

   test $? -ne 0 && doLog "FATAL the docker image building failed !!!"
   rm -v "$product_instance_dir/Dockerfile"

   printf "\n\n"
   echo 'to instantiate a new container, run :'
   echo "bash $product_instance_dir/src/bash/qto/qto.sh -a run-container"
   printf "\n\n"

   # --detach , -d       Run container in background and print container ID
   # --name              Assign a name to the container
   # --publish , -p      Publish a container’s port(s) to the host
   # --volume , -v       Bind mount a volume
   # --restart           Restart policy to apply when a container exits

   doLog "DEBUG STOP  doBuildQtoDockerImage"
}


# eof file: src/bash/qto/funcs/build-qto-docker-image.func.sh
