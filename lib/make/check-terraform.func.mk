# usage: include it in your Makefile by:
# include lib/make/make-help.task

# TODO-ensure that
ifdef $(shell which terraform)
	TERRAFORM_VERSION := $(shell terraform --version | head -n1 | tr -d 'Terraform v')
	TERRAFORM_REQUIRED_VERSION := "1.0.1"
endif


.PHONY: check-terraform ## @-> checks the terraform version
check-terraform:
	@echo "Checking Terraform version... expecting version [${TERRAFORM_REQUIRED_VERSION}], found [${TERRAFORM_VERSION}]"
	@if [ "${TERRAFORM_VERSION}" != "${TERRAFORM_REQUIRED_VERSION}" ]; then \
		echo "Please ensure you are running terraform version ${TERRAFORM_REQUIRED_VERSION}"; \
		exit 1; \
	fi
