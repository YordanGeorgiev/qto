package Qto::App::IO::In::RdrFiles ; 
	use strict; use warnings; use diagnostics ; 

	my $VERSION = '1.0.0';

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

	my @EXPORT = qw(doReadFileReturnString doReadFileReturnArrayRef);


	#
	# -----------------------------------------------------------------------------
	# Reads a file returns a sting , if second param is utf8 returns utf8 string
	# usage:
   # ( $ret , $msg , $str_file ) 
   #         = $objRdrFiles->doReadFileReturnString ( $file , 'utf8' ) ; 
   # or
   # ( $ret , $msg , $str_file ) 
   #         = $objRdrFiles->doReadFileReturnString ( $file ) ; 
	# -----------------------------------------------------------------------------
	sub doReadFileReturnString {

      my $self      = shift;
      my $file      = shift;
      my $mode      = shift ; 

      my $msg        = {} ;     
      my $ret        = 1 ; 
      my $s          = q{} ; 

      $msg = " the file : $file does not exist !!!" ; 
      cluck ( $msg ) unless -e $file ; 

      $msg = " the file : $file is not actually a file !!!" ; 
      cluck ( $msg ) unless -f $file ; 

      $msg = " the file : $file is not readable !!!" ; 
      cluck ( $msg ) unless -r $file ; 

      $msg .= "can not read the file $file !!!";

      return ( $ret , "$msg ::: $! !!!" , undef ) 
         unless ((-e $file) && (-f $file) && (-r $file));

      $msg = '' ; 

	   $s = eval {	
          my $string = ();    #slurp the file	
          {
            local $/ = undef;

            if ( defined ( $mode ) && $mode eq 'utf8' ) {
               open FILE, "<:utf8", "$file"
                 or cluck("failed to open \$file $file : $!");
               $string = <FILE> ; 
               die "did not find utf8 string in file: $file" 
                  unless utf8::valid ( $string ) ; 
            }
            else {
               open FILE, "$file" 
                  or cluck ("failed to open the \$file $file : $!" ) ; 
               $string = <FILE> ; 
            }
            close FILE;

          }
         $string ; 
       };

       if ( $@ ) {
         $msg = $! . " " . $@ ; 
         cluck ( $msg ) ; 
         $ret = 1 ; 
         $s = undef ; 
       } else {
         $ret = 0 ; $msg = "ok for read file: $file" ;  
       }
		 return ( $ret , $msg , $s ) ; 
	}
	#eof sub doReadFileReturnString


	sub doReadFileReturnArrayRef {
		my $self = shift ; 
		my $path_to_file = shift ; 
		my $arr_ref = () ; 

		open my $handle, '<', $path_to_file;
		chomp(my @lines = <$handle>);
		close $handle;

		$arr_ref = \@lines ; 
		return $arr_ref ; 

	}
	#eof sub doReadFileReturnArrayRef

   # 
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

RdrFiles

=head1 SYNOPSIS

use Qto::App::IO::In::RdrFiles ; 
my $objRdrFiles= 'Qto::App::IO::In::RdrFiles'->new();
$objRdrFiles = new RdrFiles ( ) ; 
my $str_file = $objRdrFiles->doReadFileReturnString($in_file);
  

=head1 DESCRIPTION

Provide a simplistic OO wrapping interface handling of files

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

Copyright (C) 2018 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.



=cut

