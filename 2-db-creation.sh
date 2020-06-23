#!/usr/bin/env bash
# continues installation
# starts the database provisioning

main(){
	./src/bash/qto/qto.sh -a set-roles -a create-db -a fill-db -a success
}

main "$@"
