# src/bash/issue-tracker/funcs/generate-md-docs.func.sh

#
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/generate-md-docs.func.txt
# ---------------------------------------------------------
doGenerateMdDocs(){

	doLog "DEBUG START doGenerateMdDocs"
	
   while read -r table ; do \
      url='http://'"$web_host"':'"$mojo_morbo_port/$postgres_db_name"'/export/'"$table"'?as=md'
      # debug echo url: $url
      item=$(echo $table |perl -ne 's/_doc//g;print')
      md_file="$product_instance_dir/doc/md/$item.md"
      wget -O "$md_file" "$url"
      msg="the $table.md doc has than 100 lines and is probably empty !!!"
      test $(wc -l "$md_file"|cut -d" " -f 1) -lt 100 && echo $msg >> $tmp_dir/do_exit
   done < <(cat <<EOF
userstories_doc
devops_guide_doc
features_doc
requirements_doc
concepts_doc
system_guide_doc
installations_doc
EOF
)

	doLog "DEBUG STOP  doGenerateMdDocs"
}


# eof file: src/bash/issue-tracker/funcs/generate-md-docs.func.sh
