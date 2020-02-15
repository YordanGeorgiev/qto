
do_provision_nginx(){

   test -f /etc/nginx/nginx.conf || sudo apt-get install -y nginx
   test -f /etc/nginx/nginx.conf && sudo cp -v /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
   sudo rm -v /etc/nginx/sites-enabled/*
   sudo rm -v /etc/nginx/sites-available/*
   test -f /etc/nginx/sites-enabled/default && rm -v /etc/nginx/sites-enabled/default

   sudo cp -v $PRODUCT_DIR/cnf/nginx/etc/nginx/nginx.conf /etc/nginx/nginx.conf

   source $PRODUCT_DIR/lib/bash/funcs/export-json-section-vars.sh
   for env in `echo dev tst prd`; do \

      doExportJsonSectionVars $PRODUCT_DIR/cnf/env/$env.env.json '.env.app'
      sudo cp -v $PRODUCT_DIR/cnf/nginx/etc/nginx/sites-available/%env%.http-site.conf \
         /etc/nginx/sites-available/$env.http-site.conf
      sudo perl -pi -e 's|\%nginx_port\%|'"$nginx_port"'|g' "/etc/nginx/sites-available/$env.http-site.conf"
      sudo perl -pi -e 's|\%https_port\%|'"$https_port"'|g' "/etc/nginx/sites-available/$env.http-site.conf"
      sudo perl -pi -e 's|\%mojo_hypnotoad_port\%|'"$mojo_hypnotoad_port"'|g' "/etc/nginx/sites-available/$env.http-site.conf"
      sudo perl -pi -e 's|\%web_host\%|'"$web_host"'|g' "/etc/nginx/sites-available/$env.http-site.conf"
      sudo perl -pi -e 's|\%port\%|'"$port"'|g' "/etc/nginx/sites-available/$env.http-site.conf"
      
      sudo ln -fs /etc/nginx/sites-available/$env.http-site.conf /etc/nginx/sites-enabled/$env.http-site.conf
      sudo ls -la /etc/nginx/sites-enabled/$env.http-site.conf
   done ;

   sudo service nginx restart
   sudo service nginx status
   doExportJsonSectionVars $PRODUCT_DIR/cnf/env/$ENV_TYPE.env.json '.env.app'
   
   find /var/log/nginx/

}
