# v0.2.1
#------------------------------------------------------------------------------
#  gmail the latest created package - requires mutt binary !!!
#------------------------------------------------------------------------------
doGmailPackage(){
	
	mutt --help >/dev/null 2>&1 ||
	{ doLog "ERROR. mutt is not installed or not in PATH. Aborting." >&2; exit 1; }
  
   if [ -z "$AdminEmail" ]; then
      msg="AdminEmail to set mail to not set !!! you need to export AdminEmail=list-of-emails-to-send-mail-to-comma-delimited" ;
      export exit_code=1 ;  
      doExit "$msg";
      exit 1 ;
   fi

	# zip_file=$(ls -r1 "$product_dir"/*.zip | head -1)
	zip_file=$(cat $PRODUCT_INSTANCE_DIR/dat/$RUN_UNIT/tmp/zip_file)
   test -z "${zip_file+x}" && zip_file=$(ls -r1 "$PRODUCT_INSTANCE_DIR"/*.zip | head -1)
   test -z "${zip_file+x}" && export exit_code=1 && doExit " no zip file found for gmailing !!!"

   zip_file_name=`basename $zip_file`

	# create a fake txt file type attachment
	cp -v "$zip_file" "$zip_file"'.txt'

	echo $zip_file>$tmp_dir/.msg

   doLog "DEBUG cnf_files is ${cnf_file+x}"
   doLog "DEBUG AdminEmail: $AdminEmail"

	for Email in $AdminEmail; do (
		mutt -s "${mail_msg-}::: ""$zip_file_name" -a "$zip_file"'.txt' -- "$Email" < $tmp_dir/.msg
	);
	done

	rm -fv "$zip_file"'.txt'	

}
