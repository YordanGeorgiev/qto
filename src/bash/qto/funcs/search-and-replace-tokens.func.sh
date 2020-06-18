doSearchAndReplaceTokens(){

   test -d $dir || dir=$product_instance_dir/src/sql/

   while read -r l ; do 
      to_srch=$(echo $l|awk '{print $1}')
      to_repl=$(echo $l|awk '{print $2}')

      while read -r f ; do 
         perl -pi -e "s/$to_srch/$to_repl/gm" $f
      done < <(find $dir -type f| grep -v search-and-replace-tokens.func.sh)

   # space or tabs do not mather - to search on the left, to replace on the right
   done < <(cat << EOF_WORDS
         meta_tables                app_items
         meta_columns               app_item_attributes
         meta_routes                app_routes
         roles                      app_roles
         user_roles                 app_user_roles
         items_roles_permissions    app_items_roles_permissions
         items_app_roles_permissions app_items_roles_permissions
         pg_app_roles               pg_roles
         app_app_                   app_
         user_app_roles             app_user_roles
EOF_WORDS
)

}
#         items                      app_items
#         item_attributes            app_item_attributes
#         routes                     app_routes
#         roles                      app_roles
#         user_roles                 app_user_roles
#         items_roles_permissions    app_items_roles_permissions
#         items_app_roles_permissions app_items_roles_permissions
