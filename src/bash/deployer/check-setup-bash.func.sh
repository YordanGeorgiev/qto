do_check_setup_bash(){
   cp -v $product_dir/cnf/bash/.profile_opts.host-name ~/.profile_opts.$host_name
   cp -v $product_dir/cnf/bash/.bash_opts.host-name $bash_opts_file
   # or how-to append a string to file if not found there
   grep "source $bash_opts_file" ~/.bashrc || \
      echo "source $bash_opts_file" | tee -a ~/.bashrc

}
