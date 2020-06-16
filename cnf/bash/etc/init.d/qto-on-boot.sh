#!/usr/bin/env bash

# Some things that run always
export QTO_NO_AUTH=0
export QTO_JWT_AUTH=1

case "$1" in
	start)
   	echo "Starting qto "
		/bin/bash /home/ubuntu/opt/qto/qto.0.8.5.dev.ubuntu@qto.fi/src/bash/qto/qto.sh -a mojo-hypnotoad-start &
		/bin/bash /home/ubuntu/opt/qto/qto.0.8.5.tst.ubuntu@qto.fi/src/bash/qto/qto.sh -a mojo-hypnotoad-start &
		/bin/bash /home/ubuntu/opt/qto/qto.0.8.5.prd.ubuntu@qto.fi/src/bash/qto/qto.sh -a mojo-hypnotoad-start &
    ;;
  stop)
		/bin/bash /home/ubuntu/opt/qto/qto.0.8.5.dev.ubuntu@qto.fi/src/bash/qto/qto.sh -a mojo-hypnotoad-stop &
		/bin/bash /home/ubuntu/opt/qto/qto.0.8.5.tst.ubuntu@qto.fi/src/bash/qto/qto.sh -a mojo-hypnotoad-stop &
		/bin/bash /home/ubuntu/opt/qto/qto.0.8.5.prd.ubuntu@qto.fi/src/bash/qto/qto.sh -a mojo-hypnotoad-stop &
    ;;
  status)
		sudo ps -ef | grep -i qto
    ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    cat << "EOF_ECHO"
      # ---------------------------------------------------
      the sipmliest possible start / stop app script on boot / reboot / shutdown 
      stolen from : https://unix.stackexchange.com/a/57032/37428
      ls -la /etc/init.d/qto-on-boot.sh
      #  -rwxr-x--- 1 root root 947 May 17 15:34 /etc/init.d/qto-on-boot.sh
      # to install : 
      sudo cp -v cnf/bash/etc/init.d/qto-on-boot.sh /etc/init.d/
      sudo update-rc.d qto-on-boot.sh defaults
EOF_ECHO
    exit 1
    ;;
esac

exit 0
