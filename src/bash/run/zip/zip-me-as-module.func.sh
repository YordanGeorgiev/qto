#!/bin/bash

#------------------------------------------------------------------------------
# @description Zip me as module.
#------------------------------------------------------------------------------
do_zip_me_as_module() {

  mkdir -p $PROJ_PATH/cnf/lst/
  cd $PROJ_PATH
  DEFAULT_MODULE=$(basename $PROJ_PATH)
  MODULE=${MODULE:-$DEFAULT_MODULE}  # Set MODULE explicitly
  do_require_var MODULE ${MODULE:-}

  # contains the files to be included while packaging
  component_include_list_fle=$PROJ_PATH/cnf/lst/$MODULE.include.lst
  do_log "INFO using the following include file: $component_include_list_fle"
  test -f $component_include_list_fle
  quit_on "the list file containing the relative file paths to include: $component_include_list_fle does not exist !!!"

  zip_file=$PROJ_PATH.zip
  test -f $zip_file && rm -v $zip_file

  while read -r f; do

    # if the file or symlink still exists in the bigger project add it
    if [ -f "$PROJ_PATH/$f" ] || [ -L "$PROJ_PATH/$f" ]; then
      zip -y $zip_file $f
    fi

    # if the file does not exist, remove it from the list file
    test -f $f || perl -pi -e 's|^'"$f"'\n\r||gm' $component_include_list_fle

  done < <(cat $component_include_list_fle)

  do_log "INFO produced the $zip_file file"

  test -f $component_include_list_fle

}
# run-bsh ::: v3.8.2
