use strict ; use warnings ; 
package IssueTracker::App::Mdl::MdlHsr2 ; 

	my $VERSION = '1.1.0';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter IssueTracker::App::Utils::OO::SetGetable IssueTracker::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;


	use Carp qw /cluck confess shortmess croak carp/ ; 
   use Data::Printer ; 

   use parent 'IssueTracker::App::Utils::OO::SetGetable' ;
   use parent 'IssueTracker::App::Utils::OO::AutoLoadable' ;

   our $appConfig       = {} ; 
   our $hsr2             = {} ; # this is the hash ref of hash refs 
   our $mhsr2            = {} ; # and this is the meta hash ref of hash refs 
   our $objLogger       = {} ; 

   # 
	# -----------------------------------------------------------------------------
	# merge a hash ref to the model's hash ref
   # src: https://stackoverflow.com/a/1242125/65706
	# -----------------------------------------------------------------------------
   sub addHsr2{
      my $self = shift ; 
      my $row  = shift ; 

      @{$hsr2}{keys %$row} = values %$row;
   }


	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		my $hsr2          = shift @_  || $hsr2 ; 
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
basically perl hash ref of hash refs with specific MUST-HAVE keys - uuid or id

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 
