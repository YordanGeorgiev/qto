use strict ; use warnings ; 

package IssueTracker::App::Utils::OO::SetGetable ; 

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
   use Carp qw /carp cluck croak confess/ ; 

   our @EXPORT_OK = qw(get set dumpFields);  # symbols to export on request

	# -----------------------------------------------------------------------------
	# return a field's value - aka the "getter"
   # chk: http://perldoc.perl.org/Carp.html
	# -----------------------------------------------------------------------------
	sub get {

		my $self = shift;
		my $name = shift;

		print STDERR "\@TRYING to get an undef name" unless ( defined $name ) ; 
      print STDERR "\@TRYING to get an undefined value" unless ( defined $self->{ $name } ); 

		return $self->{ $name };
	}    


	# -----------------------------------------------------------------------------
	# set a field's value - aka the "setter"
	# -----------------------------------------------------------------------------
	sub set {

		my $self  = shift;
		my $name  = shift;
		my $value = shift;

		print STDERR "\@TRYING to set an undef name" unless ( defined $name ) ; 
      print STDERR "\@TRYING to set an undefined value" unless ( defined $value ) ; 

		$self->{ "$name" } = $value;
	}
	# eof sub set

   # -----------------------------------------------------------------------------
	# return the fields of this obj instance
	# -----------------------------------------------------------------------------
	sub dumpFields {
		my $self      = shift;
		my $strFields = ();
		foreach my $key ( keys %$self ) {
			$strFields .= " $key = $self->{$key} \n ";
		}

		return $strFields;
	}    

   
1;

__END__


=head1 NAME

SetGetable

=head1 SYNOPSIS

# start ::: child class
use strict ; use warnings ; 

package SetGetableChild ; 

	require Exporter;
	our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;
   use base qw(IssueTracker::App::Utils::OO::SetGetable);

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

   use SetGetableChild ; 
   # create the child
   my $objSetGetableChild = 'SetGetableChild'->new();

   my $val_to_set = 'foobar' ; 
   $objSetGetableChild->set('val_to_set' , $val_to_set );
   my $val_to_chk = $objSetGetableChild->get('val_to_set');


# stop  ::: in the caller of the child obj 

=head1 DESCRIPTION
   A simple base module for setters and getters. 
   Java coders would have to ALWAYS ( and countless times ) define and implement
   objJavaClass.setFoo(bar)
   objJavaClass.getFoo()
   
   while with perl the childs of this module would ONLY ONCE write 
   objChild->set("foo" , "bar" )
   objChild->get("foo") ; 

   Cool , häh ?!
=head2 EXPORT


=head1 SEE ALSO

perldoc Exporter
perldoc perlobj

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 
