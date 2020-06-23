#!/usr/bin/env bash
# Starts Mojo web server
# that runs QTO web service
#
# Full command:
# ./src/bash/qto/qto.sh -a mojo-hypnotoad-start
#

main(){
	./src/bash/qto/qto.sh -a server-start
}

main "$@"
