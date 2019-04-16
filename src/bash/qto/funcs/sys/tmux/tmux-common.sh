doCheckTmuxIsInstalled(){
   which tmux >/dev/null 2>&1 ||
      { doLog "FATAL ERROR - tmux is not installed
         or not in PATH. To install it do run
         sudo apt-get install -y tmux
         or
         sudo yum install -y tmux
         or
         brew install tmux
         Aborting." >&2; exit 1; }
}


terminal_size(){
  stty size 2>/dev/null | awk '{ printf "-x%d -y%d", $2, $1 }'
}

session_exists(){
  tmux has-session -t "$1" 2>/dev/null
}

add_window(){
  tmux new-window -d -t "$1:" -n "$2" -c "$3"
}


new_tmux_session(){
  cd "$3" &&
  tmux new-session -d -s "$1" -n "$2" $4
}
