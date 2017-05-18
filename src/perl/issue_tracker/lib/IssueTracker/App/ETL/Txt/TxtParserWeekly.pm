package IssueTracker::App::ETL::Txt::TxtParserWeekly ; 

	use strict; use warnings;
   use utf8 ; 
	my $VERSION = '1.1.1';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
	use AutoLoader;

	use Cwd qw/abs_path/;
	use File::Path qw(make_path) ;
	use File::Find ; 
	use File::Copy;
	use File::Copy::Recursive ; 
	use Sys::Hostname;
	use Carp qw /cluck confess shortmess croak carp/ ; 
	use IssueTracker::App::Utils::IO::FileHandler ; 
	use IssueTracker::App::Utils::Logger ;
	use Data::Printer ; 
      
   binmode(STDIN,  ':utf8');
   binmode(STDOUT, ':utf8');
   binmode(STDERR, ':utf8');

   our $module_trace             = 0 ; 
	our $appConfig						= {} ; 
	our $HostName 						= '' ; 
	our $objLogger						= {} ; 
	our $objFileHandler				= {} ; 
   our $hsrStatus                = {} ; 
   our %inverse_hsrStatus        = (); 





=head1 SYNOPSIS

	doResolves the product version and base dirs , bootstraps cnfig files if needed

		use IssueTracker::App::ETL::IssueTracker ;
		my $objIssueTracker = 
			'IssueTracker::App::ETL::IssueTracker'->new ( \$appConfig ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut


	#
	# --------------------------------------------------------
	# read the issues file for the Weekly period
	# --------------------------------------------------------
	sub doReadIssueFile {

      my $self       = shift ; 
      my $issues_file = shift ; 

      my $msg  = '' ; 
      my $ret  = 1 ; 
      my $str_issues_file = q{} ; 

      $msg =  "START TxtParserWeekly::doReadIssueFile" ; 
      $objLogger->doLogInfoMsg ( $msg ) ; 

      unless ( -r $issues_file ) {
         $msg = "the issues_file : $issues_file does not exist !!!" ; 
         $objLogger->doLogFatalMsg ( $msg ) ; 
      }
      else {
         # src: http://ahinea.com/en/tech/perl-unicode-struggle.html
         ( $ret , $msg , $str_issues_file ) 
            = $objFileHandler->doReadFileReturnString ( $issues_file , 'utf8' ) ; 
         return ( $ret , $msg ) unless $ret == 0 ; 

         $ret = 0 ; 
         $msg = "read successfully issues_file : $issues_file" ; 
         $objLogger->doLogDebugMsg ( $str_issues_file ) if ( $module_trace == 1 ) ; 
      }
      
      $msg =  "STOP  TxtParserWeekly::doReadIssueFile with ret: $ret" ; 
      $objLogger->doLogInfoMsg ( $msg ) ; 
      return ( $ret , $msg , $str_issues_file ) ; 
	}
	



   sub doConvertStrToHashRef {

      my $self       = shift ; 
      my $str        = shift ; 

      my $ret        = 1 ; 
      my $msg        = 'unknown error while converting string to hash reference' ; 
      my $hsr        = {} ; 

      my $objTimer   = 'IssueTracker::App::Utils::Timer'->new() ; 
	   my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer->GetTimeUnits();
      my $nice_date  = $year . '-' . $mon . '-' . $mday ; 
 
      # each item starts with new line may be some space and - 
      my @arr_category_items  = split '\n(\s*)\n' , $str ; 
      my $i          = 0 ;  

      my $prev_start_time  = q{} ; 
      my $prev_stop_time   = q{} ; 

      if ( $str ) {      
         $msg = 'START TxtParserWeekly::doConvertStrToHashRef' ; 
         $objLogger->doLogInfoMsg ( $msg ) ;  

         foreach my $category_item ( @arr_category_items ) {
            last if ( $category_item =~ m/^\s*#\s*STOP\s+[(Weekly)|(WEEKLY)|(MONTHLY)] ([\d]{4}\-[\d]{2}\-[\d]{2})(.*)/g ) ; 


            my $debug_msg = "category_item: $category_item " ; 
            $objLogger->doLogDebugMsg ( $debug_msg ) if $module_trace == 1 ; 

            $msg = "category_item starts with ##" ; 
            $objLogger->doLogDebugMsg ( $msg ) if $category_item =~ m/^##/g ;
            
            # one or two # are either the file start , stop or the act , plan sections
            next if $category_item =~ m/^[#]{1,2} /g ; 
            
            next if $category_item =~ m/^--/g ; 
            
            # the first line of the category_item is the category
            my $category = ( split /\n/, $category_item )[0] ;  
            next unless ( $category ) ; 
            $category      =~ s/([\s\t]{0,5})(\w)([\s\t]{0,5})/$2/g ; 
            $category_item =~ s/$category//mg ; 
            my $tmp_category_item = $category_item ; 
            my $item_levels = {} ; 
            $tmp_category_item =~ s/\n(\s*)([\-]{1,7})/$self->doFillInLevelsPerRow( $2 , \$item_levels )/emg ; 
            my @arr_items  = split '\n(\s*)([\-]{1,7})' , $category_item ; 
            
            my $category_item_count = 0 ; 
            foreach my $item ( @arr_items ) {
               next unless $item ; 
               $hsr->{ $i } = {} ; 
               my $debug_msg = "item: $item " ; 
               $objLogger->doLogDebugMsg ( $debug_msg ) if $module_trace == 1 ; 
               $item =~ m/^\s*([a-zA-Z0-9]+)\s*(\t{1,5})(.*)/ ; 
               my $status = q{} ; 
               my $name = q{} ; 
               $status = $1 ; 
               $name = $3 ; 
               next unless $name ; 

               $hsr->{ $i }->{ 'issue_id' } = $i ;

               $item_levels->{ $category_item_count } = 1 
                  unless ( exists $item_levels->{ $category_item_count });
               $hsr->{ $i }->{ 'level' } = $item_levels->{ $category_item_count } + 1 ; 

               # $hsr->{ $i }->{ 'item' } = $item ; 
               $hsr->{ $i }->{ 'prio' } = $i ; 
               $hsr->{ $i }->{ 'category' }     = $category ; 
               $hsr->{ $i }->{ 'status' }       = $hsrStatus->{ $status } ; 

               # the title is the first line of the title description
               my $title = ( split /\n/, $name )[0] ; 

               # extract the start_time if any exists
               $title =~ m/^([\d]{2}:[\d]{2})\s+(.*)/g ; 
               my $start_time = q{} ; 
               $start_time = 'NULL'       if $status eq $1 ; 
               $start_time = $1           unless $status eq $1 ; 
               $title =~ s/$start_time//g  unless $start_time eq 'NULL' ; 
               
               # extract the stop_time if any exists 
               $title =~ m/^\s+[\-]\s+([\d]{2}:[\d]{2})(.*)/g ; 
               my $stop_time = q{} ; 

               if ( $start_time eq 'NULL' ) {
                  $stop_time = 'NULL' ;  
               }
               elsif ( !(defined $1) ) {
                  $stop_time = 'NULL' ;  
               }
               elsif ( $status eq $1 ) {
                  $stop_time = 'NULL' ;  
               }
               elsif ( defined $1 ) {
                  $stop_time = $1 ; 
               }
               else {
                  $stop_time = $1 ; 
               }
               $title =~ s/^\s*[\-]\s*$stop_time\s+//g  unless $stop_time eq 'NULL' ; 
               $title =~ s/^\s+(.*)/$1/g ;   #remove trailing and fronting spaces
               
               # debug $objLogger->doLogDebugMsg ( "\$item is $item" ) ; 
               # debug $objLogger->doLogDebugMsg ( "\$status is $status" ) ; 
               # debug $objLogger->doLogDebugMsg ( "\$title is $title" ) ; 
               # debug $objLogger->doLogDebugMsg ( "\$1 is $1" ) ; 
               # debug $objLogger->doLogDebugMsg ( "\$start_time is $start_time" ) ; 
               # debug $objLogger->doLogDebugMsg ( "\$stop_time is $stop_time" ) ; 
               
               my $description = q{} ; 
               $description .= $start_time unless ( $start_time eq 'NULL' ) ;  
               $description .= ' - ' . $stop_time unless ( $stop_time eq 'NULL' ) ;  
               $description .= "\n" if $description ; 
               $description .= $title ; 
                 
               # and the title should not be longer than 90 chars
               $title = substr($title, 0, 90 ) . ' ...' if length ( $title ) > 90 ; 

               # if this is sub-item it should inherit the time of the upper item
               if ( $hsr->{ $i }->{ 'level' } > 2 ) {
                  $start_time = $prev_start_time ; 
                  $stop_time = $prev_stop_time ; 
               }
 
               $hsr->{ $i }->{ 'start_time' }      = $start_time ; 
               $hsr->{ $i }->{ 'stop_time' }       = $stop_time ; 
               $hsr->{ $i }->{ 'name' }            = $title ; 
               $hsr->{ $i }->{ 'description' }     = $description ; 
               $hsr->{ $i }->{ 'run_date' }        = $nice_date ; 
               
               if ( $module_trace == 1 ) { 
                  $debug_msg = " START :::: $i" if 
                  $objLogger->doLogDebugMsg ( $debug_msg ) ;  
                  p ( $hsr->{ $i } ) ; 
                  $debug_msg = " STOP  :::: $i" ; 
                  $objLogger->doLogDebugMsg ( $debug_msg ) ;  
               }
               $i++ ; 
               $category_item_count++ ; 
            
               $prev_start_time = $start_time ; 
               $prev_stop_time = $stop_time ; 
            }
            #eof foreach my $item 
            #
         }
         #eof foreach my $category_item 
         $ret = 0 ; 
         $msg = '' ; 
      
      }
      
      $msg = 'STOP  TxtParserWeekly::doConvertStrToHashRef' ; 
      $objLogger->doLogInfoMsg ( $msg ) ;  

      return ( $ret , $msg , $hsr ) ; 
   }	
   # eof sub StrToHashRef 


   sub doConvertHashRefToStr {

      my $self       = shift ; 
      my $hsr2       = shift ; 

      my $msg        = 'unknown error during hash ref of hash references to string conversion !!!' ;  ; 
      my $ret        = 1 ; 
      my $str_issues = q{} ; 
      my $run_date   = q{} ;  
      p ( $hsr2 ) if $module_trace == 1 ; 
      my $str_header = '# START weekly %run_date%
   
## what will I do till the next weekly:
#---------------------------
#' ; 
#
      my $str_middler = '## what did I do since last weekly:
---------------------------
' ; 

      my $str_footer = '

# STOP  weekly @%run_date%
' ; 


      $str_issues .= $str_header . "\n\n" ; 
      my $prev_category = q{} ; 

      foreach my $issue_id ( sort { $hsr2->{$a}->{ 'prio' } <=> $hsr2->{$b}->{ 'prio' } } keys (%$hsr2))  {
         my $row = $hsr2->{ $issue_id } ; 

         $run_date         = $row->{ 'run_date'} ; 
         my $category      = $row->{ 'category'} ; 
         my $current       = $row->{ 'current'} ; 
         my $description   = $row->{ 'description'} ; 
         my $issue_id      = $row->{ 'issue_id'} ; 
         my $level         = $row->{ 'level'} ; 
         my $name          = $row->{ 'name'} ; 
         my $prio          = $row->{ 'prio'} ; 
         my $start_time    = $row->{ 'start_time'} ; 
         my $stop_time     = $row->{ 'stop_time'} ; 
         my $status        = $row->{ 'status'} || 'unknwn' ; 
         $status           = $inverse_hsrStatus{ $status } ; 
         $description      =~ s/\r\n/\n/gm ; 
         $str_issues       .= "\n" if ( $prev_category ne $category ) ; 
         $str_issues       .= $category . "\n" unless ( $prev_category eq $category ) ; 
         my $levels_dash   = '' ; 
         for ( my $i = 1 ; $i<$level ; $i++ ) {
            $str_issues    .= ' ' ; 
            $levels_dash   .= '-' ; 
         }
         $str_issues       .= ' ' . $levels_dash . ' ' ; 
         $str_issues       .= $status . "\t\t" ; 
         $str_issues       .= ( $start_time . " " ) if ( $start_time ne 'NULL' ) ; 
         $str_issues       .= ( '- ' . $stop_time . " " ) if ( $stop_time ne 'NULL' ) ; 
         $str_issues       .= $name . "\n" ; 
         $prev_category    = $category ; 
      }
      #eof foreach 

      $str_issues .= $str_footer . "\n\n" ; 
      $str_issues =~ s|%run_date%|$run_date|g ;  
      $msg = " OK for hsr2 to txt conversion " ;  
      $ret = 0 ; 

      return ( $ret , $msg , $str_issues ) ;
   }

   # eof sub doConvertHashRefToStr


	#
	# --------------------------------------------------------
	# used to calculate the amount of levels 
	# --------------------------------------------------------
   sub doFillInLevelsPerRow {

      my $self                = shift ; 
      my $str_dashes          = shift ; 
      my $ref_item_levels     = shift ; 
      my $item_levels         = $$ref_item_levels ; 

      my $row_num = scalar keys %$$ref_item_levels || 0 ; 
      my $num_of_dashes = () = $str_dashes =~ /\-/gi;
      $item_levels->{ $row_num } = $num_of_dashes ; 

   } 

	
	
   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		
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
           appConfig => $appConfig
       );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
	   $objFileHandler   = 'IssueTracker::App::Utils::IO::FileHandler'->new ( \$appConfig ) ; 
      
      $hsrStatus = {
           'eval'    => '01-eval'      # evaluate whether or not to do it
         , 'todo'    => '02-todo'      # must do it till the end of the period
         , 'rem'     => '02-rem'       # remember to act till the end of the period
         , 'wip'     => '03-wip'       # is work in progress - aka is being done right now
         , 'act'     => '03-act'       # is being actively done , aka more of an activity type
         , 'actv'    => '03-actv'      # is being actively done , aka more of an activity type
         , 'diss'    => '04-diss'      # to dissmiss or disgard
         , 'late'    => '04-late'      # too late
         , 'fail'    => '04-fail'      # to failmiss or disgard
         , 'test'    => '05-test'      # to test some implementation
         , 'tst'     => '05-tst'       # to test some implementation
         , 'hld'     => '06-onhold'    # the issue is on hold - 
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
	# return a field's value
	# -----------------------------------------------------------------------------
	sub get {

		my $self = shift;
		my $name = shift;
		croak "\@IssueTracker.pm sub get TRYING to get undefined name" unless $name ;  
		croak "\@IssueTracker.pm sub get TRYING to get undefined value" unless ( $self->{"$name"} ) ; 

		return $self->{ $name };
	}    #eof sub get


	# -----------------------------------------------------------------------------
	# set a field's value
	# -----------------------------------------------------------------------------
	sub set {

		my $self  = shift;
		my $name  = shift;
		my $value = shift;
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
	# eof sub dumpFields
		

	# -----------------------------------------------------------------------------
	# wrap any logic here on clean up for this class
	# -----------------------------------------------------------------------------
	sub RunBeforeExit {

		my $self = shift;

		#debug print "%$self RunBeforeExit ! \n";
	}
	#eof sub RunBeforeExit


	# -----------------------------------------------------------------------------
	# called automatically by perl's garbage collector use to know when
	# -----------------------------------------------------------------------------
	sub DESTROY {
		my $self = shift;

		#debug print "the DESTRUCTOR is called  \n" ;
		$self->RunBeforeExit();
		return;
	}   
	#eof sub DESTROY


	# STOP functions
	# =============================================================================

	


1;

__END__

=head1 NAME

IssueTracker 

=head1 SYNOPSIS

use IssueTracker  ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app cnfig hash 

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
