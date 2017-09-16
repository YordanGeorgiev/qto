#!/bin/bash

# file: src/bash/aspark-starter/install-prerequisites-for-aspark-starter.sh

set -eu -o pipefail # fail on error , debug all lines
# run as root
[ "$USER" = "root" ] || exec sudo "$0" "$@"

echo "=== $BASH_SOURCE on $(hostname -f) at $(date)" >&2


sudo -n true
test $? -eq 0 || exit 1 "you should have sudo priveledge to run this script"

echo installing the must-have pre-requisites
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
   perl
   zip unzip
   exuberant-ctags
   mutt
   libxml-atom-perl
   postgresql-9.6
   libdbd-pgsql
   curl
   wget
   libwww-curl-perl
EOF
)

echo installing the nice-to-have pre-requisites
echo you have 5 seconds to proceed ...
echo or 
echo hit Ctrl+C to quit
echo -e "\n"
sleep 6

sudo apt-get install -y tig

# eof src/bash/issue-tracker/install-prerequisites-on-ubuntu.sh
