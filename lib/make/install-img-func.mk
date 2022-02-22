# # usage: include it in your Makefile
# include lib/make/build-img-func.mk
#
# # function usage example:
#
# install-web-node:
# 	$(call install-img,web-node,80)

include lib/make/demand-var.func.mk

PRODUCT := $(shell basename $$PWD)
product:= $(shell echo `basename $$PWD`|tr '[:upper:]' '[:lower:]')

define install-img
	@clear
	$(call demand-var,ENV)
	docker build . -t ${product}-$(1)-img \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		--build-arg ENV=$(ENV) \
		--build-arg PRODUCT=${PRODUCT} \
		-f src/docker/$(1)/Dockerfile

	-@docker container stop $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
	-@docker container rm $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null

	docker run -it -d --restart=always \
		-v $$(pwd):/opt/${PRODUCT} \
		-v $$HOME/.aws:/home/appusr/.aws \
		-v $$HOME/.ssh:/home/appgrp/.ssh \
    -p $(2):$(2) \
		--name ${product}-$(1)-con ${product}-${1}-img ;
	@echo -e to attach run: "\ndocker exec -it ${product}-${1}-con /bin/bash"
	@echo -e to get help run: "\ndocker exec -it ${product}-${1}-con ./run --help"
endef

define uninstall-img
	@clear
	-@docker container stop $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
	-@docker container rm $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
endef
