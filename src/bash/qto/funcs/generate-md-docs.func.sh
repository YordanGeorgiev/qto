# src/bash/qto/funcs/generate-md-docs.func.sh

#
# ---------------------------------------------------------
# for docs: cat doc/txt/qto/funcs/generate-md-docs.func.txt
# ---------------------------------------------------------
doGenerateMdDocs(){
	doLog "DEBUG START doGenerateMdDocs"
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   test -z "${docs_root_dir-}" && docs_root_dir="$proj_instance_dir"

   doExportJsonSectionVars cnf/env/$env_type.env.json '.env.app'

   # <<web-host>>:<<web-port>>/<<db>>/select/export_files?as=grid&od=id
   basic_url="http://${web_host:-}:${mojo_morbo_port:-}/${postgres_db_name:-}"
   furl="$basic_url"'/select/export_files?as=grid&od=id&pg-size=20'

   curl -s $furl | jq -r '.dat[]|.url'
	ret=$?
	test $ret != "0" && doExit $ret "failed to get data from the $furl"

   while read -r url ; do 
      file_name=$(curl -s $furl | jq -r '.dat[]| select(.url=='\"$url\"')| .name'); 
      rel_path=$(curl -s $furl | jq -r '.dat[]| select(.url=='\"$url\"')| .path');
      [ "${rel_path-}" == "null" ] && rel_path=""
      mkdir -p $docs_root_dir/$rel_path
      file_path=$(echo $docs_root_dir/$rel_path/$file_name|perl -ne 's|[/]{2,5}|/|g;print')
      echo -e "\nrunning: curl -s -o \"$file_path\" \ \n \"$basic_url/export/$url\""       
      curl -s "$basic_url/export/$url" -o "$file_path"
      lines=$(wc -l "$file_path"|awk '{print $1;}')
      [[ $lines -eq 0 ]] && doExit 0 "load the $url !!! the table is empty !!!"
      echo -e "$lines lines in the $file_path file \n"
   done < <(curl -s $furl | jq -r '.dat[]|.url')
	
   printf "\033[2J";printf "\033[0;0H"
	doLog "DEBUG STOP  doGenerateMdDocs"
}

# eof file: src/bash/qto/funcs/generate-md-docs.func.sh
