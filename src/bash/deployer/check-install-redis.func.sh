# 
do_check_install_redis(){
   
   which redis-cli || {
      sudo apt-get update
      sudo adduser --system --group --no-create-home redis
      sudo apt-get install -y redis-server

      sudo mkdir -p /var/lib/redis/
		sudo chown -R redis:redis /var/lib/redis
		sudo chmod 770 /var/lib/redis
      sudo cp -v /etc/redis/redis.conf /etc/redis/redis.conf.orig

      # capture the first ip address into a var to add the the bind directive
      my_ip=$(hostname -I|awk '{print $1}')

      # append the following lines to the /etc/redis/redis.conf file
      echo "bind $my_ip"| sudo tee -a /etc/redis/redis.conf
      echo 'supervised systemd' | sudo tee -a /etc/redis/redis.conf

      # uncomment out the ip6 bind directive, it brakes the redis
      perl -pi -e 's/bind 127.0.0.1 ::1/#bind 127.0.0.1 ::1/g' /etc/redis/redis.conf

      # restart to apply the changes 
		sudo systemctl restart redis
      sudo systemctl restart redis.service
		sudo systemctl status redis

      # check that redis is running
      sudo ps -ef | grep -v grep | grep -i redis

      # should return PONG
      redis-cli ping
   }
}
