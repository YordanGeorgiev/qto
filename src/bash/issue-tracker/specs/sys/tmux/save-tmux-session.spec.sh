#!/bin/bash 
# source & courtesy of:
# https://github.com/mislav/dotfiles/blob/master/bin/tmux-session
# TODO: persist and restore_tmux_session the state & position of panes.


doSpecSaveTmuxSession(){
	doCheckTmuxIsInstalled
 	dump_tmux_session > ~/.tmux-session
}


