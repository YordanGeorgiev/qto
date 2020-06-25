package Qto::App::RAM::CnrHsr2ToTxt ; 

	use strict; use warnings;
   use utf8 ; 
	my $VERSION = '1.1.1';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter  Qto::App::Utils::OO::SetGetable);
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
   
   use base qw(Qto::App::Utils::OO::SetGetable);
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

      use Qto::App::RAM::CnrHsr2ToTxt ; 
		my $objCnrHsr2ToTxt = 
			'Qto::App::RAM::CnrHsr2ToTxt'->new ( \$config ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut

sub doConvertHashRefToStr {

  my $self              = shift;
  my $objModel        = ${shift @_} ;
  my $hsr2              = $objModel->get('hsr2');

  my $msg
    = 'unknown error during hash ref of hash references to string conversion !!!';
  my $ret        = 1;
  my $str_issues = q{};
  my $str_activity_issues = " ";
  my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
  my $run_time         = $objTimer->GetHumanReadableTime();
  p($hsr2) if $module_trace == 1;
  my $str_header = '# START ' . uc($term) . ' @%run_time%
   
## what will I do till the next period 
#---------------------------
#';

  my $str_footer = '

# STOP  ' . uc($term) . ' @%run_time%
';

  $str_issues .= $str_header . "\n\n";
  my $prev_category = q{};
  my @attributes
    = qw (guid seq run_time category current description level name prio start_time stop_time status);
  my $items_order_by_attribute = $ENV{'items_order_by_attribute'} || 'start_time' ; 

  unless (grep(/^$items_order_by_attribute$/, @attributes)) {
    $msg
      = 'Did not find the value of the pre-defined items_order_by_attribute: "';
    $msg
      .= $items_order_by_attribute
      . '" from the issues attributes list: "'
      . " \n @attributes \n" . '"';
    $objLogger->doLogWarningMsg($msg);
    $items_order_by_attribute = 'start_time';
    $msg = 'using the "start_time" as the default sorting attribute';
    $objLogger->doLogWarningMsg($msg);
  }

  my $operator = '<=>';
  $operator = 'cmp' unless (looks_like_number($items_order_by_attribute));

  foreach my $issue_id (
      eval 'sort {      '
    . '$hsr2->{$a}->{ $items_order_by_attribute }'
    . $operator
    . '$hsr2->{$b}->{ $items_order_by_attribute }'
    . '} keys (%$hsr2)')  {

    my $row = $hsr2->{$issue_id};
   
    # ignore camel case named cols and sheets
    my %row_h = %$row ; 
    %row_h = map { lc $_ => $row_h{$_} } keys %row_h;
    $row = \%row_h ; 
   
    # p $row ; 

    my $str_row = q{} ; 


    my $category    = $row->{'category'};
    my $current     = $row->{'current'};
    my $description = $row->{'description'};
    my $issue_id    = $row->{'issue_id'};
    my $level       = $row->{'level'};
    my $name        = $row->{'name'} || $row->{'description' } ; 
    $name =~ s/(\r){0,1}\n/ ;/gm ; 
    my $prio        = $row->{'prio'};
    my $start_time  = $row->{'start_time'};
    my $stop_time   = $row->{'stop_time'};
    my $status      = $row->{'status'};

    $status = $inverse_hsrStatus{$status} if $status ; 
    $status = 'unknwn' unless $status;
    $description =~ s/\r\n/\n/gm;
    $str_row .= "\n" if ($prev_category ne $category);
    $str_row .= $category . "\n" unless ($prev_category eq $category);
    my $levels_dash = '';

    for (my $i = 0; $i < $level; $i++) {
      $str_row  .= ' ';
      $levels_dash .= '-';
    }
    $str_row .= $levels_dash . ' ';
    $str_row .= $status . "\t\t" if $level == 1 ; 
    $str_row .= $status . "\t" if $level == 2;
    $str_row .= $status . " " if $level == 3;

    $str_row .= ($start_time . " ")
      if (defined($start_time) && $start_time ne 'NULL');

    if (defined $stop_time && $stop_time ne 'NULL' && $stop_time ne '') {
      $str_row .= ('- ' . $stop_time . " ");
    }
    $str_row .= $name . "\n";
    $prev_category = $category;


    # because we want activities to be printed at the end of the txt file
    if ( $items_order_by_attribute eq 'start_time' && $start_time eq "") {
      $str_activity_issues .= $str_row ; 
    } 
    else {
      $str_issues .= $str_row ; 
    }
  }


  $str_issues .= $str_activity_issues ; 
  $str_issues .= $str_footer . "\n\n";
  $str_issues =~ s|%run_time%|$run_time|g;
  $objModel->set('str_issues' , $str_issues );
  $msg = " OK for hsr2 to txt conversion ";
  $ret = 0;

  return ($ret, $msg );
}
# eof sub doConvertHashRefToStr

   sub doPrepareHashForPrinting {

      my $self                   = shift ; 
      my $objModel             = ${shift @_ } ; 
      my $hsr2                   = $objModel->get('hsr2') ;

      my $msg        = 'unknown error during hash ref of hash references to string conversion !!!' ;  ; 
      my $ret        = 1 ; 
      my $str_issues = q{} ; 
      p ( $hsr2 ) if $module_trace == 1 ; 

      foreach my $issue_id ( sort { $hsr2->{$a}->{ 'guid' } cmp $hsr2->{$b}->{ 'guid' } } keys (%$hsr2))  {

         my $row = $hsr2->{ $issue_id } ; 

         $row->{ 'run_date'} = ''      unless defined ( $row->{ 'run_date' } ) ; 
         $row->{ 'category'} = ''      unless defined ( $row->{ 'category' } ) ; 
         $row->{ 'level'} = 2          unless defined ( $row->{ 'level' } ) ; 
         $row->{ 'prio'} = 5           unless defined ( $row->{ 'prio' } ) ; 
         $row->{ 'status'} = 'unknown' unless defined ( $row->{ 'run_date' } ) ; 
         $row->{ 'name'} = ''          unless defined ( $row->{ 'name' } ) ; 
         $row->{ 'description'} = $row->{'name'} unless defined ( $row->{ 'description' } ) ; 
         $row->{ 'start_time'} = ''   unless defined ( $row->{ 'start_time' } ) ; 
         $row->{ 'stop_time'} = ''   unless defined ( $row->{ 'stop_time' } ) ; 
         $row->{ 'updated_by'} = ''      unless defined ( $row->{ 'updated_by' } ) ; 
         $row->{ 'owner'} = ''      unless defined ( $row->{ 'owner' } ) ; 

      $msg = " OK for hsr2 to txt conversion " ;  
      $ret = 0 ; 
      }

      return ( $ret , $msg ) ;
   }
   # eof sub doPrepareHashForPrinting

	
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
