#!/usr/bin/env bash

# start install perl modules
wget - http://cpanmin.us | perl - --self-upgrade

# src: http://stackoverflow.com/a/13090364/65706src: 
# echo y|cpan
# echo o conf prerequisites_policy follow | cpan
# echo o conf commit | cpan

#bash -c " -s 'curl -L cpanmin.us | perl - Mojolicious'"
# cpan Mojolicious
# stop install perl modules

