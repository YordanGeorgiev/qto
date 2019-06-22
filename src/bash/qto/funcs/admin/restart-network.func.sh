doRestartNetwork(){

   # do not run if no passwordless sudo of the running usr ...
   timeout 2 sudo id || doExit 1 \
      "you need to have sudo to able to restart the network !!!"

   doLog "INFO start restarting network ..."
   sudo /etc/init.d/networking restart
   doLog "INFO stop  restarting network."
   
   doLog "INFO start restarting postgres ..."
   sudo sh /etc/init.d/postgresql restart
   doLog "INFO stop  restarting postgres ..."
}
