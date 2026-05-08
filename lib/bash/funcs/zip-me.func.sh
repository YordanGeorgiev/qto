#!/bin/bash
#------------------------------------------------------------------------------
# @description Zips the current directory into a zip file named after the directory.
# @description The zip file is created in the parent directory.
# @description Excludes common development directories: .git, .terraform, .venv, node_modules.
# @example do_zip_me
# @prereq zip
#------------------------------------------------------------------------------
do_zip_me() {

  # remove any pre-existing zip file
  test -f ../$(basename $(pwd)).zip && rm -v ../$(basename $(pwd)).zip

  # zip everything except the .git, .terraform, .venv and node_modules dirs
  zip -r ../$(basename $(pwd)).zip . -x '.git/*' -x '*/.terraform/*' -x '*/.venv/*' -x '*/node_modules/*' --symlinks
  rv=$?

  echo -e "\n\n to unzip run the following cmd:"
  echo -e "\n mkdir -p /tmp/whatever-tgt_dir ; unzip -o $(
    cd ..
    echo $(pwd)
  )/$(basename $(pwd)).zip -d /tmp/whatever-tgt_dir \n\n"

  export EXIT_CODE=$rv

}
# run-bsh ::: v3.7.0
