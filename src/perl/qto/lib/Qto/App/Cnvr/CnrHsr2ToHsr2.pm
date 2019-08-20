use strict ; use warnings ; 
package Qto::App::Cnvr::CnrHsr2ToHsr2 ; 

our $config = {} ; 
use Data::Printer ; 
use Carp ; 

our $objModel = {} ; 


   #
	# -----------------------------------------------------------------------------
	# filter all the elements which have the same fltr key and val, usage:
   # my $objCnrHsr2ToHsr2 = 
   #     'Qto::App::Cnvr::CnrHsr2ToHsr2'->new ( \$config , \$objModel ) ; 
   # p $objCnrHsr2ToHsr2->doFilter($msr2, 'table_name' , 'monthly_issues' );
	# -----------------------------------------------------------------------------
   sub doFilter {

      my $self          = shift ; 
      my $hsr2          = shift ; 
      my $fltr_key      = shift ; 
      my $fltr_val      = shift ; 
      my $out_hsr2      = {} ; 

      my $i       = 0 ;
      foreach my $key ( sort keys %$hsr2 ) {

         my $el      = $hsr2->{ $key } ; 
         foreach my $k ( keys %$el ) {

            # print "k is $k \n" ; 
            # print "val is " . $el->{ $k } . "\n" ; 

            if ( $k eq $fltr_key && $el->{ $k } eq $fltr_val ) {
               $out_hsr2->{ $i } = $el ; 
               print "should add the following element \n" ; 
               p $el ; 
               $i = $i + 1 ; 
            }
         }
      }
      return $out_hsr2 ; 
   } 


   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		$config     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed !!!' ; 

		my $self = {}; bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  
  

1;

__END__

=head1 NAME

CnrHsr2ToHsr2

=head1 SYNOPSIS

use Qto::App::Cnvr::CnrHsr2ToHsr2 ; 

my $objCnrHsr2ToHsr2 = 
   'Qto::App::Cnvr::CnrHsr2ToHsr2'->new ( \$config , \$objModel ) ; 
my $hsr2 = $objCnrHsr2ToHsr2->doFilter($msr2, 'table_name' , 'monthly_issues' );

=head1 DESCRIPTION
the converter between xls read produced hsr2 and a hierarchichal model
containing hsr2
=head2 EXPORT


=head1 SEE ALSO

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 
