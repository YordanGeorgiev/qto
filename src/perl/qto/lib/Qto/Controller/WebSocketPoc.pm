package Qto::Controller::WebSocketPoc;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 

use Qto::App::Utils::Logger;
use Qto::App::Db::In::RdrDbsFcry ; 
use Qto::App::IO::In::CnrUrlPrms ; 
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::Cnvr::CnrHashesArrRefToHashesArrRef ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);


sub doTestWebSocket {

   my $self          = shift ; 
	
	$self->inactivity_timeout(3000);

	$self->on( 'message' => sub {
		my ($self, $msg) = @_;
		$self->send("server says I got the following msg: $msg");
	});

   return ; 
}

1 ; 

__END__
