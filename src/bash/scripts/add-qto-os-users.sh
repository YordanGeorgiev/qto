#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo $(date "+%F %T")' FATAL: you must be the root to run this script! Exiting ...' 1>&2
   exit 1
fi

sudo userdel usrqtoapp
sudo userdel usrqtoadmin
sudo groupdel grpqtoadmin
sudo groupdel grpqtoapp

# -- start add the qto os level application user
sudo groupadd -g "10010" "grpqtoadmin"
sudo cat /etc/group | grep --color "grpqtoadmin"

sudo useradd --uid "10010" --home-dir "/home/usrqtoadmin" --gid "10001" \
   --create-home --shell /bin/bash "usrqtoadmin"
sudo -H -u usrqtoadmin bash -c 'echo '\''export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "'\'' >> /home/usrqtoadmin/.bashrc'
sudo echo "usrqtoadmin:usrqtoadmin" | chpasswd
sudo cat /etc/passwd | grep --color "usrqtoadmin"
# add the usrqtoadmin to the sudoers 
sudo echo "usrqtoadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# -- stop add the qto os level application user


sudo groupadd -g "10011" "grpqtoapp"
sudo cat /etc/group | grep --color "grpqtoapp"

sudo useradd --uid "10011" --home-dir "/home/usrqtoapp" --gid "10002" \
   --create-home --shell /bin/bash "usrqtoapp"
sudo -H -u usrqtoapp bash -c 'echo '\''export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "'\'' >> /home/usrqtoapp/.bashrc'
echo "usrqtoapp:usrqtoapp" | chpasswd
sudo cat /etc/passwd | grep --color "usrqtoapp"
