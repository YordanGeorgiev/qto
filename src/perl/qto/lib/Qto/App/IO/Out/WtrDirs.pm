package Qto::App::IO::Out::WtrDirs ; 
	use strict; use warnings; use diagnostics ; 

	my $VERSION = '1.0.0';

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
	use File::Path qw(make_path) ;
	use File::Compare;
	use IO::File;
	use File::Find;
	use Fcntl qw( :flock );
	use File::Copy;
	use File::Path ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ; 
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

	my @EXPORT = qw(doMkDir);


	#
	# -----------------------------------------------------------------------------
	# Create a dir or cluck why it can't
	# use by if ( $self->doMkDir ( $dir_to_create ) ; 
	# -----------------------------------------------------------------------------
	sub doMkDir {

		my $self        	= shift;
		my $dir_to_create = shift;

		my $error_msg 		= '' ; 
		my $msg 				= '' ; 	


		# if there is !no directory!
		unless ( -d "$dir_to_create" ) {
			eval { 
				use autodie ; 
				my $error_msg = "WtrDirs::failed to create directory $dir_to_create $! !!!"  ; 
				mkpath( "$dir_to_create" ) || cluck( "$error_msg" ) ;  
			};
		}    
		else {
			#dir exists alles gut !!!
			return 1;
		}
		

	}    
	#eof sub doMkDir

   
   #  the constructor
	# -----------------------------------------------------------------------------
	sub new {
		 my $class = shift;    # Class name is in the first parameter
		 my $self = {};        # Anonymous hash reference holds instance attributes
		 bless($self, $class); # Say: $self is a $class
		 return $self;
	}   
	#eof const


1;

__END__


=head1 NAME

WtrDirs

=head1 SYNOPSIS

use Qto::App::IO::Out::WtrDirs ; 
my $objWtrDirs= 'Qto::App::IO::Out::WtrDirs'->new();
$objWtrDirs = new WtrDirs ( ) ; 
$objWtrDirs->doPrintToFile($file,$strFile);
$objWtrDirs->doMkDir($dir);
  

=head1 DESCRIPTION

Provide a simplistic OO wrapping interface for dir writing 

=head2 EXPORT


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

