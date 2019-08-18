#!/bin/bash
# file: src/bash/qto/bootstrap-qto.sh

set -eu -o pipefail # fail on error , debug all lines

run_unit='qto'
run_unit_type='dev'
run_unit_owner=$USER || 'ysg'
unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
product_base_dir=$(cd $unit_run_dir/../../../..; echo `pwd`)
product_dump_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
product_dir="$product_base_dir/csitea/$run_unit" 
product_tmp_install_dir="$product_base_dir"/"$run_unit"'-tmp-install'
cd "$product_dump_dir"
run_unit_ver=$(git tag|sort -nr|head -n 1) || run_unit_ver='0.1.9'
PRODUCT_INSTANCE_DIR="$product_dir"'/'"$run_unit"'.'"$run_unit_ver"'.'"$run_unit_type"'.'"$run_unit_owner"

mkdir -p "$product_dir" ; cd $_
# each product instance has name, version, environment type and a single person as the owner
mv -v $product_dump_dir "$PRODUCT_INSTANCE_DIR"; cd $PRODUCT_INSTANCE_DIR
# START -- search and replace recursively 

for env in `echo dev tst prd `; do
   cp -v "$PRODUCT_INSTANCE_DIR/cnf/tpl/qto.$env.p-host-name.cnf" \
         "$PRODUCT_INSTANCE_DIR/cnf/qto.$env."$(hostname -s)".cnf"
   cp -v "$PRODUCT_INSTANCE_DIR/cnf/tpl/qto.$env.v-host-name.cnf" \
         "$PRODUCT_INSTANCE_DIR/cnf/qto.$env."$(hostname -s)".cnf"
done

export dir=.
export to_srch="p-host-name"
export to_repl="$(hostname -s)"

#-- search and replace in file and dir paths excludding the .git dir
find "$dir/"  -not -path "./.git/*" -type d |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
find "$dir/"  -not -path "./.git/*" -type f |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'

#-- search and replace in file contents excludging the .git dir
find "$dir/" -not -path "./.git/*" -type f -exec perl -pi -e "s#$to_srch#$to_repl#g" {} \;
find "$dir/" -not -path "./.git/*" -type f -name '*.bak' | xargs rm -f

echo "GO TO YOUR PRODUCT_INSTANCE_DIR by"
echo "cd $PRODUCT_INSTANCE_DIR"
cd $PRODUCT_INSTANCE_DIR

# eof file src/bash/qto/bootstrap-qto.sh
