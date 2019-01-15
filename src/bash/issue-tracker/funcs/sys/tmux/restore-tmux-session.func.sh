# source & courtesy of:
# https://github.com/mislav/dotfiles/blob/master/bin/tmux-session
# TODO: persist and restore_tmux_session the state & position of panes.

dump_tmux_session(){
  local d=$'\t'
  tmux list-windows -a -F "#S${d}#W${d}#{pane_current_path}"
}


doSaveTmuxSession(){
   doCheckTmuxIsInstalled
   dump_tmux_session > ~/.tmux-session
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


doCheckTmuxIsInstalled(){
   which tmux >/dev/null 2>&1 ||
      { doLog "FATAL ERROR - tmux is not installed
         or not in PATH. To install it do run
         sudo apt-get install -y exuberant-ctags
         or
         sudo yum install -y exuberant-ctags
         or
         brew install ctags
         Aborting." >&2; exit 1; }
}


# v1.1.0
# ---------------------------------------------------------
# restores a tmux session
# ---------------------------------------------------------
doRestoreTmuxSession(){
   source "$product_instance_dir/src/bash/$run_unit/funcs/sys/tmux/tmux-common.sh"

   doCheckTmuxIsInstalled

   set +e

   local count=0
   local dimensions="$(terminal_size)"

   while IFS=$'\t' read session_name window_name dir; do
    if [[ -d "$dir" && $window_name != "log" && $window_name != "man" ]]; then
      # echo $session_name -- $window_name
      if session_exists "$session_name"; then
        add_window "$session_name" "$window_name" "$dir"
      else
        new_tmux_session "$session_name" "$window_name" "$dir" "$dimensions"
        count=$(( count + 1 ))
      fi
    fi
   done < ~/.tmux-session

   doLog "restore_tmux_sessiond $count sessions"
   tmux list-sessions | column -t | sort

}
#eof func doRestoreTmuxSession
