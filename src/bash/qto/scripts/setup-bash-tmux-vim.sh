#!/bin/bash
# purpose: a SLIGHTLY opinionated bash,tmux,vim and git setup 
# usage:
# curl https://raw.githubusercontent.com/YordanGeorgiev/qto/master/src/bash/qto/scripts/pre-push/setup-bash-n-vim.sh | bash -s yordan.georgiev@gmail.com ysg

main(){
   do_enable_locate
   do_set_vars
   do_provision_tmux
   do_provision_vim
   do_provision_git
   do_provision_ssh_keys
	do_fake_history
   do_provision_bash
	do_echo_copy_pasteables
}


do_enable_locate(){
   sudo updatedb & # because of the locate elflord.vim bellow and just to speed up..
}


do_set_vars(){
	email=${1:-yordan.georgiev@gmail.com}
	my_initials=${1:-ysg}
   host_name=`hostname -s`
}


do_provision_tmux(){

   echo 'start ::: provisioning tmux'
   which tmux 2>/dev/null || {
      sudo apt-get update
      sudo apt-get install -y tmux
   }
   mkdir -p ~/.tmux/plugins
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tmux-copycat
   echo verify the tmux plugins
   find ~/.tmux/plugins -type d -maxdepth 2

   test -f ~/.tmux.conf && cp -v ~/.tmux.conf ~/.tmux.conf.$(date "+%Y%m%d_%H%M%S")
   wget -O ~/.tmux.conf \
      https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/.tmux.conf.host-name
   echo 'stop  ::: provisioning tmux'

}


do_provision_vim(){

   echo 'start ::: provisioning vim'
   which vim 2>/dev/null || {
      sudo apt-get update
      sudo apt-get install -y vim
   }
   which wget 2>/dev/null || {
      sudo apt-get update
      sudo apt-get install -y wget
   }
   test -f ~/.vimrc && cp -v ~/.vimrc ~/.vimrc.$(date "+%Y%m%d_%H%M%S")
   wget -O ~/.vimrc 'https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/.vimrc.host-name'

   # set the ngix syntax highlighting 
   mkdir -p ~/.vim/syntax/
   cd ~/.vim/syntax/
   wget http://www.vim.org/scripts/download_script.php?src_id=19394
   mv download_script.php\?src_id\=19394 nginx.vim
   cat > ~/.vim/filetype.vim <<EOF_NGINX
   au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
EOF_NGINX

   # add the perl.vim
   mkdir -p ~/.vim/ftplugin
   wget -O ~/.vim/ftplugin/perl.vim \
      'https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/.vim/ftplugin/perl.vim'

   # add the smartcom 
   mkdir -p ~/.vim/plugin
   wget -O ~/.vim/plugin/smartcom.vim \
      'https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/.vim/plugin/smartcom.vim'

   sudo cp -rv ~/.vim/ /root/
   cd -

   # set the grey color on the nums on the left ...
   sudo perl -pi -e \
      '$_="$_\nhi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE"
      if $. == 27' $(locate elflord.vim) &
   echo 'stop ::: provisioning vim'

}


do_provision_git(){

   echo 'start ::: provisioning git'
   test -f ~/.gitconfig && cp -v ~/.gitconfig ~/.gitconfig.$(date "+%Y%m%d_%H%M%S")

cat << EOF_GIT >> ~/.gitconfig

   [credential]
     helper = cache

   [core]
     editor = vim
     pager = less -r
     autocrlf = false

   [user]
      name = Yordan Georgiev
      email = $email

   [push]
      default = simple
      followTags = true

   [color]
     diff = auto
     status = auto
     branch = auto
     interactive = auto
     ui = true
     pager = true

   [color "status"]
     added = green
     changed = red bold
     untracked = magenta bold

   [color "branch"]
     remote = yellow

   [fetch]
      prune = true
EOF_GIT

   echo 'stop ::: provisioning git'

}


do_provision_ssh_keys(){

   which expect || sudo apt-get update && sudo apt-get install -y expect

   # if the ssh key does not exist create it ...
   test -f ~/.ssh/id_rsa.ysg.pub.`hostname -s` || {
   expect <<- EOF_EXPECT
      set timeout -1
      spawn ssh-keygen -t rsa -b 4096 -C $email -f $HOME/.ssh/id_rsa.ysg.$host_name
      expect "Enter passphrase (empty for no passphrase): "
      send -- "\r"
		expect "Enter same passphrase again: "
      send -- "\r"
      expect eof
EOF_EXPECT

   }

}

do_provision_bash(){

   echo 'start ::: fetching bash_opts'
   wget -O ~/.bash_opts.`hostname -s` \
      'https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/.bash_opts.host-name'

   echo 'stop  ::: fetching bash_opts'

}


do_fake_history(){

	cat << 'EOF_HIS' >> ~/.bash_history
ssh-keygen -t rsa -b 4096 -C "yordan.georgiev@gmail.com" -f ~/.ssh/id_rsa.ysg.`hostname -s`
clear ; git log --pretty --format='%h %<(15)%ae %<(15)%an ::: %s'
alias git='GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.ysg.`hostname -s`" git'
git add --all ; git commit -m "$git_msg" --author "Yordan Georgiev <yordan.georgiev@gmail.com"; git push
git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
curr_branch=$(git rev-parse --abbrev-ref HEAD); git branch "$curr_branch"--$(date "+%Y%m%d_%H%M"); git branch -a | grep $curr_branch | sort -nr | less
EOF_HIS

}


do_echo_copy_pasteables(){
	cat ~/.ssh/id_rsa.ysg.$host_name.pub
	echo EOF ~/.ssh/id_rsa.ysg.$host_name.pub
	echo -e '\n\n'
   echo "source ~/.bash_opts.$host_name"
	echo -e '\n\n'
}


main # and .... Action !!!

# here is your parameter expansions cheat ;o) 
# +--------------------+----------------------+-----------------+-----------------+
# |                    |       parameter      |     parameter   |    parameter    |
# |                    |   Set and Not Null   |   Set But Null  |      Unset      |
# +--------------------+----------------------+-----------------+-----------------+
# | ${parameter:-word} | substitute parameter | substitute word | substitute word |
# | ${parameter-word}  | substitute parameter | substitute null | substitute word |
# | ${parameter:=word} | substitute parameter | assign word     | assign word     |
# | ${parameter=word}  | substitute parameter | substitute null | assign word     |
# | ${parameter:?word} | substitute parameter | error, exit     | error, exit     |
# | ${parameter?word}  | substitute parameter | substitute null | error, exit     |
# | ${parameter:+word} | substitute word      | substitute null | substitute null |
# | ${parameter+word}  | substitute word      | substitute word | substitute null |
# +--------------------+----------------------+-----------------+-----------------+
