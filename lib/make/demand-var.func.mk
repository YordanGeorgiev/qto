# usage example
# install-the-bot: demand_var-ENV demand_var-TGT_ORG do-build-$(component)-docker-img
demand_var-%:
	@if [ "${${*}}" = "" ]; then \
		echo "the var \"$*\" is not set, do set it by: export $*='value'"; \
		exit 1; \
	fi

# function usage example
# install-the-bot:
# 	$(call demand-var,ENV)
# 	$(call demand-var,TGT_ORG)
# 	do-build-$(component)-docker-img
define demand-var
	@if [ "${${1}}" = "" ]; then \
		echo "the var \"$1\" is not set, do set it by: export $1='value'"; \
		exit 1; \
	fi
endef
