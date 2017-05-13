package IssueTracker::App::Utils::Logger ;

	use strict; use warnings;
	use v5.10.0;
   use utf8 ; 

	my $VERSION = '2.1.7';    
	#doc at the end

	require Exporter;
	use AutoLoader  ;
   our @ISA    = qw(Exporter);
   #our @EXPORT = qw(get set dumpFields doLogInfoMsg doLogFatalMsg doLogDebugMsg doLogTraceMsg doLogErrorMsg doLogMsg doLogWarningMsg doLogBroadCastMsg );

	use Carp qw(cluck croak);
	use File::Path;
	use Data::Printer ; 
	use IssueTracker::App::Utils::Timer ; 

	# the hash holding the vars
	our ( $RunDir , $LogFile ) = ();
   our $appConfig   = {} ; 
	our $PID = "$$" ; 
	our $objTimer ; 
	our $HostName ; 
	our $LogTimeToTextSeparator ; 
	our $HumanReadableTime ; 
            

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use IssueTracker::Control::Utils::Logger ; 

    my $objLogger = IssueTracker::Control::Utils::Logger->new( \$appConfig ) ;
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS


=cut

=head2 new
# -----------------------------------------------------------------------------
# the constructor
=cut 

	sub new {

		my $class = shift;    # Class name is in the first parameter
		$appConfig = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		my $self = {};        # Anonymous hash reference holds instance attributes

		bless( $self, $class );    # Say: $self is a $class
		
      $self = $self->doInitialize() ; 
		return $self;
	}  
	#eof const


   sub doInitialize {
      my $self = shift ; 
   
      # if the log dir does not exist create it
		my $LogDir = '';
		$LogDir = $appConfig->{ 'LogDir' };

		# define the log dir as the current dir if not cnfigured 
		unless ( defined( $LogDir ) ) {
			$0 =~ m/^(.*)(\\|\/)(.*)\.([a-z]*)/;
			$RunDir = $1;
			$LogDir = $RunDir;
		}

		# if the log dir is cnfigured but it does not exist 
		if ( defined( $LogDir ) && !-d "$LogDir" ) {
			MkDir( "$LogDir" ) || cluck( " Cannot create the \$LogDir : $LogDir $! !!! " );
		}

		#debug print "The log file is " . $appConfig->{ 'LogFile' } ;
		$LogFile = $appConfig->{ 'LogFile' };

		#if the log file is not defined we create one
		unless ( defined ( $appConfig->{ 'LogFile' } ) ) {
			$LogFile = "$0.log";
		}
	
      $appConfig->{ 'PrintConsoleMsgs' } = 1 
         unless ( defined $appConfig->{ 'PrintConsoleMsgs' } ); 


		$appConfig->{ 'PrintErrorMsgs' } = 1
		  unless ( defined ( ref $appConfig->{ 'PrintErrorMsgs' } )) ; 
      

		$appConfig->{ 'PrintDebugMsgs' } = 1
		  unless ( defined( $appConfig->{ 'PrintDebugMsgs' } ) );

		$appConfig->{ 'PrintInfoMsgs' } = 1
		  unless ( defined( $appConfig->{ 'PrintInfoMsgs' } ) );
		
		$appConfig->{ 'PrintTraceMsgs' } = 1
		  unless ( defined( $appConfig->{ 'PrintTraceMsgs' } ) );

		$appConfig->{ 'PrintWarningMsgs' } = 1
		  unless ( defined( $appConfig->{ 'PrintWarningMsgs' } ) );

		$appConfig->{ 'LogMsgs' } = 1
		  unless ( defined( $appConfig->{ 'LogMsgs' } ) );

		$appConfig->{ 'LogTimeToTextSeparator' } = '##'
		  unless ( defined( $appConfig->{ 'LogTimeToTextSeparator' } ) );
		
		$appConfig->{ 'TimeFormat' } = 'YYYY-MM-DD hh:mm:ss'
		  unless ( defined( $appConfig->{ 'TimeFormat' } ) );

		$appConfig->{ 'LogToFile' } = 1
		  unless ( defined( $appConfig->{ 'LogToFile' } ) );

		$appConfig->{ 'LogToFileHandle' } = 0
		  unless ( defined( $appConfig->{ 'LogToFileHandle' } ) );

		#
		# STOP set default value if value not specified =========================

		$objTimer               = 'IssueTracker::App::Utils::Timer'->new( $appConfig->{ 'TimeFormat' } );
		$HostName					= $appConfig->{'HostName'} ; 
		$LogTimeToTextSeparator = $appConfig->{'LogTimeToTextSeparator'} ; 

       %$self = (
           appConfig => $appConfig
         , LogFile   => $LogFile
       );

      return $self ; 
   }
   # eof sub doIitialize

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
			  "\n\n\n[FATAL] RunTime Error !!! Undefined sub $name(@_) ";
			croak ( "$self , $msg" .  "$!" ) ; 
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
		return $self->{ $name };
	}    #eof sub get


	# -----------------------------------------------------------------------------
	# set a field's value
	# -----------------------------------------------------------------------------
	sub set {

		my $self  = shift;
		my $name  = shift;
		my $value = shift;
		$self->{ $name } = $value;
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


	# =============================================================================
	# START functions
	#

	# a nice func to improve readability when completing a certain phase
	sub flushScreen {
		my $self = shift ; 
		print "\033[2J";    
		print "\033[0;0H";
	}
	#eof sub




	#
	# -----------------------------------------------------------------------------
	# ALWAYS logs a fatal message
	# -----------------------------------------------------------------------------
	sub doLogFatalMsg {

		my $self = shift;
      my $msg  = q{} ; 
      
      $msg = "null info msg passed" unless @_ ;  
		$msg = "@_" if @_ ; 
		my $msgType = '[FATAL]'; 
		
		$appConfig->{ 'PrintErrorMsgs' } = 1 ; 
		$self->doLogMsg( $msgType, "$msg" ) ; 

	}
	# eof sub doLogErrorMsg 


	#
	# -----------------------------------------------------------------------------
	# logs an error message
	# -----------------------------------------------------------------------------
	sub doLogErrorMsg {
		my $self = shift;
      my $msg  = q{} ; 
      
      $msg = "null info msg passed" unless @_ ;  
		$msg = "@_" if @_ ; 

		my $msgType = '[ERROR]';

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $appConfig->{ 'LogMsgs' } == 0 );

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $appConfig->{ 'PrintErrorMsgs' } == 0 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $appConfig->{ 'PrintErrorMsgs' } == 1 );

	}
	# eof sub doLogErrorMsg 


	#
	# -----------------------------------------------------------------------------
	# logs an error message
	# -----------------------------------------------------------------------------
	sub doLogBroadCastMsg {

		my $self = shift;

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $appConfig->{ 'LogMsgs' } == 0 );


		my @BroadCastTypes = ();
		my @msgs           = @_;

		#the msg is the last one of the
		my $msg = $msgs[ $#msgs ];

		foreach my $BroadCastType ( @msgs ) {

			# print "before \$BroadCastType is $BroadCastType \n" ;
			# print "before if \@BroadCastTypes is @BroadCastTypes \n" ;
			# print "before if \@msgs is @msgs \n" ;

			if (

					$BroadCastType eq "SIMPLE"
				or $BroadCastType eq "DEBUG"
				or $BroadCastType eq "ERROR"
				or $BroadCastType eq "WARN"
				or $BroadCastType eq "INFO"
				or $BroadCastType eq "TRACE"

			  )
			{

				# print "AFTER \@BroadCastTypes is @BroadCastTypes \n" ;
				# print "AFTER \@msgs is @msgs \n" ;
				push( @BroadCastTypes, $BroadCastType );

			}

		}
		#eof sub


		# do the actual "BroadCast"
		foreach my $BroadCastType ( @BroadCastTypes ) {

			$self->doLogMsg( $msg )        if ( $BroadCastType eq "SIMPLE" );
			$self->LogDebugMsg( $msg )   if ( $BroadCastType eq "DEBUG" );
			$self->LogErrorMsg( $msg )   if ( $BroadCastType eq "ERROR" );
			$self->LogWarningMsg( $msg ) if ( $BroadCastType eq "WARN" );
			$self->LogInfoMsg( $msg )    if ( $BroadCastType eq "INFO" );
			$self->LogWarningMsg( $msg ) if ( $BroadCastType eq "TRACE" );

		} #eof foreach

	}
	#eof sub doLogBroadCastMsg


	# -----------------------------------------------------------------------------
	# logs an warning message
	# -----------------------------------------------------------------------------
	sub doLogWarningMsg {

		my $self = shift;
      my $msg  = q{} ; 
      
      $msg = "null info msg passed" unless @_ ;  
		$msg = "@_" if @_ ; 
		my $msgType = '[WARN ]';

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $appConfig->{ 'LogMsgs' } == 0 );

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $appConfig->{ 'PrintWarningMsgs' } == 0 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $appConfig->{ 'PrintWarningMsgs' } == 1 );

	}    
	#eof sub doLogWarningMsg


	#
	# -----------------------------------------------------------------------------
	# logs an info message
	# -----------------------------------------------------------------------------
	sub doLogInfoMsg {

		my $self = shift;
      my $msg  = q{} ; 
      
      $msg = "null info msg passed" unless @_ ;  
		$msg = "@_" if @_ ; 
		my $msgType = '[INFO ]';

		# Do not print anything if the PrintWarningMsgs = 0
		return unless ( $appConfig->{ 'LogMsgs' } == 1 );

		# Do not print anything if the PrintWarningMsgs = 0
		return unless ( $appConfig->{ 'PrintInfoMsgs' } == 1 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $appConfig->{ 'PrintInfoMsgs' } == 1 );

	}
	# eof sub doLogInfoMsg


	#
	# -----------------------------------------------------------------------------
	# logs an trace message
	# -----------------------------------------------------------------------------
	sub doLogTraceMsg {

		my $self    = shift;
		my $msg     = "@_";
		my $msgType = '[TRACE]';

		my ( $package, $filename, $line ) = caller();

		# Do not print anything if the PrintDebugMsgs = 0
		return unless ( $appConfig->{ 'PrintTraceMsgs' } == 1 );

		$msg = "$msg : FROM Package: $package  FileName: $filename Line: $line  ";

		# Do not print anything if the PrintWarningMsgs = 0
		return unless ( $appConfig->{ 'LogMsgs' } == 1 );

		# Do not print anything if the PrintWarningMsgs = 0
		return unless ( $appConfig->{ 'PrintTraceMsgs' } == 1 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $appConfig->{ 'PrintTraceMsgs' } == 1 );

	}
	# eof sub doLogTraceMsg
	 

	# -----------------------------------------------------------------------------
	# logs an Debug message
	# -----------------------------------------------------------------------------
	sub doLogDebugMsg { 
		my $self    = shift;
		my $msg     = "@_";

		my $msgType = '[DEBUG]';

		#my ( $package, $filename, $line ) = caller();
		#$msg = "$msg : FROM Package: $package  FileName: $filename Line: $line  ";
		#print $msg ; 

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $appConfig->{ 'LogMsgs' } == 0 );

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $appConfig->{ 'PrintDebugMsgs' } == 0 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $appConfig->{ 'PrintDebugMsgs' } == 1 );

	}    
	# eof sub doLogDebugMsg


	#
	# -----------------------------------------------------------------------------
	# builds a nice message 
	# -----------------------------------------------------------------------------
	sub BuildMsg {

		my $self    	= shift;
		my $msgType 	= shift;
		my $msg 			= shift || 'null msg passed' ; 
		
		my $HumanReadableTime      = $objTimer->GetHumanReadableTime();
			$HumanReadableTime 		= "$HumanReadableTime" ; 

		my $msgPrefix = () ; 
		$msgPrefix = "$msgType $HumanReadableTime [$PID] $LogTimeToTextSeparator"; 

		if (  $msgType eq '[WARN ]'
			|| $msgType eq '[INFO ]'
			|| $msgType eq '[DEBUG]'
			|| $msgType eq '[TRACE]' )
		{
			$msg = "$msgPrefix" . " $msg \n";
		}
		elsif ( $msgType eq '[ERROR]' ) {
			$msg = "$msgPrefix" . " $msg \n\n\n" ; 
		}
		elsif ( $msgType eq '[FATAL]' ) {
			$msg = "$msgPrefix" . " $msg \n\n\n\n\n";
		}
		else {
			$msg = "$msgPrefix" . " $msg \n";
		}

		return $msg;
	}
	# eof sub BuildMsg


	#
	# -----------------------------------------------------------------------------
	# builds a nice message 
	# -----------------------------------------------------------------------------
	sub doBuildRunLogMsg {

		my $self    	= shift;
		my $msg 			= shift ; 
		
		my $HumanReadableTime      = $objTimer->GetHumanReadableTime();
      $msg = "$HumanReadableTime $msg" ; 

		return $msg;
	}
	# eof sub doBuildRunLogMsgg



	#
	# -----------------------------------------------------------------------------
	# logs a message based on the cnfiguration settings 
	# -----------------------------------------------------------------------------
	sub doLogMsg {

		my $self    = shift;
		my $msgType = shift || "" ; 
		my $msg     = shift || 'null msg passed' ; 

      $msg = $self->BuildMsg( $msgType, $msg);
		

		#print to STDOUT and STDERR only if cnfigured to print to console
		if ( $appConfig->{'PrintConsoleMsgs'} == 1 ) {
			# PRINT TO STDOUT if
			if (  $appConfig->{ 'PrintInfoMsgs' } 	== 1
				|| $appConfig->{ 'PrintDebugMsgs' } == 1
				|| $appConfig->{ 'PrintTraceMsgs' } == 1 ) {


            binmode(STDOUT, ':utf8');
				print STDOUT $msg unless ( $msgType eq '[ERROR]' ) ; 
			}

			if ( $appConfig->{ 'PrintErrorMsgs' } 
					&& $msgType eq '[ERROR]'	) {

            binmode(STDERR, ':utf8');
				print STDERR $msg;
			}
		}
		
		# log to file only if cnfigured so
		if ( $appConfig->{ 'LogToFile' } == 1 ) {
					$self->doAppendToFile ( $LogFile, "$msg" );
		} #eof if

		# log to a file handle only if cnfigured to
		if ( $appConfig->{ 'LogToFileHandle' } == 1 ) {
					$self->doAppendToFileHandle ( "$msg" );
		} #eof if


	}
	# eof sub doLogMsg
	
   #
	# -----------------------------------------------------------------------------
	# logs a message based on the cnfiguration settings 
	# -----------------------------------------------------------------------------
	sub doRunLogMsg {

		my $self    = shift;
		my	$msg 		= shift || 'null uuid passed' ; 
		 
		$msg = $self->doBuildRunLogMsg( $msg );
      my $RunLogFile = $appConfig->{ 'RunLogFile' } || $ENV{'run_log_file' } ; 		
		$self->doAppendToFile ( $RunLogFile, "$msg" );

	}
	# eof sub doRunLogMsg

	#
	# -----------------------------------------------------------------------------
	# Appends the passed str to a file
	# -----------------------------------------------------------------------------
	sub doAppendToFile {

		my $self       		= shift;
		my $msg 					= '' ; 
		$msg           	   = 'Logger::doAppendToFile undef file for writing passed !!!' ; 
		my $file 				= shift || cluck( $msg ) ; 
		$msg               	= 'Logger::AppendTostr undef str for writing passed !!!' ; 
		my $str_to_print 		= shift || cluck( $msg );
		
		$msg 					= '' ; 
		my $error_msg 			= '' ; 
		
      # do not write anything unless log file is cnfigured or actually even passed	
		return unless ( defined ( $appConfig->{ 'LogToFile' } ) ) ;
		return unless ( $appConfig->{ 'LogToFile' } == 1 ) ; 
		return unless ( $file ) ; 
		return unless ( $str_to_print ) ; 
   

		$file =~ m/^(.*)([\/|\\])(.*)/g;
		my $FileDir = $1;

		# the owner of t
		$self->MkDir( $FileDir ) unless ( -d $FileDir ) ; 


		no warnings 'experimental::smartmatch';
		# the owner of the process might not be able to write to the file
		# src: http://search.cpan.org/~pjf/autodie-2.25/lib/autodie.pm	
		eval {
			use autodie ; 
			my $error_msg = "[FATAL] Logger::doAppendToFile cannot open file: $file" ; 
			my $FH = () ; 
			
         open( $FH, '>>:utf8' , "$file" ) || cluck( "$error_msg" ) ; 
			print $FH $str_to_print;
			close $FH ;
		};

		given ( $@ ) {
		  when (undef)   { $msg 		= "[INFO ] No error at all" ; }
		  when ('open')  { $error_msg = "[FATAL] Failed to open log file: $file" ; }
		  when (':io')   { $error_msg = "[FATAL] Non-open, IO error while openning log file: $file" ; }
		  when (':all')  { $error_msg = "[FATAL] All other autodie errors while openning log file: $file" ; }
		  default        { $msg 		= "[INFO ] No error at all" ; }
   	}
		
		if ( $error_msg ) {	
			my $solution_msg = " check the permissions of the log file : $file " ; 
			$error_msg .= $solution_msg ; 
			croak ( $error_msg ) ; 
		}	

		use warnings 'experimental::smartmatch';
		return 1 ; 
	}
	# eof sub doAppendToFile

	
	#
	# -----------------------------------------------------------------------------
	# Create a dir or cluck why it can't
	# use by if ( $self->MkDir ( $dir_to_create ) ; 
	# -----------------------------------------------------------------------------
	sub MkDir {

		my $self        	= shift;
		my $dir_to_create = shift;

		my $error_msg 		= '' ; 
		my $msg 				= '' ; 	

		no warnings 'experimental::smartmatch';

		# if there is !no directory!
		unless ( -d "$dir_to_create" ) {
			eval { 
				use autodie ; 
				my $error_msg = "Logger::MkDir failed to create directory $dir_to_create $! !!!"  ; 
				mkpath( "$dir_to_create" ) || cluck( "$error_msg" ) ;  
			};

			given ( $@ ) {
				when (undef)   { $msg 			= "[INFO ] No error. Proceed " ; }
				when ('open')  { $error_msg 	= "[FATAL] failed to open the dir: $dir_to_create" ; }
				when (':io')   { $error_msg 	= "[FATAL] Non-open, IO error for the dir: $dir_to_create " ; }
				when (':all')  { $error_msg 	= "[FATAL] All other autodie errors for the dir: $dir_to_create " ; }
		  		default        { $msg 			= "[INFO ] No error at all" ; }
			}
			if ( $error_msg ) {
				my $solution_msg = " check the permissions of the dir to create: $dir_to_create " ; 
				$error_msg .= $solution_msg ; 
				croak ( $error_msg ) ; 	
				return 0 ; 
			}
			else { 
				return 1 ; 
			}

		}    
		else {
			#dir exists alles gut !!!
			return 1;
		}
		
		use warnings 'experimental::smartmatch';

	}    
	#eof sub


	# STOP functions
	# =============================================================================



