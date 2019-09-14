# source & courtesy of:
# https://github.com/mislav/dotfiles/blob/master/bin/tmux-session


# v0.5.8
# ---------------------------------------------------------
# restores a tmux session
# ---------------------------------------------------------
doRestoreTmuxSession(){
   source "$PRODUCT_INSTANCE_DIR/src/bash/qto/funcs/sys/tmux/tmux-common.sh"
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

   tmux list-sessions | column -t | sort

}
#eof func doRestoreTmuxSession
