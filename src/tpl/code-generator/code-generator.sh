#!/bin/bash
# usage: bash src/tpl/code-generator/code-generator.sh dev_qto release_issues monthly_issues
# chk also: https://mojolicious.org/perldoc/Mojo/Template


main(){

   do_chk_print_usage "$@"
   do_set_vars "$@"
   do_get_meta_data
   do_print_meta_json
   do_print_cols_only
   do_print_old_cols_list
   do_print_new_cols_list
   do_print_excluded_cols_list
   #do_generate_html_with_perl_code_example
   do_generate_select_all
   do_generate_select_into_another_table

}

do_generate_select_into_another_table(){
   msg='generate the select into another table string'
   echo "::: start $msg"

   IFS='' read -r -d '' perl_code <<"EOF_SELECT_INTO_ANOTHER_TABLE_PERL_CODE"
      use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; use JSON; use Data::Printer;use Mojo::Template; use feature ':5.12';
      my $mt = Mojo::Template->new;
      say $mt->render(<<'EOF', $ENV{'postgres_db_name'}, $ENV{'table_name_01'},$ENV{'table_name_02'} , $ENV{'cols_comma_lst'}, $ENV{'cols_excluded_lst'});
      % my ($postgres_db_name, $table_name_01, $table_name_02, $cols_comma_lst, $cols_excluded_lst) = @_;
      INSERT INTO <%= $table_name_02 %>
      ( <%= $cols_comma_lst %> )
      SELECT <%= $cols_comma_lst %>
      FROM <%= $table_name_01 %>
      ON CONFLICT (id) DO UPDATE SET 
      <%= $cols_excluded_lst %>;
EOF

EOF_SELECT_INTO_ANOTHER_TABLE_PERL_CODE

   perl -e "$perl_code" | tee /tmp/$postgres_db_name.select-$table_name_01-into-$table_name_02.sql
   echo -e ":::  stop $msg \n\n"
}


do_generate_select_all(){
   msg='generate the select all string'
   echo "::: start $msg"

   IFS='' read -r -d '' perl_code <<"EOF_SELECT_ALL_PERL_CODE"
      use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; use JSON; use Data::Printer;use Mojo::Template; use feature ':5.12';
      my $mt = Mojo::Template->new;
      say $mt->render(<<'EOF', $ENV{'postgres_db_name'}, $ENV{'table_name_01'}, $ENV{'cols_comma_lst'});
      % my ($postgres_db_name, $table_name_01, $cols_comma_lst) = @_;
      % say "SELECT $cols_comma_lst FROM $postgres_db_name.$table_name_01;"
EOF
EOF_SELECT_ALL_PERL_CODE

   perl -e "$perl_code"
   echo -e ":::  stop $msg \n\n"
}


do_generate_html_with_perl_code_example(){
   msg='generate the perl code'
   echo "::: start $msg"

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

   perl -e "$perl_code"
   echo -e ":::  stop $msg \n\n"
}


#------------------------------------------------------------------------------
# usage example:
# doExportJsonSectionVars cnf/env/dev.env.json '.env.app'
#------------------------------------------------------------------------------
doExportJsonSectionVars(){

   json_file="$1"
   shift 1;
   test -f "$json_file" || doExit 1 "the json_file: $json_file does not exist !!! Nothing to do"

   section="$1"
   test -z "$section" && echo "the section in doExportJsonSectionVars is empty !!! nothing to do !!!"
   shift 1;

   while read -r l ; do
     key=$(echo $l|cut -d'=' -f1)
     val=$(echo $l|cut -d'=' -f2)
     eval "$(echo -e 'export '$key=\"\"$val\"\")"
   done < <(cat "$json_file"| jq -r "$section"'|keys_unsorted[] as $key|"\($key)=\"\(.[$key])\""')
}


