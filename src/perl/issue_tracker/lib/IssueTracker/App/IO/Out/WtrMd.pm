package IssueTracker::App::IO::Out::WtrMd ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
   use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use Data::Printer ; 
   use Carp ; 
   use IssueTracker::App::IO::Out::WtrDirs ; 
   use IssueTracker::App::IO::Out::WtrFiles ; 
	use IssueTracker::App::Utils::Logger ;
   use IssueTracker::App::Utils::Timer ; 

   our $module_trace       = 0 ; 
   our $IsUnitTest         = 0 ; 
   our $appConfig          = {} ; 
   our $objLogger          = {} ; 
   our $objModel          = {} ; 
   our $objWtrDirs     = {} ; 
   our $ProductInstanceDir = {} ; 

   #
   # ------------------------------------------------------
   # WtrMd
   # ------------------------------------------------------
   sub doWrite {

      my $self             = shift ; 
      my $table            = shift ; 
      my $ahs2             = shift ; 
      my $msg              = ''  ; 
      my $ret              = 1 ; 
      my $str_response     = '' ; 

      my $db = ( defined($objModel->get('postgres_db_name')) ? $objModel->get('postgres_db_name') : 'dev_issue_tracker' );
      my $objTimer = 'IssueTracker::App::Utils::Timer'->new() ; 
	   my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
      my $nice_month  = "$year" . '-' . "$mon" ; 
      my $nice_datetime  = "$year" ."$mon". "$mday" . '_' . "$hour" . "$min" . "$sec" ; 
      my $nice_date  = "$year" . '-' . "$mon" . '-' . "$mday" ; 

      my $md_file_name       = $db. '.' . $table . '.' . $nice_datetime ; 
      my $md_dir = $appConfig->{ 'ProductInstanceDir' } . '/dat/mix/' . "$year/$nice_month/$nice_date/tmp" ; 
      $objWtrDirs->doMkDir ( "$md_dir" ) ; 
      my $md_file         = "$md_dir/$md_file_name" . '.md'; 

      $msg = 'START writing the md file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $md_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
 
      my $nxt_col_id = 1 ; 
      my $col_id = 0 ; 
      my $row_id = 0 ; 
      my @col_names = ('id' , 'name' , 'description' , 'src')  ;

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
                 
                  # todo:ysg add the table of contents
                  # add the table of contents if this is the level 1
                  # $str_response .= $str_toc  if $row->{'level'} == 1 ; 
                 #
				} elsif ( $col_name eq 'description' ) {
					my $cell 		= $row->{ 'description' } ; 
					$cell =~ s/</&lt;/g ; 
					$cell =~ s/>/&gt;/g ; 

               # convert all the relative paths as md lins as well
               $cell =~ s! ((\.\.\/){0,1}([a-zA-Z0-9_\-\/\\]*)[\/\\]([a-zA-Z0-9_\-]*)\.([a-zA-Z0-9]*)) ! [$3]($1) !gm ; 

					$str_response .= $cell ;
					$str_response .= "\n\n" ; 
            }
         } 
         #eof foreach col
      } 
      #eof foreach row 

      binmode STDOUT;
      $msg = 'STOP writing the md file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $md_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
  
      my $objWtrFiles   = 'IssueTracker::App::IO::Out::WtrFiles'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objWtrFiles->doPrintToFile ( $md_file , $str_response, 'utf8' ) ; 
      
      return ( 0 , '' , $md_file ) if -f $md_file ; 
      return (1 , $msg , undef ) unless -f $md_file ; 
   }

 
   # 
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class = shift;    
		$appConfig     = ${ shift @_ } || croak 'missing appConfig !!!' ; 
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
           appConfig => $appConfig
       );

      #debug rint "WtrMd::doInit appConfig : " . p($appConfig );
      $ProductInstanceDir   = $appConfig->{ 'ProductInstanceDir' } ; 

	   $objWtrDirs       = 'IssueTracker::App::IO::Out::WtrDirs'->new ( \$appConfig ) ; 
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInit




1;


__END__
