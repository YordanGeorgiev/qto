package Qto::App::IO::In::CnrPostPrms ; 
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
   use Mojo::Parameters ; 
   use Scalar::Util::Numeric qw(isint);
   use Scalar::Util qw /looks_like_number/ ; 
   use Data::Printer ; 
   use Email::Valid;

   use Qto::App::Mdl::Model ; 
	use Authen::Passphrase::BlowfishCrypt ; 
   use Qto::App::IO::In::CnrEncrypter ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ; 
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

   our $objModel     = {} ; 
   our $appConfig    = {} ; 

	sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || croak 'appConfig not passed in RdrPostgresDb !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in RdrPostgresDb !!!' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  

   sub doSetLoginUrlParams {

      my $self             = shift ; 
      my $Controller       = shift || 'Logon' ; 
      my $email            = shift ; 
      my $pass             = shift ; 
      my $controller       = lc ( $Controller ) ; 
      my $ret              = 1 ;
      my $msg              = '' ; 
      my $epass            = undef ; # the encrypted hash


      if ( !defined ( $email ) or $email eq '' ) {
         $msg = "empty email ! " ; 
         $ret = 400 ; 
         return ( $ret , $msg ) ; 
      } else {
         unless( Email::Valid->address($email) ) {
            $msg = "$email is not a valid email! ";
            $ret = 400 ; 
            return ( $ret , $msg ) ; 
         }
      }

      if ( !defined ( $pass ) or $pass eq '' ) {
         $msg = " empty password ! " ; 
         $ret = 400 ; 
         return ( $ret , $msg ) ; 
      } else {
         $objModel->set($controller . '.pass' , $pass );
         my $objCnrEncrypter = 'Qto::App::IO::In::CnrEncrypter'->new();
         $epass = $objCnrEncrypter->make_crypto_hash($pass ) ; 
         $ret = 0 ; 
         $msg = '' ; 
      }

      return ( $ret , $msg , $epass ) ; 
   }

sub doValidateAndSetCreate {

   my $self          = shift ; 
   my $perl_hash     = shift ; 
   my $msg           = '' ; 
   my $isValid       = 0 ; 
   my $http_code     = 400 ; 
   my $id            = $perl_hash->{'id'} ; 

   unless ( isint $id && $id >= 0) {
      $http_code     = 400 ; 
      $msg           = 'the id must be a whole positive number, but ' . $id . ' was provided !' ; 
   } else {
      $http_code     = 200 ; 
      $isValid       = 1 ; 
   }
   $self->set('msg' , $msg ) ; 
   $self->set('http_code' , $http_code ) ; 
   $objModel->set('create.web-action.id' , $id ) ; 
   
   return $isValid ; 
}

sub doValidateAndSetUpdate {

   my $self          = shift ; 
   my $perl_hash     = shift ; 
   my $item          = shift ; 

   my $msg           = '' ; 
   my $isValid       = 0 ; 
   my $http_code     = 400 ; 
   my $id            = $perl_hash->{'id'} ; 

   unless ( isint $id && $id >= 0) {
      $http_code     = 400 ; 
      $id = 'undefined' unless ( defined $id ) ;
      $msg           = 'the id must be a whole positive number, but ' . $id . ' was provided !' ; 
   } else {
      $http_code     = 200 ; 
      $isValid       = 1 ; 
   }
   $self->set('msg' , $msg ) ; 
   $self->set('http_code' , $http_code ) ; 

   my $col_name      = $perl_hash->{'attribute'} ; 
   my $col_value     = $perl_hash->{'cnt'} ; 
   my @tables        = ( 'users' , 'test_update_table');

   if ( grep ( /$item/, @tables ) == 1 ) {
      my $objCnrEncrypter = 'Qto::App::IO::In::CnrEncrypter'->new();
	   $col_value     = $objCnrEncrypter->make_crypto_hash($col_value ) if $col_name eq 'password' ;
   }


   $objModel->set('update.web-action.col_name' , $col_name) ; 
   $objModel->set('update.web-action.id' , $perl_hash->{'id'} ) ; 
   $objModel->set('update.web-action.col_value' , $col_value ) ; 
   
   return $isValid ; 
}


sub doValidateAndSetDelete {

   my $self          = shift ; 
   my $perl_hash     = shift ; 
   my $msg           = '' ; 
   my $isValid       = 0 ; 
   my $http_code     = 400 ; 
   my $id            = $perl_hash->{'id'} ; 

   unless ( isint $id && $id >= 0) {
      $http_code     = 400 ; 
      $msg           = 'the id must be a whole positive number, but ' . $id . ' was provided !' ; 
   } else {
      $http_code     = 200 ; 
      $isValid       = 1 ; 
   }
   $self->set('msg' , $msg ) ; 
   $self->set('http_code' , $http_code ) ; 
   $objModel->set('delete.web-action.id' , $perl_hash->{'id'} ) ; 
   
   return $isValid ; 
}


1;

__END__


=head1 NAME

CnrPostPrms

=head1 SYNOPSIS 

   use Qto::App::IO::In::CnrPostPrms ; 
   my $objCnrPostPrms = 'Qto::App::IO::In::CnrPostPrms'->new(\$appConfig , \$objModel )


=head1 DESCRIPTION

responsible for setting the parsed url params into the objModel

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

