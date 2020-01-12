package Qto::App::Sec::Guardian ; 
use strict ; use warnings ; 

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
   use AutoLoader 'AUTOLOAD';

	use Cwd qw/abs_path/;
	use Carp qw /cluck confess shortmess croak carp/ ; 
   use Data::Printer ; 
   use Mojo::JWT ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ;
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;
   use Qto::App::IO::In::RdrFiles;

   my $config        = {} ;  # the app config


   # call-by:
   # ( $ret , $msg , $prv_secret ) = $objGuardian->getPrivateKeySecret()
   sub getPrivateKeySecret {

      my $self                = shift ; 
      my $env_type            = $config->{'env'}->{'run'}->{'ENV_TYPE'} ; 
      my $private_key_fpath   = $ENV{"HOME"} . '/.ssh/id_rsa.qto.' . $env_type ; 
      my $objRdrFiles         = 'Qto::App::IO::In::RdrFiles'->new ( \$config ) ;

      my ( $ret , $msg , $str_prv_file ) = $objRdrFiles->doReadFileReturnString ( $private_key_fpath ) ; 
      return ( $ret , $msg , $str_prv_file ); 

   }


   # call-by:
   # ( $ret , $msg , $pub_secret ) = $objGuardian->getPublicKeySecret()
   sub getPublicKeySecret {

      my $self                = shift ; 
      my $env_type            = $config->{'env'}->{'run'}->{'ENV_TYPE'} ; 
      my $public_key_fpath    = $ENV{"HOME"} . '/.ssh/id_rsa.qto.' . $env_type . '.pub' ;
      my $objRdrFiles         = 'Qto::App::IO::In::RdrFiles'->new ( \$config ) ;

      my ( $ret , $msg , $str_pub_file ) = $objRdrFiles->doReadFileReturnString ( $public_key_fpath) ; 
      return ( $ret , $msg , $str_pub_file ); 

   }


   sub isValid {
      my $self       = shift ; 
      my $is_valid   = 0 ; 
      my $msg        = '' ; 

   }


   sub create_token {
      my $self       = shift ; 
      my $prv_secret = shift ;  # the private key secret

      my $msg        = '' ; 
      my $ret        = 1 ; 
      my $jwt        = Mojo::JWT->new(claims => {}, secret => $prv_secret )->encode;

      return ( $ret , $msg , $jwt ) ; 

   }


   sub verify_token {
      my $self       = shift ; 
      my $secret     = shift ;  # might be public AND PRIVATE
      
      my $jwt        = shift ;  # the Json Web Token 

      my $claims     = Mojo::JWT->new(secret => $secret)->decode($jwt);

      return $claims ; 
   }

   # use Qto::App::Sec::Guardian
   # $objGuardian      = 'use Qto::App::Sec::Guardian'->new ( \$config ) ;
	sub new {

		my $class = shift;    # Class name is in the first parameter
		$config = ${ shift @_ } || croak 'no config provided !!!' ; 
		my $self = {};        
		bless( $self, $class );    
	
      #*AUTOLOAD = \&Qto::App::Utils::OO::AutoLoadable::AUTOLOAD;
		return $self;
	}  


1;

__END__

=head1 NAME

Guardian 

=head1 SYNOPSIS

use Guardian  ; 


=head1 DESCRIPTION
the Guardian of the qto Galaxy - verifies the validity Json Web Tokens 

=head2 EXPORT


=head1 SEE ALSO


Qto::Controller::BaseController ; 
https://metacpan.org/pod/Mojo::JWT

=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

