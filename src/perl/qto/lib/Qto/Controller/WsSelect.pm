package Qto::Controller::WsSelect ; 
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
use Mojo::JSON ; 
use JSON ;
use Time::HiRes qw(gettimeofday);


our $rdbms_type     = 'postgres';
my $clients = {};
our $config = {};

sub doWsSelectTables {

   my $self          = shift ; 

	$self->inactivity_timeout(3000);
   
	$self->on('message' => sub {
		my ($self, $msg) = @_;
		# debug print "WsSelect.pm msg: $msg \n";
      my $db = $msg ; 
      $db =~ s/open //g; 
      $config		      = $self->app->config ; 
      my $item = 'none' ; 
      
      return unless ( $self->SUPER::isAuthenticated($db) == 1 );
      my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item) ; 
      $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;

      $self->tx->max_websocket_size(16777216) if $self->tx->is_websocket;
      
      my $ret        	= 0;
      my $hsr        	= {};
      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
      my $objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type");
      ($ret, $msg, $hsr) = $objRdrDb->doSelectTablesList($db);
 
      my @arr = () ;  
      foreach my $key ( keys %$hsr ) {
        push ( @arr ,  $hsr->{$key}->{'table_name'} ) ;
      }  
      my @sorted = sort @arr;

      my $id = int (gettimeofday * 1000);
      $clients->{$id} = $self->tx;

      foreach my $id (keys %$clients) {
         $clients->{$id}->send({json => {
            dat => \@sorted
          }});
      }

   });

   # Closed
   $self->on(finish => sub {
       my ($c, $code, $reason) = @_;
       $c->app->log->debug("WebSocket closed with status $code");
   });

}

1 ; 

__END__
