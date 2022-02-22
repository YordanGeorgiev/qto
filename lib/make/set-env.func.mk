ENV ?= lde
ifeq ($(ENV),lde)
    # AWS_REGION = eu-central-1
    @echo ENV:$(ENV) in make
endif
ifeq ($(ENV),dev)
    @echo ENV:$(ENV) in make
endif
ifeq ($(ENV),stg)
    @echo ENV:$(ENV) in make
endif
ifeq ($(ENV),prd)
    @echo ENV:$(ENV) in make
endif
