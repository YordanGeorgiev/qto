#!/bin/bash
# call-by: 

test $1 == '--usage' && cat << EOF_CALL_ME
perl src/bash/qto/scripts/web-to-db-upsert.sh \
   'https://qto.fi:442/qto/select/monthly_issues_202003?oa=prio&as=grid&with=id-eq-200322150540' \
   monthly_issues_202003
EOF_CALL_ME
test $1 == '--usage' && exit 0

#https://qto.fi:442/qto/select/monthly_issues_202003?oa=prio&as=grid&with=id-eq-200322150540' | jq
url=$1
export json_str=$(curl -s -b ~/.qto/cookies.txt "$url" | jq -r '.dat')
export itm=$2

curl -s -b ~/.qto/cookies.txt "$url" | jq -r '.dat'

echo $json_str
IFS='' read -r -d '' perl_code <<"EOF_PERL_CODE"
      use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; 
      use JSON; use Data::Printer;use Mojo::Template; use feature ':5.12';
      my $json_var = decode_json($ENV{'json_str'}) ; 
      my $itm = $ENV{'itm'};
      p $json_var ;
      my $col_lst = '(';
      my $val_lst = '(';
      my $upd_lst = '';
      my $sql_lst = '';
      foreach my $row (@$json_var){
         #p $row ; 
         foreach my $key (keys %$row) {
            $col_lst .= $key . ', ' ;
            $upd_lst .= $key . ' = ' . "'" . $row->{$key} . "'" . ', ';
            $val_lst .= "'" . $row->{$key} . "'" . ', ' ;
         }
         $col_lst = substr($col_lst, 0,-2); $col_lst .= ')'; 
         $upd_lst = substr($upd_lst, 0,-2); 
         $val_lst = substr($val_lst, 0,-2); $val_lst .= ')';
         $sql_lst .= "INSERT INTO $itm $col_lst VALUES $val_lst ON CONFLICT (id) DO UPDATE SET $upd_lst; ";
         $col_lst = '(';
         $val_lst = '(';
         $upd_lst = '';
      }
      #p $col_lst ; p $val_lst ; 
      my $mt = Mojo::Template->new;
      say $mt->render(<<'EOF', $sql_lst, $col_lst,$val_lst, $upd_lst, $ENV{'col_lst_excluded'});
      % my ($sql_lst, $col_lst, $val_lst, $upd_lst, $col_lst_excluded) = @_;
      <%= $sql_lst %>
EOF


EOF_PERL_CODE

sql_code=$(perl -e "$perl_code")
echo $sql_code
         PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-} \
            --port $postgres_db_port --host $postgres_db_host -t -d ${postgres_db_name:-} \
            -c "$sql_code"
