define stop-img-containers
	@clear
	-@docker container stop $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
	-@docker container rm $$(docker ps -aqf "name=${product}-${1}-con") 2> /dev/null
endef