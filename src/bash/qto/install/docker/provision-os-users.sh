#!/usr/bin/env bash

run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")

# -- start add the qto admin user
sudo groupadd -g "10001" "grpqtoadmin"
sudo cat /etc/group | grep --color "grpqtoadmin"

sudo useradd --uid "10001" --home-dir "/home/usrqtoadmin" --gid "10001" \
   --create-home --shell /bin/bash "usrqtoadmin"
echo "usrqtoadmin:usrqtoadmin" | chpasswd

# obs !! dummy password qto-190616104728
sudo cat /etc/passwd | grep --color "usrqtoadmin"
echo "usrqtoadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' >> /home/usrqtoadmin/.bashrc
cat lib/bash/funcs/parse-cnf-env-vars.sh >> /home/usrqtoadmin/.bashrc

cat $(find cnf -name .vimrc|head -n 1) > /home/usrqtoadmin/.vimrc
mkdir -p /home/usrqtoadmin/opt

# -- start add the qto app user 
sudo groupadd -g "10002" "grpqtoapp"
sudo cat /etc/group | grep --color "grpqtoapp"

sudo useradd --uid "10002" --home-dir "/home/usrqtoapp" --gid "10002" \
   --create-home --shell /bin/bash "usrqtoapp"
echo "usrqtoapp:usrqtoapp" | chpasswd
echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' >> /home/usrqtoapp/.bashrc
cat lib/bash/funcs/parse-cnf-env-vars.sh >> /home/usrqtoapp/.bashrc
cat $(find cnf -name .vimrc | head -n 1) > /home/usrqtoapp/.vimrc
