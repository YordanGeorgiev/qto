
do_chk_install_python_modules(){
   cd $PRODUCT_DIR

   
   sudo apt-get install -y python3-venv
   pip3 install virtualenv ; python3 -m venv ./venv
   pip install --ignore-installed six
   pip3 install -r $PRODUCT_DIR/cnf/bin/python/requirements.txt

	sleep 1 ; do_flush_screen 
}
