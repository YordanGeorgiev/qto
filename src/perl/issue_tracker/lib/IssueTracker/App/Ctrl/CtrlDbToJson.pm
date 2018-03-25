package IssueTracker::App::Ctrl::CtrlDbToJson ; 

	use strict; use warnings;

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter IssueTracker::App::Utils::OO::SetGetable IssueTracker::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use utf8 ;
   use Carp ;
   use Data::Printer ; 

   use parent 'IssueTracker::App::Utils::OO::SetGetable' ;
   use parent 'IssueTracker::App::Utils::OO::AutoLoadable' ;
   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Db::In::RdrDbsFactory ; 
   use IssueTracker::App::IO::Out::WtrTextFactory ; 
   use IssueTracker::App::IO::Out::WtrFiles ;
   use IssueTracker::App::RAM::CnrHsr2ToJson ; 
   use IssueTracker::App::Mdl::Model ; 

	our $module_trace                = 1 ; 
	our $appConfig						   = {} ; 
	our $objLogger						   = {} ; 
	our $objModel                    = {} ; 
   our $objWtrFiles                 = {} ; 
	our $objFileHandler			      = {} ; 
   our $rdbms_type                  = 'postgre' ; 

=head1 SYNOPSIS
      my $objCtrlDbToJson = 
         'IssueTracker::App::Ctrl::CtrlDbToJson'->new ( \$appConfig ) ; 
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
	   push ( @tables , split(',',$tables ) ) ; 

      my $filter_by_attributes = $ENV{'filter_by_attributes'} || undef ; 
      my $data_dir = $ENV{"DataDir"} ; 
      print "data-dir : $data_dir \n" ; 
      sleep 3 ; 
      $data_dir = $appConfig->{"ProductInstanceDir"} . '/dat' unless defined $data_dir ; 

      for my $table ( @tables ) { 
         my $items_file = $data_dir . "/json/$table" . '.json' ; 
         my $objRdrDbsFactory = 'IssueTracker::App::Db::In::RdrDbsFactory'->new( \$appConfig , \$objModel ) ; 
         my $objRdrDb 			= $objRdrDbsFactory->doInstantiate ( "$rdbms_type" );

         ( $ret , $msg )  = 
            $objRdrDb->doSelectTableIntoHashRef( \$objModel , $table , $filter_by_attributes ) ; 
         return ( $ret , $msg ) unless $ret == 0 ; 

         my $objWtrTextFactory = 'IssueTracker::App::IO::Out::WtrTextFactory'->new( \$appConfig , $self ) ; 
         my $objWtrText 			= $objWtrTextFactory->doInstantiate ( $table );
         
         my $objCnrHsr2ToJson = 
            'IssueTracker::App::RAM::CnrHsr2ToJson'->new ( \$appConfig ) ; 
         ( $ret , $msg )  = $objCnrHsr2ToJson->doConvertHashRefToJsonStr( \$objModel ) ; 
         return ( $ret , $msg ) if $ret != 0 ;  

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
		$appConfig = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
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
           appConfig => $appConfig
       );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;
      $objWtrFiles   = 'IssueTracker::App::IO::Out::WtrFiles'->new ( \$appConfig ) ; 

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

