# src/make/install-dockers.func.mk
# only the clean install dockers calls here ...
# TODO: figure a more elegant and generic way to avoid this copy paste ...
#

SHELL = bash
PRODUCT := $(shell basename $$PWD)
ORG := $(shell export ORG=$${ORG}; echo $${ORG})


.PHONY: clean-install-app  ## @-> setup the whole local app environment no cache!
clean-install-app:
	$(call install-img,app,8080,--no-cache)


.PHONY: install-app  ## @-> setup the whole local app environment no cache!
install-app:
	$(call install-img,app)


