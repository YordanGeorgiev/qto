#!/bin/bash
#------------------------------------------------------------------------------
# @description  Recursively morph a directory tree: replace STR_TO_SRCH with STR_TO_REPL in all text file contents, directory names, and file names.
# @description  Safe for strings containing "-": perl \Q\E quoting escapes all regex metacharacters; bash glob treats "-" as literal outside [...].
# @param        DIR_TO_MORPH (required) — root directory to process recursively
# @param        STR_TO_SRCH  (required) — string to search for (supports "-" and other special chars)
# @param        STR_TO_REPL  (required) — string to replace with
# @prereq       perl find file grep
# @example      DIR_TO_MORPH=src/workflows/workflow-01 STR_TO_SRCH=workflow-01 STR_TO_REPL=workflow-02 ./run -a do_morph_dir
# @example      DIR_TO_MORPH=src/sql/td/<REDACTED> STR_TO_SRCH=<REDACTED> STR_TO_REPL=<REDACTED> ./run -a do_morph_dir
#------------------------------------------------------------------------------
do_morph_dir() {
  do_require_bin perl find file grep

  # Validate required variables
  do_require_var DIR_TO_MORPH "$DIR_TO_MORPH"
  do_require_var STR_TO_SRCH "$STR_TO_SRCH"
  do_require_var STR_TO_REPL "$STR_TO_REPL"

  do_log "INFO DIR_TO_MORPH: \"$DIR_TO_MORPH\""
  do_log "INFO STR_TO_SRCH: \"$STR_TO_SRCH\""
  do_log "INFO STR_TO_REPL: \"$STR_TO_REPL\""
  sleep 1

  # ============================================================================
  # STEP 1: Replace in file contents (text files only)
  # ============================================================================
  do_log "INFO START :: search and replace in non-binary files"

  while read -r file; do
    # Skip excluded directories
    case "$file" in
      *.git* | *node_modules* | *.venv*)
        continue
        ;;
    esac

    do_log "DEBUG replacing in file: $file"
    # Use perl for reliable cross-platform search/replace
    perl -pi -e "s|\Q$STR_TO_SRCH\E|$STR_TO_REPL|g" "$file"

  done < <(find "$DIR_TO_MORPH" -type f \
    -not -path "*/.venv/*" \
    -not -path "*/.git/*" \
    -not -path "*/node_modules/*" \
    -exec file {} \; | grep -E 'text|ASCII' | cut -d: -f1)

  do_log "INFO STOP  :: search and replace in non-binary files"

  # ============================================================================
  # STEP 2: Rename directories (deepest first to avoid path issues)
  # ============================================================================
  do_log "INFO START :: rename directories containing '$STR_TO_SRCH'"

  # Use -depth to process deepest directories first
  while read -r dir; do
    # Skip excluded directories
    case "$dir" in
      *.git* | *node_modules* | *.venv*)
        continue
        ;;
    esac

    # Only process if directory name contains search string
    dirname=$(basename "$dir")
    if [[ "$dirname" == *"$STR_TO_SRCH"* ]]; then
      newdirname="${dirname//$STR_TO_SRCH/$STR_TO_REPL}"
      parentdir=$(dirname "$dir")
      newpath="$parentdir/$newdirname"

      if [[ "$dir" != "$newpath" ]] && [[ ! -e "$newpath" ]]; then
        do_log "DEBUG renaming dir: $dir -> $newpath"
        mv "$dir" "$newpath"
      fi
    fi

  done < <(find "$DIR_TO_MORPH" -depth -type d \
    -not -path "*/.venv/*" \
    -not -path "*/.git/*" \
    -not -path "*/node_modules/*" \
    -name "*$STR_TO_SRCH*" 2>/dev/null)

  do_log "INFO STOP  :: rename directories"

  # ============================================================================
  # STEP 3: Rename files
  # ============================================================================
  do_log "INFO START :: rename files containing '$STR_TO_SRCH'"

  while read -r file; do
    # Skip excluded directories
    case "$file" in
      *.git* | *node_modules* | *.venv*)
        continue
        ;;
    esac

    filename=$(basename "$file")
    if [[ "$filename" == *"$STR_TO_SRCH"* ]]; then
      newfilename="${filename//$STR_TO_SRCH/$STR_TO_REPL}"
      parentdir=$(dirname "$file")
      newpath="$parentdir/$newfilename"

      if [[ "$file" != "$newpath" ]] && [[ ! -e "$newpath" ]]; then
        do_log "DEBUG renaming file: $file -> $newpath"
        mv "$file" "$newpath"
      fi
    fi

  done < <(find "$DIR_TO_MORPH" -type f \
    -not -path "*/.venv/*" \
    -not -path "*/.git/*" \
    -not -path "*/node_modules/*" \
    -name "*$STR_TO_SRCH*" 2>/dev/null)

  do_log "INFO STOP  :: rename files"
  do_log "INFO DONE  :: morph complete for $DIR_TO_MORPH"

}
# run-bsh ::: v3.8.2
