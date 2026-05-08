#!/bin/bash
#------------------------------------------------------------------------------
# @description Sets environment variables specific to Ubuntu Linux.
# @description Currently sets the HOST_NAME environment variable.
# @example do_set_vars_on_ubuntu
#------------------------------------------------------------------------------
do_set_vars_on_ubuntu() {

  # add any ubuntu specific vars settings here
  export HOST_NAME=$(hostname -s)
}
# run-bsh ::: v3.7.0
