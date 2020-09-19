doProvisionHttps(){
   do_export_json_section_vars $PRODUCT_INSTANCE_DIR/cnf/env/$ENV_TYPE.env.json '.env.app'

   sudo test -f /etc/letsencrypt/live/$web_host/privkey.pem && {
      source $PRODUCT_INSTANCE_DIR/lib/bash/funcs/export-json-section-vars.sh
      for env in `echo dev tst prd`; do \
         do_export_json_section_vars $PRODUCT_INSTANCE_DIR/cnf/env/$env.env.json '.env.app'
         sudo cp -v "$PRODUCT_INSTANCE_DIR"'/cnf/nginx/etc/nginx/sites-available/%env%.https-site.conf' \
            "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%nginx_port\%|'"$nginx_port"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%nginx_port\%|'"$nginx_port"'|g' "/etc/nginx/sites-available/$env.http-site.conf"
         sudo perl -pi -e 's|\%https_port\%|'"$https_port"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%https_port\%|'"$https_port"'|g' "/etc/nginx/sites-available/$env.http-site.conf"
         sudo perl -pi -e 's|#uncomment-for-https ||g' "/etc/nginx/sites-available/$env.http-site.conf"
         sudo perl -pi -e 's|\%mojo_hypnotoad_port\%|'"$mojo_hypnotoad_port"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%web_host\%|'"$web_host"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|\%port\%|'"$port"'|g' "/etc/nginx/sites-available/$env.https-site.conf"
         sudo perl -pi -e 's|#todo-https-me||g' "/etc/nginx/sites-available/$env.http-site.conf"
         
         sudo ln -fs /etc/nginx/sites-available/$env.https-site.conf /etc/nginx/sites-enabled/$env.https-site.conf
         sudo ls -la /etc/nginx/sites-enabled/$env.https-site.conf
      done ;

      sudo chown -R www-data:www-data /etc/nginx
      sudo service nginx restart
      sudo service nginx status
      do_export_json_section_vars $PRODUCT_INSTANCE_DIR/cnf/env/$ENV_TYPE.env.json '.env.app'
   }
}
