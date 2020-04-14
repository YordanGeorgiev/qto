doRestartNetwork(){

	test -z ${USER:-} && export USER=$(echo $HOME|cut -d'/' -f 3)
	test `sudo -n -l -U $USER 2>&1 | egrep -c -i "not allowed to run sudo|unknown user"` -eq 0 \
		|| do_log "FATAL you need to have sudo to run this script !!!"

   sudo /etc/init.d/networking restart

   do_log "INFO start restarting postgres ..."
   sudo sh /etc/init.d/postgresql restart
   do_log "INFO stop  restarting postgres ..."
}
