package Qto::App::Utils::Initiator ; 

	use strict; use warnings;

	my $VERSION = '1.2.1';    #doc at the end

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;

	use Cwd qw/abs_path/;
   use File::Basename;
	use File::Path qw(make_path) ;
	use File::Find ; 
	use File::Copy;
	use File::Copy::Recursive ; 
   use Data::Printer ; 
	use Sys::Hostname;
	use Carp qw /cluck confess shortmess croak carp/ ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ;
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

	our $config						= {} ; 
	our $RunDir 						= '' ; 
	our $ProductBaseDir 				= '' ; 
	our $ProductDir 					= '' ; 
	our $ProductInstanceDir 	   = ''; 
	our $ProductInstanceEnv       = '' ; 
	our $ProductName 					= '' ; 
	our $EnvType 					= '' ; 
	our $ProductVersion 				= ''; 
	our $ProductOwner 				= '' ; 
	our $HostName 						= '' ; 
	our $ConfFile 						= '' ; 
   our $rel_levels               = 0 ; 
   our $my_absolute_path         = '' ; 
=head1 SYNOPSIS

	doResolves the product version and base dirs , bootstraps cnfig files if needed

		 use Initiator;
		 my $objInitiator = new Initiator () ; 

	=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS


=cut

	#
	# ---------------------------------------------------------
	# the product base dir is the dir under which all the product
	# instances are installed 
	# ---------------------------------------------------------
	sub doResolveProductBaseDir {

		my $self = shift;
		my $msg  = ();
		my $levels_up = 9 + $rel_levels ; 
		my $product_base_dir = '' ; 
		my @DirParts = ();
		@DirParts = @{doGetDirParts($levels_up)};
      $product_base_dir = join( '/', @DirParts );
		#untainting ...
		$ProductBaseDir 						= $product_base_dir ; 
		$product_base_dir 					= $self->untaint ( $product_base_dir); 
		$ProductBaseDir 						= $self->untaint ( $product_base_dir); 
		$self->{'ProductBaseDir'} 			= $ProductBaseDir ; 
		$config->{'ProductBaseDir'} 	= $ProductBaseDir ; 
		$self->{'AppConfig'} 				= $config; 

		return $ProductBaseDir;
	}
	

	#
	# ---------------------------------------------------------
	# the product base dir is the dir under which all the product
	# instances are installed 
	# ---------------------------------------------------------
	sub doGetDirParts {

		my $msg  = ();
		my $levels_up = shift ; 

		$my_absolute_path =~ m/^(.*)(\\|\/)(.*)/;
		$my_absolute_path = $1;
      
		$my_absolute_path =~ tr|\\|/| if ( $^O eq 'MSWin32' );
		my @DirParts = split( '/' , $my_absolute_path );
		for ( my $count = 0; $count < $levels_up ; $count++ ){ 
			pop @DirParts; 
		}
		
		return \@DirParts ; 
	}


   #
	# ---------------------------------------------------------
	# the product version dir is the dir where this product 
	# instance is situated
	# ---------------------------------------------------------
	sub doResolveProductDir {

		my $self = shift;
		my $msg  = ();
		my $levels_up = 7 + $rel_levels ; 
		my $product_dir = '' ; 
		my @DirParts = @{doGetDirParts ( $levels_up )} ; 
		$ProductDir = join( '/' , @DirParts );
		$self->{'ProductDir'} 			= $ProductDir ; 
		$config->{'ProductDir'} 	= $ProductDir ; 
		$self->{'AppConfig'} 				= $config; 
      
		return $ProductDir;
	}
	

	#
	# ---------------------------------------------------------
	# the product version dir is the dir where this product 
	# instance is situated
	# ---------------------------------------------------------
	sub doResolveProductInstanceDir {

		my $self = shift;
      $rel_levels = shift unless ( $rel_levels ) ; 
      $rel_levels = 0 unless $rel_levels ; 
		my $msg  = ();
		my $levels_up = 5 + $rel_levels ; 
		my $PRODUCT_INSTANCE_DIR = '' ; 
		my @DirParts = @{doGetDirParts ( $levels_up )} ; 
		
		$PRODUCT_INSTANCE_DIR 					= join( '/' , @DirParts );
		$ProductInstanceDir 						= $PRODUCT_INSTANCE_DIR ; 
		$PRODUCT_INSTANCE_DIR 					= $self->untaint ( $PRODUCT_INSTANCE_DIR); 
		$ProductInstanceDir 						= $self->untaint ( $PRODUCT_INSTANCE_DIR); 
		$self->{'ProductInstanceDir'} 	   = $ProductInstanceDir ; 
		$config->{'ProductInstanceDir'} 	= $ProductInstanceDir ; 
		$self->{'AppConfig'} 				   = $config; 

		return $ProductInstanceDir;
	}

   sub doResolveVersion {
		my $self = shift ; 

      $ProductInstanceDir = $self->doResolveProductInstanceDir() unless $ProductInstanceDir ;
		my $file = $ProductInstanceDir . '/.env' ;
		open my $fh, '<', $file or carp "no .env file $file in the product instance dir !!!" ;
		
		while( my $line = <$fh>)  {   
			 $ProductVersion = $line;    
			 $ProductVersion =~ s/VERSION=(.*)/$1/g;
			 last if $ProductVersion =~ m/(\d\.){3}/g ;
		}
		close $fh; 
		$self->{'VERSION'} 	   = $ProductVersion;
		$config->{'VERSION'} 	= $ProductVersion; 
		$self->{'AppConfig'}    = $config; 

      return $ProductVersion;
   }


	#
	# ---------------------------------------------------------
	# the environment name is the dir identifying this product 
	# instance from other product instances 
	# ---------------------------------------------------------
	sub doResolveProductInstanceEnv {

		my $self = shift;
		my $msg  = ();

		$ProductInstanceEnv 			         = $ProductInstanceDir ; 
		$ProductInstanceEnv 			         =~ s#$ProductBaseDir\/##g ;
		$ProductInstanceEnv 			         =~ s#(.*?)(\/|\\)(.*)#$3#g ;
		$ProductInstanceEnv 			         = $self->untaint ( $ProductInstanceEnv ); 

		$config->{'ProductInstanceEnv'}  = $ProductInstanceEnv ; 
		$self->{ 'ProductInstanceEnv' } 		= $ProductInstanceEnv ; 
		$self->{'AppConfig'} 				   = $config; 

		return $ProductInstanceEnv;
	}


	#
	# ---------------------------------------------------------
	# the Product name is the name by which this Product is 
	# identified 
	# ---------------------------------------------------------
	sub doResolveProductName {

		my $self = shift;
		my $msg  = ();

		#fetch the the product name from the dir struct
		my @tokens = split /\./ , $ProductInstanceEnv ; 
		$ProductName = $tokens[0] ; 

		$config->{ 'ProductName' } 			= $ProductName ; 
		$self->{'AppConfig'} 				= $config; 
		return $ProductName;
	}


	#
	# ---------------------------------------------------------
	# the Product Version is a number identifying the stage 
	# of the evolution of this product 
	# ---------------------------------------------------------
	sub doResolveProductVersion {

		my $self = shift;
		my $msg  = ();
		
		my $ProductVersion	= '' ;

		my @tokens 			= split /\./ , $ProductInstanceEnv ; 
		$tokens [1] = $tokens [1] // '' ; 
		$tokens [2] = $tokens [2] // '' ; 
		$tokens [3] = $tokens [3] // '' ; 
		$ProductVersion 	= $tokens[1] . '.' . $tokens[2] . '.' . $tokens[3] ; 
		#debug rint "\n\n ProductVersion : $ProductVersion " ; 
		
		$config->{ 'ProductVersion' } 		= $ProductVersion ; 
		$self->{'AppConfig'} 				= $config; 

		return $ProductVersion;
	}


	#
	# ---------------------------------------------------------
	# the Product Type could be :
	# dev -> this product instance is used for development
	# tst -> this product instance is used for testing 
	# qas -> this product instance is used for quality assurance
	# prd -> this product instance is used for production
	# Of course you could define you own abbreviations like ...
	# fub -> full backup
	# ---------------------------------------------------------
	sub doResolveEnvType {

		my $self = shift;
		my $msg  = ();

		my @tokens = split /\./ , $ProductInstanceEnv ; 
		# the type of this environment - dev , test , dev , fb , prod next_line_is_templatized
		my $EnvType = $tokens[4] ; 
		# debug rint "\n\n EnvType : $EnvType " ; 

		$config->{ 'EnvType' } 			= $EnvType ; 
		$self->{ 'EnvType' } 			= $EnvType ; 
		$self->{'AppConfig'} 				= $config; 

		return $EnvType;
	}



	#
	# ---------------------------------------------------------
	# the Product Owner is the string identifying the main 
	# responsible person for operating the current product 
	# instance 
	# ---------------------------------------------------------
	sub doResolveProductOwner {

		my $self = shift;
		my $msg  = ();


		my @tokens = split /\./ , $ProductInstanceEnv ; 
		# the Owner of this environment - dev , test , dev , fb , prod next_line_is_templatized
		# The username of the person developin this environment 
		$ProductOwner = $tokens[5] ; 
		#debug rint "\n\n ProductOwner : $ProductOwner " ; 

		$config->{ 'ProductOwner' } 			= $ProductOwner ; 
		$self->{'AppConfig'} 				= $config; 
		return $ProductOwner;
	}


	#
	# ---------------------------------------------------------
	# returns the host name of currently running host
	# by using the Sys::hostname perl module
	# ---------------------------------------------------------
	sub doResolveHostName {

		my $self = shift;
		my $msg  = ();

		$HostName = hostname ; 
		$self->set ( 'HostName' , $HostName );
		$config->{ 'HostName' }	      = $HostName ; 
		$self->{'AppConfig'} 				= $config; 
		return $HostName;
	}


	#
	# ---------------------------------------------------------
	# returns the host name of currently running host
	# by using the Sys::ConfFile perl module
	# ---------------------------------------------------------
	sub doResolveIniConfFile {

		my $self 						= shift;
		my $msg  						= ();
		
		my $HostName					= $self->doResolveHostName();

		# set the default ConfFile path if no cmd argument is provided
		$ConfFile = "$ProductInstanceDir/cnf/$ProductName.$HostName.cnf" ; 

      # override with env conf file if found one ...
      # cnf/qto.host-name.cnf
      # cnf/qto.dev.host-name.cnf
      # cnf/qto.tst.host-name.cnf
      # cnf/qto.prd.host-name.cnf
      if ( -f "$ProductInstanceDir/cnf/$ProductName.$EnvType.$HostName.cnf" ) {
		   $ConfFile = "$ProductInstanceDir/cnf/$ProductName.$EnvType.$HostName.cnf" 
      }
      

		$self->set('ConfFile' , $ConfFile) ; 
		$config->{'ConfFile'} 	= $ConfFile ; 
		$self->{'AppConfig'} 		= $config; 

		 
		return $ConfFile;
	}


	#
	# ---------------------------------------------------------
	# returns the host name of currently running host
	# by using the Sys::ConfFile perl module
	# ---------------------------------------------------------
	sub doResolveConfFile {

		my $self 						= shift;
		my $msg  						= ();
		
      # cnf/env/dev.env.json
      # cnf/env/tst.env.json
      # cnf/env/prd.env.json
      if ( -f "$ProductInstanceDir/cnf/env/$EnvType.env.json" ) {
		   $ConfFile = "$ProductInstanceDir/cnf/env/$EnvType.env.json" 
      }
      
		$self->set('ConfFile' , $ConfFile) ; 
		$config->{'ConfFile'} 	= $ConfFile ; 
		$self->{'AppConfig'} 		= $config; 

		 
		return $ConfFile;
	}


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor
=cut 

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {
		
		my $invocant = shift;    
		# might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 
      $rel_levels = shift || 0 ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class

      # !!! important concept - src: https://stackoverflow.com/a/90721/65706
      $my_absolute_path             = abs_path( __FILE__ ); 
		$ProductBaseDir 			      = $self->doResolveProductBaseDir();
		$ProductDir 			         = $self->doResolveProductDir();
		$ProductInstanceDir 		      = $self->doResolveProductInstanceDir();
		$ProductInstanceEnv           = $self->doResolveProductInstanceEnv();
		$ProductName 				      = $self->doResolveProductName();
		$ProductVersion 			      = $self->doResolveProductVersion();
		$EnvType 				         = $self->doResolveEnvType();
		$ProductOwner 				      = $self->doResolveProductOwner();
		$HostName 					      = $self->doResolveHostName();
		$ConfFile 					      = $self->doResolveIniConfFile();


		return $self;
	}  


	# -----------------------------------------------------------------------------
	# cleans potentially suspicious dirs and files for the perl -T call
	# -----------------------------------------------------------------------------
	sub untaint {
	   my $self          = shift ; 	
		my $file 			= shift || croak 'no file passed !!!' ;

		# Don't pollute caller's value.
  		local $@;   

		
		# it just does not work under Windows ... 
		return $file if ( $^O eq 'MSWin32' ) ; 

		#debug rint ( "undef file" ) unless ( $file ) ; 
		#debug rint ( "BEFORE untaint -- file: $file " ) ; 
		
		unless ( $self->is_tainted ( $file ) ) {
			
			$file =~ /([\/_\-\@\w.]+)/ ;
			#debug rint "Initiator::untaint \$1 is $1 \n" ; 
			$file = $1; 			
			#$dat should be now untainted
			#debug rint "file : $file is not tainted \n" ; 
			#debug rint ( "AFTER untaint -- file: $file " ) ; 
			return $1 ; 
		} else {
			carp "Bad dat in file path: '$file'"; 	
		}
		
	}
	

	# -----------------------------------------------------------------------------
	# src:http://perldoc.perl.org/functions/local.html
	# src:http://perldoc.perl.org/perlsec.html#Laundering-and-Detecting-Tainted-Data
	# -----------------------------------------------------------------------------
	sub is_tainted {
		my $self = shift ; 
  		local $@;   # Don't pollute caller's value.
      my @params = @_ || ();
		return ! eval { eval("#" . substr(join("", @params), 0, 0)); 1 };
	}



1;

__END__

=head1 NAME

Initiator 

=head1 SYNOPSIS

use Initiator  ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app cnfig hash 

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
1.3.0 --- 2017-11-22 22:26:56 -- Improved Tests
1.2.0 --- 2014-09-11 20:44:26 -- tests on Windows 
1.1.0 --- 2014-08-27 11:29:25 -- tests passed with Test::More
1.0.0 --- 2014-08-25 08:25:15 -- refactored away from main calling script

=cut 

