#!/bin/bash
#------------------------------------------------------------------------------
# Purpose:
# to search for a string and replace it with another recursively in a dir
# both in dir and file paths and their contents
# Prerequisites: setting vars in the caller shell
# export dir_to_morph=<<the-dir-to-search-and-replace-in-recursively>>
# export to_srch=<<the-string-to-search-for>>
# export to_repl=<<the-string-to-replace-with>>
# while read -r f ; do cp -v $f $(echo $f|perl -ne 's#func#help#g;print'|perl -ne
# 's#src#doc#g;print'|perl -ne 's#bash#txt#g;print'|perl -ne 's#help.sh#help.txt#g;print') ; done <
# <(find src/bash/run/ -type f)
#------------------------------------------------------------------------------
do_morph_dir(){

  # set -x
  # some initial checks the users should set the vars in their shells !!!
  test -z $dir_to_morph && {
    echo "You must export dir_to_morph=<<the-dir>> - it is empty !!!"; exit 1; }
  test -d $dir_to_morph || {
    echo "The dir to morph : \"$dir_to_morph\" is not a dir !!!"; exit 1; }
  test -z $to_srch && {
    echo "You must export to_srch=<<str-to-search-for>> - it is empty !!!"; exit 1; }
  test -z $to_repl && {
        echo "You must export to_repl=<<str-to-replace-with>> - it is empty !!!";exit 1; }

  do_log "INFO dir_to_morph: $dir_to_morph"
  do_log "INFO to_srch:\"$to_srch\" " ;
  do_log "INFO to_repl:\"$to_repl\" " ;
  sleep 2

  do_log "INFO START :: search and replace in non-binary files"
  #search and replace ONLY in the txt files and omit the binary files
  while read -r file ; do (
    #debug do_log doing find and replace in $file
    do_log "DEBUG working on file: $file"
    do_log "DEBUG searching for $to_srch , replacing with :: $to_repl"

        # we do not want to mess with out .git dir
        # or how-to check that a string contains another string
        case "$file" in
          *.git*)
          continue
          ;;
        esac
    perl -pi -e "s|\Q$to_srch\E|$to_repl|g" "$file"
  );
  done < <(find $dir_to_morph -type f -not -path "*/.venv/*" -not -exec file {} \; | grep text | cut -d: -f1)

  do_log "INFO STOP  :: search and replace in non-binary files"

  #search and repl %var_id% with var_id_val in deploy_tmp_dir
  do_log "INFO search and replace in dir and file paths dir_to_morph:$dir_to_morph"
    # rename the dirs according to the pattern
    while read -r dir ; do (
        echo $dir|perl -nle '$o=$_;s#'"\Q$to_srch\E"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
    );
    done < <(find $dir_to_morph -type d -not -path "*/.venv/*" \
        -not -path "/*node_modules/*" |grep -v '.git')

    # rename the files according to the pattern
    while read -r file ; do (
        echo $file | perl -nle '$o=$_;s|'"\Q$to_srch\E"'|'"$to_repl"'|g;$n=$_;rename($o,$n) unless -e $n ;'
    );
    done < <(find $dir_to_morph -type f -not -path "*/.venv/*" \
        -not -path "*/node_modules/*" |grep -v '.git')

    while read -r dir ; do (
        rm -rv $dir
    );
    done < <(find $dir_to_morph -type d -not -path "*/.venv/*" -not -path "/*node_modules/*" \
        | grep -v '.git'|grep "$to_srch")


    export exit_code=0

}

#eof file: src/bash/run/morph-dir.func.sh
