# ssh public private key authentication 

ssh-keygen -t rsa -b 4096 -C "yordan@gmail.com"

cat id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
chmod -v 0700 ~/.ssh
chmod -v 0600 ~/.ssh/authorized_keys
chmod -v 0600 ~/.ssh/id_rsa
chmod -v 0644 ~/.ssh/id_rsa.pub
find ~/.ssh -exec stat -c "%U:%G %a %n" {} \;
rm -fv ~/id_rsa.pub
exit
# and verify that you can go on the server without having to type a pass
ssh $ssh_user@$ssh_server
# STOP COPY
# START === how-to implement public private key ( pkk ) authentication 
# create pub priv keys on server
# START copy 
ssh-keygen -t rsa -b 4096 -C "yordan@gmail.com"
ssh-keygen -t rsa
ssh-keygen -t rsa -b 4096 -C "yordan.georgiev@gmail.com" -f ~/.ssh/id_rsa.pub
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
# Hit enter twice 
# copy the rsa pub key to the ssh server
scp ~/.ssh/id_rsa.pub $ssh_user@$ssh_server:/home/$ssh_user/

