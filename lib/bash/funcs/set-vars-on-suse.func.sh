#!/bin/bash
#------------------------------------------------------------------------------
# @description Sets environment variables specific to SUSE Linux.
# @description Currently sets the HOST_NAME environment variable.
# @example do_set_vars_on_suse
#------------------------------------------------------------------------------
do_set_vars_on_suse() {

  # add any Suse Linux specific vars settings here
  export HOST_NAME="$(cat /proc/sys/kernel/hostname)"
}
# run-bsh ::: v3.7.0
