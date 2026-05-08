#!/bin/bash
#------------------------------------------------------------------------------
# @description Installs one or more packages using apt-get on Ubuntu Linux.
# @param PACKAGES (required) - Space-separated list of package names to install
# @example do_ubuntu_install_bins jq git curl
# @prereq apt-get
#------------------------------------------------------------------------------
do_ubuntu_install_bins() {
  sudo apt-get install -y \
    "$@"
}
# run-bsh ::: v3.7.0
