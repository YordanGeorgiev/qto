#!/bin/bash

#------------------------------------------------------------------------------
# @description Zip till commit.
#------------------------------------------------------------------------------
do_zip_till_commit() {

  do_require_var COMMIT "${COMMIT:-}"
  do_require_var TGT_PROJ_PATH "${TGT_PROJ_PATH:-}"

  cd "${TGT_PROJ_PATH:-}" || do_log "FATAL cannot cd to TGT_PROJ_PATH: ${TGT_PROJ_PATH:-}"
  cd "${TGT_PROJ_PATH:-}" || exit 1

  git stash
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  zip_name=$(basename "${TGT_PROJ_PATH:-}")

  test -f ../$zip_name.zip && rm -v ../$zip_name.zip

  while read -r c; do
    c=$(echo "$c" | xargs)
    if [ "$c" == "$COMMIT" ]; then
      git checkout $c
      while read -r f; do
        test "$f" == 'src/bash/run/zip-till-commit.func.sh' && continue
        zip -y ../"$zip_name".zip "$f" -x './.git/*'
      done < <(git show --pretty="" --name-only "$c")
    fi

  done < <(git log --date=iso --pretty --format="%h")

  git checkout $current_branch
  git stash pop


}
# run-bsh ::: v3.8.2
