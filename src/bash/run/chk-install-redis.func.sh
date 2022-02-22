# 
do_chk_install_redis(){
   
   which redis-cli || {
      sudo apt-get update
      sudo adduser --system --group --no-create-home redis
      sudo apt-get install -y redis-server

      sudo mkdir -p /var/lib/redis/
      sudo chown -R redis:redis /var/lib/redis
      sudo chmod 770 /var/lib/redis
      sudo cp -v /etc/redis/redis.conf /etc/redis/redis.conf.orig

      # capture the first ip address into a var to add the the bind directive
      export my_ip=$(hostname -I|awk '{print $1}')

      # append the following lines to the /etc/redis/redis.conf file
      echo "bind $my_ip"| sudo tee -a /etc/redis/redis.conf
      echo 'supervised systemd' | sudo tee -a /etc/redis/redis.conf

      # comment out the bind directive, having it bound on 127.0.0.1 breaks Redis
      sudo perl -pi -e 's/bind 127.0.0.1 ::1/# bind 127.0.0.1 ::1/ig' /etc/redis/redis.conf
      while read -r file ; do
         IFS='' read -r -d '' perl_code <<"EOF_PERL_CODE"
            use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; use JSON; use Data::Printer;
            my $my_ip = $ENV{'my_ip'};
            my $sjson;
            {
              local $/; open my $fh, "<", $ARGV[0];
              $sjson = <$fh>; close $fh;
            }
            my $data = decode_json($sjson);
            #p $data ; 
            $data->{'env'}->{'redis'}->{'server'} = $my_ip; 
            my $json = JSON->new->allow_nonref;
            open my $fh, ">", $ARGV[0];
            print $fh $json->pretty->encode($data);
            close $fh;
EOF_PERL_CODE
      
         perl -e "$perl_code" $file
	   done < <(find $PRODUCT_DIR/cnf/env/ -type f| grep -v '.bak')

      # restart to apply the changes 
      sudo systemctl restart redis
      sudo systemctl restart redis.service

      # check that redis is running
      sudo ps -ef | grep -v grep | grep -i redis

      # should return PONG
      redis-cli ping
   }
}
