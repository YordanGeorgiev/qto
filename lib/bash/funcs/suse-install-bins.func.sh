#!/bin/bash
#------------------------------------------------------------------------------
# @description Installs one or more packages using zypper on SUSE Linux.
# @param PACKAGES (required) - Space-separated list of package names to install
# @example do_suse_install_bins jq git curl
# @prereq zypper
#------------------------------------------------------------------------------
do_suse_install_bins() {
  zypper install -y \
    "$@"
}
# run-bsh ::: v3.7.0
