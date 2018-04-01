# v1.2.9 
#------------------------------------------------------------------------------
# scan all the "defined" actions and generate the 
# spec , func , test , doc files if the do not exist 
#------------------------------------------------------------------------------
doGenerateActionFiles(){
	
	doLog "DEBUG START : doGenerateActionFiles"
	
	# for each defined action 	
	while read -r act ; do (

		doLog "DEBUG START :: checking action: $act"
			# for each defined action 	
			while read -d" " deliverable_type ; do (

				doLog "DEBUG START ::: action: $act - deliverable_type: $deliverable_type "
				# src: https://gist.github.com/tyru/358703
				func_part_name=$(echo $act|perl -ne 's{(\w+)}{($a=lc $1)=~s<(^[a-z]|-[a-z])><($b=uc$1);$b;>eg;$a;}eg;s|-||g;print')
				doLog "DEBUG func_part_name: $func_part_name"
				
				# foreach deliverable_type build the code and doc files	
				case $deliverable_type in 
					'spec')
					#
						full_func="doSpec""$func_part_name"
						deliverable_doc_file="doc/txt/$run_unit/specs/$act.spec.txt"
						deliverable_code_file="src/bash/$run_unit/specs/$act.spec.sh"
					;;
					'func')
						full_func="do""$func_part_name"
						deliverable_doc_file="doc/txt/$run_unit/funcs/$act.func.txt"
						deliverable_code_file="src/bash/$run_unit/funcs/$act.func.sh"
					;;
					'test')
						full_func="doTest""$func_part_name"
						deliverable_doc_file="doc/txt/$run_unit/tests/$act.test.txt"
						deliverable_code_file="src/bash/$run_unit/tests/$act.test.sh"
					;;
					'help')
						full_func="doHelp""$func_part_name"
						deliverable_doc_file="doc/txt/$run_unit/helps/$act.help.txt"
						deliverable_code_file="src/bash/$run_unit/helps/$act.help.sh"
					;;
				esac

				doLog " DEBUG full_func: $full_func"
				doLog " INFO delvr_doc_file: $deliverable_doc_file"
				doLog " INFO delvr_code_file: $deliverable_code_file"
				doLog " DEBUG STOP  ::: action: $act - deliverable_type: $deliverable_type "

				# if the delivable file does not exist create it
				code_file_exists=$(find "src/bash/$run_unit/$deliverable_type""s" | grep $act.$deliverable_type.sh| wc -l)
				if [ $code_file_exists -eq 0 ];then

					cp -v src/bash/$run_unit/funcs/%act%.%deliverable_type%.sh "$deliverable_code_file"
					perl -pi -e "s|%full_func%|$full_func|g" "$deliverable_code_file"
					perl -pi -e "s|%act%|$act|g" "$deliverable_code_file"
					perl -pi -e "s|%deliverable_type%|$deliverable_type|g" "$deliverable_code_file"

				fi
				
				doc_file_exists=$(find "doc/txt/$run_unit/$deliverable_type""s" | grep $act.$deliverable_type.txt| wc -l)
				if [ $doc_file_exists -eq 0 ];then

					cp -v doc/txt/issue-tracker/tmpl/%act%.%deliverable_type%.txt "$deliverable_doc_file"
					perl -pi -e "s|%full_func%|$full_func|g" "$deliverable_doc_file"
					perl -pi -e "s|%act%|$act|g" "$deliverable_doc_file"
					perl -pi -e "s|%deliverable_type%|$deliverable_type|g" "$deliverable_doc_file"

				fi
			); 
			done< <(echo 'spec' 'func' 'test' 'help' 'none')

      echo -e "generated the following files: \n" ; 
      find . | grep -i $act |cut -c 3-|sort -nr
      echo -e "\n\n" 

		doLog "DEBUG STOP  :: checking action: $act"
		
	); 
	done< <(cat src/bash/$run_unit/tests/new-issue-tracker-tests.lst)
	
	doLog "DEBUG STOP  : doGenerateActionFiles"

}
#eof func doGenerateActionFiles
