package Qto::App::IO::Out::WtrGitHubMd ; 

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
   our $objModel          = {} ; 
   our $objWtrDirs     = {} ; 
   our $ProductInstanceDir = {} ; 
	
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
   # ------------------------------------------------------
   # WtrGitHubMd
   # ------------------------------------------------------
   sub doWrite {

      my $self             = shift ; 
      my $table            = shift ; 
      my $ahs2             = shift ; 
      my $md_dialect       = shift || 'github' ; 
      my $msg              = ''  ; 
      my $ret              = 1 ; 
      my $str_response     = '' ; 

      my $db = ( defined($objModel->get('postgres_db_name')) ? $objModel->get('postgres_db_name') : 'dev_qto' );
      my $objTimer = 'Qto::App::Utils::Timer'->new() ; 
	   my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
      my $nice_month  = "$year" . '-' . "$mon" ; 
      my $nice_datetime  = "$year" ."$mon". "$mday" . '_' . "$hour" . "$min" . "$sec" ; 
      my $nice_date  = "$year" . '-' . "$mon" . '-' . "$mday" ; 

      my $md_file_name       = $db. '.' . $table . '.' . $nice_datetime ; 
      my $md_dir = $config->{'env'}->{'run'}->{ 'ProductInstanceDir' } . '/dat/mix/' . "$year/$nice_month/$nice_date/tmp" ; 
      $objWtrDirs->doMkDir ( "$md_dir" ) ; 
      my $md_file         = "$md_dir/$md_file_name" . '.md'; 

      $msg = 'START writing the md file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $md_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
 
      my $nxt_col_id = 1 ; 
      my $col_id = 0 ; 
      my $row_id = 0 ; 
      my @col_names = ('id' , 'name' , 'description' , 'img_relative_path', 'src')  ;
      
      my $str_toc = $self->doBuildTOC($table,$ahs2);
      $str_toc = '[[_TOC_]]' if ( $md_dialect eq 'msft' );

      foreach my $row ( @$ahs2 ) {
         my $id = $row->{ 'id' } ; 
		   my $logical_order	= $row->{ 'logical_order' } || '' ; 
         # p $row ; 
         $row_id++ ; 

      foreach my $col_name ( @col_names ) {
            # debug p( $row );
            # debug p $row->{ $col_name } ; 
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
      $msg = 'STOP writing the md file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $md_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
  
      my $objWtrFiles   = 'Qto::App::IO::Out::WtrFiles'->new ( \$config ) ; 
      ( $ret , $msg ) = $objWtrFiles->doPrintToFile ( $md_file , $str_response, 'utf8' ) ; 
      
      return ( 0 , '' , $md_file ) if -f $md_file ; 
      return (1 , $msg , undef ) unless -f $md_file ; 
   }

   sub doBuildTOC {

      my $self       = shift ; 
      my $table      = shift ; 
      my $ahs2       = shift ; 
      my $row_id     = 0 ; 
      my @col_names  = ('id' , 'name' , 'description' , 'src')  ;
      my $control    = '' ; 

      foreach my $row ( @$ahs2 ) {
         my $id = $row->{ 'id' } ; 
		   my $logical_order	= $row->{ 'logical_order' } || '' ; 
		   my $level	= $row->{ 'level' } || 0 ; 
         # p $row ; 
         $row_id++ ; 

      foreach my $col_name ( @col_names ) {
            # debug p( $row );
            # debug p $row->{ $col_name } ; 
            if ( !defined ( $row )  or !defined ( $row->{ $col_name } ) or $row->{ $col_name } eq 'NULL' ) {
               $row->{ $col_name } = '' ; 
            }

				if ( $col_name eq 'name' && $level != 0 ) {
					my $title = '' ; 
					my $msg							= '' ; 
					my $debug_msg					= '' ; 

					my $title_data					= $row->{'name'} ; 
					$title_data						= convertHtmlEntities ( $title_data) ;
					my $level_num					= $row->{'level'} ; 
					$title_data						 = uc($title_data ) if ( $level_num == 1 or $level_num == 0 or $level_num == 2 ) ; 

					my $id							= 'id' ; 
					my $spaces 						= '' ; 
               my $asterixes              = '' ; 
               my $dashes                 = '' ; 
					for ( my $i=1; $i < $row->{ 'level' };$i++) {
						$spaces				  .= '  ' ; 
						$asterixes		     .= '*' ; 
						$dashes		        .= '#' ; 
						$spaces				  .= '  ' if $i > 3 ; 
					}
					
					my $title_link					= '' ; 
					$title_link					   = lc ($title_data ) ; 
					$title_link					   =~ s/ /-/g ; 
					$title_link					   =~ s/[\<\>\?\!\:,]//g ; 
					$title_link					   =~ s/&gt;//g ; 
					$title_link					   =~ s/&lt;//g ; 
					$title_link					   =~ s/\-\-/-/g ; 
					$title_link					   =~ s/\.//g ; 
					
					$title	 						.= $spaces . '*' . ' [' . $logical_order . " " . $title_data . ']' ; 
               $logical_order              =~ s/\.//g ; 
					$title	 						.= '(' . '#' . $logical_order . "-" . $title_link . ')' ; 
					$title	 						.= "\n" ; 
					
					$control .= $title ; 
                 
				} elsif ( $col_name eq 'description' ) {
            } elsif ( $col_name eq 'src' ) {
            }
         } 
         #eof foreach col
      } 
      
      $control .= "\n\n" ; 

      return $control ; 
   }
 
   # 
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class = shift;    
		$config     = ${ shift @_ } || croak 'missing config !!!' ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
		my $self = {}; bless( $self, $class ); 
      $self = $self->doInit();
		return $self;
	}  
	#eof const

   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInit {
      my $self          = shift ; 

      %$self = (
           config => $config
       );

      #debug rint "WtrGitHubMd::doInit config : " . p($config );
      $ProductInstanceDir   = $config->{ 'ProductInstanceDir' } ; 

	   $objWtrDirs       = 'Qto::App::IO::Out::WtrDirs'->new ( \$config ) ; 
	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$config ) ;

      return $self ; 
	}	
	#eof sub doInit




1;


__END__
