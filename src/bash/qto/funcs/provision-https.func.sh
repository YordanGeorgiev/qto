doProvisionHttps(){
   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$ENV_TYPE.env.json '.env.app'

   # if we have already got NOT yet registered the ssl cert
   sudo test -f /etc/letsencrypt/live/$web_host/privkey.pem || {
      echo 'at this moment you should have your dns registered according to the docs  if not abort'
      sleep 6
      sudo apt-get update
      sudo apt-get install software-properties-common
      sudo add-apt-repository universe
      expect <<- EOF_EXPECT
         set timeout -1
         sudo add-apt-repository ppa:certbot/certbot
         expect "Press [ENTER] to continue or Ctrl-c to cancel adding it."
         send -- "\r"
         expect eof
EOF_EXPECT
   sudo apt-get install -y certbot python-certbot-nginx

      # src: https://medium.com/@mightywomble/how-to-set-up-nginx-reverse-proxy-with-lets-encrypt-8ef3fd6b79e5
      echo put in the backgroup and run the following command 
      echo sudo certbot --nginx -d $web_host 
   }
   
   sudo test -f /etc/letsencrypt/live/$web_host/privkey.pem && {
      source $PRODUCT_INSTANCE_DIR/lib/bash/funcs/export-json-section-vars.sh
      for env in `echo dev tst prd`; do \
         doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env.env.json '.env.app'
         sudo cp -v "$PRODUCT_INSTANCE_DIR"'/cnf/nginx/etc/nginx/sites-available/%env%.https-site.conf' \
            "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%nginx_port\%|'"$nginx_port"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%https_port\%|'"$https_port"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%mojo_hypnotoad_port\%|'"$mojo_hypnotoad_port"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%web_host\%|'"$web_host"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%port\%|'"$port"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         
         sudo ln -fs /etc/nginx/sites-available/$env.https-site.conf /etc/nginx/sites-enabled/$env.https-site.conf
         sudo ls -la /etc/nginx/sites-enabled/$env.https-site.conf
      done ;

      sudo service nginx restart
      sudo service nginx status
      doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$ENV_TYPE.env.json '.env.app'
   }
}
