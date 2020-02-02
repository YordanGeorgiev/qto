# 
do_check_install_redis(){
   
   which redis-cli || {
      sudo apt-get update
      sudo apt-get install redis-server
      sudo cp -v /etc/redis/redis.conf /etc/redis/redis.conf.orig
      sudo systemctl restart redis.service
      echo 'supervised systemd' | sudo tee -a /etc/redis/redis.conf
      sudo systemctl restart redis.service
      sudo ps -ef | grep -v grep | grep -i redis
      redis-cli ping
   }
}
