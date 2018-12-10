package IssueTracker::Controller::HSelect;
use strict ; use warnings ; 

require Exporter; our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
use AutoLoader;
use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 

use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Db::In::RdrDbsFactory;
use IssueTracker::App::IO::In::CnrUrlParams ; 
use IssueTracker::App::Cnvr::CnrHsr2ToArray ; 

sub doHSelectItems {
   my $self = shift ; 
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');


}

1 ; 

__END__
