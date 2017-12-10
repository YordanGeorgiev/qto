#!/bin/bash
# file: src/bash/issue-tracker/install-prerequisites-on-ubuntu.sh

# caveat package names are for Ubuntu !!!
set -eu -o pipefail # fail on error , debug all lines

# run as root
[ "$USER" = "root" ] || exec sudo "$0" "$@"

echo "=== $BASH_SOURCE on $(hostname -f) at $(date)" >&2


echo installing the must-have pre-requisites
while read -r p ; do
	if [ "" == "`which $p`" ];
	then echo "$p Not Found";
		if [ -n "`which apt-get`" ];
		then apt-get install -y $p ;
		elif [ -n "`which yum`" ];
		then yum -y install $p ;
		fi ;
	fi
done < <(cat << "EOF"
	perl
	zip
	unzip
	exuberant-ctags
	mutt
	curl
	wget
	libwww-curl-perl
	postgresql-9.6
	libdbd-pgsql
	libxml-atom-perl
   git
   vim
   libxml-atom-perl
   tar
   gzip
EOF
)

echo installing the nice-to-have pre-requisites
echo you have 5 seconds to proceed ...
echo or
echo hit Ctrl+C to quit
echo -e "\n"
sleep 6

echo installing the nice to-have pre-requisites
while read -r p ; do
	if [ "" == "`which $p`" ];
	then echo "$p Not Found";
		if [ -n "`which apt-get`" ];
		then apt-get install -y $p ;
		elif [ -n "`which yum`" ];
		then yum -y install $p ;
		fi ;
	fi
done < <(cat << "EOF"
	tig
EOF
)

# eof file: src/bash/issue-tracker/install-prerequisites-on-ubuntu.sh
