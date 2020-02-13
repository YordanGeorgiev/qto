use strict ; use warnings ; 

package Qto::App::Utils::OO::AutoLoadable ; 

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
   use Carp ; 


   our @EXPORT_OK = qw(AUTOLOAD);  # symbols to export on request


=head2
	# -----------------------------------------------------------------------------
	# overrided autoloader prints - a run-time error - perldoc AutoLoader
	# -----------------------------------------------------------------------------
=cut
	sub AUTOLOAD {

		my $self = shift;
		no strict 'refs';
		my $name = our $AUTOLOAD;
		*$AUTOLOAD = sub {
			my $msg =
			  "BOOM! BOOM! BOOM! \n RunTime Error !!! \n Undefined Function in $name(@_) \n ";
			croak "$self , $msg $!";
		};
		goto &$AUTOLOAD;    # Restart the new routine.
	}   
	# eof sub AUTOLOAD

   #
	# -----------------------------------------------------------------------------
	# wrap any logic here on clean up for this class
	# -----------------------------------------------------------------------------
	sub RunBeforeExit {

		my $self = shift;
		my $name = our $AUTOLOAD;
	   # debug rint "$name RunBeforeExit ! \n";
	}
	#eof sub RunBeforeExit


	# -----------------------------------------------------------------------------
	# called automatically by perl's garbage collector use to know when
	# -----------------------------------------------------------------------------
	sub DESTROY {
		my $self = shift;

		#debug rint "the DESTRUCTOR for $self is called  \n" ;
		$self->RunBeforeExit();
		return;
	}   
	#eof sub DESTROY
   
1;

__END__


=head1 NAME

AutoLoadable

=head1 SYNOPSIS

# start ::: child class
use strict ; use warnings ; 

package AutoLoadableChild ; 

	require Exporter;
	our @ISA = qw(Exporter  Qto::App::Utils::OO::AutoLoadable);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;
   use base qw(Qto::App::Utils::OO::AutoLoadable);

	sub new {

		my $class = shift;    # Class name is in the first parameter
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  


1 ; 

__END__

# stop ::: child class

# start ::: in the caller of the child obj 

   use AutoLoadableChild ; 
   # create the child
   my $objAutoLoadableChild = 'AutoLoadableChild'->new();

   # todo : add calling unexisting method desc

# stop  ::: in the caller of the child obj 

=head1 DESCRIPTION

   Cool , häh ?!
=head2 EXPORT


=head1 SEE ALSO

perldoc Exporter
perldoc perlobj

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 
