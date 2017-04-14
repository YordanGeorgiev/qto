package IssueTracker::App::Utils::ETL::IssueTracker ; 

	use strict; use warnings;
   use utf8 ; 
	my $VERSION = '1.1.0';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
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

   our $module_trace             = 1  ; 
	our $appConfig						= {} ; 
	our $RunDir 						= '' ; 
	our $ProductBaseDir 				= '' ; 
	our $ProductDir 					= '' ; 
	our $ProductInstanceDir 			= '' ; 
	our $EnvironmentName 			= '' ; 
	our $ProductName 					= '' ; 
	our $ProductType 					= '' ; 
	our $ProductVersion 				= '' ; 
	our $ProductOwner 				= '' ; 
	our $HostName 						= '' ; 
	our $ConfFile 						= '' ; 
	our $objLogger						= {} ; 
	our $objFileHandler				= {} ; 

=head1 SYNOPSIS

	doResolves the product version and base dirs , bootstraps cnfig files if needed

		use IssueTracker::App::Utils::ETL::IssueTracker ;
		my $objIssueTracker = 
			'IssueTracker::App::Utils::ETL::IssueTracker'->new ( \$appConfig ) ; 
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
	# just and example method
	# --------------------------------------------------------
	sub doReadIssueFile {

      my $self       = shift ; 
      my $issues_file = shift ; 
      my $msg  = '' ; 
      my $ret  = 1 ; 
      
      my $str_issues_file = q{} ; 

      $objLogger->doLogInfoMsg ( " START doReadIssueFile" ) ; 


      unless ( -r $issues_file ) {
         $msg = "the issues_file : $issues_file does not exist !!!" ; 
         $objLogger->doLogFatalMsg ( $msg ) ; 
      }
      else {

         $str_issues_file = $objFileHandler->ReadFileReturnString ( $issues_file , 'utf8' ) ; 
         $ret = 0 ; 
         $msg = "read successfully issues_file : $issues_file" ; 
         $objLogger->doLogDebugMsg ( $str_issues_file ) if ( $module_trace == 1 ) ; 
      }
      
      $msg =  " STOP  doReadIssueFile with ret: $ret" ; 
      $objLogger->doLogInfoMsg ( $msg ) ; 
      return ( $ret , $msg , $str_issues_file ) ; 
	}
	# eof sub doConvertMdFileToBigSqlHash



   sub doConvertStrToHashRef {

      my $self       = shift ; 
      my $str        = shift ; 

      my $ret        = 1 ; 
      my $msg        = 'unknown error while converting string to hash reference' ; 
      my $hsr        = {} ; 

      binmode(STDIN,  ':utf8');
      binmode(STDOUT, ':utf8');
      binmode(STDERR, ':utf8');
 
      # each item starts with new line may be some space and - 
      my @arr_category_items  = split '\n(\s*)\n' , $str ; 
      my $i          = 0 ;  
      my $current_date = '' ; 
      my $flag_current = -1 ; 


      if ( $str ) {      
         $msg = 'START ::: parsing issue file string into hash ref of hash refs' ; 
         $objLogger->doLogInfoMsg ( $msg ) ;  

         foreach my $category_item ( @arr_category_items ) {
            # START DAILY 2017-04-02 09:30 su
            if ( $category_item =~ m/^\s*#\s*START\s+[(DAILY)|(MONTHLY)|(WEEKLY)] ([\d]{4}\-[\d]{2}\-[\d]{2})(.*)/g ) {
               $current_date = $1 ; 
            }
            last if ( $category_item =~ m/^\s*#\s*STOP\s+[(DAILY)|(WEEKLY)|(MONTHLY)] ([\d]{4}\-[\d]{2}\-[\d]{2})(.*)/g ) ; 


            my $debug_msg = "category_item: $category_item " ; 
            $objLogger->doLogDebugMsg ( $debug_msg ) if $module_trace == 1 ; 

            $flag_current++ if $category_item =~ m/^[#]{1,2} /g ; 
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
               $item =~ m/^\s([a-zA-Z0-9]*)\s*(\t{1,5})(.*)/ ; 
               my $status = $1 ; 
               my $name = $3 ; 
               next unless $name ; 
               $hsr->{ $i }->{ 'issue_id' } = $i ;
               $hsr->{ $i }->{ 'level' } = $item_levels->{ $category_item_count } ; 
               # $hsr->{ $i }->{ 'item' } = $item ; 
               $hsr->{ $i }->{ 'prio' } = $i ; 
               $hsr->{ $i }->{ 'category' }     = $category ; 
               $hsr->{ $i }->{ 'status' }       = $status ; 
               # the title is the first line of the title description
               my $title = ( split /\n/, $name )[0] ; 
               
               # the description is what is left from the name 
               my $description = $name ; 
               $description =~ s/$title//gm ; 

               # but only if something is left 
               $description = $title unless ( $description ) ;  

               # and the title should not be longer than 90 chars
               $title = substr($title, 0, 90 ) . ' ...' if length ( $title ) > 90 ; 

               $hsr->{ $i }->{ 'name' }         = $title ; 
               $hsr->{ $i }->{ 'description' }  = $description ; 
               $hsr->{ $i }->{ 'daily_date' }   = $current_date ; 
               $hsr->{ $i }->{ 'actual' }       = $flag_current ; 
               
               if ( $module_trace == 1 ) { 
                  $debug_msg = " START :::: $i" if 
                  $objLogger->doLogDebugMsg ( $debug_msg ) ;  
                  p ( $hsr->{ $i } ) ; 
                  $debug_msg = " STOP  :::: $i" ; 
                  $objLogger->doLogDebugMsg ( $debug_msg ) ;  
               }
               $i++ ; 
               $category_item_count++ ; 
            }
            #eof foreach my $item 
         }
         #eof foreach my $category_item 
         $ret = 0 ; 
         $msg = '' ; 
      
      }
      
      $msg = 'STOP  ::: parsing issue file string into hash ref of hash refs' ; 
      $objLogger->doLogInfoMsg ( $msg ) ;  

      return ( $ret , $msg , $hsr ) ; 
   }	
   # eof sub StrToHashRef 




   sub doFillInLevelsPerRow {

      my $self                = shift ; 
      my $str_dashes          = shift ; 
      my $ref_item_levels     = shift ; 
      my $item_levels         = $$ref_item_levels ; 

      my $row_num = scalar keys %$$ref_item_levels ; 
      my $num_of_dashes = () = $str_dashes =~ /\-/gi;
      $item_levels->{ $row_num } = $num_of_dashes ; 

   } 


	#
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
	sub doInitialize {
		
		$objLogger 	      = "IssueTracker::App::Utils::Logger"->new( \$appConfig ) ; 
		$objFileHandler 	= "IssueTracker::App::Utils::IO::FileHandler"->new( \$appConfig ) ; 
	}	
	#eof sub doInitialize
	

=head1 SUBROUTINES/METHODS

	STOP  SUBS 
	# -----------------------------------------------------------------------------
=cut


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor
=cut 

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {
		
		my $invocant = shift;    
		# might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class

      $self->doInitialize();
		return $self;
	}  
	#eof const


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

