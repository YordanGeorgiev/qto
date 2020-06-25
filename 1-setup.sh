#!/usr/bin/env bash
# starts deployer from a folder, then QtoDir redirects to a newly created PRODUCT_INSTANCE_DIR

main(){
	. ./qto/src/bash/deployer/run.sh "$@"; QtoDir
}

main "$@"
