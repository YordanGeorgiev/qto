
do_chk_install_os_packages(){
   packages_list_file="$PRODUCT_DIR/src/bash/qto/deploy/single-ubuntu-18.04/$run_unit/cnf/bin/ubuntu-18.04.lst"
   err_msg="the packages list file: $packages_list_file does not exist !"
   test -f $packages_list_file || do_exit 1 "$err_msg"
   packages="$(cat $packages_list_file)"

   sudo apt-get update      
	# sudo apt-get upgrade # probably not a good idea, but if yes ... this is the place ...
   while read -r package ; do 
      test "$(sudo dpkg -s $package | grep Status)" == "Status: install ok installed" || {
         $maybe_echo sudo apt-get install -y $package 
      }
   done < <(echo "$packages");
      
}
