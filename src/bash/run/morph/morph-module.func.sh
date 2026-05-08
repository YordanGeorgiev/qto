#!/bin/bash
#------------------------------------------------------------------------------
# @description Creates a morphed clone of a source module by renaming strings
# @description and directory/file paths.
# @param SRC_MODULE (required) - The name of the source module.
# @param TGT_MODULE (required) - The name of the target module.
# @example SRC_MODULE=run.sh TGT_MODULE=foo-bar ./run -a do_morph_module
#------------------------------------------------------------------------------
do_morph_module() {
  do_require_var SRC_MODULE ${SRC_MODULE:-}
  do_require_var TGT_MODULE ${TGT_MODULE:-}

  do_morph_dir() {
    # set -x
    # some initial checks the users should set the vars in their shells !!!
    do_require_var DIR_TO_MORPH $DIR_TO_MORPH
    do_require_var STR_TO_SRCH $STR_TO_REPL
    do_require_var STR_TO_REPL $STR_TO_REPL

    do_log "INFO DIR_TO_MORPH: \"$DIR_TO_MORPH\" "
    do_log "INFO STR_TO_SRCH:\"$STR_TO_REPL\" "
    do_log "INFO STR_TO_REPL:\"$STR_TO_REPL\" "
    sleep 2

    do_log "INFO START :: search and replace in non-binary files"
    #search and replace ONLY in the txt files and omit the binary files
    while read -r file; do
      (
        #debug do_log doing find and replace in $file
        do_log "DEBUG working on file: $file"
        # do_log "DEBUG searching for $STR_TO_REPL , replacing with :: $STR_TO_REPL"

        # we do not want to mess with out .git dir
        # or how-to check that a string contains another string
        case "$file" in
        *.git* | *node_modules* | *.venv*)
          continue
          ;;
        esac
        perl -pi -e "s|\Q$STR_TO_REPL\E|$STR_TO_REPL|g" "$file"
        sed -i '' -e 's/$STR_TO_REPL/$STR_TO_REPL/g' "$file"
      )
    done < <(find $DIR_TO_MORPH -type f -not -path "*/*.venv/*" -not -path "*/*.git/*" -not -path "*/*node_modules/*" -exec file {} \; | grep text | cut -d: -f1)

    do_log "INFO STOP  :: search and replace in non-binary files"

    #search and repl %var_id% with var_id_val in deploy_tmp_dir
    do_log "INFO search and replace in dir and file paths DIR_TO_MORPH:$DIR_TO_MORPH"
    # rename the dirs according to the patter
    while read -r dir; do
      (
        # we do not want to mess with out .git dir
        # or how-to check that a string contains another string
        case "$file" in
        *.git* | *node_modules* | *.venv*)
          continue
          ;;
        esac
        echo $dir | perl -nle '$o=$_;s#'"\Q$STR_TO_REPL\E"'#'"$STR_TO_REPL"'#g;$n=$_;`mkdir -p $n` ;'
        find $dir -depth -name '*'$STR_TO_REPL'*' -execdir bash -c 'for file; do mv -- "$file" "${file//'$STR_TO_REPL'/'$STR_TO_REPL'}"; done' bash {} +
      )
    done < <(find $DIR_TO_MORPH -type d -not -path "*/*.venv/*" -not -path "*/*.git/*" -not -path "*/*node_modules/*")

    # rename the files according to the pattern
    while read -r file; do
      (
        echo $file | perl -nle '$o=$_;s|'"\Q$STR_TO_REPL\E"'|'"$STR_TO_REPL"'|g;$n=$_;rename($o,$n) unless -e $n ;'
      )
    done < <(find $DIR_TO_MORPH -type f -not -path "*/*.venv/*" -not -path "*/*.git/*" -not -path "*/*node_modules/*")

    export EXIT_CODE=0

  }


  # mkdir -p $APP_PATH/$TGT_MODULE ; cd $APP_PATH/$TGT_MODULE
  test -d $APP_PATH/$TGT_MODULE && rm -r $APP_PATH/$TGT_MODULE
  mkdir -p $APP_PATH/$TGT_MODULE
  cd $_
  sudo chmod 0775 src/bash/run/run.sh
  ln -sfn src/bash/run/run.sh run
  unzip -o $APP_PATH/$SRC_MODULE.zip -d .
  cp -v $PROJ_PATH/cnf/lst/$SRC_MODULE.include.lst $APP_PATH/$TGT_MODULE/cnf/lst/$TGT_MODULE.include.lst
  cp -v $PROJ_PATH/cnf/lst/$SRC_MODULE.exclude.lst $APP_PATH/$TGT_MODULE/cnf/lst/$TGT_MODULE.exclude.lst

  # Action !!! do search and replace src & tgt module into the new dir
  test $SRC_MODULE != 'run.sh' && STR_TO_SRCH=$SRC_MODULE STR_TO_REPL=$TGT_MODULE DIR_TO_MORPH=$APP_PATH/$TGT_MODULE do_morph_dir

  SRC_MODULE_UNDERSCORED=$(echo ${SRC_MODULE:-} | perl -ne 's|-|_|g;print')
  TGT_MODULE_UNDERSCORED=$(echo ${TGT_MODULE:-} | perl -ne 's|-|_|g;print')
  do_log DEBUG SRC_MODULE_UNDERSCORED: $SRC_MODULE_UNDERSCORED
  do_log DEBUG TGT_MODULE_UNDERSCORED: $TGT_MODULE_UNDERSCORED
  sleep 1

  # Action !!! do search and replace src & tgt module into the new dir UNDERSCORED
  test $SRC_MODULE != 'run.sh' && STR_TO_SRCH=$SRC_MODULE_UNDERSCORED STR_TO_REPL=$TGT_MODULE_UNDERSCORED DIR_TO_MORPH=$APP_PATH/$TGT_MODULE do_morph_dir

  cd $APP_PATH/$TGT_MODULE
  test -f run && rm -v run
  ln -sfn src/bash/run/run.sh run

  cd $PROJ_PATH

  EXIT_CODE="0"
}
# run-bsh ::: v3.8.2