#------------------------------------------------------------------------------
# register and show the run-time vars
#------------------------------------------------------------------------------
do_set_vars(){
   umask 022  ; set -u -o pipefail 
   call_start_dir=`pwd`
   run_unit_bash_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
   tmp_dir="$run_unit_bash_dir/tmp/.tmp.$$"
   mkdir -p "$tmp_dir"
   ( set -o posix ; set )| sort >"$tmp_dir/vars.before"
   my_name_ext=`basename $0`
   RUN_UNIT=${my_name_ext%.*}
   export postgres_db_name=$1
   export table_name_01=$2
   export table_name_02=$3

   cd $run_unit_bash_dir
   for i in {1..3} ; do cd .. ; done ; export PRODUCT_INSTANCE_DIR=`pwd`;
   environment_name=$(basename "$PRODUCT_INSTANCE_DIR")
   cd $PRODUCT_INSTANCE_DIR
   source $PRODUCT_INSTANCE_DIR/.env
   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"

   if [ "$environment_name" == "$RUN_UNIT" ]; then
      product_dir=$PRODUCT_INSTANCE_DIR
   else
      cd .. ; product_dir=`pwd`;
   fi

   cd .. ; product_base_dir=`pwd`; org_name=$(basename `pwd`)
   doExportJsonSectionVars $PROJ_CONF_FILE '.env.db'
   ( set -o posix ; set ) | sort >"$tmp_dir/vars.after"
   echo "INFO using the following vars:"
   cmd="$(comm -3 $tmp_dir/vars.before $tmp_dir/vars.after | perl -ne 's#\s+##g;print "\n $_ "' )"
   echo -e "$cmd"

   clearTheScreen
}


do_chk_print_usage(){ 

   if [[ -z "$1" || -z "$2" ]]; then
      cat << EOF_USAGE

      code-generator - a script for generating code
      bash $0 <<db-name>> <<table-name>>
      example:
      bash $0 dev_qto release_issues

EOF_USAGE

   exit 1
   fi
}


do_get_meta_data(){
   #set -x
   export meta_json_str=$(PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} --port $postgres_db_port --host $postgres_db_host -t -d ${postgres_db_name:-} -c "select array_to_json(array_agg(row_to_json(t))) from ( SELECT * from information_schema.columns where 1=1 and table_catalog='"$postgres_db_name"' and table_name='"$table_name_01"') t")
}


do_print_meta_json(){
   msg='the whole json string'
   echo "::: start $msg"
   echo $meta_json_str|jq -r '.[]'
   echo -e ":::  stop $msg \n\n"
}


do_print_cols_only(){
   msg='the columns only'
   echo "::: start $msg"
   while read -r c ; do cols_comma_lst="${cols_comma_lst:-} , $c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   export cols_comma_lst=$(echo $cols_comma_lst|cut -c 3-)
   echo $cols_comma_lst
   echo -e ":::  stop $msg \n\n"
}


do_print_old_cols_list(){
   msg='the OLD columns list '
   #echo "::: start $msg"
   while read -r c ; do cols_old_lst="${cols_old_lst:-}, OLD.$c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   cols_old_lst=$(echo $cols_old_lst|cut -c 3-)
   #echo $cols_old_lst
   #echo -e ":::  stop $msg \n\n"
}


do_print_new_cols_list(){
   msg='the NEW columns list'
   #echo "::: start $msg"
   while read -r c ; do cols_new_lst="${cols_new_lst:-}, NEW.$c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   export cols_new_lst=$(echo $cols_new_lst|cut -c 3-)
   #echo $cols_new_lst
   #echo -e ":::  stop $msg \n\n"
}


do_print_excluded_cols_list(){
   msg='the excluded columns list '
   #echo "::: start $msg"
   while read -r c ; do cols_excluded_lst="${cols_excluded_lst:-}, $c = excluded.$c" ; done < <(echo $meta_json_str|jq -r '.[]|.column_name')
   export cols_excluded_lst=$(echo $cols_excluded_lst|cut -c 3-)
   #echo $cols_excluded_lst
   #echo -e ":::  stop $msg \n\n"
}


clearTheScreen(){
	printf "\033[2J";printf "\033[0;0H"
}


main "$@"
