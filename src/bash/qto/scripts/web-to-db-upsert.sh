#!/usr/bin/env bash

if [ \( "$1" = '--usage' \) -o \( "$1" = '' \) -o \( "$1" = '--help' \) ]
then
   source $PRODUCT_DIR/lib/bash/funcs/flush-screen.sh
   do_flush_screen
   
   url='https://qto.fi:442/qto/select/monthly_issues_202005?oa=prio&with=app_users_guid-eq-02d16010-20af-4b0d-be86-cdf116a7d8c7'
   tgt_table='monthly_issues_202005'
   cat << EOF_PRINT_USAGE

   $0
   Purpose: 
   --------------------------------------------------------
   upsert qto http json data to postgres db

   USAGE EXAMPLE:
   --------------------------------------------------------
  
   url='https://qto.fi:442/qto/select/monthly_issues_202005'
   tgt_table=monthly_issues_202005
   bash $0 \$url \$tgt_table


EOF_PRINT_USAGE
   exit 1
fi

#https://qto.fi:442/qto/select/monthly_issues_202005?oa=prio' | jq
url=$(echo $1|perl -ne 's|\/list|/select|g;print') # copy list from browser but use select for data
echo $url
#curl -s -b ~/.qto/cookies.txt "$url"
#sleep 3
export json_str=$(curl -s -b ~/.qto/cookies.txt "$url" | jq -r '.dat')
export itm=$2

curl -s -b ~/.qto/cookies.txt "$url" | jq -r '.dat'

echo $json_str
IFS='' read -r -d '' perl_code <<"EOF_PERL_CODE"
      use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; 
      use JSON; use Data::Printer;use Mojo::Template; use feature ':5.12';
      my $json_var = decode_json($ENV{'json_str'}) ; 
      my $itm = $ENV{'itm'};
      #p $json_var ;
      my $col_lst = '(';
      my $val_lst = '(';
      my $upd_lst = '';
      my $sql_lst = '';
      foreach my $row (@$json_var){
         #p $row ; 
         foreach my $key (keys %$row) {
            my $cll = $row->{$key} ;
            $cll = '' if ($cll eq 'null' or !defined($cll));
            $cll =~ s/'/''/g;
            $cll =~ s/\\n/\\\n/g;
            $col_lst .= $key . ', ' ;
            $upd_lst .= $key . ' = ' . "'" . $cll . "'" . ', ';
            $val_lst .= "'" . $cll . "'" . ', ' ;
         }
         $col_lst = substr($col_lst, 0,-2); $col_lst .= ')'; 
         $upd_lst = substr($upd_lst, 0,-2); 
         $val_lst = substr($val_lst, 0,-2); $val_lst .= ')';
         $sql_lst .= "INSERT INTO $itm $col_lst VALUES $val_lst ON CONFLICT (id) DO UPDATE SET $upd_lst; ";
         $col_lst = '(';
         $val_lst = '(';
         $upd_lst = '';
      }
      #p $col_lst ; 
      #p $val_lst ; 
      my $mt = Mojo::Template->new;
      say $mt->render(<<'EOF', $sql_lst, $col_lst,$val_lst, $upd_lst, $ENV{'col_lst_excluded'});
      % my ($sql_lst, $col_lst, $val_lst, $upd_lst, $col_lst_excluded) = @_;
      <%= $sql_lst %>
EOF


EOF_PERL_CODE

#echo $perl_code
#echo eof perl_code
sql_code=$(perl -e "$perl_code")
echo $sql_code
PGPASSWORD=${postgres_sys_usr_admin_pw:-} psql -v -t -X -w -U ${postgres_sys_usr_admin:-} \
            --port $postgres_rdbms_port --host $postgres_rdbms_host -t -d ${postgres_app_db:-} \
            -c "$sql_code"
