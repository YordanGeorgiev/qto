#!/bin/bash
#------------------------------------------------------------------------------
# @description Sets environment variables specific to CentOS Linux.
# @description Currently sets the HOST_NAME environment variable.
# @example do_set_vars_on_centos
#------------------------------------------------------------------------------
do_set_vars_on_centos(){

   # add any CentOS specific vars settings here
   export HOST_NAME="$(hostname -s)"
}
# run-bsh ::: v3.7.0
