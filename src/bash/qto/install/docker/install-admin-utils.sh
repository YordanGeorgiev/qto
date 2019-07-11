#!/usr/bin/env bash

set -x
unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")

# add the required binaries
apt-get clean && apt-get update && apt-get install -y perl net-tools exuberant-ctags mutt curl wget libwww-curl-perl libtest-www-selenium-perl libdbd-pgsql libxml-atom-perl libxml-atom-perl tar gzip graphviz python-selenium chromium-chromedriver python-selenium python-setuptools python-dev build-essential gpgsm nodejs lsof libssl1.0-dev procps node-gyp nodejs-dev npm
