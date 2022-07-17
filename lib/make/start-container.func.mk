.PHONY: do-start-$(component)-container ## @-> start a named container - run: container=devops do-start-devops-ter-container
do-start-$(component)-container: demand_var-ENV do-stop-$(component)-container
	@clear
	docker run -d --restart=always \
		-v $$(pwd):/opt/${PRODUCT} \
		-v $$HOME/.aws:/home/appusr/.aws \
		-v $$HOME/.ssh:/home/appgrp/.ssh \
		-p $(exposed_port):$(exposed_port) \
		--name ${PRODUCT}-$(component)-con ${PRODUCT}-${component}-img ;
	@echo -e to attach run: "\ndocker exec -it ${PRODUCT}-${component}-con /bin/bash"
	@echo -e to get help run: "\ndocker exec -it ${PRODUCT}-${component}-con ./run --help"
