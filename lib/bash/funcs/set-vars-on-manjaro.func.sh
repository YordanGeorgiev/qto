#!/bin/bash
#------------------------------------------------------------------------------
# @description Sets environment variables specific to Manjaro Linux.
# @description Currently sets the HOST_NAME environment variable.
# @example do_set_vars_on_manjaro
#------------------------------------------------------------------------------
do_set_vars_on_manjaro() {

  # add any manjaro specific vars settings here
  export HOST_NAME="$(hostname -s)"
}
# run-bsh ::: v3.7.0
