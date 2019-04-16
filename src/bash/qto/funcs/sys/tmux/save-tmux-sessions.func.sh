doSaveTmuxSessions(){
  source "$product_instance_dir/src/bash/qto/funcs/sys/tmux/tmux-common.sh"
  doCheckTmuxIsInstalled
  local d=$'\t'
  tmux list-windows -a -F "#S${d}#W${d}#{pane_current_path}" > ~/.tmux-session
}

