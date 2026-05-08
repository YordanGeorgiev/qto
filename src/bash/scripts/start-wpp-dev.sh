#!/bin/bash
#------------------------------------------------------------------------------
# @description Starts PHP-FPM and Nginx services for the WordPress development environment.
# @example ./start-wpp-dev.sh
# @prereq service (sysvinit/systemd), nginx, php7.4-fpm
#------------------------------------------------------------------------------
# export NODE_ENV="development"

# WUI_PROJ_PATH=/opt/csi/wpp/admin-tool-js
# APPUSR=${APPUSR:-wpp}
# SRC_DIR=/home/${APPUSR:-}/opt/csi/wpp/admin-tool-js/src/node_modules
# TGT_DIR="${WUI_PROJ_PATH}/src/node_modules"

# cd $WUI_PROJ_PATH || exit 1
# git config --global --add safe.directory $WUI_PROJ_PATH
# # ensure the apps will be run as non-sudo OS user

# # TODO:uncomment / add configurability for env
# # sudo sed -i "/^$APPUSR ALL=(ALL) NOPASSWD:ALL/d" /etc/sudoers

# cd $WUI_PROJ_PATH
# npm install @beam-australia/react-env && npm install
# npm run dev # start by running the local devevelopment

service php7.4-fpm stop
service php7.4-fpm start

nginx

trap : TERM INT
sleep infinity &
wait
# run-bsh ::: v3.8.0
