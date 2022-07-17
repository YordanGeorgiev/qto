# # usage: include it in your Makefile
# include <<file-path>>
#
# # function usage example:
#
# uninstall-csitea-web:
# 	$(call uninstall-img,csitea-web,80)


define uninstall-img
	@clear
	-@docker container stop $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
	-@docker container rm $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
endef

