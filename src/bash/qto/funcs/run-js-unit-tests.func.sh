# v0.5.8
# ---------------------------------------------------------
#	run all the js 
# ---------------------------------------------------------
doRunJsUnitTests(){
	which mocha 2>/dev/null || \
		{ echo >&2 "The mocha is missing - \"sudo npm install -g --save-dev mocha \" ! Aborting ..."; exit 1; }
	# which chai 2>/dev/null || \
	 #  { echo >&2 "The chai is missing - \"sudo npm install -g --save-dev chai \" ! Aborting ..."; exit 1; }

	js_unit_tests_dir="$product_instance_dir/src/js/node/js-unit-tests"
	cd $js_unit_tests_dir
	while read -r d ; do
		echo -e "cd to dir: $d"
		cd $d
		echo -e "installing packages for dir $d: \n"
		sleep 1
		npm install
		printf "\033[2J";printf "\033[0;0H" # clear the screen

		echo -e "test dir $d \n"
		sleep 1
		npm test
		sleep 4
		printf "\033[2J";printf "\033[0;0H" # clear the screen
	done < <(find $js_unit_tests_dir -type d -name '0*-*'|sort)
}
