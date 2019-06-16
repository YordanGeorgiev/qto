# src/bash/qto/funcs/build-qto-docker-image.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestBuildQtoDockerImage comments ...
# cat doc/txt/qto/tests/build-qto-docker-image.test.txt
# ---------------------------------------------------------
doTestBuildQtoDockerImage(){

	doLog "DEBUG START doTestBuildQtoDockerImage"
	
	# Action !!!
   bash "$product_instance_dir/src/bash/qto/qto.sh" -a build-qto-docker-image
	doLog "DEBUG STOP  doTestBuildQtoDockerImage"
}
# eof func doTestBuildQtoDockerImage


# eof file: src/bash/qto/funcs/build-qto-docker-image.test.sh
