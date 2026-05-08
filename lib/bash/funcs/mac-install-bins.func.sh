#!/bin/bash
#------------------------------------------------------------------------------
# @description Installs one or more packages using Homebrew on macOS.
# @param PACKAGES (required) - Space-separated list of package names to install
# @example do_mac_install_bins jq git curl
# @prereq brew
#------------------------------------------------------------------------------
do_mac_install_bins() {
  brew install \
    "$@"
}
# run-bsh ::: v3.7.0
