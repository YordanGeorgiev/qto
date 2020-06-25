#!/usr/bin/env bash
# usage:
# bash src/tpl/psql-code-generator/psql-code-generator.sh dev_qto release_issues monthly_issues
#
# check also: https://mojolicious.org/perldoc/Mojo/Template


main(){

   do_print=0 ;  # set to 0 to not print a certain function ...
   do_init "$@"
   do_chk_print_usage "$@"
   do_set_vars "$@"
   do_get_psql_meta_data
   do_print=0; do_print_meta_json_str
   do_print=0; do_build_cols_lst_comma 
   do_print=1; do_build_cols_lst_table_col
   do_print=0; do_build_cols_lst_old
   do_print=0; do_build_cols_lst_new
   do_print=0; do_build_cols_lst_excluded
   do_print=0; do_generate_psql_html_with_perl_code_example
   do_print=1; do_generate_psql_select_all
   do_print=1; do_run_sql=1; do_generate_psql_select_into_another_table
   do_exit 0
}



do_generate_psql_select_into_another_table(){
   msg='generate the select into another table string'

   IFS='' read -r -d '' perl_code <<"EOF_SELECT_INTO_ANOTHER_TABLE_PERL_CODE"
      use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; use JSON; use Data::Printer;use Mojo::Template; use feature ':5.12';
      my $mt = Mojo::Template->new;
      say $mt->render(<<'EOF', $ENV{'postgres_db_name'}, $ENV{'table_name_01'},$ENV{'table_name_02'} , $ENV{'cols_lst_comma'}, $ENV{'cols_lst_excluded'});
      % my ($postgres_db_name, $table_name_01, $table_name_02, $cols_lst_comma, $cols_lst_excluded) = @_;
      INSERT INTO <%= $table_name_02 %>
      ( <%= $cols_lst_comma %> )
      SELECT <%= $cols_lst_comma %>
      FROM <%= $table_name_01 %>
      ON CONFLICT (id) DO UPDATE SET 
      <%= $cols_lst_excluded %>;
EOF

EOF_SELECT_INTO_ANOTHER_TABLE_PERL_CODE

   if [[ $do_print -eq 1 ]]; then
      echo "::: start $msg"
      perl -e "$perl_code" | tee /tmp/$postgres_db_name.select-$table_name_01-into-$table_name_02.sql
      echo -e ":::  stop $msg \n\n"
      if [[ $do_run_sql -eq 1 ]]; then
         PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} \
            --port $postgres_db_port --host $postgres_db_host -t -d ${postgres_db_name:-} \
            < /tmp/$postgres_db_name.select-$table_name_01-into-$table_name_02.sql
      fi
   fi
}


do_generate_psql_select_all(){
   msg='generate the select all string'

   IFS='' read -r -d '' perl_code <<"EOF_SELECT_ALL_PERL_CODE"
      use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; use JSON; use Data::Printer;use Mojo::Template; use feature ':5.12';
      my $mt = Mojo::Template->new;
      say $mt->render(<<'EOF', $ENV{'postgres_db_name'}, $ENV{'table_name_01'}, $ENV{'cols_lst_comma'});
      % my ($postgres_db_name, $table_name_01, $cols_lst_comma) = @_;
      % say "SELECT $cols_lst_comma FROM $postgres_db_name.$table_name_01;"
EOF
EOF_SELECT_ALL_PERL_CODE

   if [[ $do_print -eq 1 ]]; then
      echo "::: start $msg"
      perl -e "$perl_code"
      echo -e ":::  stop $msg \n\n"
   fi
}

# and this is how your generate code in 3 run-times - bash , perl , and Mojo::Template
do_generate_psql_html_with_perl_code_example(){
   msg='generate the perl code'

   IFS='' read -r -d '' perl_code <<"EOF_PERL_CODE"
      use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; use JSON; use Data::Printer;use Mojo::Template; use feature ':5.12';
      my $mt = Mojo::Template->new;
      my $json_var = decode_json($ENV{'meta_json_str'}) ; 
      p $json_var ;
      say $mt->render(<<'EOF', [1 .. 13], 'Hello World!');
      % my ($numbers, $title) = @_;
      <div>
        <h1><%= $title %></h1>
          % for my $i (@$numbers) {
              Test <%= $i %>
          % }
      </div>
EOF
EOF_PERL_CODE

   if [[ $do_print -eq 1 ]]; then
      echo "::: start $msg"
      perl -e "$perl_code"
      echo -e ":::  stop $msg \n\n"
   fi
}


#------------------------------------------------------------------------------
# init the minimal possible amount of vars to even fail properly
#------------------------------------------------------------------------------
do_init(){
   umask 022  ; set -u -o pipefail 
   call_start_dir=`pwd`
   run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   tmp_dir="$run_unit_bash_dir/tmp/.tmp.$$"
   mkdir -p "$tmp_dir"
   ( set -o posix ; set )| sort >"$tmp_dir/vars.before"
   my_name_ext=`basename $0`
   RUN_UNIT=${my_name_ext%.*}
   
   export postgres_db_name=${1:-}
   export table_name_01=${2:-}
   export table_name_02=${3:-}
}

