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


sub isAuthenticated {

   my $self                = shift ;
   my $config              = shift ; 
   my $db                  = shift ;
   my $controller          = shift ;
   my $msg                 = ${ shift @_ }; # ref passed !!!
   my $rv                  = 0;
   $msg                    = 'an error occurred during the authentication !!!' ;

   return 1 if $ENV{'QTO_NO_AUTH'}; # no authentication when testing if desired so !!!

   # qto-200302161711 - jwt auth implementation
   if ( defined $ENV{'QTO_JWT_AUTH'} && $ENV{'QTO_JWT_AUTH'} == 1 ){
      # get the jwt from the session 
      return 0 unless ( defined ( $controller->session( 'app.' . $db . '.jwt')));
      my $jwt           = $controller->session( 'app.' . $db . '.jwt');
      my $pub_secret    = $config->{'env'}->{'run'}->{ 'PublicRSAKey' } ; 

      ( $rv, $msg, my $claims_from_token ) = $self->doVerifyTokenAndGetClaims($jwt,$pub_secret);
      return $rv unless $rv == 0 ; 

   } else {
      # basic native authentication mode if NOT started with this env var
      unless ( defined ( $controller->session( 'app.' . $db . '.user')) ) {
         return 0;
      } else {
         return 1 ;
      }
   }

}

# call-by: 
# $objGuardian->doAuthenticate($config,$db, $controller);
# returns 1 if is authorized, returns 0 if NOT authorized to perform 
# the <<web-action>> to the <<web-action-subject>>
sub isAuthorized {

   my $self                = shift ;
   my $config              = shift ; 
   my $db                  = shift ;
   my $controller          = shift ;
   my $msg                 = ${ shift @_ }; # ref passed !!!
   my $rv                  = 0;
   $msg                    = 'an error occurred during authentication !!!' ;

   p $ENV{'QTO_NO_AUTH'} ; 
   print "QTO_NO_AUTH in Guardian.pm todo:ysg \n";
   # non-authentication mode IF the app has been stared with this env var
   return 1 if $ENV{'QTO_NO_AUTH'}; # no authentication when testing if desired so !!!


   # debug rint $controller->session( 'app.' . $db . '.user') ;
   # debug rint ('app.' . $db . '.user');
   # debut rint " ::: eof session user from isAuthenticated in Guardian.pm \n";
   #
   p $ENV{'QTO_JWT_AUTH '};
   print "QTO_JWT_AUTH in Guardian.pm todo:ysg \n";

   # qto-200302161711 - jwt auth implementation
   if ( defined $ENV{'QTO_JWT_AUTH'} && $ENV{'QTO_JWT_AUTH'} == 1 ){
      #my $url           = (split('#',$controller->req->url->to_abs))[0];
      my $path          = $controller->req->url->path;
      my $web_action    = (split('/',$path))[2];
      my $act_subject   = (split('/',$path))[3] || '' ;

      # get the jwt from the session 
      return 0 unless ( defined ( $controller->session( 'app.' . $db . '.jwt')));

      # get the public key from the session from the config
      my $pub_secret    = $config->{'env'}->{'run'}->{ 'PublicRSAKey' } ;
      my $jwt           = $controller->session( 'app.' . $db . '.jwt');

      # compare the route requested to the rbac list
      # get the roles from the jwt
      ( my $ret, $msg, my $claims_from_token ) = $self->doVerifyTokenAndGetClaims($jwt,$pub_secret);
      return $rv unless $ret == 0 ; 
      
      # get the RBAC list from the Redis
      my $objRdrRedis   = 'Qto::App::Db::In::RdrRedis'->new(\$config);
      my $rbac_list     = $objRdrRedis->getData(\$config,"$db" . '.rbac-list');
      # p $rbac_list ; 
      # print "eof rbac_list from Guardian.pm todo:ysg \n";
      # p $claims_from_token ;
      # print "claims_from_token from Guardian.pm todo:ysg \n";
      p $claims_from_token->{'roles'} ; 
      print "the claims from token from Guardian todo:ysg \n";

      # foreach role in the claims, build the permission string:
      my $roles = $claims_from_token->{'roles'};
      foreach my $role ( @$roles ) {
         p $role ; 
         print "role in forach my role \n";
         # READER__may__view__yearly_issues
         my $permission = $role . '__may__' . $web_action . '__' . $act_subject ;
         $permission = substr($permission,0,-2) unless ( $act_subject);
         print "permission $permission from Guardian.pom todo:ysg \n";
         # grep the permission string from the rbac_list 
         # if found set rv to 1 , else do nothing as rv is set to 0 
         $rv = grep ( /^$permission/, @$rbac_list);
         if ( $rv == 1 ) {
            $msg = '' if ( $rv == 1 );
            last ;
         }
      }
      return $rv if ( $rv == 1 );

      $msg = "you do not have the permission to $web_action" ; 
      $msg .= "the $act_subject" if $act_subject ; 
      $msg .= '! Please, check your url.' ;

      # return $rv
      return $rv ; 

   } else {
      # basic native authentication mode if NOT started with this env var
      unless ( defined ( $controller->session( 'app.' . $db . '.user')) ) {
         return 0;
      } else {
         return 1 ;
      }
   }

}

# --------------------------------------------------------
# called during the login process
# call-by: 
# ( $rv, $msg , $jwt ) = $objGuardian->doGrantAccessToken($hsr);
# --------------------------------------------------------
sub doGrantAccessToken {
   my $self        = shift ; 
   my $db          = shift ; 
   my $hsr         = shift ; 

   p $hsr ; 
   print "hsr from Guardian.pm ::: doGrantAccessToken todo:ysg \n";

   my $prv_secret  = $self->doGetPrivateKeySecret();
   my $claims      = $self->doBuildClaims($db , $hsr);

   my ( $rv, $msg , $jwt) = $self->create_token($claims,$prv_secret);
   return ( $rv, $msg , $jwt );
}


# build the JWT claims based on the login hash ref
# src: https://www.iana.org/assignments/jwt/jwt.xhtml
sub doBuildClaims {
   my $self             = shift ; 
   my $db               = shift ; 
   my $hsr              = shift ; 
   my $claims           = {} ;
   my @roles            = ();

   foreach my $key ( keys %$hsr ){
      my $row = $hsr->{$key};
      $claims->{'iss'}     = 'qto' . '.' . $db . '-' . $config->{'env'}->{'run'}->{'VERSION'};
      $claims->{'sub'}     = $row->{'user_id'};
      $claims->{'name'}    = $row->{'user_name'};
      $claims->{'email'}   = $row->{'email'};
      push ( @roles , $row->{'role'} );
      $claims->{'roles'}   = \@roles; # user might have 1..* roles
   }

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


# return 0 if ok , return 1 if NOK
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

