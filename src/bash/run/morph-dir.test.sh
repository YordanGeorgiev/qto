#v1.2.6
#------------------------------------------------------------------------------
#  Purpose: 
#  export to_repl=<<the-string-to-replace-with>>
#------------------------------------------------------------------------------
doTestMorphDir(){
		
	do_log " INFO START : morph-dir.test"

	# doSpecMorphDir
	echo this function should not work without setting the following shell vars
	echo export dir_to_morph="<<the-dir-to-search-and-replace>>"
	echo to_srch="<<to_srch>>"
	echo to_repl="<<to_repl>>"

	sleep 1	
	bash src/bash/qto/qto.sh -a morph-dir
	echo now this test should succeed	
	mkdir -p /tmp/src/bash	
	cp -rv src/bash/qto /tmp/src/bash
	export dir_to_morph=/tmp/src/bash/qto
	export to_srch=qto
	export to_repl=new-app
	bash src/bash/qto/qto.sh -a morph-dir
	
	echo "and check the produced dir"
	find /tmp/src/bash/new-app -type f
	do_log " INFO STOP  : morph-dir.test"

}
#eof doMorphDir

#eof file: src/bash/qto/tests/dev/morph-dir.test.sh
