# file: src/bash/qto/funcs/generate-pdf-docs.func.sh

doGeneratePdfDocs(){
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   test -z "${docs_root_dir-}" && docs_root_dir="$proj_instance_dir"

   test -z ${proj_conf_file-} && proj_conf_file=$proj_instance_dir/cnf/env/$env_type.env.json
   do_export_json_section_vars $proj_conf_file '.env.app'

   # <<web-host>>:<<web-port>>/<<db>>/select/export_files?as=grid&od=id
   basic_url="$ht_protocol://${web_host:-}:${port:-}/${postgres_db_name:-}"
   furl="$basic_url"'/select/export_files?as=grid&od=id&pg-size=20'
   echo "running: curl --cookie ~/.qto/cookies.txt --insecure  -s $furl \| jq -r '.dat[]|.url'"
   curl --cookie ~/.qto/cookies.txt --insecure  -s $furl | jq -r '.dat[]|.url'
	ret=$?
	test $ret != "0" && do_exit $ret "failed to get data from the $furl"

   while read -r url ; do 
      file_name=$(curl --cookie ~/.qto/cookies.txt --insecure  -s $furl | jq -r '.dat[]| select(.url=='\"$url\"')| .name'); 
      file_name="$file_name.pdf"
      rel_path=$(curl --cookie ~/.qto/cookies.txt --insecure  -s $furl | jq -r '.dat[]| select(.url=='\"$url\"')| .path');
      [ "${rel_path-}" == "null" ] && rel_path="doc"
      rel_path="$rel_path/pdf"
      mkdir -p $docs_root_dir/$rel_path
      file_path=$(echo $docs_root_dir/$rel_path/$file_name|perl -ne 's|[/]{2,5}|/|g;print')
      url="$url"'?as=print-doc'
      echo -e "\nrunning: chrome --headless --disable-gpu --print-to-pdf=$file_path $basic_url/view/$url"
      chrome --headless --disable-gpu --print-to-pdf=$file_path $basic_url/view/$url
      lines=$(wc -l "$file_path"|awk '{print $1;}')
      [[ $lines -eq 0 ]] && do_exit 0 "load the $url !!! the table is empty !!!"
      echo -e "$lines lines in the $file_path file \n"
   done < <(curl --cookie ~/.qto/cookies.txt --insecure  -s $furl | jq -r '.dat[]|.url')
	
   do_flush_screen
}

