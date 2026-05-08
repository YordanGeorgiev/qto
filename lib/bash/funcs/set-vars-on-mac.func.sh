#!/bin/bash
#------------------------------------------------------------------------------
# @description Sets environment variables specific to macOS.
# @description Currently sets the HOST_NAME environment variable.
# @example do_set_vars_on_mac
#------------------------------------------------------------------------------
do_set_vars_on_mac() {

  # add any mac OS specific vars settings here
  export HOST_NAME=$(hostname -s)
}
# run-bsh ::: v3.7.0
