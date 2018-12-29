# src/bash/issue-tracker/funcs/generate-md-docs.func.sh

set +u +o 
#
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/generate-md-docs.func.txt
# ---------------------------------------------------------
doGenerateMdDocs(){

	doLog "DEBUG START doGenerateMdDocs"
	
   while read -r table ; do \
      url='http://'"$web_host"':'"$mojo_morbo_port/$postgres_db_name"'/export/'"$table"'?as=md'
      echo url: $url
      md_file="$product_instance_dir/doc/md/$table.md"
      wget -O "$md_file" "$url"
      msg="the $table.md doc has than 100 lines and is probably empty !!!"
      test $(wc -l "$n.md"|cut -d" " -f 1) -lt 100 && echo $msg >> $tmp_dir/do_exit
   done < <(cat <<EOF
userstories
devops_guide
features
EOF
)

	doLog "DEBUG STOP  doGenerateMdDocs"
}


# eof file: src/bash/issue-tracker/funcs/generate-md-docs.func.sh