#------------------------------------------------------------------------------
# register and show the run-time vars
#------------------------------------------------------------------------------
do_set_vars(){

   cd $run_unit_bash_dir
   for i in {1..3} ; do cd .. ; done ; export PRODUCT_INSTANCE_DIR=`pwd`;
   environment_name=$(basename "$PRODUCT_INSTANCE_DIR")
   cd $PRODUCT_INSTANCE_DIR
   
   source $PRODUCT_INSTANCE_DIR/.env
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   source $PRODUCT_INSTANCE_DIR/lib/bash/funcs/export-json-section-vars.sh
   
   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"

   if [ "$environment_name" == "$RUN_UNIT" ]; then
      product_dir=$PRODUCT_INSTANCE_DIR
   else
      cd .. ; product_dir=`pwd`;
   fi

   cd .. ; product_base_dir=`pwd`; org_name=$(basename `pwd`)
   
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'
   
   if [[ $do_print -eq 1 ]]; then
      ( set -o posix ; set ) | sort >"$tmp_dir/vars.after"
      echo "INFO using the following vars:"
      cmd="$(comm -3 $tmp_dir/vars.before $tmp_dir/vars.after | perl -ne 's#\s+##g;print "\n $_ "' )"
      echo -e "$cmd"
      do_flush_screen
   fi

}


do_chk_print_usage(){ 

   db=dev_qto
   if [[ -z "${1:-}" || -z "${2:-}" ]]; then
      cat << EOF_USAGE

      psql-code-generator - a script for generating code
      bash $0 <<db-name>> <<table-name>>
      example:
      bash $0 dev_qto release_issues

      example to generate code for all the tables in a db: 
      while read -r t; do $0 dev_qto \$t ; done < <(psql -d dev_qto -t -q -c "SELECT table_name FROM information_schema.tables where 1=1 and table_catalog='dev_qto' and table_schema='public'")

      needless to say anything you print you could append to a file as follows:
      <<command>> | tee -a /tmp/generated-code.sql

EOF_USAGE

   do_exit 1
   fi
}


do_get_psql_meta_data(){
   export meta_json_str=$(PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host -t -d ${postgres_db_name:-} -c "select array_to_json(array_agg(row_to_json(t))) from ( SELECT * from information_schema.columns where 1=1 and table_catalog='"$postgres_db_name"' and table_name='"$table_name_01"') t")
}


do_print_maybe(){
   msg="$1" ; shift
   to_print="$*"
   test $do_print -eq 1 && echo "::: start $msg" && echo $to_print && echo -e "::: stop  $msg \n\n"
}


do_print_meta_json_str(){
   msg='the whole json string'
   test $do_print -eq 1 && echo "::: start $msg"
   test $do_print -eq 1 && echo $meta_json_str|jq -r '.[]'
   test $do_print -eq 1 && echo -e ":::  stop $msg \n\n"
}


do_build_cols_lst_comma(){
   msg='the columns only'
   while read -r c ; do cols_lst_comma="${cols_lst_comma:-} , $c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   export cols_lst_comma=$(echo $cols_lst_comma|cut -c 3-)
   do_print_maybe "$msg" $cols_lst_comma
}

do_build_cols_lst_table_col(){
   msg='the tables and columns only'
   while read -r c ; do cols_lst_table_col="${cols_lst_table_col:-} , $table_name_01.$c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   export cols_lst_table_col=$(echo $cols_lst_table_col|cut -c 3-)
   do_print_maybe "$msg" $cols_lst_table_col
}


do_build_cols_lst_old(){
   msg='the OLD columns list '
   while read -r c ; do cols_lst_old="${cols_lst_old:-}, OLD.$c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   cols_lst_old=$(echo $cols_lst_old|cut -c 3-)
   do_print_maybe "$msg" $cols_lst_old
}


do_build_cols_lst_new(){
   msg='the NEW columns list'
   while read -r c ; do cols_lst_new="${cols_lst_new:-}, NEW.$c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   export cols_lst_new=$(echo $cols_lst_new|cut -c 3-)
   do_print_maybe "$msg" $cols_lst_new
}


do_build_cols_lst_excluded(){
   msg='the excluded columns list '
   while read -r c ; do cols_lst_excluded="${cols_lst_excluded:-}, $c = excluded.$c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   export cols_lst_excluded=$(echo $cols_lst_excluded|cut -c 3-)
   do_print_maybe "$msg" $cols_lst_excluded
}


do_exit(){
   exit_code="$1";shift 
   rm -rf "$run_unit_bash_dir/tmp" #clear the tmpdir
   cd $call_start_dir
   exit $exit_code
}


main "$@"
