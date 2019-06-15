# src/bash/qto/funcs/build-qto-docker-image.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/build-qto-docker-image.func.txt
# ---------------------------------------------------------
doBuildQtoDockerImage(){

	doLog "DEBUG START doBuildQtoDockerImage"
	
   img_file_name='ubuntu-bionic-core-cloudimg-amd64-root.tar.gz'
   mkdir -p $product_instance_dir/dat/tar/
   uri='https://partner-images.canonical.com/core/bionic/current/'"$img_file_name"
   test -f $product_instance_dir/dat/tar/$img_file_name || \
      wget -O "$product_instance_dir/dat/tar/$img_file_name" "$uri"

   docker build -t qto-image -f "$product_instance_dir/src/docker/Dockerfile" .

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
