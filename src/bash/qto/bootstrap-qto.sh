#!/bin/bash
# file: src/bash/qto/bootstrap-qto.sh

set -eu -o pipefail # fail on error , debug all lines
# uncomment the next line if you have bootstraping problems and sent it to me
# set -eux -o pipefail # fail on error , debug all lines

run_unit='qto'
run_unit_type='dev'
run_unit_owner='usrqtoadmin'
unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
product_base_dir=$(cd $unit_run_dir/../../../..; echo `pwd`)
product_dump_dir=$(cd $unit_run_dir/../../..; echo `pwd`)
product_dir="$product_base_dir/csitea/$run_unit" 
product_tmp_install_dir="$product_base_dir"/"$run_unit"'-tmp-install'
cd "$product_dump_dir"
run_unit_ver=$(git tag|sort -nr|head -n 1) || run_unit_ver='0.6.5'
product_instance_dir="$product_dir"'/'"$run_unit"'.'"$run_unit_ver"'.'"$run_unit_type"'.'"$run_unit_owner"

mkdir -p "$product_dir" ; cd $_
# each product instance has name, version, environment type and a single person as the owner
mv -v $product_dump_dir "$product_instance_dir"; cd $product_instance_dir
# START -- search and replace recursively 
export dir=.
export to_srch="host-name"
export to_repl="$(hostname -s)"

#-- search and replace in file and dir paths excludding the .git dir
find "$dir/"  -not -path "./.git/*" -type d |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
find "$dir/"  -not -path "./.git/*" -type f |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'

#-- search and replace in file contents excludging the .git dir
find "$dir/" -not -path "./.git/*" -type f -exec perl -pi -e "s#$to_srch#$to_repl#g" {} \;
find "$dir/" -not -path "./.git/*" -type f -name '*.bak' | xargs rm -f

# START === create symlink to the executing user's ~/opt/csitea
export link_path=/opt/csitea
export tgt_path=~/opt/csitea
mkdir -p `dirname "$link_path"`
test -L "$link_path" && unlink "$link_path"
sudo ln -s "$tgt_path" "$link_path"
ls -la $link_path; 
# STOP === create symlink

#-- search and replace in file contents excludging the .git dir
find "$dir/" -not -path "./.git/*" -type f -exec perl -pi -e "s#$to_srch#$to_repl#g" {} \;
find "$dir/" -not -path "./.git/*" -type f -name '*.bak' | xargs rm -f

export to_srch='use Any::Moose;'
export to_repl="
no warnings 'deprecated' ;
use Any::Moose;
use warnings 'deprecated' ;
"
while read -r f ; do sudo perl -pi -e 's/'"$to_srch"'/'"$to_repl"'/g' $f ; \
   done < <(find /usr/local -name OAuth2.pm)

# set a default .vimrc
test -f ~/.vimrc && cp -v ~/.vimrc ~/.vimrc.$(date "+%Y%m%d_%H%M%S").bak
cp -v $(find $product_instance_dir/cnf/hosts/ -name '.vimrc') ~/.vimrc

psql_cnf_dir='/etc/postgresql/11/main'
test -f $psql_cnf_dir/pg_hba.conf && \
   sudo cp -v $psql_cnf_dir/pg_hba.conf $psql_cnf_dir/pg_hba.conf.orig.bak && \
   sudo cp -v $(find $product_instance_dir/cnf -name pg_hba.conf) $psql_cnf_dir/pg_hba.conf

test -f $psql_cnf_dir/postgresql.conf && \
   sudo cp -v $psql_cnf_dir/postgresql.conf $psql_cnf_dir/postgresql.conf.orig && \
   sudo cp -v $(find $product_instance_dir/cnf -name postgresql.conf) $psql_cnf_dir/postgresql.conf

echo "DO ALWAYS ! GO TO YOUR product_instance_dir by while working on a qto instance !!!"
echo "cd $product_instance_dir"
cd $product_instance_dir

# eof file src/bash/qto/bootstrap-qto.sh
