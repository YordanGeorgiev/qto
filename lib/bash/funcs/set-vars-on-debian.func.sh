#!/bin/bash
#------------------------------------------------------------------------------
# @description Sets environment variables specific to Debian Linux.
# @description Currently sets the HOST_NAME environment variable.
# @example do_set_vars_on_debian
#------------------------------------------------------------------------------
do_set_vars_on_debian() {

  # add any debian specific vars settings here
  export HOST_NAME=$(hostname -s)
}
# run-bsh ::: v3.7.0
