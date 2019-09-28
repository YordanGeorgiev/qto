doScrambleConfs(){

   while read -r file ; do
      cp -v $file $file.bak
		script=$(cat <<'EOF'
			use strict; use warnings; binmode STDOUT, ":utf8"; use utf8; use JSON; use Data::Printer;
			sub rndStr{ join'', @_[ map{ rand @_ } 1 .. shift ] }
			my $sjson;
			{
			  local $/; #Enable 'slurp' mode
			  open my $fh, "<", $ARGV[0];
			  $sjson = <$fh>;
			  close $fh;
			}
			my $data = decode_json($sjson);
			#p $data ; 
			# basically scramble the passwords
			$data->{'env'}->{'aws'}->{'AWS_ACCESS_KEY_ID'} = rndStr 12, 'A'..'Z', 0..9, 'a'..'z' ; 
			$data->{'env'}->{'aws'}->{'AWS_SECRET_ACCESS_KEY'} = rndStr 12, 'A'..'Z', 0..9, 'a'..'z' ; 
			$data->{'env'}->{'db'}->{'postgres_db_user_pw'} = rndStr 12, 'A'..'Z', 0..9, 'a'..'z' ; 
			$data->{'env'}->{'db'}->{'postgres_db_useradmin_pw'} = rndStr 12, 'A'..'Z', 0..9, 'a'..'z' ; 
			$data->{'env'}->{'db'}->{'root_pwd'} = rndStr 12, 'A'..'Z', 0..9, 'a'..'z' ; 
			$data->{'env'}->{'db'}->{'app_user_pwd'} = rndStr 12, 'A'..'Z', 0..9, 'a'..'z' ; 
			$data->{'env'}->{'AdminEmail'} = rndStr 12, 'A'..'Z', 0..9, 'a'..'z' ; 
         my $json = JSON->new->allow_nonref;
			open my $fh, ">", $ARGV[0];
			print $fh $json->pretty->encode($data);
			close $fh;
EOF
)
		perl -e "$script" $file
      git add $file
	done < <(find $PRODUCT_INSTANCE_DIR/cnf/env/ -type f| grep -v '.bak')

}
