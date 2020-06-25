package Qto::App::RAM::CnrHsr2ToJson ; 

	use strict; use warnings; use autodie qw(:all);
   use utf8 ; 
	my $VERSION = '1.1.1';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;

	use Cwd qw/abs_path/;
	use File::Path qw(make_path) ;
	use File::Find ; 
	use File::Copy;
	use Sys::Hostname;
	use Data::Printer ; 
	use Carp qw /cluck confess shortmess croak carp/ ; 
   use Scalar::Util qw /looks_like_number/;
   use JSON;

   use base qw(Qto::App::Utils::OO::SetGetable);
   use base qw(Qto::App::Utils::OO::AutoLoadable); 
	use Qto::App::Utils::Logger ;
   use Qto::App::Mdl::Model ; 
      
   binmode(STDIN,  ':utf8');
   binmode(STDOUT, ':utf8');
   binmode(STDERR, ':utf8');

   our $module_trace             = 0 ; 
	our $config						= {} ; 
	our $HostName 						= '' ; 
	our $objLogger						= {} ; 
	our $objController				= {} ; 
   our $hsrStatus                = {} ; 
   our %inverse_hsrStatus        = (); 
   our $term                     = 'daily' ; 


=head1 SYNOPSIS

	doResolves the product version and base dirs , bootstraps config files if needed

      use Qto::App::RAM::CnrHsr2ToJson ; 
		my $objCnrHsr2ToJson = 
			'Qto::App::RAM::CnrHsr2ToJson'->new ( \$config ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut

   sub doConvertHashRefToJsonStr {

     my $self              = shift;
     my $objModel        = ${shift @_} ;
     my $hsr2              = $objModel->get('hsr2');

     my $msg
       = 'unknown error during hash ref of hash references to string conversion !!!';
     my $ret        = 1;
     my $str_json = encode_json $hsr2 ;
     my $str_activity_issues =  
     # debug p($hsr2) ;

     $objModel->set('str_items' , $str_json );
     $msg = " OK for hsr2 to json conversion ";
     $ret = 0;

     return ($ret, $msg );
   }
   # eof sub doConvertHashRefToStr


	
   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$config     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
	   $objController       = shift ; 
      $term                = shift || 'daily' ; 
	
      # might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

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
      my $self          = shift ; 

      %$self = (
           config => $config
       );

	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$config ) ;
      
      $hsrStatus = {
           'eval'    => '01-eval'      # evaluate whether or not to do it
         , 'todo'    => '02-todo'      # must do it till the end of the period
         , 'late'    => '02-late'      # must do it till the end of the period
         , 'rem'     => '02-rem'       # remember to act till the end of the period
         , 'wip'     => '03-wip'       # is work in progress - aka is being done right now
         , 'act'     => '03-act'       # is being actively done , aka more of an activity type
         , 'actv'    => '03-actv'      # is being actively done , aka more of an activity type
         , 'disg'    => '03-disg'      # to discard - a more positive
         , 'diss'    => '04-diss'      # to dissmiss - a more negative
         , 'fail'    => '04-fail'      # to failmiss or discard
         , 'test'    => '05-test'      # to test some implementation
         , 'tst'     => '05-tst'       # to test some implementation
         , 'hld'     => '06-onhold'    # the issue is on hold - 
         , 'hold'    => '06-hold'    # the issue is on hold - 
         , 'part'    => '06-part'      # the issue has been partly completed - might have more work
         , 'flow'    => '06-flow'      # follow an event or action to occur
         , 'qas'     => '07-qas'       # the issue is in quality assurance mode
         , 'qa'      => '07-qa'        # the issue is in quality assurance mode
         , 'blck'    => '08-blocked'   # the issue is blocked
         , 'done'    => '09-done'      # the issue is done
      }; 
      
      %inverse_hsrStatus = reverse %$hsrStatus;

      return $self ; 
	}	
	#eof sub doInitialize
   

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
			  "BOOM! BOOM! BOOM! \n RunTime Error !!! \n Undefined Function $name(@_) \n ";
			croak "$self , $msg $!";
		};
		goto &$AUTOLOAD;    # Restart the new routine.
	}   
	# eof sub AUTOLOAD

		

	# -----------------------------------------------------------------------------
	# wrap any logic here on clean up for this class
	# -----------------------------------------------------------------------------
	sub RunBeforeExit {

		my $self = shift;

		#debug rint "%$self RunBeforeExit ! \n";
	}
	#eof sub RunBeforeExit


	# -----------------------------------------------------------------------------
	# called automatically by perl's garbage collector use to know when
	# -----------------------------------------------------------------------------
	sub DESTROY {
		my $self = shift;

		#debug rint "the DESTRUCTOR is called  \n" ;
		$self->RunBeforeExit();
		return;
	}   
	#eof sub DESTROY


	# STOP functions
	# =============================================================================

	


1;

__END__

=head1 NAME

Qto 

=head1 SYNOPSIS

use Qto  ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app config hash 

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 




# ---------------------------------------------------------
# VersionHistory: 
# ---------------------------------------------------------
#
1.2.0 --- 2014-09-11 20:44:26 -- tests on Windows 
1.1.0 --- 2014-08-27 11:29:25 -- tests passed with Test::More
1.0.0 --- 2014-08-25 08:25:15 -- refactored away from main calling script

=cut 

1;


__END__
