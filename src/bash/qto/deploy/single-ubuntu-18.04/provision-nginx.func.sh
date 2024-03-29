do_chk_provision_nginx(){
   set +e
   # chk: devops_guide_doc-200325051051
   #sudo mkdir /etc/systemd/system/nginx.service.d
   cat << EOF | sudo tee /etc/systemd/system/nginx.service.d/override.conf
[Service]
ExecStartPost=/bin/sleep 0.1
EOF

   sudo mkdir -p /etc/nginx/sites-available
   sudo mkdir -p /etc/nginx/sites-enabled
   sudo test -f  /etc/nginx/sites-available/* && {
      sudo rm -v /etc/nginx/sites-available/*
   }
   sudo test -f  /etc/nginx/sites-enabled/* && {
      sudo rm -v /etc/nginx/sites-enabled/*
   }

   # qto-200326084258 create the cache dir NOT in the global dir, related to site crashes
   mkdir -p ~/var/cache ; chmod -R 777 ~/var/cache
   perl -pi -e 's|~/|'$HOME/'|g' $PRODUCT_DIR/cnf/nginx/etc/nginx/nginx.conf #qto-200402172803
   sudo cp -v $PRODUCT_DIR/cnf/nginx/etc/nginx/nginx.conf /etc/nginx/nginx.conf

   source $PRODUCT_DIR/lib/bash/funcs/export-json-section-vars.sh
   for env in `echo dev tst prd`; do \

      do_export_json_section_vars $PRODUCT_DIR/cnf/env/$env.env.json '.env.app'
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

   sudo chown -R www-data:www-data /etc/nginx # !!! monthly_issues_202003-200326084258
   sudo systemctl daemon-reload
   sudo systemctl try-restart nginx
   sudo systemctl enable nginx
   sudo systemctl status nginx
   source $PRODUCT_DIR/.env
   do_export_json_section_vars $PRODUCT_DIR/cnf/env/$ENV.env.json '.env.app'
  

}
