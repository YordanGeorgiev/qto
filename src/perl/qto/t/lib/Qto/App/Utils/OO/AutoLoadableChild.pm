use strict ; use warnings ; 

package AutoLoadableChild ; 
# package Qto::App::Utils::OO::AutoLoadableChild ; 

	require Exporter;
	our @ISA = qw(Exporter  Qto::App::Utils::OO::AutoLoadable);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;

# you can copy this 
use base qw(Qto::App::Utils::OO::AutoLoadable);


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor
=cut 

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class = shift;    # Class name is in the first parameter
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  


1 ; 

__END__
