package IssueTracker::Controller::View ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base IssueTracker::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(IssueTracker::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 
use Scalar::Util qw /looks_like_number/;

use IssueTracker::App::Utils::Logger;
use IssueTracker::App::Utils::Timer ; 

our $module_trace   = 0 ; 
our $appConfig      = {};
our $objLogger      = {} ;


#
# --------------------------------------------------------
# View all the items according to the "as" url param output type
# --------------------------------------------------------
sub doViewItems {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $item             = $self->stash('item');
   my $ret              = 1 ; 
   my $msg              = '' ; 

   $self->render('text' => 'view page is presented');

}

sub doRenderHtml {

}

1;

__END__

