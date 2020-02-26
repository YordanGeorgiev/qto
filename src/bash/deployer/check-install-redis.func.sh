# 
do_check_install_redis(){
   
   which redis-cli || {
#      sudo apt-get update
#      sudo apt-get install -y redis-server
#      sudo cp -v /etc/redis/redis.conf /etc/redis/redis.conf.orig
#      sudo systemctl restart redis.service
#      echo 'supervised systemd' | sudo tee -a /etc/redis/redis.conf
#      sudo systemctl restart redis.service

		cd /tmp
		curl -O http://download.redis.io/redis-stable.tar.gz
		tar xzvf redis-stable.tar.gz
		cd redis-stable
		make
		sudo apt-get --purge remove redis-server
		sudo rm -rf /etc/redis/dump.rdb
		make test
		sudo make install
		sudo mkdir /etc/redis
		sudo cp -v /tmp/redis-stable/redis.conf /etc/redis
      echo 'supervised systemd' | sudo tee -a /etc/redis/redis.conf
      my_ip=$(sudo ifconfig eth0 | grep -i 'inet '|awk '{print $2}')
      echo "bind $my_ip" | sudo tee -a /etc/redis/redis.conf
		#sudo vim /etc/redis/redis.conf
      sudo mkdir -p /var/lib/redis/
		ls -al /var/lib/redis/
		sudo ls -al /var/lib/redis/
      sudo mkdir -p /var/log/redis
		sudo chown -R redis:redis /var/log/redis
      sudo chmod -R u+rwX,g+rwX,u+rx /var/log/redis
		sudo cp -v $PRODUCT_DIR/cnf/redis/etc/systemd/system/redis.service /etc/systemd/system/redis.service
		sudo adduser --system --group --no-create-home redis
		sudo chown -R redis:redis /var/lib/redis
		sudo chmod 770 /var/lib/redis
		sudo systemctl start redis
		sudo systemctl status redis
      sudo ps -ef | grep -v grep | grep -i redis
      redis-cli ping
   }
}
