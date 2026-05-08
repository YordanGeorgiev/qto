#!/bin/bash
#------------------------------------------------------------------------------
# @description Recursively finds and updates all git repositories in the parent directory using rebase.
# @example ./git-pull-rebase-all.sh
# @prereq git, find
#------------------------------------------------------------------------------
    current_dir=$(pwd)/..

    # Find all git repositories and execute git pull --rebase
    find "$current_dir" -type d -name .git | while read -r repo; do
        repo_dir=$(dirname "$repo")
        echo "Updating $repo_dir"
        cd "$repo_dir" || continue
        git pull --rebase
        test "$?" -ne 0 && exit 1
        cd "$current_dir" || return
    done

# run-bsh ::: v3.8.0
