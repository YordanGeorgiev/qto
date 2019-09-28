#how-to add a linux group
export group=staff
export gid=20001
sudo groupadd -g "$gid" "$group"
sudo cat /etc/group | grep --color "$group"

export user=phz
export uid=20001
export home_dir=/home/$user
export desc="the qto user"
#how-to add an user
sudo useradd --uid "$uid" --home-dir "$home_dir" --gid "$group" \
--create-home --shell /bin/bash "$user" \
--comment "$desc"
sudo cat /etc/passwd | grep --color "$user"
groups "$user"


# modify a user
usermod -a -G $group $user

# change the password for the specified user (own password)
passwd $user 
#how-to forces to change password when logging in for the first time
passwd -f login 
#change user pass to expire never 
chage -I -1 -m 0 -M 99999 -E -1 $user
# and check results 
chage -l $user


#Ei should not return anything !!!
passwd -s -a | grep NP (=No Password)

#delete an user
userdel $user
#administer the /etc/group file
gpasswd: 
