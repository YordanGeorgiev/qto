UNAME := $(shell uname)
ifeq ($(UNAME),Darwin)
	OS_X   := true
	SHELL  := /bin/bash
else
	OS_DEB := true
	SHELL  := /bin/bash
endif
