package Qto::App::Ctrl::CtrlDbToJson ; 

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
   use Qto::App::Db::In::RdrDbsFcry ; 
   use Qto::App::IO::Out::WtrTextFactory ; 
   use Qto::App::IO::Out::WtrFiles ;
   use Qto::App::RAM::CnrHsr2ToJson ; 
   use Qto::App::Mdl::Model ; 
   use Qto::App::Utils::Timer ; 

	our $module_trace                = 1 ; 
	our $config						   = {} ; 
	our $objLogger						   = {} ; 
	our $objModel                    = {} ; 
   our $objWtrFiles                 = {} ; 
	our $objFileHandler			      = {} ; 
   our $rdbms_type                  = 'postgre' ; 

=head1 SYNOPSIS
      my $objCtrlDbToJson = 
         'Qto::App::Ctrl::CtrlDbToJson'->new ( \$config ) ; 
      ( $ret , $msg ) = $objCtrlDbToJson->doLoadIssuesFileToDb ( $items_file ) ; 
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
      my $str_items          = q{} ; 
      my $hsr                 = {} ;   # this is the data hash ref of hash reffs 
      my $mhsr                = {} ;   # this is the meta hash describing the data hash ^^
      my @tables              = () ;   # which tables to read from
      
      my $tables              = $objModel->get( 'ctrl.tables' )  || 'daily_issues' ; 
      $objModel->set('select.web-action.pg-size' , 1000000000) ; #set the maximum size
	   push ( @tables , split(',',$tables ) ) ; 

      my $out_dir = $objModel->get( 'io.out-dir' ) ; 

      # if the xls_file is not defined take the latest one from the mix data dir
      unless ( defined $out_dir  ) {
         my $mix_data_dir    = $ENV{'mix_data_dir' } ;  ; 
         my $objTimer         = 'Qto::App::Utils::Timer'->new( $config->{ 'TimeFormat' } );
	      my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = $objTimer-> GetTimeUnits(); 
         # /vagrant/opt/nokia/musa/dat/mix/issues/2018/2018-06/2018-06-11
         $out_dir = "$mix_data_dir/$year/$year-$mon/$year-$mon-$mday/json" ; 
      } 

      my $db = $config->{ 'postgres_db_name' } ; 

      for my $table ( @tables ) { 
         my $items_file ="$out_dir/$table" . '.json' ; 
         my $objRdrDbsFcry = 'Qto::App::Db::In::RdrDbsFcry'->new( \$config , \$objModel ) ; 
         my $objRdrDb 			= $objRdrDbsFcry->doSpawn( "$rdbms_type" );

         
         ( $ret , $msg )  = 
            $objRdrDb->doSelectAll( $db , $table) ; 
         return ( $ret , $msg ) unless $ret == 0 ; 

         my $objWtrTextFactory = 'Qto::App::IO::Out::WtrTextFactory'->new( \$config , $self ) ; 
         my $objWtrText 			= $objWtrTextFactory->doInit ( $table );
         
         my $objCnrHsr2ToJson = 
            'Qto::App::RAM::CnrHsr2ToJson'->new ( \$config ) ; 
         ( $ret , $msg )  = $objCnrHsr2ToJson->doConvertHashRefToJsonStr( \$objModel ) ; 
         return ( $ret , $msg ) if $ret != 0 ;  
         
         $msg = 'writing the following file: ' . "\n" . $items_file ; 
         $objLogger->doLogInfoMsg ( $msg ) ; 
         my ( $ret , $msg ) = $objWtrFiles->doPrintToFile ( $items_file , $objModel->get('str_items') , 'utf8' ) ; 
         return ( $ret , $msg ) if $ret != 0 ;  
      }
         return ( $ret , $msg ) ; 
   } 


=head1 SUBROUTINES/METHODS

=cut


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
=cut 
	sub new {

		my $class = shift;    # Class name is in the first parameter
		$config = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel   = ${ shift @_ } || croak 'objModel not passed !!!' ; 
		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize( ) ; 
		return $self;
	}  
	#eof const


   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self          = shift ; 

      %$self = (
           config => $config
       );

	   $objLogger 	   = 'Qto::App::Utils::Logger'->new( \$config ) ;
      $objWtrFiles   = 'Qto::App::IO::Out::WtrFiles'->new ( \$config ) ; 

      return $self ; 
	}	
	#eof sub doInitialize



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

