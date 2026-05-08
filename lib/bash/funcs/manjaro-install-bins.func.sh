#!/bin/bash
#------------------------------------------------------------------------------
# @description Installs one or more packages using pacman on Manjaro Linux.
# @param PACKAGES (required) - Space-separated list of package names to install
# @example do_manjaro_install_bins jq git curl
# @prereq pacman
#------------------------------------------------------------------------------
do_manjaro_install_bins() {
  sudo pacman -S --noconfirm \
    "$@"
}
# run-bsh ::: v3.7.0
