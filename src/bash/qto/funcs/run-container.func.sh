# src/bash/qto/funcs/run-container.func.sh

# v0.6.7
doRunContainer(){
   doLog "DEBUG START doRunContainer"

   test -z ${qto_project:-} && \
      source "$product_instance_dir/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars $product_instance_dir/cnf/$run_unit.$env_type.$host_name.cnf

   tgt_product_instance_dir='/opt/csitea/'"$run_unit/$environment_name"
   chmod 777 $product_instance_dir/src/bash/qto/install/docker/docker-entry-point.sh

   container_name='qto-container-'$(date "+%Y%m%d_%H%M%S")

   docker run -d --name $container_name \
      -e product_instance_dir=$tgt_product_instance_dir \
      -e host_host_name=$(hostname -s) \
      -v $product_instance_dir:$tgt_product_instance_dir \
      -p  127.0.0.1:${mojo_morbo_port:-}:$mojo_morbo_port \
      'qto-image':${product_version:-}.$env_type
   
   # -p 127.0.0.1:${postgres_db_port:-}:$postgres_db_port \

   printf "\n"
   echo do check which containers are running 
   echo docker container ls
   printf "\n\n"
   echo "to attach to the running container run:"
   echo "docker exec -it  $container_name /bin/bash"
   printf "\n\n"
   echo do stop it run the following command
   echo docker container stop $container_name

   doLog "DEBUG STOP  doRunContainer"
}


# eof file: src/bash/qto/funcs/run-container.func.sh
