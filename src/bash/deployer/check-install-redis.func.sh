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
		sudo cp /tmp/redis-stable/redis.conf /etc/redis
		sudo vim /etc/redis/redis.conf
		ls -al /var/lib/redis/
		sudo ls -al /var/lib/redis/
		fg
		sudo vim /etc/systemd/system/redis.service
		sudo adduser --system --group --no-create-home redis
		sudo chown -R redis:redis /var/lib/redis
		sudo chmod 770 /var/lib/redis
		sudo systemctl start redis
		sudo systemctl status redis
      sudo ps -ef | grep -v grep | grep -i redis
      redis-cli ping
   }
}
