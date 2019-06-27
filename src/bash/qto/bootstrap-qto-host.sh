#!/bin/bash
# file: src/bash/qto/bootstrap-qto.sh

set -eu -o pipefail # fail on error , debug all lines
# uncomment the next line if you have bootstraping problems and sent it to me
# set -eux -o pipefail # fail on error , debug all lines

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
product_instance_dir="$product_dir"'/'"$run_unit"'.'"$run_unit_ver"'.'"$run_unit_type"'.'"$run_unit_owner"

mkdir -p "$product_dir" ; cd $_
# each product instance has name, version, environment type and a single person as the owner
mv -v $product_dump_dir "$product_instance_dir"; cd $product_instance_dir
# START -- search and replace recursively 
export dir=.
export to_srch="phzs-MacBook-Pro"
export to_repl="$(hostname -s)"

#-- search and replace in file and dir paths excludding the .git dir
find "$dir/"  -not -path "./.git/*" -type d |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
find "$dir/"  -not -path "./.git/*" -type f |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'

#-- search and replace in file contents excludging the .git dir
find "$dir/" -not -path "./.git/*" -type f -exec perl -pi -e "s#$to_srch#$to_repl#g" {} \;
find "$dir/" -not -path "./.git/*" -type f -name '*.bak' | xargs rm -f

echo "GO TO YOUR product_instance_dir by"
echo "cd $product_instance_dir"
cd $product_instance_dir

# eof file src/bash/qto/bootstrap-qto.sh
