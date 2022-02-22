# src/make/install-dockers.func.mk
# only the install dockers calls here ...
# TODO: figure a more elegant and generic way to avoid this copy paste ...
#

SHELL = bash
PRODUCT := $(shell basename $$PWD)
TGT_ORG := $(shell export TGT_ORG=$${TGT_ORG:-csitea}; echo $${TGT_ORG})


.PHONY: install-devops  ## @-> setup the whole local devops environment
install-devops:
	$(call install-img,devops,3000)
