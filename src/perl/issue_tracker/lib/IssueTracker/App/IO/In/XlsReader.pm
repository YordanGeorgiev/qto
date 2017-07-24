package IssueTracker::App::IO::In::XlsReader;

use strict;
use warnings;
use utf8;

require Exporter;
use AutoLoader;
use Encode qw( encode decode encode_utf8 is_utf8 );
use POSIX qw(strftime);

use Data::Printer;
use Carp;
use Spreadsheet::ParseExcel;
use Text::Iconv;
use Spreadsheet::XLSX;

use IssueTracker::App::Utils::IO::FileHandler;
use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Utils::Timer;
use Spreadsheet::ParseExcel::FmtJapan;

our $module_trace       = 0;
our $IsUnitTest         = 0;
our $appConfig          = q{};
our $objLogger          = q{};
our $objFileHandler     = q{};
our $ProductInstanceDir = {};
our @tables             = () ; 

#
# ------------------------------------------------------
# convert an excel file into a hash ref of hash ref of hash refs
# ------------------------------------------------------
sub doReadXlsFileToHsr2 {
  my $self     = shift;
  my $xls_file = shift;

  my $ret = 1;
  my $msg = "open the xls_file: $xls_file";
  $objLogger->doLogDebugMsg($msg);

  my $formatter    = Spreadsheet::ParseExcel::FmtJapan->new();
  my $objXlsParser = 'Spreadsheet::ParseExcel'->new();

  # my $objWorkbook      = $objXlsParser->Parse( $xls_file , $formatter );
  my $objWorkbook = $objXlsParser->Parse($xls_file);
  my $hsr2 = {};    # this is the data hash ref of hash refs

  # check if we are using Excel2007 open xml format
  if (!defined $objWorkbook) {

    # works too my $objConverter = () ;
    my $objConverter = Text::Iconv->new("utf-8", "utf-8");

    # my $objConverter  = ();
    $objWorkbook = Spreadsheet::XLSX->new($xls_file, $objConverter);

    # exit the whole application if there is no excel defined
    if (!defined $objWorkbook) {
      $msg = "cannot parse \$xls_file $xls_file $! $objXlsParser->error()";
      $objLogger->doLogErrorMsg("$msg");
      return ($ret, $msg, {});
    }

  }    #eof if not $objWorkbook


  foreach my $worksheet (@{$objWorkbook->{Worksheet}}) {

    my $hsWorkSheet   = {};
    my $WorkSheetName = $worksheet->{'Name'};

	 next unless grep( /^$WorkSheetName$/, @tables ) ; 
    $objLogger->doLogInfoMsg("read worksheet: " . $WorkSheetName) ; 
    

    my $RowMin = $worksheet->{'MinRow'};
    my $RowMax = $worksheet->{'MaxRow'};

    #    my ( $RowMin, $RowMax) = $worksheet->row_range();
    #    my ( $MinCol, $MaxCold ) = $worksheet->col_range();

    my $row_num = 0;
    for my $row ($RowMin .. $RowMax) {

      my $hsRow  = {};
      my $MinCol = $worksheet->{'MinCol'};
      my $MaxCol = $worksheet->{'MaxCol'};

      #debug print "MinCol::$MinCol , MaxCol::$MaxCol \n" ;
      my $col_num = 0;

      #print "row_num:: $row_num \n" ;
      for my $col ($MinCol .. $MaxCol) {

        # print "col_num:: $col_num \n" ;
        my $cell       = $worksheet->{'Cells'}[$row][$col];
        my $obj_header = $worksheet->{'Cells'}[0][$col];
        my $header     = $obj_header->unformatted();
        my $token      = '';

        # to represent NULL in the sql
        unless (defined($cell)) {
          $token = 'NULL';
        }
        else {
          # this one seems to return the value ONLY if
          # it is formateed properly with Ctrl + 1
          # $token = $cell->Value();
          # this one seems to return the value as it has been typed into ...
          $token = $cell->unformatted();

          # this is must have !!!
          $token = decode('utf8', $token);

          # $token = $cell->{'Val'} ;
          my $encoding = $cell->encoding();

          # debug print "token is :: " . $token . "\n" ;
          # debug print "encoding is :: " . $encoding . "\n" ;
          # debug print "is_utf8 " . is_utf8 ( $token ) ;
          # p($token);

          # and this one of those wtf moments ?!
          $token =~ s/\&gt;/\>/g;
          $token =~ s/\&lt;/\</g;
          $token =~ s/\&amp;/\&/g;
        }

        $hsRow->{$header} = $token;
        $col_num++;
      }

      #eof for col
      $hsWorkSheet->{"$row_num"} = $hsRow;
      $row_num++;

      # debug sleep 3 ;
    }    #eof foreach row

    $hsr2->{"$WorkSheetName"} = $hsWorkSheet;

    p($hsWorkSheet );
  }

  $ret = 0;
  $msg = 'xls file parse OK';


  return ($ret, $msg, $hsr2);

}    


# Adjust the column widths to fit the longest string in the column
sub autofit_columns {

  my $self      = shift;
  my $worksheet = shift;
  my $hsr_meta  = shift;
  my $col       = 0;

  for my $width (@{$worksheet->{'data'}}) {

    $worksheet->set_column($col, $col, 40) if $width;

# $worksheet->set_column($col, $col, $hsr_meta->{'ColumnWidths'}->{ $col } ) if $width;
    $col++;
  }
}


# -----------------------------------------------------------------------------
# doInitialize the object with the minimum data it will need to operate
# -----------------------------------------------------------------------------
sub doInitialize {

  my $self = shift;

  #debug print "ExcelHandler::doInitialize appConfig : " . p($appConfig );
  $objLogger          = 'IssueTracker::App::Utils::Logger'->new(\$appConfig);
  $ProductInstanceDir = $appConfig->{'ProductInstanceDir'};
  $objFileHandler
    = 'IssueTracker::App::Utils::IO::FileHandler'->new(\$appConfig);
}


#
# -----------------------------------------------------------------------------
# the constructor
# source:http://www.netalive.org/tinkering/serious-perl/#oop_constructors
# -----------------------------------------------------------------------------
sub new {

  my $class = shift;    # Class name is in the first parameter
  $appConfig = ${shift @_} if (@_);
  @tables = @{ $_[0] } ; 
   
  # Anonymous hash reference holds instance attributes
  my $self = {};
  bless($self, $class);    # Say: $self is a $class

  $self->doInitialize();


    foreach my $table ( @tables ) {
      $objLogger->doLogInfoMsg("XlsReader sub newtable " . $table ) ; 
    }
  return $self;
}


1;


__END__
