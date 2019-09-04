package Qto::App::Ctrl::CtrlJsonToDb ; 

	use strict; use warnings;

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use utf8 ;
   use Carp ;
   use Data::Printer ; 

   use parent 'Qto::App::Utils::OO::SetGetable' ;
   use parent 'Qto::App::Utils::OO::AutoLoadable' ;

   use Qto::App::Utils::Logger ; 
   use Qto::App::Db::Out::WtrDbsFcry ; 
   use Qto::App::IO::In::RdrTextFactory ; 
   use Qto::App::IO::Out::WtrFiles ;
   use Qto::App::RAM::CnrJsonToHsr2 ; 
   use Qto::App::Mdl::Model ; 
   use Qto::App::IO::In::RdrFiles ; 

	our $module_trace                = 1 ; 
	our $config						   = {} ; 
	our $objLogger						   = {} ; 
	our $objModel                    = {} ; 
   our $objWtrFiles                 = {} ; 
	our $objFileHandler			      = {} ; 
   our $rdbms_type                  = 'postgres' ; 

=head1 SYNOPSIS
      my $objCtrlJsonToDb = 
         'Qto::App::Ctrl::CtrlJsonToDb'->new ( \$config ) ; 
      ( $ret , $msg ) = $objCtrlJsonToDb->doLoadIssuesFileToDb ( $items_file ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

=cut



   # 
	# -----------------------------------------------------------------------------
   # read the passed issue file , convert it to hash ref of hash refs 
   # and insert the hsr into a db
	# -----------------------------------------------------------------------------
   sub doReadAndWrite {

      my $self                = shift ; 

      my $ret                 = 1 ; 
      my $msg                 = 'unknown error while loading db issues to xls file' ; 
      my $str_items           = q{} ; 
      my $str_file            = q{} ; 
      my $hsr                 = {} ;   # this is the data hash ref of hash reffs 
      my $mhsr                = {} ;   # this is the meta hash describing the data hash ^^
      my @tables              = () ;   # which tables to read from
      my $objRdrFiles         = {} ; 
      
      my $tables              = $objModel->get( 'ctrl.tables' )  || 'daily_issues' ; 
	   push ( @tables , split(',',$tables ) ) ; 

      my $in_dir = $objModel->get('io.in-dir');
      $objRdrFiles= 'Qto::App::IO::In::RdrFiles'->new();
      
      unless ( defined $in_dir  ) {
         my $ProjInstanceDir = $ENV{'PROJ_INSTANCE_DIR' } || $config->{'env'}->{'run'}->{'ProductInstanceDir'} ; 
         my $mix_data_dir    = "$ProjInstanceDir/dat/mix" ;  ; 
         my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{ 'TimeFormat' } );
	      my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer-> GetTimeUnits(); 
         # example: /vagrant/opt/nokia/musa/dat/mix/issues/2018/2018-06/2018-06-11
         $in_dir = "$mix_data_dir/$year/$year-$mon/$year-$mon-$mday/json" ; 
      } 

      for my $table ( @tables ) { 

         my $items_file = "$in_dir/$table" . '.json' ; 
         ( $ret , $msg , $str_file ) = $objRdrFiles->doReadFileReturnString ( $items_file , 'utf8' ) ; 
         $objModel->set('str_items' , $str_file ) ; 
         
         my $objCnrJsonToHsr2 = 'Qto::App::RAM::CnrJsonToHsr2'->new ( \$config ) ; 
         ( $ret , $msg )      = $objCnrJsonToHsr2->doConvert( \$objModel ) ; 
         return ( $ret , $msg ) if $ret != 0 ;  

         next if ( keys %{ $objModel->get('hsr2') } == 0 ) ; 

         my $objWtrDbsFcry = 'Qto::App::Db::Out::WtrDbsFcry'->new( \$config , \$objModel ) ; 
         my $objWtrDb 			= $objWtrDbsFcry->doSpawn ( "$rdbms_type" );
         
         ( $ret , $msg )  = $objWtrDb->doUpsertTable( \$objModel , $table ) ; 
         return ( $ret , $msg ) unless $ret == 0 ; 
      }
         return ( $ret , $msg ) ; 
   } 


=head1 SUBROUTINES/METHODS

=cut


	sub new {

		my $class = shift;    
		$config = ${ shift @_ } || croak "no config !!!" ; 
		$objModel   = ${ shift @_ } || croak 'objModel not passed !!!' ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInit( ) ; 
		return $self;
	}  


   sub doInit {
      my $self          = shift ; 

      %$self = (
           config => $config
       );

	   $objLogger 	   = 'Qto::App::Utils::Logger'->new( \$config ) ;
      $objWtrFiles   = 'Qto::App::IO::Out::WtrFiles'->new ( \$config ) ; 

      return $self ; 
	}	



1;

__END__

=head1 NAME

UrlSniper 

=head1 SYNOPSIS

use UrlSniper  ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app cnfig hash 

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

