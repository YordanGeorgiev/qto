#!/bin/bash
# purpose: a SLIGHTLY opinionated bash,tmux,vim and git setup 
# usage:
# curl https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/src/bash/min-shell-bootstrapper/setup-bash-n-vim.sh | bash -s yordan.georgiev@gmail.com

main(){
	do_enable_locate
	do_set_vars "$@"
	do_chk_provision_tmux
	do_chk_provision_vim
	do_chk_provision_git
	do_chk_provision_ssh_keys
	do_fake_history
	do_chk_provision_bash
	do_echo_copy_pasteables
}

do_print_usage(){

cat << EOF_USAGE 
	curl <<url>> | bash -s <<email>>
EOF_USAGE

}

do_enable_locate(){
   sudo updatedb & # because of the locate elflord.vim bellow and just to speed up..
}


# echo pass params and print them to a log file and terminal
# usage:
# do_log "INFO some info message"
# do_log "DEBUG some debug message"
#------------------------------------------------------------------------------
do_log(){
   type_of_msg=$(echo $*|cut -d" " -f1)
   msg="$(echo $*|cut -d" " -f2-)"
   [[ -t 1 ]] && echo " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [min-shell-bootstrapper][@$host_name] [$$] $msg "
   log_dir="$PROJ_INSTANCE_DIR/dat/log/bash" ; mkdir -p $log_dir && log_file="$log_dir/min-shell-bootstrapper.`date "+%Y%m"`.log"
   printf " [$type_of_msg] `date "+%Y-%m-%d %H:%M:%S %Z"` [min-shell-bootstrapper][@$host_name] [$$] $msg " >> $log_file
}

# ------------------------------------------------------------------------------
# clean and exit with passed status and message
# call by:
# do_exit 0 "ok msg"
# do_exit 1 "NOK msg"
# ------------------------------------------------------------------------------
do_exit(){
   exit_code=$1 ; shift
   exit_msg="$*"

   if (( ${exit_code:-} != 0 ));
   then
      exit_msg=" ERROR --- exit_code $exit_code --- exit_msg : $exit_msg"
      >&2 printf "$exit_msg"
      do_log "FATAL STOP min-shell-bootstrapper RUN with: "
      do_log "FATAL exit_code: $exit_code exit_msg: $exit_msg"
   else
      do_log "INFO STOP min-shell-bootstrapper RUN with: "
      do_log "INFO STOP FOR min-shell-bootstrapper min-shell-bootstrapper RUN: $exit_code $exit_msg"
   fi

   exit $exit_code
}


do_set_vars(){
	set -u -o pipefail
	email=${1:-}; shift
	export host_name="$(hostname -s)"
	export PROJ_INSTANCE_DIR=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
	test -z ${email:-} && do_exit 1 "YOU MUST specify an email adress"

}


do_chk_provision_tmux(){

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


do_chk_provision_vim(){

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


do_chk_provision_git(){

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


do_chk_provision_ssh_keys(){

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

do_chk_provision_bash(){

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


main "$@" # and .... Action !!!

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
