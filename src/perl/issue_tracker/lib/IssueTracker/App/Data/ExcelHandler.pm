package IssueTracker::App::Data::ExcelHandler ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
   use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use Data::Printer ; 
   use Carp ; 
   use Excel::Writer::XLSX ; 
   use IssueTracker::App::Utils::IO::FileHandler ; 
	use IssueTracker::App::Utils::Logger ;
   use IssueTracker::App::Utils::Timer ; 

   our $module_trace      = 0 ; 
   our $IsUnitTest        = 0 ; 
   our $appConfig         = q{} ; 
   our $objLogger         = q{} ; 
   our $objFileHandler    = q{} ; 
   our $ProductInstanceDir = {} ; 

   #
   # ------------------------------------------------------
   # builds and xls file into the xls dir 
   # from the passed hash ref of hashs refs by using the calling
   # sql script as a source for the xls file path to produce
   # src: http://search.cpan.org/~jmcnamara/Excel-Writer-XLSX/lib/Excel/Writer/XLSX.pm
   # ------------------------------------------------------
   sub doBuildXlsFromHashRef {

      my $self             = shift ; 
      my $hsr_meta         = shift ; 
      my $hsr              = shift ; 
      my $msg              = q{} ; 
      #debug ok p($hsr ) if $module_trace == 1 ; 
      
      my $objTimer = 'IssueTracker::App::Utils::Timer'->new() ; 
	   my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits(); 

      my $issues_file      = $appConfig->{ 'issues_file' } ; 
      my $xls_file_name    = $issues_file ; 
      $xls_file_name       =~ s/(.*)(\\|\/)(.*)\.([a-zA-Z0-9]*)/$3/g ; 
      $xls_file_name    = "$xls_file_name" . '.' . "$hour" . "$min" . "$sec" ; 
      my $xls_dir          = "$ProductInstanceDir/dat/xls/run" ; 
      $objFileHandler->MkDir ( "$xls_dir" ) ; 
      my $xls_file         = "$xls_dir/$xls_file_name" . '.xlsx' ; 

      $msg = 'START writing the xls file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $xls_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
 
      # Create a new Excel workbook
      my $objWorkbook      = 'Excel::Writer::XLSX'->new( $xls_file );
      my $sheet_name        = $xls_file_name ; 
      $sheet_name          = 'data' ; 
      my $objWorksheet     = $objWorkbook->add_worksheet( $sheet_name );


      # print the headers  
      foreach my $colid ( sort ( keys (  %{$hsr_meta->{ 'ColumnNames'}} ) ) ) {

         my $objFormat    =  $objWorkbook->add_format(
            'color' => 'black'
          , 'font'  => 'Lucida Console'
          , 'bold'  => '1'
         );
         $objWorksheet->write(0, $colid, $hsr_meta->{ 'ColumnNames'}->{ $colid } , $objFormat )  ; 

         # set the initial widh of the column as the width of the title column
         $hsr_meta->{'ColumnWidths'}->{ $colid } = length ( $hsr_meta->{ 'ColumnNames'}->{ $colid } ) ; 
      }

      foreach my $rowid ( sort ( keys ( %$hsr ) ) ) {

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

         my $hsr_row = $hsr->{ "$rowid" } ; 
         $rowid = $rowid+1 ; 
         p($hsr_row ) if $module_trace == 1 ; 
         
         foreach my $colid ( sort ( keys ( %{$hsr_meta->{'ColumnNames'}} ) ) ) {
            my $col_name     = $hsr_meta->{'ColumnNames'}->{ $colid } ; 
       
            my $cell_length = length ( $hsr_row->{ $col_name } ) || 5 ;  
            $hsr_meta->{ 'ColumnWidths' }->{ $colid } = $cell_length || 5 ; 

            #define the max width 
            if ( $hsr_meta->{ 'ColumnWidths' }->{ $colid } < $cell_length ) {
               $hsr_meta->{ 'ColumnWidths' }->{ $colid } = $cell_length ;                
            }
            
            # $objWorksheet->set_column($colid, $colid, $hsr_meta->{ 'ColumnWidths' }->{ $colid } );
            $objWorksheet->set_column($colid, $colid, $hsr_meta->{ 'ColumnWidths' }->{ $colid } );
            $objWorksheet->write($rowid, $colid, $hsr_row->{ $col_name } , $objFormat )  ; 
         }
         
      } 
      #eof foreach row 
     
      # does not work why ?! 
      # $self->autofit_columns ( $objWorksheet , $hsr_meta ) ; 
     
      $msg = 'STOP writing the xls file: ' ; $objLogger->doLogInfoMsg ( $msg ) ; 
      $msg = $xls_file ; $objLogger->doLogInfoMsg ( $msg ) ; 
      
      return 0 if -f $xls_file ; 
   }
   #eof sub doBuildXlsFromHashRef

   
   # Adjust the column widths to fit the longest string in the column
   sub autofit_columns {
    
        my $self      = shift ; 
        my $worksheet = shift;
        my $hsr_meta  = shift ; 
        my $col       = 0;
    
        for my $width (@{$worksheet->{'data'}}) {
           
            $worksheet->set_column($col, $col, 40 ) if $width;
            # $worksheet->set_column($col, $col, $hsr_meta->{'ColumnWidths'}->{ $col } ) if $width;
            $col++;
        }
   }
    #


   # -----------------------------------------------------------------------------
   # doInitialize the object with the minimum data it will need to operate 
   # -----------------------------------------------------------------------------
   sub doInitialize {

      my $self = shift ; 

      #debug print "ExcelHandler::doInitialize appConfig : " . p($appConfig );
	   $objLogger 			   = 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
      $ProductInstanceDir   = $appConfig->{ 'ProductInstanceDir' } ; 
	   $objFileHandler 	   = 'IssueTracker::App::Utils::IO::FileHandler'->new( \$appConfig ) ;

   }
   #eof sub doInitialize


#   sub doMoveOldXlsFilesToBackup {
#      my $self             = shift ; 
#      my $xls_dir          = "$ProductInstanceDir/dat/backups/" ; 
#      $objFileHandler->MkDir ( "$xls_dir" ) ; 
#      use File::Copy;
#      my @files = glob("$PATH1/*.txt");
#
#      for my $file (@files) {
#          copy($file, $ENV{DIRWORK}) or die "Copy failed: $!";
#      }

   #}

 
   #
   # -----------------------------------------------------------------------------
   # the constructor 
   # source:http://www.netalive.org/tinkering/serious-perl/#oop_constructors
   # -----------------------------------------------------------------------------
   sub new {

      my $class            = shift ;    # Class name is in the first parameter
      $appConfig = ${ shift @_ } if ( @_ );

      # Anonymous hash reference holds instance attributes
      my $self = { }; 
      bless($self, $class);     # Say: $self is a $class

      $self->doInitialize() ; 
      return $self;
   } 
   #eof const 
   
   



1;


__END__
