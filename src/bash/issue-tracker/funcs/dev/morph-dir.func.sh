# v1.0.7
#------------------------------------------------------------------------------
# Purpose: 
# to search for a string and replace it with another recursively in a dir
# both in dir and file paths and their contents
# Prerequisites: setting vars in the caller shell
# export dir_to_morph=<<the-dir-to-search-and-replace-in-recursively>> 
# export to_srch=<<the-string-to-search-for>>
# export to_repl=<<the-string-to-replace-with>>
# while read -r f ; do cp -v $f $(echo $f|perl -ne 's#func#help#g;print'|perl -ne
# 's#src#doc#g;print'|perl -ne 's#bash#txt#g;print'|perl -ne 's#help.sh#help.txt#g;print') ; done <
# <(find src/bash/issue-tracker/funcs/ -type f)
#------------------------------------------------------------------------------
doMorphDir(){
		
		# some initial checks the users should set the vars in their shells !!!
		test -z $dir_to_morph && doExit 1 "You must export dir_to_morph=<<the-dir>> - it is empty !!!"	
		test -d $dir_to_morph || doExit 1 "The dir to morph : \"$dir_to_morph\" is not a dir !!!"
		test -z $to_srch && doExit 1 "You must export to_srch=<<str-to-search-for>> - it is empty !!!"	
		test -z $to_repl && doExit 1 "You must export to_repl=<<str-to-replace-with>> - it is empty !!!"	

		doLog "INFO dir_to_morph: $dir_to_morph"
		doLog "INFO to_srch:\"$to_srch\" " ; 
		doLog "INFO to_repl:\"$to_repl\" " ; 
		sleep 2
		
		doLog "INFO START :: search and replace in non-binary files"
		#search and replace ONLY in the txt files and omit the binary files
		while read -r file ; do (
			#debug doLog doing find and replace in $file 
			doLog "DEBUG working on file: $file"
			doLog "DEBUG searching for $to_srch , replacing with :: $to_repl"

			perl -pi -e "s#$to_srch#$to_repl#g" "$file"
		);
		done < <(find $dir_to_morph -not -path "*/node_modules/*" -type f \
            -exec file {} \; | grep text | cut -d: -f1)
		
		doLog "INFO STOP  :: search and replace in non-binary files"

		#search and repl %var_id% with var_id_val in deploy_tmp_dir 
		doLog "INFO search and replace in dir and file paths dir_to_morph:$dir_to_morph"
      # rename the dirs according to the pattern
      while read -r dir ; do (
         perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` if -d $_ ;'
      );
      done < <(find $dir_to_morph -not -path "*/node_modules/*" -type f|grep -v '.git')


      # rename the files according to the pattern
      while read -r file ; do (
         perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'
      );
      done < <(find $dir_to_morph -not -path "*/node_modules/*" -type f|grep -v '.git')

}
#eof doMorphDir

#eof file: src/bash/issue-tracker/funcs/dev/morph-dir.func.sh
