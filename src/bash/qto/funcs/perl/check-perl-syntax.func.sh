# src/bash/qto/funcs/check-perl-syntax.func.sh

umask 022    ;

trap 'doExit $LINENO $BASH_COMMAND; exit' SIGHUP SIGINT SIGQUIT

#
#------------------------------------------------------------------------------
# checks the perl syntax of the cgi perl modules
#------------------------------------------------------------------------------
doCheckPerlSyntax(){

	doLog "INFO == START == doCheckPerlSyntax"
	cd $PRODUCT_INSTANCE_DIR

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
		cd $PRODUCT_INSTANCE_DIR/src/perl/$dir ; 

		# run the autoloader utility	
		find . -name '*.pm' -exec perl -MAutoSplit -e 'autosplit($ARGV[0], $ARGV[1], 0, 1, 1)' {} \;
		
         c=0
			# foreach perl file check the syntax by setting the correct INC dirs	
			while read -r file ; do 
            # run in a chunk of 3
            c=$((c+1)) ; test $c -eq 3 && sleep 1 && export c=0 ;
            (
               echo perl -MCarp::Always -I `pwd` -I `pwd`/lib -wc "$file";
               perl -MCarp::Always -I `pwd` -I `pwd`/lib -wc "$file"
               #ret=$? ;  # probably not needed ... better just to spit out the error for the
               #test $ret -ne 0 && break 2 ; 
            )&
			done < <(find "." -type f \( -name "*.pl" -or -name "*.pm" \))

			test $ret -ne 0 && break ; 
		
			echo "stop compiling $dir ..." ; 
			echo -e "\n\n"
			cd $PRODUCT_INSTANCE_DIR ; 
	
	done < <(ls -1 "src/perl")


	echo -e "\n"
	test $ret -ne 0 && doExit 4 "Perl syntax error" ; 
	cd $PRODUCT_INSTANCE_DIR

	# and clear the screen
	printf "\033[2J";printf "\033[0;0H"

	doLog "INFO == STOP  == doCheckPerlSyntax NO Errors !!!"
}

# eof file: src/bash/qto/funcs/check-perl-syntax.func.sh
