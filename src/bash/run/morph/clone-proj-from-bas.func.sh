#!/bin/env bash
#------------------------------------------------------------------------------
# @description Alias of do_clone_proj_from_src_proj kept for historical reasons.
# @param TGT_PATH (required) - Path to the local target module root.
# @param SRC_ORG (required) - Source organization name.
# @param SRC_APP (required) - Source application name.
# @example TGT_PATH=/opt/org/org-app/org-app-utl SRC_ORG=bas SRC_APP=bas-wpb ./run -a do_clone_proj_from_bas
#------------------------------------------------------------------------------
do_clone_proj_from_bas() {
  do_clone_proj_from_src_proj "$@"
}
# run-bsh ::: v3.8.2
