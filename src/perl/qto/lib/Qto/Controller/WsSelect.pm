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


my $clients = {};
our $config = {};
our $rdbms_type     = 'postgres';

sub doWsSelectTables {

   my $self          = shift ; 
	$self->inactivity_timeout(3000);

	$self->on('message' => sub {
		my ($self, $msg) = @_;
      my $db = $msg ; 
      $db =~ s/open //g; 
      my $config = $self->app->get('AppConfig');
      $db = toEnvName ( $db , $config );
      $self->tx->max_websocket_size(16777216) if $self->tx->is_websocket;
      
      my $objModel   = 'Qto::App::Mdl::Model'->new ( \$config , $db) ;

# todo:ysg 
#      #return unless ( $self->SUPER::isAuthenticated($db) == 1 );
#      #$self->SUPER::doReloadProjDbMeta( $db , 'meta_columns' ) ;
#
      my $ret        = 0;
      my $hsr        = {};
      my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
      my $objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type");
      ($ret, $msg, $hsr) = $objRdrDb->doSelectTablesList(\$objModel);
 
      my @arr = () ;  
      foreach my $id ( keys %$hsr ) {
        push ( @arr ,  $hsr->{$id}->{ 'table_name' } ) ;
      }  

      #my $id = sprintf "%s", $self->tx;
      my $id = int (gettimeofday * 1000);
      $clients->{$id} = $self->tx;

      foreach my $id (keys %$clients) {
         $msg = "your id is $id , your msg: $msg " ;
         $clients->{$id}->send({json => {
            dat => \@arr
          }});
      }

	});

   return ; 
}

1 ; 

__END__
