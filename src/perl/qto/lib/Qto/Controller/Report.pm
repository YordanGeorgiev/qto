package Qto::Controller::Report ; 
use strict ; use warnings ; 

require Exporter;
our @ISA = qw(Exporter Mojo::Base Qto::Controller::BaseController);
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use parent qw(Qto::Controller::BaseController);

use Data::Printer ; 
use Data::Dumper; 

use Qto::Controller::PageFactory ; 
use Qto::App::Db::In::RdrDbsFcry;
use Qto::App::Utils::Logger;
use Qto::App::Cnvr::CnrHsr2ToArray ; 
use Qto::App::IO::In::CnrUrlPrms ; 
use Qto::App::Utils::Timer ; 
use Qto::App::Cnvr::CnrDbName qw(toPlainName toEnvName);

my $module_trace        = 0 ;
our $config             = {};
our $objLogger          = {} ;
our $rdbms_type         = 'postgres';


sub doGetRsMeta {
   my $self 			= shift ; 
	my $db 				= shift ; 
   my $report_name   = shift ; 
   
   $config		      = $self->app->config ; 
   $db               = toEnvName ( $db , $config) ;
   my $objModel      = 'Qto::App::Mdl::Model'->new ( \$config , $db , 'report') ; 
   my $objRdrDbsFcry = {} ; 
   my $objRdrDb      = {} ; 
   
	$objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new(\$config, \$objModel );
   $objRdrDb = $objRdrDbsFcry->doSpawn("$rdbms_type",$db);

   my ($ret, $msg , $msr2 ) = $objRdrDb->doCallFuncGetHashRef('func_get_function_args','pos',$report_name,'public');
   return $msr2 ; 
}


sub doListReportResultItems {

   my $self             = shift;
   my $db               = $self->stash('db');
   my $report_name      = 'func_' . $self->stash('report_name');
   my $objCnrUrlPrms    = {} ; 
   my $ret              = 0;
   my $msg              = 'unknown error during Report';
   my $hsr2             = {};
   my $msr2             = {};
   my $http_code        = 200 ; 
   my $rows_count       = 0 ; 
   my $as               = 'grid' ; 
   my $srch_control     = 'report-grid' ; 
   my $notice           = '' ; 
   my $left_menu        = '' ; 
   my $item             = 'Report' ; 
   $config		         = $self->app->config ; 
   $db                  = toEnvName ( $db , $config) ;
  
   
   my $objModel         = 'Qto::App::Mdl::Model'->new ( \$config , $db , $item ) ; 
   $self->SUPER::doReloadProjDbMeta( \$objModel , $db , $item) ;

   $objCnrUrlPrms = 
      'Qto::App::IO::In::CnrUrlPrms'->new(\$config , \$objModel , $self->req->query_params);
   ( $ret , $msg ) = $objCnrUrlPrms->doSetQueryUrlParams('Report' );

   if ( ! defined ($self->req->query_params ) or $ret != 0 ) {
   
      my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
      my $page_load_time   = $objTimer->GetHumanReadableTime();
      my $tables_list      = $objModel->get("$db" . '.tables-list');
      my @items_arr        = @{$tables_list};
      my $items_lst        = '';
      foreach my $table ( @items_arr) {
         $items_lst .= "'" . "$table" . "'," ;
      }
      $items_lst = substr($items_lst, 0, -1);
   
		my $msr2             = $self->doGetRsMeta($db,$report_name) ; 
		$srch_control = '[';
		foreach my $key ( sort { $msr2->{$a}->{ 'pos' } <=> $msr2->{$b}->{ 'pos'} } keys (%$msr2)) {
			$srch_control .= "'" . $msr2->{"$key"}->{'argname'} . "'," 
				unless $msr2->{"$key"}->{'argname'} eq 'RETURN VALUE';
		}
		chop($srch_control); $srch_control .= ']';
      my $pdb = toPlainName ($db); 
      $self->render(
         'template'        => 'controls/report-grid/report-grid'
       , 'as'              => 'grid'
       , 'item'            => 'Report'
       , 'msg'             => ''
       , 'db' 		         => $db
       , 'pdb' 		      => $pdb
       , 'EnvType' 			=> $config->{'env'}->{'run'}->{'ENV_TYPE'}
       , 'ProductVersion' 	=> $config->{'env'}->{'run'}->{'VERSION'}
       , 'GitShortHash' 	=> $config->{'env'}->{'run'}->{'GitShortHash'}
       , 'page_load_time'  => $page_load_time
       , 'srch_control'    => $srch_control
       , 'notice'          => $notice
       , 'left_menu'       => $left_menu
       , 'items_lst'       => $items_lst
      ) ; 
      return ; 
   }  else {
      $as = $self->req->query_params->param('as') || $as ; 
      $self->doRenderPageTemplateNoResultSet( \$objModel , $msg , $db , $as, $left_menu) ; 
   }

}




sub doRenderPageTemplateNotResultSet {
   
   my $self             = shift ; 
   my $objModel         = ${ shift @_ } ; 
   my $msg              = shift ; 
   my $db               = shift ; 
   my $as               = shift || 'grid' ; 
   my $left_menu        = shift ;
   my $notice           = '' ; 
   my $as_templates = { 
        'grid'          => 'report-grid' 
   };
   my $srch_control     = '';
  
   my $template_name    = $as_templates->{ $as } || 'report-grid' ; 
   my $template         = 'controls/' . $template_name . '/' . $template_name ; 

   my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{'env'}->{'log'}->{ 'TimeFormat' } );
   my $page_load_time   = $objTimer->GetHumanReadableTime();
   my $tables_list      = $objModel->get("$db" . '.tables-list');
   my @items_arr        = @{$tables_list};
   my $items_lst        = '';
   foreach my $table ( @items_arr ){
      $items_lst .= "'" . "$table" . "'," ;
   }
   $items_lst = substr($items_lst, 0, -1);
   my $pdb              = toPlainName($db);
   $self->render(
      'template'        => $template 
    , 'as'              => $as
    , 'item'            => 'Report'
    , 'msg'             => $msg
    , 'db' 		         => $db
    , 'pdb' 	         => $pdb
    , 'EnvType' 		   => $config->{'env'}->{'run'}->{'ENV_TYPE'}
    , 'ProductVersion' 	=> $config->{'env'}->{'run'}->{'VERSION'}
    , 'GitShortHash'    => $config->{'env'}->{'run'}->{'GitShortHash'}
    , 'page_load_time'  => $page_load_time
    , 'srch_control'    => $srch_control
    , 'notice'          => $notice
    , 'left_menu'       => $left_menu
    , 'items_lst'       => $items_lst
	) ; 

   return ; 
}



1;

__END__
