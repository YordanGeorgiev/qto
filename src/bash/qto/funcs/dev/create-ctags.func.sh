# file: src/bash/qto/funcs/dev/create-ctags.func.sh

# v0.8.5
#------------------------------------------------------------------------------
# creates the ctags file for the projet
#------------------------------------------------------------------------------
doCreateCtags(){

	ctags --help >/dev/null 2>&1 ||
	   { do_log "ERROR. ctags is not installed or not in PATH. Aborting." >&2; exit 1; }
	pushd .
	cd $product_instance_dir

	cmd="rm -fv ./tags"                          && doRunCmdAndLog "$cmd"
	cmd="ctags  -R -n --fields=+i+K+S+l+m+a --exclude=.git --exclude=dat --exclude=*/node_modules/* ."   && doRunCmdAndLog "$cmd"
	cmd="ls -la $product_instance_dir/tags"       && doRunCmdAndLog "$cmd"

	popd

}
