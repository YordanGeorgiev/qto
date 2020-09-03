package Qto::App::Utils::Logger ;

	use strict; use warnings;
	use v5.10.0;
   use utf8 ; 

	my $VERSION = '2.1.9';    

	require Exporter;
	use AutoLoader  ;
   our @ISA    = qw(Exporter);

	use Carp qw(cluck croak);
	use File::Path;
	use Data::Printer ; 
   use Qto::App::Utils::Timer ; 

   our $config    = {} ; 
   our $logConfig    = {} ; 
	our $RunDir       = q{};
	our $LogDir       = q{};
	our $LogFile      = q{};
	our $PID                = "$$" ; 
	our $objTimer ; 
	our $HostName ; 
	our $LogTimeToTextSeparator ; 
	our $HumanReadableTime ; 
   our ( $caller_pckg, $filename, $line ) = ();
            

=head1 SYNOPSIS

the main perl logging module in qto 
    use Qto::App::Utils::Logger ; 

    my $objLogger = Qto::App::Utils::Logger->new( \$logConfig ) ;
    ...

=head1 EXPORT

   #our @EXPORT = qw(get set dumpFields info doLogFatalMsg debug doLogTraceMsg error doLogMsg warn );
=cut 

	sub new {

		my $class = shift;    # Class name is in the first parameter
		$config = ${ shift @_ } || croak 'no config provided !!!' ; 
      $logConfig = $config->{'env'}->{'log'} ; 
		my $self = {};        
      ( $caller_pckg, $filename, $line ) = caller();
      $caller_pckg =~ s/(.*)(\:{2})(.*?)/$3/g ; 
		bless( $self, $class );    
		
      $self = $self->doInit() ; 
		return $self;
	}  


   sub doInit {
      my $self = shift ; 
   
      # if the log dir does not exist create it
		$LogDir = $logConfig->{ 'LogDir' };

      $LogDir =~ s/\$ProductInstanceDir/$config->{'env'}->{'run'}->{'ProductInstanceDir'}/g ; 
      $logConfig->{'LogDir'} = $LogDir ; 

		# define the log dir as the current dir if not configured 
		unless ( defined( $LogDir ) ) {
			$0 =~ m/^(.*)(\\|\/)(.*)\.([a-z]*)/;
			$RunDir = $1;
			$LogDir = $RunDir;
		}

		# if the log dir is configured but it does not exist 
		if ( defined( $LogDir ) && !-d "$LogDir" ) {
			$self->MkDir( "$LogDir" ) || cluck( " Cannot create the \$LogDir : $LogDir $! !!! " );
		}

		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $self->GetTimeUnits(); 
		$LogFile = $logConfig->{ 'LogFile' };
      $LogFile =~ s/\$LogDir/$LogDir/g ; 
      $LogFile =~ s/\$ProductName/$config->{'env'}->{'run'}->{'ProductName'}/g ; 
      $LogFile =~ s/%YYYY%/$year/g ; 
      $LogFile =~ s/%MM%/$mon/g ; 
      $LogFile =~ s/%DD%/$mday/g ; 
      $LogFile =~ s/%hh%/$hour/g ; 

      $logConfig->{'LogFile'} = $LogFile ;

		#if the log file is not defined we create one
		unless ( defined ( $logConfig->{ 'LogFile' } ) ) {
			$LogFile = "$0.log";
		}
	
      $logConfig->{ 'PrintConsoleMsgs' } = 1 
         unless ( defined $logConfig->{ 'PrintConsoleMsgs' } ); 

		$logConfig->{ 'PrintErrorMsgs' } = 1
	      unless ( defined ( ref $logConfig->{ 'PrintErrorMsgs' } )) ; 

		$logConfig->{ 'PrintDebugMsgs' } = 1
         unless ( defined( $logConfig->{ 'PrintDebugMsgs' } ) );

		$logConfig->{ 'PrintInfoMsgs' } = 1
		  unless ( defined( $logConfig->{ 'PrintInfoMsgs' } ) );
		
		$logConfig->{ 'PrintTraceMsgs' } = 1
		  unless ( defined( $logConfig->{ 'PrintTraceMsgs' } ) );

		$logConfig->{ 'PrintWarningMsgs' } = 1
		  unless ( defined( $logConfig->{ 'PrintWarningMsgs' } ) );

		$logConfig->{ 'LogMsgs' } = 1
		  unless ( defined( $logConfig->{ 'LogMsgs' } ) );

		$logConfig->{ 'LogTimeToTextSeparator' } = '##'
		  unless ( defined( $logConfig->{ 'LogTimeToTextSeparator' } ) );
		
		$logConfig->{ 'TimeFormat' } = 'YYYY-MM-DD hh:mm:ss'
		  unless ( defined( $logConfig->{ 'TimeFormat' } ) );

		$logConfig->{ 'LogToFile' } = 1
		  unless ( defined( $logConfig->{ 'LogToFile' } ) );

		$logConfig->{ 'LogToFileHandle' } = 0
		  unless ( defined( $logConfig->{ 'LogToFileHandle' } ) );

      $objTimer               = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
		$HostName					= $logConfig->{'HostName'} ; 
		$LogTimeToTextSeparator = $logConfig->{'LogTimeToTextSeparator'} ; 

       %$self = (
           logConfig => $logConfig
         , LogFile   => $LogFile
       );

      return $self ; 
   }


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


	# -----------------------------------------------------------------------------
	# return a field's value
	# -----------------------------------------------------------------------------
	sub get {

		my $self = shift;
		my $name = shift;
		return $self->{ $name };
	}    


	# -----------------------------------------------------------------------------
	# set a field's value
	# -----------------------------------------------------------------------------
	sub set {

		my $self  = shift;
		my $name  = shift;
		my $value = shift;
		$self->{ $name } = $value;
	}


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
		

	# -----------------------------------------------------------------------------
	# wrap any logic here on clean up for this class
	# -----------------------------------------------------------------------------
	sub RunBeforeExit {
		my $self = shift;
	}


	# -----------------------------------------------------------------------------
	# called automatically by perl's garbage collector use to know when
	# -----------------------------------------------------------------------------
	sub DESTROY {
		my $self = shift;

		$self->RunBeforeExit();
		return;
	}   


	# a clear screen func
	# to improve readability when completing a certain phase
	sub flushScreen {
		my $self = shift ; 
		print "\033[2J";    
		print "\033[0;0H";
	}


	#
	# -----------------------------------------------------------------------------
	# ALWAYS logs a fatal message
	# -----------------------------------------------------------------------------
	sub doLogFatalMsg {

      my $self = shift;
      my $msg  = q{} ; 
      
      ( $caller_pckg, $filename, $line ) = caller();
      $caller_pckg =~ s/(.*)(\:{2})(.*?)/$3/g ; 
      $msg = "null info msg passed" unless @_ ;  
		$msg = "@_" if @_ ; 
		my $msgType = '[FATAL]'; 
		
		$logConfig->{ 'PrintErrorMsgs' } = 1 ; 
		$self->doLogMsg( $msgType, "$msg" ) ; 

	}


	#
	# -----------------------------------------------------------------------------
	# logs an error message
	# -----------------------------------------------------------------------------
	sub error {
		my $self = shift;
      my $msg  = "null error msg passed" ; 
      
		$msg = "@_" if @_ ; 

		my $msgType = '[ERROR]';
      
      ( $caller_pckg, $filename, $line ) = caller();
      $caller_pckg =~ s/(.*)(\:{2})(.*?)/$3/g ; 

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $logConfig->{ 'LogMsgs' } == 0 );

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $logConfig->{ 'PrintErrorMsgs' } == 0 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $logConfig->{ 'PrintErrorMsgs' } == 1 );

	}


	# -----------------------------------------------------------------------------
	# logs an warning message
	# -----------------------------------------------------------------------------
	sub warn {

		my $self = shift;
      my $msg  = q{} ; 
      ( $caller_pckg, $filename, $line ) = caller();
      $caller_pckg =~ s/(.*)(\:{2})(.*?)/$3/g ; 
      
      $msg = "null info msg passed" unless @_ ;  
		$msg = "@_" if @_ ; 
		my $msgType = '[WARN ]';

      ( $caller_pckg, $filename, $line ) = caller();
      $caller_pckg =~ s/(.*)(\:{2})(.*?)/$3/g ; 
		
      # Do not print anything if the PrintWarningMsgs = 0
		return if ( $logConfig->{ 'LogMsgs' } == 0 );

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $logConfig->{ 'PrintWarningMsgs' } == 0 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $logConfig->{ 'PrintWarningMsgs' } == 1 );

	}    


	#
	# -----------------------------------------------------------------------------
	# logs an info message
	# -----------------------------------------------------------------------------
	sub info {

		my $self = shift;
      my $msg  = q{} ; 
            
      $msg = "null info msg passed" unless @_ ;  
		$msg = "@_" if @_ ; 
		my $msgType = '[INFO ]';
		
      ( $caller_pckg, $filename, $line ) = caller();
      $caller_pckg =~ s/(.*)(\:{2})(.*?)/$3/g ; 

		# Do not print anything if the PrintWarningMsgs = 0
		return unless ( $logConfig->{ 'LogMsgs' } == 1 );

		# Do not print anything if the PrintWarningMsgs = 0
		return unless ( $logConfig->{ 'PrintInfoMsgs' } == 1 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $logConfig->{ 'PrintInfoMsgs' } == 1 );

	}


	sub doLogTraceMsg {

		my $self    = shift;
		my $msg     = "@_";
		my $msgType = '[TRACE]';

		my ( $package, $filename, $line ) = caller();
      $caller_pckg =~ s/(.*)(\:{2})(.*?)/$3/g ; 

		# Do not print anything if the PrintDebugMsgs = 0
		return unless ( $logConfig->{ 'PrintTraceMsgs' } == 1 );

		$msg = "$msg : FROM Package: $package  FileName: $filename Line: $line  ";

		# Do not print anything if the PrintWarningMsgs = 0
		return unless ( $logConfig->{ 'LogMsgs' } == 1 );

		# Do not print anything if the PrintWarningMsgs = 0
		return unless ( $logConfig->{ 'PrintTraceMsgs' } == 1 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $logConfig->{ 'PrintTraceMsgs' } == 1 );

	}
	 

	# -----------------------------------------------------------------------------
	# logs an Debug message
	# -----------------------------------------------------------------------------
	sub debug { 
		my $self    = shift;
		my $msg     = "@_";

		my $msgType = '[DEBUG]' ; 

      ( $caller_pckg, $filename, $line ) = caller();
      $caller_pckg =~ s/(.*)(\:{2})(.*?)/$3/g ; 

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $logConfig->{ 'LogMsgs' } == 0 );

		# Do not print anything if the PrintWarningMsgs = 0
		return if ( $logConfig->{ 'PrintDebugMsgs' } == 0 );

		$self->doLogMsg( $msgType, "$msg" )
		  if ( $logConfig->{ 'PrintDebugMsgs' } == 1 );

	}    


	#
	# -----------------------------------------------------------------------------
	# builds a nice message 
	# -----------------------------------------------------------------------------
	sub doBuildMsg {

		my $self    	= shift;
		my $msgType 	= shift;
		my $msg 			= shift || 'null msg passed' ; 
		
		my $HumanReadableTime      = $objTimer->GetHumanReadableTime();
			$HumanReadableTime 		= "$HumanReadableTime" ; 

		my $msgPrefix = () ; 
		$msgPrefix = "$msgType $HumanReadableTime [$PID] " . sprintf("%23s", "$caller_pckg:$line " ) . "$LogTimeToTextSeparator"; 

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



	#
	# -----------------------------------------------------------------------------
	# logs a message based on the configuration settings 
	# -----------------------------------------------------------------------------
	sub doLogMsg {

		my $self    = shift;
		my $msgType = shift || "" ; 
		my $msg     = shift || 'null msg passed' ; 
      
      $msg = $self->doBuildMsg( $msgType, $msg);

		#print to STDOUT and STDERR only if configured to print to console
		if ( $logConfig->{'PrintConsoleMsgs'} == 1 ) {
			# PRINT TO STDOUT if
			if (  $logConfig->{ 'PrintInfoMsgs' } 	== 1
				|| $logConfig->{ 'PrintDebugMsgs' } == 1
				|| $logConfig->{ 'PrintTraceMsgs' } == 1 ) {


            binmode(STDOUT, ':utf8');
				print STDOUT $msg unless ( $msgType eq '[ERROR]' ) ; 
			}

			if ( $logConfig->{ 'PrintErrorMsgs' } 
					&& $msgType eq '[ERROR]'	) {

            binmode(STDERR, ':utf8');
				print STDERR $msg;
			}
		}
		
		# log to file only if configured so
		if ( $logConfig->{ 'LogToFile' } == 1 ) {
					$self->doAppendToFile ( $LogFile, "$msg" );
		} #eof if

		# log to a file handle only if configured to
		if ( $logConfig->{ 'LogToFileHandle' } == 1 ) {
					$self->doAppendToFileHandle ( "$msg" );
		} #eof if
	}


   #
	# -----------------------------------------------------------------------------
	# logs a message based on the configuration settings 
	# -----------------------------------------------------------------------------
	sub doRunLogMsg {

		my $self    = shift;
		my	$msg 		= shift || 'null uuid passed' ; 
		 
		$msg = $self->doBuildRunLogMsg( $msg );
      my $RunLogFile = $logConfig->{ 'RunLogFile' } || $ENV{'run_log_file' } || "$0.log" ; 
		$self->doAppendToFile ( $RunLogFile, "$msg" );

	}


	#
	# -----------------------------------------------------------------------------
	# Appends the passed str to a file
	# -----------------------------------------------------------------------------
	sub doAppendToFile {
      my $msg 					= '' ; 
		$msg           	   = 'Logger::doAppendToFile undef file for writing passed !!!' ; 
		$msg               	= 'Logger::AppendTostr undef str for writing passed !!!' ; 

		my $self       		= shift;
		my $file 				= shift || cluck( $msg ) ; 
		my $str_to_print 		= shift || cluck( $msg );
		
		
		$msg 					= '' ; 
		my $error_msg 			= '' ; 
		
      # do not write anything unless log file is configured or actually even passed	
		return unless ( defined ( $logConfig->{ 'LogToFile' } ) ) ;
		return unless ( $logConfig->{ 'LogToFile' } == 1 ) ; 
		return unless ( $file ) ; 
		return unless ( $str_to_print ) ; 
   

		$file =~ m/^(.*)([\/|\\])(.*)/g;
		my $FileDir = $1 ; 
      unless ( $FileDir ) {
         use Cwd qw (abs_path);
         $FileDir = Cwd::abs_path($0);
		   $FileDir =~ m/(.*)([\/|\\])(.*)/g;
		   $FileDir = $1 ; 
		   $self->MkDir( $FileDir ) ; 
      }

		$self->MkDir( $FileDir ) unless ( -d $FileDir ) ; 


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

		if ( $@ ) {
		  if (undef)   { $msg 		= "[INFO ] No error at all" ; }
		  elsif ('open')  { $error_msg = "[FATAL] Failed to open log file: $file" ; }
		  elsif (':io')   { $error_msg = "[FATAL] Non-open, IO error while openning log file: $file" ; }
		  elsif (':all')  { $error_msg = "[FATAL] All other autodie errors while openning log file: $file" ; }
		  else { $msg 		= "[INFO ] No error at all" ; }
   	}
		
		if ( $error_msg ) {	
			my $solution_msg = " check the permissions of the log file : $file " ; 
			$error_msg .= $solution_msg ; 
			croak ( $error_msg ) ; 
		}	

		return 1 ; 
	}


	# -----------------------------------------------------------------------------
   # usage:
	# my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $self-> GetTimeUnits(); 
	# -----------------------------------------------------------------------------
	sub GetTimeUnits {

		my $self = shift ; 

		# Purpose returns the time in yyyymmdd-format 
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time); 
		#---- change 'month'- and 'year'-values to correct format ---- 
		$sec = "0$sec" if ($sec < 10); 
		$min = "0$min" if ($min < 10); 
		$hour = "0$hour" if ($hour < 10);
		$mon = $mon + 1;
		$mon = "0$mon" if ($mon < 10); 
		$year = $year + 1900;
		$mday = "0$mday" if ($mday < 10); 

		return ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) ; 

	} 


	#
	# -----------------------------------------------------------------------------
	# Create a dir or cluck why it can't
	# use by if ( $self->MkDir ( $dir_to_create ) ; 
	# -----------------------------------------------------------------------------
	sub MkDir {
      my $self = shift ; 
		my $dir_to_create = shift;

		my $error_msg 		= '' ; 
		my $msg 				= '' ; 	


		# if there is !no directory!
		unless ( -d "$dir_to_create" ) {
			eval { 
				use autodie ; 
				my $error_msg = "Logger::MkDir failed to create the directory \"$dir_to_create\" $! !!!"  ; 
				mkpath( "$dir_to_create" ) || cluck( "$error_msg" ) ;  
			};

			if ( $@ ) {
				if (undef)      { $msg 			= "[INFO ] No error. Proceed " ; }
				elsif ('open')  { $error_msg 	= "[FATAL] failed to open the dir: $dir_to_create" ; }
				elsif (':io')   { $error_msg 	= "[FATAL] Non-open, IO error for the dir: $dir_to_create " ; }
				elsif (':all')  { $error_msg 	= "[FATAL] All other autodie errors for the dir: $dir_to_create " ; }
		  		default         { $msg 			= "[INFO ] No error at all" ; }
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
		

	}    





1;

__END__


=head1 NAME

Logger 

=head1 SYNOPSIS

use Logger  ; 


=head1 DESCRIPTION
Provide a simple interface for dynamic logging... 

2019-06-11-13:33:11 --- this is a simple message  
2019-06-11-13:33:11 --- ERROR : This is an error message  
2019-06-11-13:33:11 --- WARN : This is a warning message  
2019-06-11-13:33:11 --- INFO : This is a info message  
2019-06-11-13:33:11 --- DEBUG : This is a debug message  
2019-06-11-13:33:11 --- TRACE : This is a trace message  : FROM Package: Morphus  

- Logger does doInit all the config values it is utilizing on doInit if they do not exist in the config file 
- Logger understands the following type of msgs : DEBUG,ERROR,TRACE,INFO,WARN, SIMPLE
- Logger prints each type of msgs into a file if configured to do so
- The TRACE type of msg does provide a file , line of file of the caller
- When called with the LogBroadCastMsg ( "ERROR" , "INFO" , "ANYOTHERTYPE" , $msg ) ; Logger will output both the ERROR and the INFO msg 


=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 
