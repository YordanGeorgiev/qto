.PHONY: do-stop-$(component)-container ## @-> stop a named container - run: container=devops do-stop-devops-ter-container
do-stop-$(component)-container:
	@clear
	-@docker container stop $$(docker ps -aqf "name=${PRODUCT}-${component}-con") 2> /dev/null
	-@docker container rm $$(docker ps -aqf "name=${PRODUCT}-${component}-con") 2> /dev/null
