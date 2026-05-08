#!/bin/bash
#------------------------------------------------------------------------------
# @description Parses an INI configuration file section and exports key-value pairs as environment variables.
# @description Supports skipping comments and trimming whitespace.
# @param CNF_FILE (required) - Path to the INI configuration file
# @param INI_SECTION (required) - Name of the section to parse (without brackets)
# @example do_parse_ini_section_vars "cnf/qto.dev.host-name.cnf" "MainSection"
# @example do_parse_ini_section_vars "$AWS_SHARED_CREDENTIALS_FILE" "profile default"
# @prereq sed, perl, comm
#------------------------------------------------------------------------------
do_parse_ini_section_vars() {

  cnf_file=$1
  shift 1
  INI_SECTION=$1
  shift 1

  test -z "$cnf_file" && echo " you should set the cnf_file !!!"

  (
    set -o posix
    set
  ) | sort >~/vars.before

  eval $(sed -e 's/[[:space:]]*\=[[:space:]]*/=/g' \
    -e 's/#.*$//' \
    -e 's/[[:space:]]*$//' \
    -e 's/^[[:space:]]*//' \
    -e "s/^\(.*\)=\([^\"']*\)$/export \1=\"\2\"/" \
    <$cnf_file |
    sed -n -e "/^\[$INI_SECTION\]/,/^\s*\[/{/^[^#].*\=.*/p;}")

  # and post-register for nice logging
  (
    set -o posix
    set
  ) | sort >~/vars.after

  echo "INFO added the following vars from section: [$INI_SECTION]"
  comm -3 ~/vars.before ~/vars.after | perl -ne 's#\s+##g;print "\n $_ "'
}
# run-bsh ::: v3.7.0
