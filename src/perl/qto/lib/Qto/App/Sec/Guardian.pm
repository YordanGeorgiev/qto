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
use Mojo::File;

use parent 'Qto::App::Utils::OO::SetGetable' ;
use parent 'Qto::App::Utils::OO::AutoLoadable' ;
use Qto::App::IO::In::RdrFiles;
use Qto::App::Utils::Timer ; 
use Qto::App::IO::In::CnrEncrypter ;
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

our $config                = {} ;
our $objLogger             = {} ;
our $jwt_public_key_file   = '' ; 
our $jwt_private_key_file  = '' ; 

# call-by: 
# $objGuardian->doAuthenticate($config,$db, $controller);
# returns 1 if is authenticated, otherwise 0
sub isAuthenticated {

   my $self                = shift ;
   my $config              = shift ; 
   my $db                  = shift ;
   my $controller          = shift ;
   my $rv                  = 0;

   # non-authentication mode IF the app has been stared with this env var
   return 1 if $ENV{'QTO_NO_AUTH'}; # no authentication when testing if desired so !!!

   p $controller->session( 'app.' . $db . '.user') ;
   print ('app.' . $db . '.user');
   print " ::: eof session user from isAuthenticated in Guardian.pm \n";

   # basic native authentication mode if NOT started with this env var
   unless ( defined ( $controller->session( 'app.' . $db . '.user')) ) {
      return 0;
   } else {
      return 1 ;
   }

}

# --------------------------------------------------------
# called during the login process
# call-by: 
# ( $rv, $msg , $jwt ) = $objGuardian->doGrantAccessToken($hsr);
# --------------------------------------------------------
sub doGrantAccessToken {
   my $self        = shift ; 
   my $hsr         = shift ; 

   my $prv_secret  = $self->doGetPrivateKeySecret();
   my $claims      = $self->doBuildClaims($hsr);

   my ( $rv, $msg , $jwt) = $self->create_token($claims,$prv_secret);
   return ( $rv, $msg , $jwt );
}


# build the JWT claims based on the login hash ref
# src: https://www.iana.org/assignments/jwt/jwt.xhtml
sub doBuildClaims {
   my $self             = shift ; 
   my $hsr              = shift ; 
   my $claims           = {} ;
  
   $claims->{'iss'}     = 'qto-' . $config->{'env'}->{'run'}->{'VERSION'};
   $claims->{'sub'}     = $hsr->{'user_id'};
   $claims->{'name'}    = $hsr->{'user_name'};
   $claims->{'email'}   = $hsr->{'email'};

   return $claims ;
}


# --------------------------------------------------------
# call-by: my $epass  = $objGuardian->doProduceEncryptedPass($pass);
# --------------------------------------------------------
sub doProduceEncryptedPass {
   my $self = shift ; 
   my $pass = shift ; 

   my $objCnrEncrypter = 'Qto::App::IO::In::CnrEncrypter'->new();
   my $epass = $objCnrEncrypter->make_crypto_hash($pass ) ; 
   return $epass ;
}


# --------------------------------------------------------
# call-by: $objGuardian->passwordsMatch($dbepass,$pass);
# returns 1: if the passwords match , 0 if they do NOT match
# --------------------------------------------------------
sub passwordsMatch {

   my $self       = shift ; 
   my $dbepass    = shift ;
   my $pass       = shift ; 

   my $objCnrEncrypter = 'Qto::App::IO::In::CnrEncrypter'->new();
   return $objCnrEncrypter->match_passphrase_against_crypto_hash($dbepass,$pass) ;
}


# usage:
# ( $ret , $msg , $prv_secret ) = $objGuardian->doGetPrivateKeySecret()
sub doGetPrivateKeySecret {

   my $self = shift ; 
   my $private_key_str = 'Mojo::File'->new($jwt_private_key_file)->slurp;
   return $private_key_str ;
}


# usage:
# ( $ret , $msg , $pub_secret ) = $objGuardian->doGetPublicKeySecret()
sub doGetPublicKeySecret {

   my $self = shift ; 
   my $public_key_str = 'Mojo::File'->new($jwt_public_key_file)->slurp;
   return $public_key_str ;
}


# usage:
# $self->create_token
sub create_token {
   my $self       = shift ; 
   my $claims     = shift ; # the claims of the jwt
   my $prv_secret = shift ;  # the private key secret
   my $msg        = 'an error during create_token in Guardian occurred !!!' ; 
   my $ret        = 1 ; 
   my $header = {
      "typ" => "JWT",
      "alg" => "RS256"
   };

   my $jwt        = Mojo::JWT->new() ; 
   $jwt->algorithm('RS256');
   $jwt->claims($claims);
   $jwt->secret($prv_secret);
   $jwt->header($header);

   my $token      = $jwt->encode;
   $msg           = '' ; 
   $ret           = 0 ; 
   
   return ( $ret , $msg , $token) ; 
}


# usage
sub doVerifyTokenAndGetClaims {

   my $self       = shift ; 
   my $token      = shift ;  # the Json Web Token as string
   my $pub_secret = shift ; 

   my $msg        = '';
   my $rv         = 1;
   my $jwt        = 'Mojo::JWT'->new();

   $jwt->algorithm('RS256');
   $jwt->public($pub_secret);

   my $claims     = $jwt->decode($token);
   $rv            = 0 ; 
   return ( $rv, $msg, $claims);
}


# use Qto::App::Sec::Guardian
# $objGuardian      = 'use Qto::App::Sec::Guardian'->new ( \$config ) ;
sub new {

   my $class = shift;    # Class name is in the first parameter
   $config = ${ shift @_ } || croak 'no config provided !!!' ; 
   my $self = {};        
   bless( $self, $class );    
   $self->do_init();
   #*AUTOLOAD = \&Qto::App::Utils::OO::AutoLoadable::AUTOLOAD;
   return $self;
}  


sub do_init {
   
   my $self                = shift  ;
   my $env_type            = $config->{'env'}->{'run'}->{'ENV_TYPE'} ; 
   $jwt_private_key_file   = $ENV{'HOME'} . '/.ssh/qto.' . "$env_type" . '.jwtRS256.key';
   $jwt_public_key_file    = $ENV{'HOME'} . '/.ssh/qto.' . "$env_type" . '.jwtRS256.key.pub';

}


1;

__END__


=head1 NAME

Guardian 

=head1 SYNOPSIS


   use Qto::App::Sec::Guardian
   my $objGuardian      = 'use Qto::App::Sec::Guardian'->new ( \$config ) ;

=head1 DESCRIPTION

the Guardian of the QTO Galaxy - verifies the validity Json Web Tokens 

=head2 EXPORT


=head1 SEE ALSO


Qto::Controller::BaseController ; 
https://metacpan.org/pod/Mojo::JWT

=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

