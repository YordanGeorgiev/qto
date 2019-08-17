#!/bin/bash
# file: src/bash/qto/bootstrap-qto.sh
set -x
set -eu -o pipefail # fail on error , debug all lines
run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
cd $run_unit_bash_dir
for i in {1..3} ; do cd .. ; done ; export product_instance_dir=`pwd`;
export run_unit=$(echo `basename "$product_instance_dir"`|cut -d'.' -f1)
export env_type=$(echo `basename "$product_instance_dir"`|cut -d'.' -f5)

unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
export dir=$product_instance_dir
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

echo "DO ALWAYS ! GO TO YOUR product_instance_dir by while working on a qto instance !!!"
echo "cd $product_instance_dir"
cd $product_instance_dir

source "$product_instance_dir/lib/bash/funcs/parse-cnf-env-vars.sh"

cp -v "$product_instance_dir/cnf/$run_unit.$env_type.$host_host_name.cnf" \
      "$product_instance_dir/cnf/$run_unit.$env_type."$(hostname -s)".cnf"

doParseCnfEnvVars "$product_instance_dir/cnf/$run_unit.$env_type."$(hostname -s)".cnf"
echo "doParseCnfEnvVars $product_instance_dir/cnf/$run_unit.$env_type.$(hostname -s).cnf" \
   >> /home/usrqtoadmin/.bashrc

bash $product_instance_dir/src/bash/qto/qto.sh -a restart-postgres
bash $product_instance_dir/src/bash/qto/qto.sh -a run-pgsql-scripts

latest_dump_uri='https://s3-eu-west-1.amazonaws.com/qto.fi/prd_qto.latest.insrt.dmp.sql'
wget "$latest_dump_uri" -O "$product_instance_dir/dat/prd_qto.latest.insrt.dmp.sql"

PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -q -t -X -w -U ${postgres_db_useradmin:-} \
   -d $postgres_db_name < "$product_instance_dir/dat/prd_qto.latest.insrt.dmp.sql"

cd $product_instance_dir

# eof file src/bash/qto/bootstrap-qto.sh
