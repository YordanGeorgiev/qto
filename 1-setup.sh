#!/usr/bin/env bash
# starts deployer from a folder, then QtoDir redirects to a newly created product_instance_dir

main(){
	. ./qto/src/bash/deployer/run.sh "$@"; QtoDir
}

main "$@"
