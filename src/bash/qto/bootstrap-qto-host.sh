#!/bin/bash

set -eu -o pipefail 

RUN_UNIT='qto'
run_unit_owner=$USER || exit 1
unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
product_base_dir=$(cd $unit_run_dir/../../../..; echo `pwd`)
product_dir="$product_base_dir/$RUN_UNIT" 
product_tmp_install_dir="$product_base_dir"/""'-tmp-install'
source "$product_dir/.env"
PRODUCT_INSTANCE_DIR="$product_dir/$RUN_UNIT.$VERSION.$ENV_TYPE.$run_unit_owner"

test -d "$PRODUCT_INSTANCE_DIR" && \
   mv -v "$PRODUCT_INSTANCE_DIR" "$PRODUCT_INSTANCE_DIR"."$(date '+%Y%m%d_%H%M%S')"

mv -v "$product_dir" "$product_dir"'_'
mkdir -p "$product_dir" ;  mv -v "$product_dir"'_' "$PRODUCT_INSTANCE_DIR"; 

cp -v $PRODUCT_INSTANCE_DIR/cnf/git/hooks/* $PRODUCT_INSTANCE_DIR/.git/hooks/
chmod 770 $PRODUCT_INSTANCE_DIR/.git/hooks/*

echo "GO TO YOUR PRODUCT_INSTANCE_DIR by"
echo "cd $PRODUCT_INSTANCE_DIR"
cd $PRODUCT_INSTANCE_DIR

# eof file src/bash/qto/bootstrap-qto.sh
