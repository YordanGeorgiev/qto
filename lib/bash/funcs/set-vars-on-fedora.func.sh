#!/bin/bash
#------------------------------------------------------------------------------
# @description Sets environment variables specific to Fedora Linux.
# @description Currently sets the HOST_NAME environment variable.
# @example do_set_vars_on_fedora
#------------------------------------------------------------------------------
do_set_vars_on_fedora() {

  # add any fedora specific vars settings here
  export HOST_NAME="$(hostname -s)"
}
# run-bsh ::: v3.7.0
