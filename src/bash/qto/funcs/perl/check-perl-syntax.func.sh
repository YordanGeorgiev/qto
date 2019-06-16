# src/bash/qto/funcs/check-perl-syntax.func.sh

umask 022    ;

trap 'doExit $LINENO $BASH_COMMAND; exit' SIGHUP SIGINT SIGQUIT

#v0.6.4
#------------------------------------------------------------------------------
# checks the perl syntax of the cgi perl modules
#------------------------------------------------------------------------------
doCheckPerlSyntax(){
	set +x	
	doLog "INFO == START == doCheckPerlSyntax"
	cd $product_instance_dir

   # start prevent spew out of the Any::Moose warnings workaround
   export to_srch='use Any::Moose;'
   export to_repl="
   no warnings 'deprecated' ;
   use Any::Moose ;
   use warnings 'deprecated' ;
   "
   while read -r f ; do \
      test $(grep "no warnings 'deprecated'" $f|wc -l) -eq 0 && \
      sudo perl -pi -e 's/'"$to_srch"'/'"$to_repl"'/g' $f ; \
   done < <(find /usr/local -name OAuth2.pm)
   # start prevent spew out of the Any::Moose warnings workaround

	#remove all the autosplit.ix files 
	find . -name autosplit.ix | xargs rm -fv
	
	# remove all the empty dirs
	# hmm should this be here ?!
	# if it is here the auto lib dir was created warning appears
	# find . -type d -empty -exec rm -fvr {} \;
	
	declare -a ret
	ret=0	

	# foreach perl file in the src/perl dir
	while read -r dir ; do 

		echo -e "\n"
		echo "start compiling $dir ..." ; 
		cd $product_instance_dir/src/perl/$dir ; 

		# run the autoloader utility	
		find . -name '*.pm' -exec perl -MAutoSplit -e 'autosplit($ARGV[0], $ARGV[1], 0, 1, 1)' {} \;
		
			# foreach perl file check the syntax by setting the correct INC dirs	
			while read -r file ; do 
            echo perl -MCarp::Always -I `pwd` -I `pwd`/lib -wc "$file"
				perl -MCarp::Always -I `pwd` -I `pwd`/lib -wc "$file" 
            # run the perltidy inline
            # perltidy -b "$file"
            # sleep 3
				ret=$? ; 
				test $ret -ne 0 && break 2 ; 
			done < <(find "." -type f \( -name "*.pl" -or -name "*.pm" \))

			test $ret -ne 0 && break ; 
		
			echo "stop compiling $dir ..." ; 
			echo -e "\n\n"
			cd $product_instance_dir ; 
	
	done < <(ls -1 "src/perl")


	echo -e "\n"
	test $ret -ne 0 && doExit 4 "Perl syntax error" ; 
	cd $product_instance_dir

	# and clear the screen
	printf "\033[2J";printf "\033[0;0H"

	doLog "INFO == STOP  == doCheckPerlSyntax NO Errors !!!"
}

# eof file: src/bash/qto/funcs/check-perl-syntax.func.sh
