use strict ; use warnings ; 
package IssueTracker::App::Mdl::MdlHsr2 ; 

   use Carp ; 

   our $appConfig       = {} ; 
   my $hsr2             = {} ; # this is the hash ref of hash refs 
   my $mhsr2            = {} ; # and this is the meta hash ref of hash refs 
   our $objLogger       = {} ; 


	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$hsr2          = shift @_  || $hsr2 ; 
		$mhsr2          = shift @_  || $mhsr2 ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 
		return $self;
	}  
	#eof const
	
   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
           , hsr2 => $hsr2
           , mhsr2 => $mhsr2
      );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
      

      return $self ; 
	}	
	#eof sub doInitialize



1;


__END__

=head1 NAME

MdlHsr2

=head1 SYNOPSIS

use MdlHsr2 ; 


=head1 DESCRIPTION
the main model of the application : 
passed between the readers, writers and the converters

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 
