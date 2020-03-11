package Qto::App::IO::In::CnrEncrypter ; 
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
   
   use parent 'Qto::App::Utils::OO::SetGetable' ; 
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

	sub new {
		my $invocant   = shift ;    
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  
	
   sub make_crypto_hash {
		my $self = shift ; 
		my ($passphrase) = @_;
		return 'Authen::Passphrase::BlowfishCrypt'->new(
			  'cost'        => 8,
			  'salt_random' => 1,
			  'passphrase'  => $passphrase,
		 )->as_rfc2307;
   }

   sub match_passphrase_against_crypto_hash {
      my $self = shift  ;
      my ($crypto_hash, $passphrase) = @_;
      return Authen::Passphrase::BlowfishCrypt->from_rfc2307($crypto_hash)->match($passphrase);
   }
1;

__END__


=head1 NAME

CnrEncrypter

=head1 SYNOPSIS 

   use Qto::App::IO::In::CnrEncrypter ; 
   my $objCnrEncrypter = 
      'Qto::App::IO::In::CnrEncrypter'->new();

  

=head1 DESCRIPTION

wrapper around the Authen::Passphrase::BlowfishCrypt module
=head2 EXPORT


=head1 SEE ALSO


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

