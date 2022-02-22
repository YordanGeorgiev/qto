# src/make/clean-install-dockers.func.mk
# only the clean install dockers calls here ...
# TODO: figure a more elegant and generic way to avoid this copy paste ...
#

SHELL = bash
PRODUCT := $(shell basename $$PWD)
TGT_ORG := $(shell export TGT_ORG=$${TGT_ORG:-csitea}; echo $${TGT_ORG})


.PHONY: clean-install-devops  ## @-> setup the whole local devops environment no cache!
clean-install-devops:
	$(call clean-install-img,devops,3000)
