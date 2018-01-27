package IssueTracker::App::Utils::Timer ; 

	use strict ; use warnings ; 
	my $VERSION='1.2.8' ; 

	require Exporter;
	our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable);
	use AutoLoader ; 
	my @EXPORT = qw(dumpFields GetHumanReadableTime GetANiceTime GenerateDates);

   use base qw(IssueTracker::App::Utils::OO::SetGetable);

	use POSIX qw(strftime);
	use Time::Local qw( timelocal_nocheck ) ; 


   # ---------------------------------------------------------
	# START OO

	# the default time format
	my $TimeFormat = 'YYYY-MM-DD hh:mm:ss' ; 


	#
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {
		
		my $invocant = shift;    
		# might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		$TimeFormat = shift if ( @_ ) ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
		return $self;
	}   
	#eof const


	#
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub AUTOLOAD {

		my $self = shift ; 
		no strict 'refs'; 
		my $name = our $AUTOLOAD;
		*$AUTOLOAD = sub { 
		my $msg = "BOOM! BOOM! BOOM! \n RunTime Error !!!\nUndefined Function $name(@_)\n" ;
		cluck( "$msg");
		};
		goto &$AUTOLOAD;    # Restart the new routine.
	}  

	sub DESTROY {
		my $self = shift;
		#debug print "the DESTRUCTOR is called  \n" ; 
		return ; 
	} 

	# STOP OO
	# 

	# 
	# START functions

	#
	# -----------------------------------------------------------------------------
	# return the current time in the YYYY-MM-DD - dd:hh:ss format
	# -----------------------------------------------------------------------------
	sub GetHumanReadableTime {

		my $self = shift ; 
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $self->GetTimeUnits(); 

		my $HumanReadableTime = () ; 
		$HumanReadableTime = $TimeFormat ;  
		$HumanReadableTime =~ s/YYYY/$year/ ; 
		$HumanReadableTime =~ s/MM/$mon/ ; 
		$HumanReadableTime =~ s/DD/$mday/ ; 
		$HumanReadableTime =~ s/hh/$hour/ ; 
		$HumanReadableTime =~ s/mm/$min/ ;
		$HumanReadableTime =~ s/ss/$sec/ ;

		return "$HumanReadableTime"; 

	} 


	#
	# -----------------------------------------------------------------------------
	# call by: 
	# my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer-> GetTimeUnits(); 
	# -----------------------------------------------------------------------------
	sub GetTimeUnits {

		my $self = shift ; 

		# Purpose: returns the time in yyyymmdd-format 
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
	# call by: 
	# -----------------------------------------------------------------------------
	sub GetNiceTodayDate {

		my $self = shift ; 
		$TimeFormat  = shift if ( @_ ) ; 
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)  = $self->GetTimeUnits(); 

		my $today = $TimeFormat ; 

		$today =~ s/YYYY/$year/g ; 
		$today =~ s/MM/$mon/g ; 
		$today =~ s/DD/$mday/g ;

		return "$today" ; 
	} #eof sub 


	#
	# -----------------------------------------------------------------------------
	# call by: 
	# -----------------------------------------------------------------------------
	sub GetNiceYesterdayDate {

		my $self = shift ; 
		my $TimeFormat = shift if ( @_ ) ; 
		
		$TimeFormat  = shift if ( @_ ) ; 
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)  = $self->GetTimeUnits(); 

		my $yesterday = $TimeFormat ; 

		$yesterday =~ s/YYYY/%Y/g ; 
		$yesterday =~ s/MM/%m/g ; 
		$yesterday =~ s/DD/%d/g ;

		$yesterday = strftime "%Y-%m-%d", $sec, $min, $hour, $yday - 1, $mon, $year;


		return "$yesterday" ; 
	} 
	#eof sub 


	#
	# -----------------------------------------------------------------------------
	# return the current time in the YYYY-MM-DD - dd:hh:ss format
	# -----------------------------------------------------------------------------
	sub GetANiceTime {

		my $self = shift ; 

		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $self->GetTimeUnits(); 
		return "$year$mon$mday" . "_" . "$hour$min$sec"; 

	}
	#eof sub GetANiceTime



	#
	# -----------------------------------------------------------------------------
	# 
	# -----------------------------------------------------------------------------
	sub GenerateDates {

		my $self = shift ; 
		my $startDate = shift ;       #such as '2010-09-23';
		my $daysToAdd = shift ; #such as '360';

		my $StrToReturn = () ; 

		$startDate =~ /(\d+)-(\d+)-(\d+)/;
		my ($mday,$mon,$year) = ($3,$2,$1);

		# convert to epoch time
		my $date = timelocal_nocheck(0,0,0,
														 $mday-1,
														 $mon-1,
														 $year
														);
		# make the new filenames
		for (1..$daysToAdd) {
		 my $NewDate = strftime('%Y%m%d',0,0,0,
													 (localtime($date+=86400))[3,4,5]
													);
		 my $RunTimeStart = "$NewDate" . "000000" ; 
		 my $RunTimeStop = "$NewDate" . "235959" ; 
		 #debug print "$RunTimeStart---$RunTimeStop\n" ; 
		 $StrToReturn .= "$RunTimeStart---$RunTimeStop\n" ; 

		} #eof for


		return $StrToReturn ; 

	} 
	#eof sub GenerateDates 


# STOP functions
# ---------------------------------------------------------


1;
__END__


=head1 NAME

Timer 

=head1 SYNOPSIS

use Timer  ; 


=head1 DESCRIPTION

A simple class proding OO methods for time and time formatting 

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

Copyright (C) 2012 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.


VersionHistory: 
1.2.8 --- 2012-09-05 15:17:15 --- add a formatting for get today's date 
1.2.8 --- ysg --- fixed $sec bug 
1.2.8 --- ysg --- Added my $VERSION
1.2.8 --- ysg --- Added time formatter in constructor 
1.2.8 --- ysg --- Create basic methods 
1.0.0 --- ysg --- Stolen shamelessly from several places of the Perl monks ...

=cut
