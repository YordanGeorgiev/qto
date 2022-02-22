# v0.5.8
# ---------------------------------------------------------
#	run all the js 
# ---------------------------------------------------------
doRunJsUnitTests(){
	which mocha 2>/dev/null || \
		{ 
         sudo npm install -g --save-dev mocha
         echo >&2 "The mocha is missing - \"sudo npm install -g --save-dev mocha \" ! Aborting ..."; 
         exit 1; 
      }
   # sudo npm install -g --save-dev chrome-remote-interface
	# which chai 2>/dev/null || \
	 #  { echo >&2 "The chai is missing - \"sudo npm install -g --save-dev chai \" ! Aborting ..."; exit 1; }
	source $PRODUCT_INSTANCE_DIR/lib/bash/funcs/flush-screen.sh

	js_unit_tests_dir="$PRODUCT_INSTANCE_DIR/src/js/node/js-unit-tests"
	cd $js_unit_tests_dir
	while read -r d ; do
		echo -e "cd to dir: $d"
		cd $d
		echo -e "installing packages for dir $d: \n"
		sleep 1
		npm install
		do_flush_screen  # clear the screen
		echo -e "test dir $d \n"
		sleep 1
		npm test
		sleep 4
		do_flush_screen
	done < <(find $js_unit_tests_dir -type d -name '0*-*'|sort)
}
