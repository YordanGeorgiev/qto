package Qto::App::IO::Out::WtrFiles ; 
	use strict; use warnings; use diagnostics ; 

	my $VERSION = '1.0.0' ; 

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
   use Getopt::Long;
	use File::Path qw(make_path) ;
	use File::Compare;
	use IO::File;
	use File::Find;
	use Fcntl qw( :flock );
	use File::Copy;
	use File::Path ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ; 
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

	my @EXPORT = qw(doPrintToFile);

	# ^.* at (.+) line ([0-9]+)[.,]
	# -----------------------------------------------------------------------------
	# Prints the passed string to a file if the file exists it is overwritten
	# -----------------------------------------------------------------------------
	sub doPrintToFile {

		my $self           = shift;
		my $out_file       = shift
		   || confess ("WtrFiles::doPrintToFile undef \$out_file  !!!");
		my $prt_str    = shift
		   || croak("WtrFiles::doPrintToFile undef \$prt_str  !!!");
		my $mode             = shift 
         || 'utf8' ; 

      my $ret            = 1 ; 
      my $msg            = 'unknown error in print to file' ; 


		$out_file =~ m/(.*)(\\|\/)(.*)/g ;
		my $out_file_dir = "$1$2"  ;
		chomp ( $out_file_dir ) ; 

		# try to create the dir path of the file path if it does not exist
		unless (-d $out_file_dir) {
		  $self->doMkDir( "$out_file_dir" ) || carp "should create the file dir $out_file_dir" ; 
		}


      if ( $mode eq 'utf8' ) {

         binmode(STDIN,  ':utf8');
         binmode(STDOUT, ':utf8');
         binmode(STDERR, ':utf8');

         open(out_file, ">:utf8", "$out_file")
         || croak("could not open the \$out_file $out_file! $! \n");

         binmode(out_file, ":utf8") ; 
         
      } else {
         open(out_file, ">$out_file")
         || croak("could not open the \$out_file $out_file! $! \n");
      }
      

		print out_file $prt_str;
		close out_file;
      $ret = 0 ; 
      $msg = 'OK for print to file : ' . $out_file ; 
      return ( $ret , $msg ) ; 
	}  
	#eof sub doPrintToFile


	#
	# -----------------------------------------------------------------------------
	# Create a dir or croak why it can't
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
				my $error_msg = "WtrFiles::failed to create directory $dir_to_create $! !!!"  ; 
				mkpath( "$dir_to_create" ) || croak( "$error_msg" ) ;  
			};
		}    
		else {
			#dir exists alles gut !!!
			return 1;
		}
		

	}    
	#eof sub doMkDir

   # 
	# src: http://www.netalive.org/tinkering/serious-perl/#oop_constructors¨
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

WtrFiles

=head1 SYNOPSIS

use Qto::App::IO::Out::WtrFiles ; 
my $objWtrFiles= 'Qto::App::IO::Out::WtrFiles'->new();
$objWtrFiles = new WtrFiles ( ) ; 
$objWtrFiles->doPrintToFile($file,$strFile);
$objWtrFiles->doMkDir($dir);
  

=head1 DESCRIPTION

Provide a simplistic OO wrapping interface for writing to files

=head2 EXPORT


=head1 SEE ALSO

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

Copyright (C) 2019 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.



=cut

