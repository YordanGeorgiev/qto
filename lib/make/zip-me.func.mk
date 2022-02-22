# # usage: include it in your Makefile
# include <<file-path>>
#
# usage:
# make zip_me
# 


.ONESHELL: # Applies to every targets in the file!

.PHONY: zip_me ## @-> zip the whole project without the .git dir
zip_me:
	@clear
	-rm -v ../$(PRODUCT).zip ; zip -r ../$(PRODUCT).zip  . -x '*.git*'
	@sleep 1
	@clear
	@echo done check
	@echo $(PWD)/../$(PRODUCT).zip