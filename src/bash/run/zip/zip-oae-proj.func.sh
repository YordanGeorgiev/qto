#!/bin/bash

#------------------------------------------------------------------------------
# @description Zip oae proj.
#------------------------------------------------------------------------------
do_zip_oae_proj() {

  do_require_var SRC_PROJ ${SRC_PROJ:-$PROJ}
  mkdir -p $SRC_PROJ_PATH/cnf/lst/
  cd $SRC_PROJ_PATH

  # contains the files to be included while packaging
  component_include_list_fle=$SRC_PROJ_PATH/cnf/lst/$SRC_PROJ.include.lst

  zip_file=$SRC_PROJ_PATH.zip
  test -f $zip_file && rm -v $zip_file

  while read -r f; do

    # if the file or symlink still exists in the bigger project add it
    if [ -f "$SRC_PROJ_PATH/$f" ] || [ -L "$SRC_PROJ_PATH/$f" ]; then
      zip -y $zip_file $f
    fi

    # if the file does not exist, remove it from the list file
    test -f $f || perl -pi -e 's|^'"$f"'\n\r||gm' $component_include_list_fle

  done < <(cat $component_include_list_fle)

  do_log "INFO produced the $zip_file file"

  test -f $component_include_list_fle

}
# run-bsh ::: v3.8.2
