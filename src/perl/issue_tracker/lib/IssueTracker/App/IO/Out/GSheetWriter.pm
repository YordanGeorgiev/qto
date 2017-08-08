package IssueTracker::App::IO::Out::GSheetWriter ; 

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

   our $module_trace       = 0 ; 
   our $IsUnitTest         = 0 ; 
   our $appConfig          = {} ; 
   our $objLogger          = {} ; 
   our $objFileHandler     = {} ; 
   our $ProductInstanceDir = {} ; 


   #
   # ------------------------------------------------------
   # GSheetWriter
   # ------------------------------------------------------
   sub doWriteGSheetFromHashRef {

      my $self             = shift ; 
      my $hsr_meta         = shift ; 
      my $hsr              = shift ; 
      my $table            = shift ; 
      my $msg              = 'unknown error during google sheet write' ; 
      my $ret              = 1 ; 
      #debug ok p($hsr ) if $module_trace == 1 ; 
      p ( $hsr_meta )  ; 

      my $objTimer = 'IssueTracker::App::Utils::Timer'->new() ; 
	   my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
      my $nice_month  = "$year" . '-' . "$mon" ; 
      my $nice_datetime  = "$year" ."$mon". "$mday" . '_' . "$hour" . "$min" . "$sec" ; 
      my $nice_date  = "$year" . '-' . "$mon" . '-' . "$mday" ; 



      my $oauth2 = Net::Google::DataAPI::Auth::OAuth2->new(
          client_id        => $ENV{CLIENT_ID},
          client_secret    => $ENV{CLIENT_SECRET},
          scope            => ['https://www.googleapis.com/auth/spreadsheets'],
      );

      my $url = $oauth2->authorize_url();
      # system("open '$url'");
      print "go to the following url with your browser \n" ; 
      print "$url\n" ; 
   
      sleep 40 ; 

      my $code = $ENV{ 'CODE' } ; 
      # binmode STDOUT, ":encoding(utf8)";
      # my $code = prompt('x', 'paste code: ', '', '');
      my $objToken = $oauth2->get_access_token($code);
      #       p( $objToken ) ; 
      my $refresh_token = $objToken->refresh_token() ; 

      print "my refresh token is : \n" ; 
      p($refresh_token ) ; 
      # debug p ( $objToken ) ; 

      my @rows = () ; 
      my $gs = Net::Google::Spreadsheets::V4->new(
            client_id      => $ENV{CLIENT_ID}
          , client_secret  => $ENV{CLIENT_SECRET}
          , refresh_token  => $refresh_token 
          , spreadsheet_id => '1hGNULaWpYwtnMDDPPkZT73zLGDUgv5blwJtK7hAiVIU'
      );

      my($content, $res);

      my $title = $table ; 

      my $sheet = $gs->get_sheet(title => $title);


      # create a sheet if does not exit
      unless ($sheet) {
          ($content, $res) = $gs->request(
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
      $gs->clear_sheet(sheet_id => $sheet_prop->{sheetId});



      # print the headers  
      my $rowid = 0 ; 
      my @row = () ; 
      push ( @row , $rowid ) ; 

      # foreach my $colid ( sort ( keys (  %{$hsr_meta->{ 'ColumnNames'}} ) ) ) {
      #foreach my $colid ( sort { $hsr_meta->{$a}->{'attnum'} <=> $hsr_meta->{$b}->{'attnum'}} keys (%$hsr_meta)) {
      my $hsr_meta1 = $hsr_meta->{ 'ColumnNames' } ; 
      foreach my $colid ( sort { $hsr_meta1->{$a}->{'attnum'} <=> $hsr_meta1->{$b}->{'attnum'}} keys (%$hsr_meta1)) {
         print "\$colid is $colid \n" ; 
         my $col_name     = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attname' } ; 
         push ( @row , $col_name ) ; 
      }
      push ( @rows , \@row ) ; 

      foreach my $guid ( sort { $hsr->{$a}->{ 'seq' } <=> $hsr->{$b}->{ 'seq' } } keys (%$hsr))  {

#         if ( $rowid % 2 == 1 ) {
#            $objFormat = $objWorkbook->add_format(
#                'font'  => 'Lucida Console'
#            );
#            $objFormat->set_bg_color('silver') ; 
#         }
#         else {
#            $objFormat = $objWorkbook->add_format(
#                'font'  => 'Lucida Console'
#            );
#            $objFormat->set_bg_color('white') ; 
#         }
          

         my $hsr_row = $hsr->{ "$guid" } ; 
         $rowid = $rowid+1 ; 

         my @row = () ; 
         push ( @row , $rowid ) ; 
         #foreach my $colid ( sort ( keys ( %{$hsr_meta->{'ColumnNames'}} ) ) ) {
         foreach my $colid ( sort { $hsr_meta1->{$a}->{'attnum'} <=> $hsr_meta1->{$b}->{'attnum'}} keys (%$hsr_meta1)) {
            my $col_name     = $hsr_meta->{'ColumnNames'}->{ $colid }->{ 'attname' } ; 
            print "col_name $col_name \n" ; 
            print "colid $colid \n" ; 
            push ( @row , $hsr_row->{ $col_name } ) ; 
            # $objWorksheet->write($rowid, $colid, $hsr_row->{ $col_name } , $objFormat )  ; 
         }
         push ( @rows , \@row ) ; 
      } 
      #eof foreach row 
      
      p(@rows ) ; 

      $rowid++ ; 
      # import data
      my @requests = ();
      my $idx = 0;

#      my @rows = (
#          [qw(name age favorite)], # header
#          [qw(tarou 31 curry)],
#          [qw(jirou 18 gyoza)],
#          [qw(saburou 27 ramen)],
#      );

      for my $row (@rows) {
          push @requests, {
              pasteData => {
                  coordinate => {
                      sheetId     => $sheet_prop->{sheetId},
                      rowIndex    => $idx++,
                      columnIndex => 0,
                  },
                  data => $gs->to_csv(@$row),
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
              fields => 'userEnteredFormat(backgroundColor,textFormat,horizontalAlignment)',
          },
      };

      ($content, $res) = $gs->request(
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

   
   # Adjust the column widths to fit the longest string in the column
   sub autofit_columns {
    
        my $self      = shift ; 
        my $worksheet = shift;
        my $hsr_meta  = shift ; 
        my $col       = 0;
    
        for my $width (@{$worksheet->{'issue'}}) {
           
            $worksheet->set_column($col, $col, 40 ) if $width;
            # $worksheet->set_column($col, $col, $hsr_meta->{'ColumnWidths'}->{ $col } ) if $width;
            $col++;
        }
   }
   

 
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

      #debug print "GSheetWriter::doInitialize appConfig : " . p($appConfig );
      $ProductInstanceDir   = $appConfig->{ 'ProductInstanceDir' } ; 

	   $objFileHandler   = 'IssueTracker::App::Utils::IO::FileHandler'->new ( \$appConfig ) ; 
	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize




1;


__END__
