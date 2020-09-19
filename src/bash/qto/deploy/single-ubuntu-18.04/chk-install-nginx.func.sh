do_chk_install_nginx(){

	if [ ! "grep -q nginx /etc/apt/sources.list" ] ;  # check to avoid adding lines multiple times, if this record already exists
	then
		printf "\nAdding nginx repositories to install the latest nginx version.\n\n"
		set -x
		sudo bash -c 'cat >> /etc/apt/sources.list << EOF_NGINX_REPOS
# nginx repos
deb https://nginx.org/packages/ubuntu/ bionic nginx
deb-src https://nginx.org/packages/ubuntu/ bionic nginx
EOF_NGINX_REPOS'

		wget http://nginx.org/keys/nginx_signing.key
		sudo apt-key add nginx_signing.key
		sudo apt-get update
	fi

   test -f /etc/nginx/nginx.conf || sudo apt-get install -y nginx
   test -f /etc/nginx/nginx.conf && sudo cp -v /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

  

}
