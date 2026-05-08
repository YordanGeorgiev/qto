#!/bin/bash
#------------------------------------------------------------------------------
# @description Sets environment variables specific to Alpine Linux.
# @description Currently sets the HOST_NAME environment variable.
# @example do_set_vars_on_alpine
#------------------------------------------------------------------------------
do_set_vars_on_alpine() {

  # add any alpine specific vars settings here
  export HOST_NAME=$(hostname -s)
}
# run-bsh ::: v3.7.0
