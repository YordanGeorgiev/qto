#!/bin/bash
#------------------------------------------------------------------------------
# @description Search-and-replace a token across both file contents and file
# @description names within a target directory tree. Skips .git, node_modules,
# @description .venv and any patterns listed in cnf/lst/${PROJ}.exclude.lst.
# @description Binary files are not edited (filtered via `grep -I`); they are
# @description still renamed if their filename matches.
# @param STR_TO_SRCH (required) - The string to search for (literal, regex-quoted).
# @param STR_TO_REPL (required) - The string to replace with.
# @param TGT_PATH    (required) - The target directory path to morph in.
# @example STR_TO_SRCH=run-bsh STR_TO_REPL=doc-gen TGT_PATH=/opt/csi/doc-gen \
# @example   ./run -a do_morph_path
#------------------------------------------------------------------------------
do_morph_path() {
  do_require_var STR_TO_SRCH "${STR_TO_SRCH:-}"
  do_require_var STR_TO_REPL "${STR_TO_REPL:-}"
  do_require_var TGT_PATH    "${TGT_PATH:-}"

  local exclude_file="${PROJ_PATH}/cnf/lst/${PROJ}.exclude.lst"
  local -a exclude_patterns=()
  if [[ -f "$exclude_file" ]]; then
    while IFS= read -r line; do
      [[ -n "$line" && "$line" != \#* ]] && exclude_patterns+=(-not -path "*${line}*")
    done < <(grep -Ev '^[[:space:]]*$|^[[:space:]]*#' "$exclude_file")
  fi
  exclude_patterns+=(-not -path '*/.git/*' -not -path '*/node_modules/*' -not -path '*/.venv/*')

  do_log "INFO morph contents:  ${STR_TO_SRCH} -> ${STR_TO_REPL}  in ${TGT_PATH}"
  # Portable in-place edit (works on Linux + macOS): perl -pi.
  # `grep -I` skips binaries; `-l` lists matching files; `-F` literal string.
  find "$TGT_PATH" "${exclude_patterns[@]}" -type f -exec grep -IlF "$STR_TO_SRCH" {} + 2>/dev/null \
    | while IFS= read -r f; do
        perl -pi -e "s|\Q${STR_TO_SRCH}\E|${STR_TO_REPL}|g" "$f"
      done

  do_log "INFO morph filenames: ${STR_TO_SRCH} -> ${STR_TO_REPL}  in ${TGT_PATH}"
  # -depth so leaves are renamed before their parents. Pass tokens as env vars
  # so the inner shell sees them via parameter substitution (no quoting hell).
  STR_TO_SRCH="$STR_TO_SRCH" STR_TO_REPL="$STR_TO_REPL" \
  find "$TGT_PATH" "${exclude_patterns[@]}" -depth -name "*${STR_TO_SRCH}*" \
    -execdir bash -c '
      for f in "$@"; do
        mv -- "$f" "${f//${STR_TO_SRCH}/${STR_TO_REPL}}"
      done
    ' _ {} +

  export EXIT_CODE=0
}
# run-bsh ::: v3.8.2
