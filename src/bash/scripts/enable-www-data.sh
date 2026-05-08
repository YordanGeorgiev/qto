#!/bin/bash
#------------------------------------------------------------------------------
# @description Enables OS login for the www-data user, sets home directory, and configures permissions.
# @param WWW_PASSWORD (required) - The password to set for the www-data user.
# @example sudo ./enable-www-data.sh "your_secure_password"
# @prereq root privileges, expect, usermod
#------------------------------------------------------------------------------

quit_on() {
    if [ $? -ne 0 ]; then
        echo "FATAL Error: Failed to $1"
        exit 1
    fi
}

usage() {
    echo "Usage: $0 <password>"
    echo "  <password>: The password to set for the www-data user"
    exit 1
}

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

if [ $# -eq 0 ] || [ -z "$1" ]; then
    usage
fi

WWW_PASSWORD="$1"
WWW_HOME="/var/www"

[ ! -d "$WWW_HOME" ] && mkdir -p "$WWW_HOME"

chown www-data:www-data "$WWW_HOME"
quit_on "set the ownership of $WWW_HOME"

chmod 755 "$WWW_HOME"
quit_on "set the permissions on $WWW_HOME"

usermod -d "$WWW_HOME" -s /bin/bash www-data
quit_on "modify the www-data user to allow login and set home directory"

expect << EOF
spawn passwd www-data
expect "New password:"
send "$WWW_PASSWORD\r"
expect "Retype new password:"
send "$WWW_PASSWORD\r"
expect eof
EOF
quit_on "set password for www-data"

#chmod 0440 /etc/sudoers.d/www-data
#quit_on "set permissions on sudoers file"

if [ ! -d "$WWW_HOME/.ssh" ]; then
    mkdir "$WWW_HOME/.ssh"
    quit_on "create .ssh directory"
    chown www-data:www-data "$WWW_HOME/.ssh"
    quit_on "set ownership of .ssh directory"
    chmod 700 "$WWW_HOME/.ssh"
    quit_on "set permissions on .ssh directory"
fi

echo "OS login for www-data has been enabled with home directory set to $WWW_HOME"
echo "Please ensure you have set a strong password and consider using SSH key authentication."

exit 0
# run-bsh ::: v3.8.0
