# src/bash/issue-tracker/funcs/generate-docs.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/generate-docs.func.txt
# ---------------------------------------------------------
doGenerateDocs(){

	doLog "DEBUG START doGenerateDocs"
	
   test -z "${mysql_user+x}" && doExit 1 "mysql_user not set - Nothing to do !!!" 
   test -z "${mysql_user_pw+x}" && doExit 1 "mysql_user_pw not set - Nothing to do !!!"
   test -z "${mysql_host+x}" && doExit 1 "mysql_host not set - Nothing to do !!!"
   test -z "${mysql_port+x}" && doExit 1 "mysql_port not set - Nothing to do !!!"
   test -z "${mysql_db_name+x}" && doExit 1 "mysql_db_name not set - Nothing to do !!!"
   test -z "${web_host+x}" && doExit 1 "web_host not set - Nothing to do !!!"
	
	doLog "DEBUG START exporting github md files"
   sql="
      select ItemModel.TableName , ExportFile.BranchId , CONCAT ( ExportFile.RelativePath ,
      ExportFile.Name) as Name from ExportFile 
      INNER JOIN ItemView on
      ExportFile.ItemViewId = ItemView.ItemViewId 
      INNER JOIN ItemController
      on ItemView.ItemControllerId = ItemController.ItemControllerId 
      INNER JOIN ItemModel on
      ItemView.ItemControllerId = ItemModel.ItemControllerId 
      WHERE 1=1 
      AND ItemView.Type='document' 
      AND ItemView.doExportToPdf=1 
      AND ExportFile.Type='md'
   ;" ; 

   mysql -NBA -u"$mysql_user" -p"$mysql_user_pw" -P"$mysql_port" -D"$mysql_db_name" -h "$mysql_host" -e "$sql"| { 
   while read -r l ; do \
      t=$(echo $l|cut -d" " -f 1); 
      b=$(echo $l|cut -d" " -f 2); 
      n=$(echo $l|cut -d" " -f 3-);
      echo start $t,$b; 
      url='http://'"$web_host"':'"$web_port"'/export?to=githubmd&db='"$mysql_db_name"
      url="$url"'&path-id='$b'&item='$t'&order-by=SeqId&filter-by=Level&filter-value=1,2,3,4,5,6'
      wget -O "$n.md" "$url"
   done }
	doLog "DEBUG STOP  exporting github md files"

	doLog "DEBUG START exporting github md files"
   sql="
      select ItemModel.TableName , ExportFile.BranchId , CONCAT ( ExportFile.RelativePath ,
      ExportFile.Name) as Name from ExportFile 
      INNER JOIN ItemView on
      ExportFile.ItemViewId = ItemView.ItemViewId 
      INNER JOIN ItemController
      on ItemView.ItemControllerId = ItemController.ItemControllerId 
      INNER JOIN ItemModel on
      ItemView.ItemControllerId = ItemModel.ItemControllerId 
      WHERE 1=1 
      AND ItemView.Type='document' 
      AND ItemView.doExportToPdf=1 
      AND ExportFile.Type='pdf'
   ;" ; 

   mysql -NBA -u"$mysql_user" -p"$mysql_user_pw" -P"$mysql_port" -D"$mysql_db_name" -h "$mysql_host" -e "$sql"| { 
   while read -r l ; do \
      t=$(echo $l|cut -d" " -f 1); 
      b=$(echo $l|cut -d" " -f 2); 
      n=$(echo $l|cut -d" " -f 3-);
      url='http://'"$web_host"':'"$web_port"'/export?to=pdf&db='"$mysql_db_name"
      url="$url"'&branch-id='$b'&item='$t'&order-by=SeqId&filter-by=Level&filter-value=1,2,3,4,5,6'
      wget -O "$n.pdf" "$url"
   done }

	doLog "DEBUG STOP  exporting github md files"

	doLog "DEBUG STOP  doGenerateDocs"
}
# eof func doGenerateDocs


# eof file: src/bash/issue-tracker/funcs/generate-docs.func.sh
