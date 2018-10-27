#!/bin/bash 
# source & courtesy of:
# https://github.com/mislav/dotfiles/blob/master/bin/tmux-session
# TODO: persist and restore_tmux_session the state & position of panes.

dump_tmux_session(){
  local d=$'\t'
  tmux list-windows -a -F "#S${d}#W${d}#{pane_current_path}"
}


doSpecSaveTmuxSession(){
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


doSpecCheckTmuxIsInstalled(){
	which tmux >/dev/null 2>&1 ||
		{ doLog "ERROR. tmux is not installed or not in PATH. Aborting." >&2; exit 1; }
}
