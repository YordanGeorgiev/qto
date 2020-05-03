package Qto::App::IO::In::RdrDirs ; 
	use strict; use warnings; use diagnostics ; 

	my $VERSION = '1.0.0';

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
	use File::Path qw(make_path) ;
	use IO::File;
	use File::Find;
	use Fcntl qw( :flock );
	use File::Path ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ; 
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

	my @EXPORT = qw(doReadDirGetFilesByExtension);

	#
	# -----------------------------------------------------------------------------
	# read dir recursively , return only the files matching the regex for the 
	# file extension , example - get all the .pl or .pm files:
	# my $arrRefTxtFiles = $objFH->doReadDirGetFilesByExtension ( $dir, 'pl|pm')
	# -----------------------------------------------------------------------------
   sub doReadDirGetFilesByExtension {
		my $self = shift ;	# remove this if you are not calling OO style 
		my $dir  = shift ; 
		my $ext  = shift ; 
		
		my @arr_files = () ; 
		# File::find accepts ONLY single function call, without params, hence :
		find(wrapp_wanted_call(\&filter_file_with_ext , $ext , \@arr_files ) , $dir );  
		return \@arr_files ; 
   }

	#
	# -----------------------------------------------------------------------------
	# return only the file with the passed file extention regex
	# -----------------------------------------------------------------------------
	sub filter_file_with_ext {
		my $ext 	= shift ; 
		my $arr_ref_files = shift ; 

		my $F = $File::Find::name;

		# fill into the arr behind the array ref any file matching the ext regex
		push @$arr_ref_files , $F if ( -f $F and $F =~ /^.*\.$ext$/ ) ; 
	}

	#
	# -----------------------------------------------------------------------------
	# the wrapper around the wanted func
	# -----------------------------------------------------------------------------
	sub wrapp_wanted_call {
		my ($function, $param1 , $param2) = @_;

		sub {
		  $function->($param1 , $param2);
		}
	}



	#
	# -----------------------------------------------------------------------------
	# read dir recursively , return only the files matching the regex for the 
	# src: https://www.perlmonks.org/?node_id=170969
	# file extension , example - get all the .pl or .pm files:
	# my $arrRefTxtFiles = $objFH->doFindMaxDepth( $dir, 1)
	# -----------------------------------------------------------------------------
   sub doFindMaxDepth {

		my $self 		= shift ;
		my $root_dir 	= shift ; 
		my $max_depth 	= shift || 1 ;
		my $min_depth 	= shift || $max_depth ;

      $_ = $root_dir ; 	
		my $full_depth = tr!/!! ; # count slashes to get depth
      my $full_max_depth = $full_depth + $max_depth ; 
      my $full_min_depth = $full_depth + $min_depth ; 
		# find files
		my @files;
		find({ wanted => 
				 sub {
					  my $depth = tr!/!!; # count slashes to get depth
					  return if $depth < $full_min_depth or $depth > $full_max_depth;
					  push @files, $_ ;
				 },
				 no_chdir => 1 }, $root_dir );

      my @sorted_files = sort @files ;
		return \@sorted_files ; 
		# sort by mtime
		# @files = sort { (stat($a))[9] <=> (stat($b))[9] } @files;
   }


	sub new {
		 my $class = shift;    # Class name is in the first parameter
		 my $self = {};        # Anonymous hash reference holds instance attributes
		 bless($self, $class); # Say: $self is a $class
		 return $self;
	}   

1;

__END__


=head1 NAME

RdrDirs

=head1 SYNOPSIS

use Qto::App::IO::In::RdrDirs ; 
my $objRdrDirs= 'Qto::App::IO::In::RdrDirs'->new();
my $arr_ref_perl_files = $objRdrDirs->doReadDirGetFilesByExtension($in_dir, 'pl|pm' );
  

=head1 DESCRIPTION

Provide a simplistic OO for reading dirs

=head2 EXPORT


=head1 SEE ALSO


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

Copyright (C) 2019 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

