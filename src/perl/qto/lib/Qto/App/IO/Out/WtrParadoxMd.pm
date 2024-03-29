package Qto::App::IO::Out::WtrParadoxMd ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
   use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use Data::Printer ; 
   use Carp ; 
   use Qto::App::IO::Out::WtrDirs ; 
   use Qto::App::IO::Out::WtrFiles ; 
	use Qto::App::Utils::Logger ;
   use Qto::App::Utils::Timer ; 

   our $module_trace       = 0 ; 
   our $IsUnitTest         = 0 ; 
   our $config          = {} ; 
   our $objLogger          = {} ; 
   our $objModel           = {} ; 
   our $objWtrDirs         = {} ; 
   our $ProductInstanceDir = {} ; 


   sub convertHtmlEntities {
		my $str = shift || '' ; 
		$str =~ s/>/&gt;/g;
		$str =~ s/</&lt;/g;
		return $str ;
	}

   
   sub doWrite {

      my $self             = shift ; 
      my $table            = shift ; 
      my $ahs2             = shift ; 
      my $msg              = ''  ; 
      my $ret              = 1 ; 
      my $str_response     = '' ; 

      my $db = ( defined($objModel->get('postgres_app_db')) ? $objModel->get('postgres_app_db') : 'dev_qto' );
      my $objTimer = 'Qto::App::Utils::Timer'->new() ; 
	   my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
      my $nice_month  = "$year" . '-' . "$mon" ; 
      my $nice_datetime  = "$year" ."$mon". "$mday" . '_' . "$hour" . "$min" . "$sec" ; 
      my $nice_date  = "$year" . '-' . "$mon" . '-' . "$mday" ; 

      my $md_file_name       = $db. '.' . $table . '.' . $nice_datetime ; 
      my $md_dir = $config->{ 'ProductInstanceDir' } . '/dat/mix/' . "$year/$nice_month/$nice_date/tmp" ; 
      $objWtrDirs->doMkDir ( "$md_dir" ) ; 
      my $md_file         = "$md_dir/$md_file_name" . '.md'; 

      $msg = 'START writing the md file: ' ; $objLogger->info ( $msg ) ; 
      $msg = $md_file ; $objLogger->info ( $msg ) ; 
 
      my $nxt_col_id = 1 ; 
      my $col_id = 0 ; 
      my $row_id = 0 ; 
      my @col_names = ('id' , 'name' , 'description' , 'img_relative_path', 'src')  ;
      
      my $str_toc = "\n" . ' @@toc { depth=3 } ' . "\n" ; 

      foreach my $row ( @$ahs2 ) {
         my $id = $row->{ 'id' } ; 
		   my $logical_order	= $row->{ 'logical_order' } || '' ; 
         # p $row ; 
         $row_id++ ; 

      foreach my $col_name ( @col_names ) {
            # rint ( $row );
            # rint $row->{ $col_name } ; 
            if ( !defined ( $row )  or !defined ( $row->{ $col_name } ) or $row->{ $col_name } eq 'NULL' ) {
               $row->{ $col_name } = '' ; 
            }

				if ( $col_name eq 'name' ) {
					my $h_syntax = '' ; 
					for ( my $h = 0 ; $h <= $row->{'level'} ; $h++ ) {
						$h_syntax .= '#' ; 
					}
						$h_syntax .= ' ' . $logical_order . ' ' ; 
						my $cell 		= $row->{ 'name' } ; 
						$cell =~ s/</&lt;/g ; 
						$cell =~ s/>/&gt;/g ; 

						$str_response .= $h_syntax . $cell ; 
						$str_response .= "\n" ; 
                 
                  # it-190108215050
                  $str_response .= $str_toc  if $row_id == 1 ; 
                 
				} elsif ( $col_name eq 'description' ) {
					my $cell 		= $row->{ 'description' } ; 
					$cell =~ s/</&lt;/g ; 
					$cell =~ s/>/&gt;/g ; 

               # convert all the relative paths as md lins as well
               $cell =~ s! ((\.\.\/){0,1}([a-zA-Z0-9_\-\/\\]*)[\/\\]([a-zA-Z0-9_\-]*)\.([a-zA-Z0-9]*)) ! [$3]($1) !gm ; 
					$str_response .= $cell ;

					$str_response .= "\n\n" ; 

            } elsif ( $col_name eq 'img_relative_path' and defined ( $row->{'img_item_guid'} ) ) {	

               # ![myimage-alt-tag](url-to-image)
               $str_response			.= "\n" . $row->{'img_name'} . "\n" ; 
               $str_response			.= '![' . $row->{'img_name'} . ']'  ; 
               $str_response			.= '(' . $row->{'img_relative_path'} . ')' ; 
					$str_response        .= "\n\n" ; 

            } elsif ( $col_name eq 'src' ) {

					my $src_code  = $row->{ 'src' } ; 
					$src_code =~ s/^/    /g ; 
					$src_code =~ s/\n/\n    /gm ; 
					$str_response .= $src_code ; 
					$str_response .= "\n\n" ; 

            } 
         } 
         #eof foreach col
      } 
      #eof foreach row 

      binmode STDOUT;
      $msg = 'STOP writing the md file: ' ; $objLogger->info ( $msg ) ; 
      $msg = $md_file ; $objLogger->info ( $msg ) ; 
  
      my $objWtrFiles   = 'Qto::App::IO::Out::WtrFiles'->new ( \$config ) ; 
      ( $ret , $msg ) = $objWtrFiles->doPrintToFile ( $md_file , $str_response, 'utf8' ) ; 
      
      return ( 0 , '' , $md_file ) if -f $md_file ; 
      return (1 , $msg , undef ) unless -f $md_file ; 
   }

 
	sub new {
		my $class = shift;    
		$config     = ${ shift @_ } || croak 'missing config !!!' ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
		my $self = {}; bless( $self, $class ); 
      $self = $self->doInit();
		return $self;
	}  


   sub doInit {
      my $self          = shift ; 
      %$self = (
           config => $config
      );
      $ProductInstanceDir   = $config->{ 'ProductInstanceDir' } ; 
	   $objWtrDirs       = 'Qto::App::IO::Out::WtrDirs'->new ( \$config ) ; 
	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$config ) ;
      return $self ; 
	}	


1;


__END__
