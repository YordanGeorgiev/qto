package Qto::App::Utils::Configurator ; 

	use strict ;  use warnings ;  use diagnostics ; 

	my $VERSION='2.6.1' ; #doc at the end
	require Exporter;

	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	my @EXPORT = qw(getConfHolder clone);

	use AutoLoader ; 
	use Carp ; 
	use IO::File; 

   use base qw(Qto::App::Utils::OO::SetGetable);
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;
	
   our $ModuleDebug 			= 0  ; 
	our $NowInUnitTest 		= 0  ; 
	our $ConfFile 				= '' ; 
	our $HostName 				= () ; 

	# -----------------------------------------------------------------------------
	# the default global cnfiguration hash ref
	# -----------------------------------------------------------------------------
	our $cnfHolder = {

		# Whether or not to print messages to STDOUT and / or STDERR
		  PrintConsoleMsgs               => 1
		# Whether or not to pring INFO messages
		, PrintInfoMsgs                  => 1                             
		# Whether or not to pring WARNING messages
		, PrintWarningMsgs               => 1                             
		# Whether or not to pring ERROR messages
		, PrintErrorMsgs                 => 1                             
		# Whether or not to pring DEBUG messages
		, PrintDebugMsgs                 => 1
		# Whether or not to pring TRACE messages
		, PrintTraceMsgs                 => 1 
		# The logging directory 
		, LogDir                         => '%ProductInstanceDir%/dat/log/perl'
		# the environment name of this product instance 
		, ProductInstanceEnvironment     => '%ProductName%.%ProductVersion%.%ProductType%.%ProductOwner%'
		# the default Log file
		, LogFile                        => '%LogDir%/%ProductName%.log'
		# the default chars separating the time from the txt
		, LogTimeToTextSeparator         =>'###'
		# whether or not to log to a file
		, LogToFile                      => 1
		# the time format of the logging 
		, TimeFormat                     => 'YYYY-MM-DD hh:mm:ss'
	  };  
	  

	#
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {
		
		my $invocant 			= shift;    
		$ConfFile 				= shift ; 
		my $ref_cnf_holder	= shift ; 
      my $cnf_holder   	= ${$ref_cnf_holder} ; 


		# might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class

		$self->doOverWriteConfHolder ($cnf_holder ) ; 
		$self->doReadConfFile( $ConfFile);

		# print "Configurator.pm::: \n" ; 
		# use Data::Printer ; 
		# p($cnfHolder) ; 
		# sleep 6 ; 

		$$ref_cnf_holder = $cnfHolder ; 

		return $self ; 

	}   
	#eof const

	# -----------------------------------------------------------------------------
	# a constructor taking an ini file and exisiting cnfiguration setting hash
	# -----------------------------------------------------------------------------
	sub clone 
	{
		my $invocant 			= shift;    
		$ConfFile 				= shift ; 
      my $cnf_holder   	   = shift ; 

		
		#debug rint "\n Configurator.pm 89 \$ConfFile : $ConfFile \n" ; sleep 5 ; 
		# might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class

		# interpolate the global cnf holder
		$self->doOverWriteConfHolder ($cnf_holder ) ; 

		# populate with new values from the passed ini file
		#debug rint "from Configurator clone : ConfFile:: $ConfFile \n" ; sleep 3 ; 
		$self->doReadConfFile( $ConfFile);

		# OBS in cloning we do not modify the original global app cnfiguration Holder
		## $$ref_cnf_holder = $cnfHolder ; 

		return $self ; 
	}
	# eof const


	# -----------------------------------------------------------------------------
	# This function goes through the cnfHolder nameless hash, it searches for
	# strings that look like %NAMEOFPARAM%, and replaces it with the
	# possible value
	# -----------------------------------------------------------------------------
	sub doParametrize {

		my $self 	= shift ;
		my $key 		= shift ; 
		my $Value 	= shift ;

		my $old_key = $key ; 

		#print " before if \$Value is $Value \n" ; 

		# start the interpolation of %vars%
		if( $Value =~ m/\%([a-zA-Z_]*?)\%/ ) {
			my $temp = $Value ; 
			# debug ok print " AFTER 1 if \$Value is $Value \n"  ; 

			my ($prt1,$value,$prt2) = ();
			
			#strip the everyting not interpolatable
			$temp =~ m/(.*?)\%([a-zA-Z]*?)\%(.*)/;
			($prt1,$value,$prt2)=($1 , $2 , $3 ) ;

			# debug ok print " AFTER 2 \$value is $value \n"  ; 

			# replace any %HostName% with the running <<NameOfTheHost>>
			croak "undef $cnfHolder->{'HostName'} " unless  ( $cnfHolder->{'HostName'} );
			$Value =~ s/\%HostName\%/$cnfHolder->{'HostName'}/g ; 

			# ($prt1,$value,$prt2)=/(.+?)\%([a-zA-Z]*)\%(.*)/;

			my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = 
									$self->GetTimeUnits(); 

			$Value =~ s/\%YYYY\%/$year/g ; 
			$Value =~ s/\%MM\%/$mon/g ; 
			$Value =~ s/\%DD\%/$mday/g ; 
			$Value =~ s/\%hh\%/$hour/g ; 
			$Value =~ s/\%mm\%/$min/g ; 
			$Value =~ s/\%ss\%/$sec/g ; 


			#debug rint " AFTER 2 \$prt1 IS $prt1 ,\$value IS $value,\$prt2 IS $prt2 \n"; 
			#v.1.2.8 --- ysg --- replace the env vars as well 
			if ( defined ( $value ) && defined ($ENV{"$value"})) {
				$Value =~ s/\%$value\%/$ENV{"$value"}/gi;
				#"%-40s %-80s"
				##debug rintf ("%20s %-30s %-100s " , 'EnvVarName = EnvVarValue' , "$value" , "$ENV{$value}") ; 
			}


			#debug rint "BEFORE the cnfHolder key is " . "$key" . "\n" ; 
			# at this point of time the $cnfHolder->{"$key"} might not even exist
		   if ( defined $value ) {	
            unless ( defined ( $cnfHolder->{"$value"} ) ) {
               die "all configuration variables should be defined in the cnf_file !!!" ; 
            }
            else {
               $Value =~  s/%$value%/$cnfHolder->{"$value"}/gi
            }
         }

			$cnfHolder->{"$key"} = $Value  ;

			# debug ok print "AFTER the cnfHolder key is " . "$key" . "\n" ; 
			# debug ok print "AFTER the cnfHolder value is " . $cnfHolder->{"$key"} . "\n" ; 
		} 
		#eof if start the interpolation of %vars%
		
		#debug #debug rint "AFTER 3  \$Value IS $Value \n " ; 

	  if( $Value =~ m/(.*?)\%([a-zA-Z]*)\%(.*)/g ) {
			#debug #debug rint "LABEL 4  \$Value IS $Value \n " ; 
			$Value = $self->doParametrize($key , $Value );
		}
		else {
			#debug #debug rint "LABEL 5  \$Value IS $Value \n "  ;
			my $die_msg = "the var: %" . "$key" ."% is not defined in the ini file: $ConfFile ";
			return $Value;
		}

	} 
	#eof sub doParametrize


	# -----------------------------------------------------------------------------
	# read the ini file line by line, set VarName= VarValue to the cnfHash
	# if #include key is found on the left read the file path on the right 
	# recursively 
	# -----------------------------------------------------------------------------
	sub doReadConfFile {
		
		my $self 			= shift ;
		my $cnf_file 		= shift || $ConfFile ; 

		my $msg 				= '' ; 
		my $error_msg 		= '' ; 
		
		# if we do not have an ini file return with the default values 
		unless ( -f $cnf_file ) { return 0 ; }

		# dump those only 
		if ( $NowInUnitTest == 1 ) {
			$msg = "CFPoint7  OK reading the ini file :" ; 
			print "[INFO ] $msg \n" ; 
			$msg = $cnf_file ; 
			print "[INFO ] $msg \n" ; 
			$msg = "interporlate ini file vars into global app cnfiguration holder hash ref " ; 
			print "[INFO ] $msg \n" ; 
		}

		eval {
			use autodie ; 
			my $error_msg = "[FATAL] Configurator::doReadConfFile cannot open file: $cnf_file" ; 
			#my $cnf_file_h = IO::File->new();
			
			#$cnf_file='/var/csitea/isg-pub/isg-pub.0.9.5.dev.ysg/foo.txxt' ; 
			#open (my $cnf_file_h ,'<' , $cnf_file);
			#open ( cnf_file ,'<' , $cnf_file) or die "$error_msg" ; 
			# debug rint "cofigurator cnf_file is $cnf_file \n" ; 
			my $encoding = ":encoding(UTF-8)" ; 
			open(my $cnf_file_h , '<', $cnf_file ) 
				or die " cannot find cnf_file $cnf_file !!!" ; 
			#while ( < cnf_file > ) {
			# no spaces between the first < the file handle >
			while ( <$cnf_file_h> ) {
				#debug rint "cnfigurator \$_ :: $_ \n" ; 
				#skip the comments
				next if m/^\s+#/g ; 


				if ($_ =~ /^[a-zA-Z=]/) {
					chomp ; 	
					my @tokens = split('=',$_);

					#the var is the left most token separated by =
					my $key = shift (@tokens ) ; 
					#debug rint "key:$key " if ( $NowInUnitTest ) ; 
					#
					my $value = join ('=' , @tokens ) ; 
					#debug rint "value is $value \n" ; 	
					
					$key=trim($key);
					$value = trim($value);
					
					# debug rint "Configurator while \$value is $value \n" if ( $NowInUnitTest ) ; 
					$value = $self->doParametrize($key , $value ) ;

					# if we have include notation 
					if ( $key eq '#include' ) {
						#debug rint "found include \n\n\n" if ( $NowInUnitTest ) ;  
						# if the include file does not exist or is not readable
						# return with error
						unless ( -r $value ) {
							die "ERROR: unexisting cnfiguration file : $value \n " ; 
							return 1 ; 
						}
						$self->doReadConfFile ( $cnf_file , $value ) 
					}
					else {
						# set the VarName = VarValue into the hash
						$cnfHolder->{"$key"} = $value;
				  
				  } #eof if include 
				} #eof if this is key=value line
			} #eof while read line 
			
			close( $cnf_file_h );
			$error_msg = '' ; 

		};	
			
		return 0;
	} 
	#eof sub doReadConfFile

	#
	# -----------------------------------------------------------------------------
	# returns the cnfiguration as a single string 
	# -----------------------------------------------------------------------------
	sub dumpIni {
			
			my $self = shift ; 
			my $str_dump = () ; 
			my $msg = () ; 
			$msg = "CFPoint8  OK    Dump the ready cnfiguration hash for review \n"  ;      
			#debug rint "[INFO ] $msg" ; 
			
			$str_dump .= "\n\n[INFO ] == START == Using the following env INI in perl :\n" ; 
			foreach my $key (sort(keys %$cnfHolder))       {

				$str_dump .=  "$key = $cnfHolder->{$key} \n";
			}
			$str_dump .= "\n[INFO ] == STOP  == Using the following env INI in perl \n\n\n" ; 
			return $str_dump ; 

	} #eof sub 

	#
	# -----------------------------------------------------------------------------
	# overwrite my hash
	# -----------------------------------------------------------------------------
	sub doOverWriteConfHolder {
			
			my $self = shift ; 
			my $passed_cnf_holder = shift ; 
			
			#debug rint $self->dumpIni();
			
			foreach my $key (sort(keys %$passed_cnf_holder ))       {
				$cnfHolder->{"$key"} = $passed_cnf_holder->{"$key"} ; 
				if ( $NowInUnitTest == 1 ) {
					#debug rint "overwriting the key: $key with value : " . $cnfHolder->{"$key"} . "\n" ; 
					#debug rint "with the the new key: $key with new value : " . $passed_cnf_holder->{"$key"} . "\n" ; 
				}
			}
			

	} #eof sub 

	# -----------------------------------------------------------------------------
	# all the ini key - values are set to the %ENV hash  
	# -----------------------------------------------------------------------------
	sub SetAllIniVarsToEnvironmentVars {
			
			my $self = shift ; 
			my $msg = () ; 
			$msg = "set all ini vars to env vars"  ;        
			#debug rint "$msg \n" if ( $NowInUnitTest ) ;  

			foreach my $key (sort(keys %$cnfHolder))       {
				$ENV{"$key"}=$cnfHolder->{"$key"} ; 
			} #eof foreach
	} 
	#eof sub SetAllIniVarsToEnvironmentVars


	# -----------------------------------------------------------------------------
	# returns the ini settings into a string 
	# -----------------------------------------------------------------------------
	sub DumpEnvVars {
			
			my $self = shift ; 
			my $str_dump = () ; 
			
			$str_dump .= "\n\n[INFO ] == START == Using the following env vars in perl :\n"  ;
			foreach my $key (sort(keys %ENV)) {
				$str_dump .=  "$key = $ENV{$key} \n";
			}
			$str_dump .= "\n[INFO ] == STOP  == Using the following env vars in perl\n\n\n" ; 
			return $str_dump ; 
	} 
	#eof sub DumpEnvVars


	# -----------------------------------------------------------------------------
	#  Return the cnfHolder hash reference
	# -----------------------------------------------------------------------------
	sub getConfHolder {  

		return $cnfHolder ; 
	} 
	#eof sub getConfHolder


	# -----------------------------------------------------------------------------
	# used to trap and log run-time errors
	# -----------------------------------------------------------------------------
	sub AUTOLOAD {
		no strict 'refs'; 
		my $name = our $AUTOLOAD;
		*$AUTOLOAD = sub { 
			my $msg = '' ; 
			$msg .= "BOOM! BOOM! BOOM! \n RunTime Error !!!\n" ; 
			$msg .= "ERROR --- undefined function $name(@_) \n" ;
			#debug rint $msg ; 
		};
		goto &$AUTOLOAD;    # Restart the new routine.
	} #eof sub  


	# -----------------------------------------------------------------------------
	# used to trap and log run-time errors
	# -----------------------------------------------------------------------------
	sub DESTROY {
		my $self = shift;
		#debug #debug rint "the DESTRUCTOR is called  \n" ; 
		return ; 
	} 
	# eof sub 


	# -----------------------------------------------------------------------------
	# used to trap and log run-time errors
	# -----------------------------------------------------------------------------
	sub trim {

		 $_[0] =~ s/^\s+//;
		 $_[0] =~ s/\s+$//;
		 return $_[0];
	}
	# eof sub trim 


	# -----------------------------------------------------------------------------
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

	} #eof sub 

	#
	# -----------------------------------------------------------------------------
	#  Return the cnfHolder hash reference
	# -----------------------------------------------------------------------------
	sub getConfHolderRef {  

		return \$cnfHolder ; 
	} 
	#eof sub getConfHolder

1;

__END__



=head1 NAME

Configurator 

=head1 SYNOPSIS

use Configurator ; 
my $objConfigurator = new Configurator( $ConfFile , \$cnfholder ) ;
my $objConfigurator = clone Configurator($FileRobotsIni , \$cnfHolder); 

=head1 DESCRIPTION

This package is responsible for reading the ini-files
it is used by every other application and module in the Product
use vars qw(%variables);


=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT LICENSE

Copyright (C) 2018 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
