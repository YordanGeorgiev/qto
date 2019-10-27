doProvisionHttps(){

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

   #src: https://medium.com/@mightywomble/how-to-set-up-nginx-reverse-proxy-with-lets-encrypt-8ef3fd6b79e5
   sudo certbot --nginx -d dev.qto.fi #todo:ysg fix hardcoded  - add -d tst.qto -d prd.qto -d qto
}
