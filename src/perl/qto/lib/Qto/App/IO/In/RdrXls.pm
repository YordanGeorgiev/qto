package Qto::App::IO::In::RdrXls;

use strict; use warnings; use utf8;

require Exporter;
use AutoLoader;
use Encode qw( encode decode encode_utf8 is_utf8 );
use POSIX qw(strftime);

use Carp;
use Data::Printer;
use Spreadsheet::ParseExcel;
use Text::Iconv;
use Spreadsheet::XLSX;

use Qto::App::Utils::Logger;
use Qto::App::Utils::Timer;
use Spreadsheet::ParseExcel::FmtJapan;

our $module_trace       = 0;
our $IsUnitTest         = 0;
our $appConfig          = q{};
our $objLogger          = q{};
our $ProductInstanceDir = {};
our @tables             = () ; 

#
# ------------------------------------------------------
# convert an excel file into a hash ref of hash ref of hash refs
# ------------------------------------------------------
sub doReadXlsFileToHsr3 {

  my $self           = shift;
  my $xls_file       = shift;
  my $objModel     = ${ shift @_ } ; 

  my $ret = 1;
  my $msg = "read the following xls_file: $xls_file";
  $objLogger->doLogInfoMsg($msg);

  my $formatter    = Spreadsheet::ParseExcel::FmtJapan->new();
  my $objXlsParser = 'Spreadsheet::ParseExcel'->new();

  # optionally : 
  # my $objWorkbook      = $objXlsParser->Parse( $xls_file , $formatter );
  my $objWorkbook = $objXlsParser->Parse($xls_file);
  my $hsr3 = {};    # this is the data hash ref of hash refs

  # check if we are using Excel2007 open xml format
  if (!defined $objWorkbook) {

    # works too my $objConverter = () ;
    my $objConverter = Text::Iconv->new("utf-8", "utf-8");

    $objWorkbook = Spreadsheet::XLSX->new($xls_file, $objConverter);

    # exit the whole application if there is no excel defined
    if (!defined $objWorkbook) {
      $msg = "cannot parse \$xls_file $xls_file $! $objXlsParser->error()";
      $objLogger->doLogErrorMsg("$msg");
      return ($ret, $msg, {});
    }

  } 

  my $flg_found_at_least_one_table = 0 ; 
  $msg = "did not find any of the tables:  " . "@tables" ; 
  foreach my $worksheet (@{$objWorkbook->{Worksheet}}) {

    my $hsWorkSheet   = {};
    my $WorkSheetName = $worksheet->{'Name'};
    $objLogger->doLogInfoMsg("check worksheet: " . $WorkSheetName) ; 

	 next unless grep( /^$WorkSheetName$/, @tables ) ; 

    $flg_found_at_least_one_table++ ; 
    $msg = "read worksheet: " . $WorkSheetName ; 
    $objLogger->doLogInfoMsg( $msg ) ; 

    my $RowMin = $worksheet->{'MinRow'};
    my $RowMax = $worksheet->{'MaxRow'};

    my $row_num = 0;
    for my $row ($RowMin .. $RowMax) {

      my $hsRow  = {};
      my $MinCol = $worksheet->{'MinCol'};
      my $MaxCol = $worksheet->{'MaxCol'};

      #debug rint "MinCol::$MinCol , MaxCol::$MaxCol \n" ;
      my $col_num = 0;

      #debug rint "row_num:: $row_num \n" ;
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

          # debug rint "token is :: " . $token . "\n" ;
          # debug rint "encoding is :: " . $encoding . "\n" ;
          # debug rint "is_utf8 " . is_utf8 ( $token ) ;
          # p($token);

          # and this is one of those wtf moments ?!
          $token =~ s/\&gt;/\>/g;
          $token =~ s/\&lt;/\</g;
          $token =~ s/\&amp;/\&/g;
        }

        $hsRow->{$header} = $token;
        $col_num++;
      } #eof for col

      $hsWorkSheet->{"$row_num"} = $hsRow;
      $row_num++;

    } #eof foreach row

    $hsr3->{"$WorkSheetName"} = $hsWorkSheet;

    # p($hsWorkSheet );
  }

   $ret = 0 if $flg_found_at_least_one_table > 0 ; 
   $msg = 'xls file parse OK' if $flg_found_at_least_one_table > 0 ;

   $objModel->set('hsr3' , $hsr3 ); 
   return ($ret, $msg);

}    


# Adjust the column widths to fit the longest string in the column
sub autofit_columns {

  my $self      = shift;
  my $worksheet = shift;
  my $hsr_meta  = shift;
  my $col       = 0;

  for my $width (@{$worksheet->{'data'}}) {

    $worksheet->set_column($col, $col, 40) if $width;
    #debug $worksheet->set_column($col, $col, $hsr_meta->{'ColumnWidths'}->{ $col } ) if $width;
    $col++;
  }
}


# -----------------------------------------------------------------------------
# doInitialize the object with the minimum data it will need to operate
# -----------------------------------------------------------------------------
sub doInitialize {

  my $self = shift;

  #debug rint "ExcelHandler::doInitialize appConfig : " . p($appConfig );
  $objLogger          = 'Qto::App::Utils::Logger'->new(\$appConfig);
  $ProductInstanceDir = $appConfig->{'ProductInstanceDir'};
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
      $objLogger->doLogInfoMsg("RdrXls sub newtable " . $table ) ; 
    }
  return $self;
}


1;


__END__
