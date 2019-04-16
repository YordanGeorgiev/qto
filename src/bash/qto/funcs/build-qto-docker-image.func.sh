# src/bash/qto/funcs/build-qto-docker-image.func.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doBuildQtoDockerImage comments ...
# ---------------------------------------------------------
doBuildQtoDockerImage(){

	doLog "DEBUG START doBuildQtoDockerImage"
	
	cat doc/txt/qto/funcs/build-qto-docker-image.func.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   cd $product_instance_dir/src/docker
   docker build -t qto_image .
   cd -

	doLog "DEBUG STOP  doBuildQtoDockerImage"
}
# eof func doBuildQtoDockerImage


# eof file: src/bash/qto/funcs/build-qto-docker-image.func.sh
