package Qto::App::Utils::Timer ; 

	use strict ; use warnings ; 
	my $VERSION='1.2.9' ; 

	require Exporter;
	our @ISA = qw(Exporter  Qto::App::Utils::OO::SetGetable);
	use AutoLoader ; 
	my @EXPORT = qw(dumpFields GetHumanReadableTime );

   use base qw(Qto::App::Utils::OO::SetGetable);

	use POSIX qw(strftime);
	use Time::Local qw( timelocal_nocheck ) ; 


	my $TimeFormat = 'YYYY-MM-DD hh:mm:ss' ; # the default one


	sub new {
		
		my $invocant = shift;    
		my $class = ref ( $invocant ) || $invocant ; 
		$TimeFormat = shift || 'YYYY-MM-DD hh:mm:ss' ;
		my $self = {};        
		bless( $self, $class );    
		return $self;
	}   


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
		#debug rint "the DESTRUCTOR is called  \n" ; 
		return ; 
	} 


	#
	# -----------------------------------------------------------------------------
	# return the current time in the desired format
	# -----------------------------------------------------------------------------
	sub GetHumanReadableTime {

		my $self = shift ; 
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = ();
		($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $self->GetTimeUnits(); 

		my $HumanReadableTime = '';
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

		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time); 
		$sec = "0$sec" if ($sec < 10); 
		$min = "0$min" if ($min < 10); 
		$hour = "0$hour" if ($hour < 10);
		$mon = $mon + 1;
		$mon = "0$mon" if ($mon < 10); 
		$year = $year + 1900;
		$mday = "0$mday" if ($mday < 10); 

		return ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) ; 
	} 





1;


__END__


=head1 NAME

Timer 

=head1 SYNOPSIS

use Qto::App::Utils::Timer ; 
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer-> GetTimeUnits(); 


=head1 DESCRIPTION

A simple class proding OO methods for time and time formatting 

=head2 EXPORT
qw(dumpFields GetHumanReadableTime )

=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

Copyright (C) 2019 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.



=cut
