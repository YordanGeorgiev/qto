package Qto::App::Db::In::Postgres::RdrHPostgresDb ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
	use Carp ; 
   use DBI ; 
	use Data::Printer ; 
   use DBD::Pg ; 

   our $objModel = {} ; 
   our $objLogger = {} ; 
   our $appConfig = {} ; 

   #
   # -----------------------------------------------------------------------------
   # open the database handle if possible, if not return proper error msgs
   # ( $ret , $msg , $dbh ) = $self->doConnectToDb ( $db ) ; 
   # -----------------------------------------------------------------------------
   sub doConnectToDb {
      my $self = shift ; 
      my $db = shift ; 
   
      my $ret = 1 ; 
      my $msg = q{} ; 
      my $dbh = q{} ; 

      eval { 
         $dbh = DBI->connect("dbi:Pg:dbname=$db", "", "" , {
                    'RaiseError'          => 1
                  , 'ShowErrorStatement'  => 1
                  , 'PrintError'          => 1
                  , 'AutoCommit'          => 1
                  , 'pg_utf8_strings'     => 1
         } ) 
      };

      if ($@) {
         $ret = 2 ; 
         $msg = 'cannot connect to the "' . $db . '" database: ' . DBI->errstr ; 
         return ( $ret , $msg , undef ) ; 
      }

      $ret = 0 ; $msg = "" ; 
      return ( $ret , $msg , $dbh ) ; 
   }
   
	sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || croak 'appConfig not passed in RdrPostgresDb !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in RdrPostgresDb !!!' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class );    # Say: $self is a $class
      $self          = $self->doInitialize() ; 
		return $self;
	}  

   sub doInitialize {
      my $self = shift ; 


   }


1 ; 

__END__
