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

   sub doSetLogonUrlParams {

      my $self             = shift ; 
      my $Controller       = shift || 'Logon' ; 
      my $post_body_data   = shift || croak 'no post body data in CnrPostPrms::doSetLogonUrlParams' ;
      my $controller       = lc ( $Controller ) ; 
      my $ret              = 1 ;
      my $msg              = '' ; 
      my $email            = $post_body_data->{'email'} ;
      my $password         = $post_body_data->{'password'} ;

      if ( !defined ( $email ) or $email eq '' ) {
         $msg = "fill in the email name" ; 
         $ret = 400 ; 
      } else {
         $objModel->set($controller . '.email' , $email );
         $ret = 0 ; 
      }

      if ( !defined ( $password ) or $password eq '' ) {
         $msg = "fill in the password " ; 
         $ret = 400 ; 
      } else {
         $objModel->set($controller . '.password' , $password );
         my $objCnrEncrypter = 'Qto::App::IO::In::CnrEncrypter'->new();
         $password = $objCnrEncrypter->make_crypto_hash($password ) ; 
         $post_body_data->{'password'} = $password ; 
         $ret = 0 ; 
      }

      return ( $ret , $msg , ) ; 
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

