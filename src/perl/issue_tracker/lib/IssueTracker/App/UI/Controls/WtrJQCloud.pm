package IssueTracker::App::UI::Controls::WtrJQCloud ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp ; 
   use Data::Printer ; 
   use List::Util 1.33 'any';

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Utils::Timer ; 

   our $module_trace      = 1 ; 
   our $objModel          = {} ; 
   our $appConfig         = {} ; 


   sub doBuild {
      my $self =     shift ; 
      my $hs_headers = $objModel->get('hs_headers');
      my $hsr2 		= $objModel->get('hsr2');
      my $db         = $objModel->get('postgres_db_name' ) ; 
      my $table      = $objModel->get('table_name');

      my $single_item = $table ; 
      $single_item   =~ s/^(.*)s$/$1/g ; 

      unless ( $table eq "$single_item" . 's' ) {
        $single_item = "single_" . "$table" ; 
      }

#      let items = [
#         {
#              text: "john"
#            , weight: 1
#         },
#         {
#              text: "steve"
#            , weight: 2.5
#         },
#         {
#              text: "bob"
#            , weight: 5
#         }
#      ];

      my $control = 'let items = [ ' ; 

		foreach my $id ( sort { $hsr2->{$a}->{ 'id' } <=> $hsr2->{$b}->{ 'id' } } keys (%$hsr2))  {
			my $row = $hsr2->{$id} ; 
         $control .= "\n { \n" ; 
         foreach my $col_num ( reverse sort ( keys %$hs_headers )) {
            my $col = $hs_headers->{ $col_num }->{ 'attname' }; 
				next unless ( $col eq 'name' or $col eq 'prio' ) ; 
				if ( $col eq 'name' ) {
            	$control .= 'text: "' . $row->{'name'} . '"' ;
					next ; 
				}			
				if ( $col eq 'prio' ) {
            	$control .= ', weight:' . $row->{'prio'} ;
				}			
         } 
            	$control .= "\n },\n" ; 
		 }	
		 chomp $control ; chop $control ; 
       $control .= "\n ]; \n" ; 
   ;


   return ( 0 , "" , $control ) ; 
   }

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
      # might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 

		return $self;
	}  
	#eof const
	
   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self = shift ; 

      %$self = (
           appConfig => $appConfig
      );
      return $self ; 
	}	
	#eof sub doInitialize
   


1;


__END__
