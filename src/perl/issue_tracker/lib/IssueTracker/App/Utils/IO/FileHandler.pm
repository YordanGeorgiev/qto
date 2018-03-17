package IssueTracker::App::Utils::IO::FileHandler ; 
	use strict; use warnings; use diagnostics ; 

	my $VERSION = '1.1.8';

	require Exporter;
	our @ISA = qw(Exporter  IssueTracker::App::Utils::OO::SetGetable);
	use AutoLoader  ;

	use Carp qw(cluck croak);
	use File::Path qw(make_path) ;
	use File::Compare;
	use IO::File;
	use File::Find;
	use Fcntl qw( :flock );
	use File::Copy;
	use File::Path ; 
	use Carp ; 
   
   use base qw(IssueTracker::App::Utils::OO::SetGetable);

	my @EXPORT = qw(doReadFileReturnString AppendToFile);
	our ($cnfHolder) = ();


	#
	# -----------------------------------------------------------------------------
	# Reads a file returns a sting , if second param is utf8 returns utf8 string
	# usage:
   # ( $ret , $msg , $str_file ) 
   #         = $objFileHandler->doReadFileReturnString ( $file , 'utf8' ) ; 
   # or
   # ( $ret , $msg , $str_file ) 
   #         = $objFileHandler->doReadFileReturnString ( $file ) ; 
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
               open FILE, "$file "
                 or cluck "failed to open \$file $file : $!" ; 
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


	#
	# ^.* at (.+) line ([0-9]+)[.,]
	# -----------------------------------------------------------------------------
	# Prints the passed string to a file if the file exists it is overwritten
	# -----------------------------------------------------------------------------
	sub PrintToFile {

		my $self             = shift;
		my $FileOutput       = shift
		   || cluck("FileHandler::PrintToFile undef \$FileOutput  !!!");
		my $StringToPrint    = shift
		   || cluck("FileHandler::PrintToFile undef \$StringToPrint  !!!");
		my $mode             = shift 
         || 'utf8' ; 


		#$FileOutput = $self->ToUnixDir($FileOutput);

		$FileOutput =~ m/(.*)(\\|\/)(.*)/g ;
		my $FileDir = "$1$2"  ;
		#print "\$FileDir : $FileDir " ; 

		chomp ( $FileDir ) ; 

		# try to create the dir path of the file path if it does not exist
		unless (-d $FileDir) {
		  $self->MkDir( "$FileDir" );
		  carp "should create the file dir $FileDir" ; 
		}


      if ( $mode eq 'utf8' ) {

         binmode(STDIN,  ':utf8');
         binmode(STDOUT, ':utf8');
         binmode(STDERR, ':utf8');

         open(FILEOUTPUT, ">:utf8", "$FileOutput")
         || cluck("could not open the \$FileOutput $FileOutput! $! \n");

         binmode(FILEOUTPUT, ":utf8") ; 
         
      } else {
         open(FILEOUTPUT, ">$FileOutput")
         || cluck("could not open the \$FileOutput $FileOutput! $! \n");
      }
      

		print FILEOUTPUT $StringToPrint;
		close FILEOUTPUT;

		#debug $strToReturn .=  $StringToPrint;
      return ( 0 , 'print ok' ) ; 
	}  
	#eof sub PrintToFile


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
				my $error_msg = "FileHandler::failed to create directory $dir_to_create $! !!!"  ; 
				mkpath( "$dir_to_create" ) || cluck( "$error_msg" ) ;  
			};
		}    
		else {
			#dir exists alles gut !!!
			return 1;
		}
		
		use warnings 'experimental::smartmatch';

	}    
	#eof sub



	#
	# -----------------------------------------------------------------------------
	# -----------------------------------------------------------------------------
	sub ReadFileReturnArrayRef {
		my $self = shift ; 
		my $path_to_file = shift ; 
		my $arr_ref = () ; 

		open my $handle, '<', $path_to_file;
		chomp(my @lines = <$handle>);
		close $handle;

		$arr_ref = \@lines ; 
		return $arr_ref ; 

	}
	#eof sub ReadFileReturnArrayRef





	# call by : $objFileHandler = new FileHandler ( \$cnfHolder  ) ;
	# source:http://www.netalive.org/tinkering/serious-perl/#oop_constructors�
	# -----------------------------------------------------------------------------
	sub new {

		 my $class = shift;    # Class name is in the first parameter
		 $cnfHolder = ${shift @_} if (@_);

		 my $self = {};        # Anonymous hash reference holds instance attributes

		 bless($self, $class); # Say: $self is a $class
		 $self->Initialize();

		 return $self;
	}   
	#eof const



	#
	# -----------------------------------------------------------------------------
	# Initialize the object with the minimum dat it will need to operate
	# -----------------------------------------------------------------------------
	sub Initialize {

		 my $self = shift;

		 #debug print "objFileHandler Intialized \n" ;
	}
	#eof sub Initialize


	sub AUTOLOAD {

		 my $self = shift;
		 no strict 'refs';
		 my $name = our $AUTOLOAD;
		 *$AUTOLOAD = sub {
			  my $msg =
				 "BOOM! BOOM! BOOM! \n RunTime Error !!!\nUndefined Function $name(@_)\n";
			  cluck("$self , $msg");
		 };
		 goto &$AUTOLOAD;    # Restart the new routine.
	}
	#eof sub AUTOLOAD

	# -----------------------------------------------------------------------------
	# called automatically by perl , yet nice to have sometimes when ...
	# -----------------------------------------------------------------------------
	sub DESTROY {

		 my $self = shift;

		 #debug print "the DESTRUCTOR is called  \n" ;
		 return;
	}


# STOP OO
# =============================================================================

1;

__END__


=head1 NAME

FileHandler

=head1 SYNOPSIS

use FileHandler  ; 
  

=head1 DESCRIPTION

Provide a simple OO interface handling of files

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

Copyright (C) 2017 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.


-------------------------------------------------------------------------------
--	VersionHistory: 
-------------------------------------------------------------------------------

1.1.8 -- 2017-04-29 21:05:53 -- improved utf8 read with doReadFileReturnString
1.1.7 -- 2014-09-30 10:45:06 -- ysg -- fiexed bug with use Carp
1.1.6 -- 2014-06-01 22:30:40 -- ysg -- mkpath -> make_path
1.1.5 -- 2012-12-26 22:31:30 -- ysg -- re-formattting 

=cut

