
do_check_install_python_modules(){
   cd $DEPLOY_DIR
   modules="$(cat src/bash/deployer/qto/cnf/bin/python-modules.lst)"
  
   while read -r module ; do
      import_modules=$(echo "${import_modules:-} import $module\n")
   done < <(echo "$modules");

   python -c "$import_modules" || {
      while read -r module ; do
         pip install $module
      done < <(echo "$modules");
   }
}
