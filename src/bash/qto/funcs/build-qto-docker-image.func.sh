# src/bash/qto/funcs/build-qto-docker-image.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/build-qto-docker-image.func.txt
# ---------------------------------------------------------
doBuildQtoDockerImage(){

	doLog "DEBUG START doBuildQtoDockerImage"
	
   doRemoveAllDockerContainers 
   doRemoveAllDockerImages             # todo:ysg rem !!!
   cd "$product_instance_dir/src/docker"
   docker build -t qto-image .
   cd -

   # run the docker in the background
   docker run -d --name  qto-container-01 -p 127.0.0.1:15432:15432 --restart=always qto-image

	# --detach , -d       Run container in background and print container ID
	# --name              Assign a name to the container
	# --publish , -p      Publish a container’s port(s) to the host
	# --volume , -v       Bind mount a volume
	# --restart           Restart policy to apply when a container exits

	doLog "DEBUG STOP  doBuildQtoDockerImage"
}
# eof func doBuildQtoDockerImage


# eof file: src/bash/qto/funcs/build-qto-docker-image.func.sh
