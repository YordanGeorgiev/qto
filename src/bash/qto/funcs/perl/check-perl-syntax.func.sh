# file: src/bash/qto/funcs/perl/check-perl-syntax.func.sh
doCheckPerlSyntax(){

	find . -name autosplit.ix | xargs rm -fv # because idempotence
	declare -a ret; ret=0
	
	source $product_instance_dir/lib/bash/funcs/flush-screen.sh

   # foreach perl file check the syntax by setting the correct INC dirs	
	while read -r dir ; do 

		echo -e "\n start compiling $dir ..." ; 
		cd $product_instance_dir/src/perl/$dir ; 

		# run the autoloader utility	
		find . -name '*.pm' -exec perl -MAutoSplit -e 'autosplit($ARGV[0], $ARGV[1], 0, 1, 1)' {} \;
		
         c=0
         # feel free to adjust to 5, more might get you the "Out of memory!" error
         amount_of_perl_syntax_checks_to_run_in_parallel=1
			while read -r file ; do 
            c=$((c+1)) ; test $c -eq $amount_of_perl_syntax_checks_to_run_in_parallel && sleep 1 && export c=0 ;
            (
               echo -e "\n ::: running: cd src/perl/qto ; perl -MCarp::Always -I `pwd` -I `pwd`/lib -wc \"$file\" ; cd -"
               perl -MCarp::Always -I `pwd` -I `pwd`/lib -wc "$file"
               # ret=$? ;  # probably not needed ... better just to spit out the error for the
               # test $ret -ne 0 && break 2 ; 
            )&
			done < <(find "." -type f \( -name "*.pl" -or -name "*.pm" -or -name '*.t' \))
			test $ret -ne 0 && break ; 
		
			echo -e "stop compiling $dir ... \n\n" ; 
			cd $product_instance_dir ; 
	
	done < <(ls -1 "src/perl")

	test $ret -ne 0 && do_exit 4 "Perl syntax error" ;
	
	do_flush_screen
}
