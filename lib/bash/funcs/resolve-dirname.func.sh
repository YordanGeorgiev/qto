#!/bin/bash
#------------------------------------------------------------------------------
# @description Resolve the absolute path of the directory containing a given file/path.
# @param path (required) - File or directory path to resolve
# @example do_resolve_dirname "/some/relative/../path/file.txt"
#------------------------------------------------------------------------------
do_resolve_dirname() {
  local path_in_the_BASE_PATH="$1"
  perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$path_in_the_BASE_PATH"
}
# run-bsh ::: v3.7.0
