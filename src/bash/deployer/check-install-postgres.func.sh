
do_check_install_postgres(){

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
		echo "FATAL failed to install postgres !!!" ; exit 1
	}

	echo "check the postgres version:"
	sudo -u postgres psql postgres -c "SELECT version();" | grep 'PostgreSQL'

   ## ensure the postresql starts on boot 
   sudo update-rc.d postgresql enable

}
