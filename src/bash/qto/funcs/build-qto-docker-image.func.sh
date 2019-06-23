# src/bash/qto/funcs/build-qto-docker-image.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/build-qto-docker-image.func.txt
# ---------------------------------------------------------
doBuildQtoDockerImage(){

    doLog "DEBUG START doBuildQtoDockerImage"

    doFullCleanDocker
    doRemoveAllDockerContainers 
    doRemoveAllDockerImages             # todo:ysg rem !!!
    cp -v "$product_instance_dir/src/docker/Dockerfile.deploy-qto.0.6.5.dev.ysg" "$product_instance_dir/Dockerfile"
    #cp -v "$product_instance_dir/src/docker/Dockerfile.deploy-quick-test" "$product_instance_dir/Dockerfile"
    cd $product_instance_dir
    docker build -t qto-image:$product_version .
    test $? -ne 0 && doLog "FATAL the docker image building failed !!!"
    rm -v "$product_instance_dir/Dockerfile"

    printf "\n\n"
    echo 'to instantiate a new container, run :'
    echo 'docker run -d --name qto-container-01 -v `pwd`:/opt/csitea/qto/qto.0.6.5.dev.ysg -p 127.0.0.1:15432:15432 -p 127.0.0.1:3001:3001 qto-image:0.6.5'
    printf "\n"
    echo 'to attach to the the running container run:'
    echo 'docker exec -it qto-container-01 /bin/bash'

    # --detach , -d       Run container in background and print container ID
    # --name              Assign a name to the container
    # --publish , -p      Publish a container’s port(s) to the host
    # --volume , -v       Bind mount a volume
    # --restart           Restart policy to apply when a container exits

    doLog "DEBUG STOP  doBuildQtoDockerImage"
}


# eof file: src/bash/qto/funcs/build-qto-docker-image.func.sh
