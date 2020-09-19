#!/bin/bash

encrypt_pass(){
 echo "$1"| perl -ne '$_=crypt($_,$_); s/[#\-%&\$*+()\/]//g; print substr (sprintf("%s%s", $_ , "12?"), 7, 9, "")'
}
c=10
while read -r user; do
	c=$((c+1))
	uid=$((1000+$c))
   echo runnnig sudo useradd -m -d "/home/$user" -s /bin/bash -c "$user" -u $uid -g 1000 $user
   set -x
   sudo useradd -m -d "/home/$user" -s /bin/bash -c "$user" -u $uid -g 1000 $user
   pass=$(encrypt_pass $user)
   sudo bash -c "echo $user:$pass | chpasswd"
	#echo and verify
	sudo cat /etc/passwd | grep --color=always "$user"
   echo "done creating :"
   echo "user: $user"
   echo "pass: $pass"
done < <(echo "$@"|tr ' ' "\n")
