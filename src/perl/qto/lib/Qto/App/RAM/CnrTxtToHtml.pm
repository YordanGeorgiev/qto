package Qto::App::RAM::CnrTxtToHtml ;

	use strict ; use warnings ; use diagnostics ; 
	
	require Exporter ; 
	our @ISA = qw(Exporter);
	our %EXPORT_TAGS = ( 'all' => [ qw(text2html) ] );
	our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
	our @EXPORT = qw(text2html) ; 
	use AutoLoader 'AUTOLOAD';

	use Carp qw (croak carp);


	our $ModuleDebug 		= 0  ; 


	# -----------------------------------------------------------------------------
	# credit:http://www.dispersiondesign.com/articles/perl/converting_text_to_html
	# -----------------------------------------------------------------------------
	sub text2html {

		my $str = shift || '' ; 
		my $caller_type = shift || 'Description' ; 

		# Convert CR or CRLF to LF
		$str =~ s/\r\n?/\n/g;

		# Remove whitespace at the end of lines
		$str =~ s/[ \t]+$//gm;

		# Remove initial empty lines
		$str =~ s/^\n+//s;

		# Remove trailing empty lines
		$str =~ s/\n+$//s;

		# Convert HTML entities
		$str =~ s/>/&gt;/g;
		$str =~ s/</&lt;/g;
		#$str =~ s/&/&amp;/g;

		# Build a regular expression for detecting URLs
		my $sub_delims = '!\$&\'\(\)\*\+,;=';
		my $unreserved = '-a-zA-Z0-9\._~';
		my $pchar = "${unreserved}${sub_delims}\%:\@";

		my $scheme = '(?:https?|ftp)';
		my $tld = '[a-zA-Z]{2,6}';
		my $subdomain = '[a-zA-Z0-9](?:[-a-zA-Z0-9]{0,62}[a-zA-Z0-9])?';
		my $domain = "(?:$subdomain\\.)+$tld";

		my $port = '[0-9]*';
		my $authority = "$domain(?::$port)?";

		my $path = "(?:/[${pchar}]*)*";
		my $query = "[${pchar}/\\?]*";
		my $fragment = "[${pchar}/\\?]*";

		my $url_ex = "$scheme://$authority$path(?:\\?$query)?(?:#$fragment)?";

		# Add hyperlinks to URLs
		$str =~ s/($url_ex)/<a href="$1">$1<\/a>/g;

		# Add hyperlinks to URLs with missing protocol
		my $www_url_ex = "www\\.$authority$path(?:\\?$query)?(?:#$fragment)?";
		$str =~ s/(?<![-a-zA-Z0-9\/\.])($www_url_ex)/<a tabindex="0" href="http:\/\/$1">$1<\/a>/g;
			
		return $str if ( $caller_type eq 'SrcCode' ) ; 

		# Locate paragraphs
		my @paras = split(/\n{2,}/, $str );


		foreach(@paras) {
				$_ =~ s/\n/<br \/>\n/sg;
				$_ = "<p>" . $_ . "</p>";
		}
		#$current_token = encode_entities( $current_token ) ; 
		#$current_token = join("\n", @paras);

		return join("\n", @paras);
	}
	#eof sub text2html


	# -----------------------------------------------------------------------------
	# credit:http://www.dispersiondesign.com/articles/perl/converting_text_to_html
	# -----------------------------------------------------------------------------
	sub convertHtmlEntities {
		my $str = shift || '' ; 
		$str =~ s/>/&gt;/g;
		$str =~ s/</&lt;/g;
		return $str ;
	}

	#
	# -----------------------------------------------------------------------------
	# simply print a better message by using AUTOLOAD 
	# -----------------------------------------------------------------------------
	no warnings 'redefine' ; 
	sub AUTOLOAD {
		my $func_name 	 = our $AUTOLOAD ; 
		my $error_msg 	 = '' ; 
		$error_msg 		.= "\n\n\n[FATAL] Undefined function $func_name " ; 
		$error_msg 		.= "with params:\"" . ( @_ ) . "\" called !!!\n\n\n" ; 
		Carp::croak $error_msg ; 
	}
	use warnings 'redefine' ; 



1;
__END__




=head1 NAME

HtmlHandler

=head1 SYNOPSIS

use HtmlHandler
  
=head1 DESCRIPTION

the Purpose of this module is to provide non-object methods for html handling

=head2 EXPORT


=head1 SEE ALSO


  No mailing list for this module


=head1 AUTHOR

  yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

  Copyright (C) 2014 Yordan Georgiev

  This library is free software; you can redistribute it and/or modify
  it under the same terms as Perl itself, either Perl version 5.8.1 or,
  at your option, any later version of Perl 5 you may have available.

=cut


# 
# -----------------------------------------------------------------------------
# VersionHistory
# -----------------------------------------------------------------------------
#
# 1.0.0 -- 2014-09-02 21:55:09 -- ysg -- output sh and txt files ok
#
