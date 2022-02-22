# usage: include it in your Makefile
# include lib/make/make-help.task

.DEFAULT_GOAL := help

.PHONY: help  ## @-> show this help  the default action
help:
	@clear
	@fgrep -h "##" $(MAKEFILE_LIST)|fgrep -v fgrep|sed -e 's/^\.PHONY: //'|sed -e 's/^\(.*\)##/\1/'| \
      column -t -s $$'@'
