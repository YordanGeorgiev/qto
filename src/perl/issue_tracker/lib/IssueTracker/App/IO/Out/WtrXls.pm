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
      my $msg              = q{} ; 
      my $hsr2              = $objModel->get('hsr2') ; 
      my $hsr_meta         = $objModel->get('hsr_meta'  ); 

      # p $hsr_meta ; 
      #  sleep 10 ; 


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
 
      # Create a new Excel workbook
      my $objWorkbook      = 'Excel::Writer::XLSX'->new( $xls_file );
      my $sheet_name       = $xls_file_name ; 
      $sheet_name          = $table ; 
      my $objWorksheet     = $objWorkbook->add_worksheet( $sheet_name );


      # print the headers  
      my $nxt_colid = 1 ; 
      # the format tof the title row
      my $objFormat     =  $objWorkbook->add_format(
         'color' => 'black'
       , 'font'  => 'Lucida Console'
       , 'bold'  => '1'
      );

      foreach my $colid ( sort ( keys (  %{$hsr_meta->{ 'ColumnNames'}} ) ) ) {

         my $col_name      = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attname' } ; 
         my $col_lenth     = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attlen' } ; 
         $objWorksheet->write(0, $colid-2, $col_name , $objFormat )  unless $colid == 1 ; 

         # set the initial widh of the column as the width of the title column
         $hsr_meta->{'ColumnWidths'}->{ $colid } = $col_lenth ; 
         $hsr_meta->{ 'ColumnWidths' }->{ $colid } = 60 if $col_lenth > 60 ; 
         $nxt_colid++ ; 
      }
     
      # put the guid at the end
      $hsr_meta->{'ColumnNames'}->{ $nxt_colid }->{ 'attname' } = 'guid' ;  
      $hsr_meta->{ 'ColumnWidths' }->{ $nxt_colid } = 43 ; 
      $objWorksheet->write(0, $nxt_colid-2, 'guid' , $objFormat )  ; 

      my $rowid = 0 ; 
      #foreach my $guid ( sort { $hsr2->{$a}->{ 'seq' } <=> $hsr2->{$b}->{ 'seq' } } keys (%$hsr2))  {
      foreach my $guid ( sort ( keys ( %$hsr2 ) ) ) {

         my $objFormat        = {} ; 
         # $objFormat->set_autofit();
         # alternate colors
         if ( $rowid % 2 == 1 ) {
            $objFormat = $objWorkbook->add_format(
                'font'  => 'Lucida Console'
            );
            $objFormat->set_bg_color('silver') ; 
         }
         else {
            $objFormat = $objWorkbook->add_format(
                'font'  => 'Lucida Console'
            );
            $objFormat->set_bg_color('white') ; 
         }
          
         $objFormat->set_text_wrap();

         my $hsr_row = $hsr2->{ "$guid" } ; 

         $rowid = $rowid+1 ; 


         foreach my $colid ( sort ( keys ( %{$hsr_meta->{'ColumnNames'}} ) ) ) {
            next if $colid == 1 ; # put the guid at the end
            my $col_name     = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attname' } ;
       
            my $cell_length = length ( $hsr_row->{ $col_name } ) || 10 ; 
            #define the max width 
            if ( $hsr_meta->{ 'ColumnWidths' }->{ $colid } < $cell_length ) {
               $hsr_meta->{ 'ColumnWidths' }->{ $colid } = $cell_length ;
            }

            $hsr_meta->{ 'ColumnWidths' }->{ $colid } = 60
               if $hsr_meta->{ 'ColumnWidths' }->{ $colid } > 60 ;



            unless ( 
                  defined ( $hsr_row ) 
               or defined ( $hsr_row->{ $col_name } ) 
               or $hsr_row->{ $col_name } ne 'NULL' ) {
                  # p( $hsr_row );
                  $hsr_row->{ $col_name } = '' ; 
            }

            # to adjust the columns width debug as follows:
            # debug print "$col_name width is " . $hsr_meta->{ 'ColumnWidths' }->{ $colid } . "\n" ; 

            # $objWorksheet->set_column($colid, $colid, $hsr_meta->{ 'ColumnWidths' }->{ $colid } );
            $objWorksheet->set_column($colid, $colid-2, $hsr_meta->{ $colid } );
            $objWorksheet->write($rowid, $colid-2, $hsr_row->{ $col_name } , $objFormat )  ; 
         }
         
      } 
      #eof foreach row 
     
     
      $msg = 'STOP writing the xls file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $xls_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
      
      $rowid++ ; 
      return 0 if -f $xls_file ; 
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
