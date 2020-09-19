
do_chk_setup_bash(){
   bash_opts_file=~/.bash_opts.$host_name
   cp -v $PRODUCT_DIR/cnf/bash/.profile_opts.host-name ~/.profile_opts.$host_name
   cp -v $PRODUCT_DIR/cnf/bash/.bash_opts.host-name $bash_opts_file

   set +e
   test $(grep -c "source $bash_opts_file" ~/.bashrc) -lt 1 && \
      cat <<EOF | sudo tee -a ~/.bashrc > /dev/null 
   source $bash_opts_file
EOF

}
