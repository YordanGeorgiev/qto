# src/bash/qto/funcs/generate-md-docs.func.sh

#
# ---------------------------------------------------------
# for docs: cat doc/txt/qto/funcs/generate-md-docs.func.txt
# ---------------------------------------------------------
doGenerateMdDocs(){

	doLog "DEBUG START doGenerateMdDocs"
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   test -z "${docs_root_dir-}" && docs_root_dir="$proj_instance_dir"
   # <<web-host>>:<<web-port>>/<<db>>/select/export_files?as=grid&od=id
   basic_url="http://$web_host:$mojo_morbo_port/$postgres_db_name"
   furl="$basic_url"'/select/export_files?as=grid&od=id'

   while read -r url ; do 
      printf "\033[2J";printf "\033[0;0H"
      file_name=$(curl -s $furl | jq -r '.dat[]| select(.url=='\"$url\"')| .name'); 
      rel_path=$(curl -s $furl | jq -r '.dat[]| select(.url=='\"$url\"')| .path');
      [ "${rel_path-}" == "null" ] && rel_path=""
      echo -e "\nrunning: curl -s -o \"$docs_root_dir/$rel_path/$file_name\" \ \n \"$basic_url/$url\"\n"       
      curl -o "$docs_root_dir/$rel_path/$file_name" "$basic_url/$url"
   done < <(curl -s $furl | jq -r '.dat[]|.url')
	
	doLog "DEBUG STOP  doGenerateMdDocs"
}

# eof file: src/bash/qto/funcs/generate-md-docs.func.sh
