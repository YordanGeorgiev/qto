# # usage: include it in your Makefile
# include lib/make/build-img-func.mk
#
# # function usage example:
#
# install-web-node:
# 	$(call install-img,web-node,80)

include lib/make/demand-var.func.mk
include lib/make/stop-img-containers.func.mk

define install-img
	@clear
	$(call demand-var,ORG)
	$(call demand-var,APP)
	$(call demand-var,ENV)

	@PORT_COMMAND=`[[ "${2}" == "" ]] || echo "--publish ${2}:${2}"`
	@NO_CACHE=`[[ "${3}" == "" ]] || echo "--no-cache"`

	docker build . -t ${product}-$(1)-img $${NO_CACHE}\
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		--build-arg ORG=$(ORG) \
		--build-arg APP=$(APP) \
		--build-arg ENV=$(ENV) \
		--build-arg PRODUCT=${PRODUCT} \
		-f src/docker/$(1)/Dockerfile

	$(call uninstall-img,$1)

	docker run -it -d --restart=always $${PORT_COMMAND}\
		-v $$(pwd):/opt/${PRODUCT} \
		-v $$HOME/.aws:/home/appusr/.aws \
		-v $$HOME/.ssh:/home/appgrp/.ssh $${PORT_COMMAND}\
		--name ${product}-$(1)-con ${product}-${1}-img ;
	@echo -e to attach run: "\ndocker exec -it ${product}-${1}-con /bin/bash"
	@echo -e to get help run: "\ndocker exec -it ${product}-${1}-con ./run --help"

endef
