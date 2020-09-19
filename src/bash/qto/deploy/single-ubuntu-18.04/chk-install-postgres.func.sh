
do_chk_install_postgres(){

   postgres_repo_url='http://apt.postgresql.org/pub/repos/apt/'
   postgres_repo_fle='/etc/apt/sources.list.d/pgdg.list'

	which psql 2>/dev/null || {
		sudo sh -c 'echo "deb '"$postgres_repo_url"' `lsb_release -cs`-pgdg main" >> '"$postgres_repo_fle"
		wget -q 'https://www.postgresql.org/media/keys/ACCC4CF8.asc' -O - | sudo apt-key add -
		sudo apt-get update

      packages="$(cat << EOF_PACKAGES
         postgresql
         postgresql-contrib
         libpq-dev
         pgadmin3
EOF_PACKAGES
)"
      
      while read -r package ; do 
         sudo apt-get install -y $package 
      done < <(echo "$packages");
	}

	which psql 2>/dev/null || {
		cat << EOF_UNINSTALL
      FATAL failed to install postgres !!! You might have to run those manually
      sudo /etc/init.d/postgresql stop
      sudo /etc/init.d/postgresql status
      sudo dpkg --configure -a
      sudo rm -rf /var/log/postgresql/
      sudo rm -rf /var/lib/postgresql/
      sudo apt-get purge -y remove pgdg-keyring postgresql*
      sudo apt-get -y purge postgresql
      sudo apt-get -y purge postgresql-contrib
      sudo apt-get -y purge libpq-dev
      sudo apt-get -y purge pgadmin3
      sudo apt-get purge -y postgresql-client
      sudo apt-get -y purge psql
EOF_UNINSTALL
      exit 1
	}

	echo "check the postgres version:"
	sudo -u postgres psql postgres -c "SELECT version();" | grep 'PostgreSQL'

   ## ensure the postresql starts on boot 
   sudo update-rc.d postgresql enable

}
