package IssueTracker::App::IO::In::FmtDefault ; 

use strict;
use base 'Spreadsheet::ParseExcel::FmtDefault';
use Encode qw(decode);

# the super-class isn't very friendly to sub-classing, so we have to o
# +verride this to make
# sure it's blessed into the right class
sub new {
       my $class = shift;
       return bless {}, $class;
}

# the only other method we need to override...
sub TextFmt {
       my ($self,$data,$encoding) = @_;

       # Spreadsheet::ParseExcel will pass in the encoding to us!
       # or, it passes nothing in if it's iso-8859-1
       $encoding ||= 'iso-8859-1';

       # we perform the decoding in a "fatal" manner so that if it fails,
       # we'll just pass the data back as-is
       my $decoded = eval { decode($encoding,$data,1) } || $data;

       return $decoded;
}



1;


__END__
