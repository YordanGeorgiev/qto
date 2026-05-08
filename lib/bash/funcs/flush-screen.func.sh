#!/bin/bash
#------------------------------------------------------------------------------
# @description Clear the terminal screen and move cursor to top-left position.
#------------------------------------------------------------------------------
do_flush_screen() {
  printf "\033[2J"
  printf "\033[0;0H"
}
# run-bsh ::: v3.7.0