1;

__END__


=head1 NAME

Logger 

=head1 SYNOPSIS

use Logger  ; 


=head1 DESCRIPTION
Provide a simple interface for dynamic logging... 

2011.06.11-13:33:11 --- this is a simple message  
2011.06.11-13:33:11 --- ERROR : This is an error message  
2011.06.11-13:33:11 --- WARN : This is a warning message  
2011.06.11-13:33:11 --- INFO : This is a info message  
2011.06.11-13:33:11 --- DEBUG : This is a debug message  
2011.06.11-13:33:11 --- TRACE : This is a trace message  : FROM Package: Morphus  

- Logger does doInitialize all the cnfig values it is utilizing on doInitialize if they do not exist in the cnfig file 
- Logger understands the following type of msgs : DEBUG,ERROR,TRACE,INFO,WARN, SIMPLE
- Logger prints each type of msgs into a file if cnfigured to do so
- The TRACE type of msg does provide a file , line of file of the caller
- When called with the LogBroadCastMsg ( "ERROR" , "INFO" , "ANYOTHERTYPE" , $msg ) ; Logger will output both the ERROR and the INFO msg 


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
2.1.7 -- 2017-04-09 18:48:17 -- ysg -- utf8 binmode for utf8 chars logging ..
2.1.6 -- 2014-08-26 09:37:36 -- ysg -- autodie and better checks in doAppendToFile
2.1.5 -- 2014-08-25 21:01:58 -- ysg -- added PrintToConsole settings
2.1.4 -- 2013-03-03 20:00:58 -- ysg -- cleaned up formatting for MSG types
2.1.3 -- 2013-03-03 20:00:58 -- ysg -- added msg prefix
2.1.2 -- 2013-02-14 17:11:45 -- ysg -- re-factor 
2.1.1 -- 2013-02-13 16:36:54 -- ysg -- added LogFatalError
2.1.0 -- 2013-02-12 20:49:18 -- ysg -- log to an opened file handle
2.0.0 -- 2012-12-26 14:54:33 -- ysg -- refactoring, LogFile as our
1.9.1 -- 2012-12-24 14:37:53 -- ysg -- formatting 
1.8.0 -- 2011.08.30 12:00:00 -- ysg -- Removed dependancy from FileHandler
1.8.0 -- 2011.08.13 17:23:49 -- ysg -- new constructor
1.7.0 -- 2011.07.02 12:00:00 -- ysg -- Removed Rotate Logs 
1.6.0 -- 2011.07.02 12:00:00 -- ysg -- Added LogBroadCastMsg
1.5.2 -- 2011.07.02 12:00:00 -- ysg -- Added doc in Descrption + specs for the RotateLogs feature , doInitialize
1.5.0 -- 2011.06.25 12:00:00 -- ysg -- WIP. Added RotateLogs in Initialization
1.4.0 -- 2011.06.11 12:00:00 -- ysg -- Separated actions of building and printing msgs. Total refactoring. Beta . 
1.3.0 -- 2011.06.09 12:00:00 -- ysg -- Added doInitialize 
1.2.8 -- 2011.06.07 12:00:00 -- ysg -- Added LogInfoErrorMsg print both to all possible
1.2.8 -- 2011.06.07 12:00:00 -- ysg -- added default values if cnf values are not set 
1.0.0 -- 2011.06.07 12:00:00 -- ysg -- Create basic methods 
1.0.0 -- 2011.06.07 12:00:00 -- ysg -- Stolen shamelessly from several places of the Perl monks ...

=cut 

