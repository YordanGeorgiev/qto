#!/usr/bin/env bash
# purpose: just list all the postgres tables sorted in the terminal
# you might wanto to adjust the 11- bellow 
clear ; psql -d qto -t -c '\dt' | cut -c 11- | perl -ne 's/^([a-z_0-9]*)( )(.*)/$1/; print '


