package IssueTracker::App::IO::Out::WtrGoogleSheet ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
   use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use Data::Printer ; 
   use Carp ; 

   use Text::CSV_XS;
   use Net::Google::Spreadsheets::V4;

   use Net::Google::DataAPI::Auth::OAuth2;
    
   use Term::Prompt;
   use Net::Google::DataAPI::Auth::OAuth2;
   use Net::Google::Spreadsheets;
   use Data::Printer ; 
   
   use utf8;


   use IssueTracker::App::Utils::IO::FileHandler ; 
	use IssueTracker::App::Utils::Logger ;
   use IssueTracker::App::Utils::Timer ; 

   our $module_trace       = 1 ; 
   our $IsUnitTest         = 0 ; 
   our $appConfig          = {} ; 
   our $objLogger          = {} ; 
   our $objFileHandler     = {} ; 
   our $ProductInstanceDir = {} ; 


   #
   # ------------------------------------------------------
   # WtrGoogleSheet
   # ( $ret , $msg )  = $objWtrGoogleSheet->doWriteGSheetFromHashRef ( 
   #           $mhsr , $hsr , \$objGoogleService , $table , $refresh_token , $spread_sheet_id ) ; 
   # ------------------------------------------------------
   sub doWriteGSheetFromHashRef {

      my $self             = shift ; 
      my $hsr_meta         = shift ; 
      my $hsr              = shift ; 
      my $objGoogleService = ${ shift @_ } ; 
      my $table            = shift ; 
      my $refresh_token    = shift ; 
      my $spread_sheet_id  = shift ; 

      my $msg              = 'unknown error during google sheet write' ; 
      my $ret              = 1 ; 

      # debug ok p($hsr ) if $module_trace == 1 ; 
      # debug p ( $hsr_meta )  ; 

      # https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/request
      my @rows = () ; 
      my($content, $res);
      my $title = $table ;       # by convention the name of the db table is the same as the xls sheet name
      my $sheet = $objGoogleService->get_sheet(title => $title);

      
      # create a sheet if does not exit
      unless ($sheet) {
          ($content, $res) = $objGoogleService->request(
              POST => ':batchUpdate',
              {
                  requests => [
                      {
                          addSheet => {
                              properties => {
                                  title => $title,
                                  index => 0,
                              },
                          },
                      },
                  ],
              },
          );

          $sheet = $content->{replies}[0]{addSheet};
      }

      my $sheet_prop = $sheet->{properties};

      # clear all cells
      $objGoogleService->clear_sheet(sheet_id => $sheet_prop->{sheetId});



      # print the headers  
      my $rowid = 0 ; 
      my @row = () ; 
      push ( @row , '#' ) ; 

      # foreach my $colid ( sort ( keys (  %{$hsr_meta->{ 'ColumnNames'}} ) ) ) {
      #foreach my $colid ( sort { $hsr_meta->{$a}->{'attnum'} <=> $hsr_meta->{$b}->{'attnum'}} keys (%$hsr_meta)) {
      my $default_col_to_sort_by = 'seq' ; 
      my $flg_found_default_col_to_sort_by = 0 ; 
      my $hsr_meta1 = $hsr_meta->{ 'ColumnNames' } ; 
      foreach my $colid ( sort { $hsr_meta1->{$a}->{'attnum'} <=> $hsr_meta1->{$b}->{'attnum'}} keys (%$hsr_meta1)) {
         # debug print "\$colid is $colid \n" ; 
         my $col_name     = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attname' } ; 
         $flg_found_default_col_to_sort_by++ if $col_name eq $default_col_to_sort_by ; 
         next if $col_name eq 'guid' ; 
         next if $col_name eq 'planned_hours' ; 
         next if $col_name eq 'actual_hours' ; 
         push ( @row , $col_name ) ; 
      }
         push ( @row , 'guid' );
      push ( @rows , \@row ) ; 
      $default_col_to_sort_by = 'seqid' if $flg_found_default_col_to_sort_by == 0 ; 


      foreach my $guid ( 
         sort { $hsr->{$a}->{ $default_col_to_sort_by } <=> $hsr->{$b}->{ $default_col_to_sort_by } } keys (%$hsr)
         )  {


         my $hsr_row = $hsr->{ "$guid" } ; 
         $rowid = $rowid+1 ; 

         my @row = () ; 
         push ( @row , $rowid ) ; 
         #foreach my $colid ( sort ( keys ( %{$hsr_meta->{'ColumnNames'}} ) ) ) {
         foreach my $colid ( sort { $hsr_meta1->{$a}->{'attnum'} <=> $hsr_meta1->{$b}->{'attnum'}} keys (%$hsr_meta1)) {
            my $col_name     = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attname' } ; 
            # debug print "col_name $col_name \n" ; 
            # debug print "colid $colid \n" ; 
            next if $col_name eq 'guid' ; 
            next if $col_name eq 'planned_hours' ; 
            next if $col_name eq 'actual_hours' ; 
            push ( @row , $hsr_row->{ $col_name } ) ; 
            # $objWorksheet->write($rowid, $colid, $hsr_row->{ $col_name } , $objFormat )  ; 
         }
         push ( @row , $hsr_row->{ 'guid' } ) ; 
         push ( @rows , \@row ) ; 
      } 
      #eof foreach row 
      
      p(@rows ) if $module_trace == 1 ; 

      $rowid++ ; 
      # import data
      my @requests = ();
      my $idx = 0;

      for my $row (@rows) {
          push @requests, {
              pasteData => {
                  coordinate => {
                      sheetId     => $sheet_prop->{sheetId},
                      rowIndex    => $idx++,
                      columnIndex => 0,
                  },
                  data => $objGoogleService->to_csv(@$row),
                  type => 'PASTE_NORMAL',
                  delimiter => ',',
              },
          };
      }

      # format a header row
      push @requests, {
          repeatCell => {
              range => {
                  sheetId       => $sheet_prop->{sheetId},
                  startRowIndex => 0,
                  endRowIndex   => 1,
              },
              cell => {
                  userEnteredFormat => {
                      backgroundColor => {
                          red   => 0.0,
                          green => 0.0,
                          blue  => 0.0,
                      },
                      horizontalAlignment => 'CENTER',
							 wrapStrategy		=>  'WRAP',
                      textFormat => {
                          foregroundColor => {
                              red   => 1.0,
                              green => 1.0,
                              blue  => 1.0
                          },
                          bold => \1,
                      },
                  },
              },
              fields => 'userEnteredFormat(backgroundColor,textFormat,horizontalAlignment,wrapStrategy)',
          },
      };
      
      # set txt wrap for all the data rows
		# https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#wrapstrategy
      push @requests, {
          repeatCell => {
              range => {
                  sheetId       => $sheet_prop->{sheetId},
                  startRowIndex => 1,
                  endRowIndex   => scalar ( @rows ) ,
              },
              cell => {
                  userEnteredFormat => {
							 wrapStrategy		=>  'WRAP',
                  },
              },
              fields => 'userEnteredFormat(wrapStrategy)',
          },
      };

      ($content, $res) = $objGoogleService->request(
          POST => ':batchUpdate',
          {
              requests => \@requests,
          },
      );

      $ret = 0 ; 
      $msg = 'google sheet write done' ; 

      return ( $ret , $msg ) ; 
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

      #debug print "WtrGoogleSheet::doInitialize appConfig : " . p($appConfig );
      $ProductInstanceDir   = $appConfig->{ 'ProductInstanceDir' } ; 

	   $objFileHandler   = 'IssueTracker::App::Utils::IO::FileHandler'->new ( \$appConfig ) ; 
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize




1;


__END__
