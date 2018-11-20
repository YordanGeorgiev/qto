package IssueTracker::App::IO::Out::WtrXls ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
   use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use Data::Printer ; 
   use Carp ; 
   use Excel::Writer::XLSX ; 
   use IssueTracker::App::IO::Out::WtrDirs ; 
	use IssueTracker::App::Utils::Logger ;
   use IssueTracker::App::Utils::Timer ; 

   our $module_trace       = 0 ; 
   our $IsUnitTest         = 0 ; 
   our $appConfig          = {} ; 
   our $objLogger          = {} ; 
   our $objWtrDirs     = {} ; 
   our $ProductInstanceDir = {} ; 



   #
   # ------------------------------------------------------
   # WtrXls
   # builds and xls file into the xls dir 
   # from the passed hash ref of hashs refs by using the calling
   # sql script as a source for the xls file path to produce
   # src: http://search.cpan.org/~jmcnamara/Excel-Writer-XLSX/lib/Excel/Writer/XLSX.pm
   # ------------------------------------------------------
   sub doBuildXlsFromHashRef {

      my $self             = shift ; 
      my $objModel         = ${shift @_ } ;   
      my $table            = shift ; 
      my $hsr2             = shift ; 
      my $msr2             = shift ; 
      my $omsr2            = {} ; 
      my $msg              = ''  ; 

      my $objTimer = 'IssueTracker::App::Utils::Timer'->new() ; 
	   my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
      my $nice_month  = "$year" . '-' . "$mon" ; 
      my $nice_datetime  = "$year" ."$mon". "$mday" . '_' . "$hour" . "$min" . "$sec" ; 
      my $nice_date  = "$year" . '-' . "$mon" . '-' . "$mday" ; 

      my $xls_file_name       = $ENV{'issue_tracker_project'} . '.' . $table . '.' . $nice_datetime ; 
      my $xls_dir = $appConfig->{ 'xls_dir' } || $ENV{'mix_data_dir'} . "/$year/$nice_month/$nice_date" ; 
      $objWtrDirs->doMkDir ( "$xls_dir" ) ; 
      my $xls_file         = "$xls_dir/$xls_file_name" . '.xlsx' ; 

      $msg = 'START writing the xls file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $xls_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
 
      my $objWorkbook      = 'Excel::Writer::XLSX'->new( $xls_file );
      my $sheet_name       = $table ; 
      my $objWorksheet     = $objWorkbook->add_worksheet( $sheet_name );

      my $nxt_col_id = 1 ; 
      my $objFormat     =  $objWorkbook->add_format(
         'color' => 'black'
       , 'font'  => 'Lucida Console'
       , 'bold'  => '1'
      );
      
      my $col_id = 0 ; 
      foreach my $mid ( sort ( keys (  %$msr2 ) ) ) {
         my $row = $msr2->{ $mid } ; 
         my $col_name         = $row->{ 'attribute_name' } ; 
         my $attr_num         = $row->{ 'attribute_number' } ; 
         $omsr2->{ $attr_num } = {} ; 
         $omsr2->{ $attr_num }->{'attribute_name'} = $col_name ;
         $omsr2->{ $attr_num }->{'attribute_number'} = $attr_num ;
      }

      foreach my $col_id ( sort ( keys (  %$omsr2 ) ) ) {
         my $row        = $omsr2->{ $col_id } ; 
         my $col_name   = $row->{ 'attribute_name' } ; 
         $objWorksheet->write(0, $col_id-1, $col_name , $objFormat )  ; 
      }
     
      my $row_id = 0 ; 
      foreach my $guid ( keys ( %$hsr2 ) ) {
         my $objFormat        = {} ; 
         # set alternating rows
         if ( $row_id % 2 == 1 ) {
            $objFormat = $objWorkbook->add_format( 'font'  => 'Lucida Console' );
            $objFormat->set_bg_color('silver') ; 
         }
         else {
            $objFormat = $objWorkbook->add_format( 'font'  => 'Lucida Console' );
            $objFormat->set_bg_color('white') ; 
         }
         $objFormat->set_text_wrap();
         my $row = $hsr2->{ "$guid" } ; 
         # p $row ; 
         $row_id++ ; 
         foreach my $col_id ( sort ( keys ( %$omsr2 ) ) ) {
            my $mrow             = $omsr2->{ $col_id } ; 
            my $col_name         = $mrow->{ 'attribute_name' }  ;
            # debug p( $row );
            # debug p $row->{ $col_name } ; 
            if ( !defined ( $row )  or !defined ( $row->{ $col_name } ) or $row->{ $col_name } eq 'NULL' ) {
               $row->{ $col_name } = '' ; 
            }
            $objWorksheet->write($row_id, $col_id-1, $row->{ "$col_name" } , $objFormat )  ; 
         } 
         #eof foreach col
      } 
      #eof foreach row 
     
      $msg = 'STOP writing the xls file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $xls_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
      
      $row_id++ ; 
      return 0 if -f $xls_file ; 
      return 1 ; 
   }
   #eof sub doBuildXlsFromHashRef

   

 
   # 
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class = shift;    # Class name is in the first parameter
		$appConfig = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize();
		return $self;
	}  
	#eof const

   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self          = shift ; 

      %$self = (
           appConfig => $appConfig
       );

      #debug print "WtrXls::doInitialize appConfig : " . p($appConfig );
      $ProductInstanceDir   = $appConfig->{ 'ProductInstanceDir' } ; 

	   $objWtrDirs       = 'IssueTracker::App::IO::Out::WtrDirs'->new ( \$appConfig ) ; 
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize




1;


__END__
