#!/bin/bash
# file: src/bash/qto/bootstrap-qto.sh
set -x
set -eu -o pipefail # fail on error , debug all lines
run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
cd $run_unit_bash_dir
for i in {1..3} ; do cd .. ; done ; export PRODUCT_INSTANCE_DIR=`pwd`;
export run_unit=$(echo `basename "$PRODUCT_INSTANCE_DIR"`|cut -d'.' -f1)
export env_type=$(echo `basename "$PRODUCT_INSTANCE_DIR"`|cut -d'.' -f5)

unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
export dir=$PRODUCT_INSTANCE_DIR
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

echo "DO ALWAYS ! GO TO YOUR PRODUCT_INSTANCE_DIR by while working on a qto instance !!!"
echo "cd $PRODUCT_INSTANCE_DIR"
cd $PRODUCT_INSTANCE_DIR

source "$PRODUCT_INSTANCE_DIR/lib/bash/funcs/parse-cnf-env-vars.sh"

cp -v "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type.$host_host_name.cnf" \
      "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type."$(hostname -s)".cnf"

doParseCnfEnvVars "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type."$(hostname -s)".cnf"
echo "doParseCnfEnvVars $PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type.$(hostname -s).cnf" \
   >> /home/usrqtoadmin/.bashrc

bash $PRODUCT_INSTANCE_DIR/src/bash/qto/qto.sh -a restart-postgres
bash $PRODUCT_INSTANCE_DIR/src/bash/qto/qto.sh -a run-pgsql-scripts

latest_dump_uri='https://s3-eu-west-1.amazonaws.com/qto.fi/prd_qto.latest.insrt.dmp.sql'
wget "$latest_dump_uri" -O "$PRODUCT_INSTANCE_DIR/dat/prd_qto.latest.insrt.dmp.sql"

PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -q -t -X -w -U ${postgres_db_useradmin:-} \
   -d $postgres_db_name < "$PRODUCT_INSTANCE_DIR/dat/prd_qto.latest.insrt.dmp.sql"

cd $PRODUCT_INSTANCE_DIR

# eof file src/bash/qto/bootstrap-qto.sh
