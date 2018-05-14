package IssueTracker::App::UI::Controls::WtrVueListLabelsTemplate ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp ; 
   use Data::Printer ; 

   use IssueTracker::App::Utils::Logger ; 
   use IssueTracker::App::Utils::Timer ; 

   our $module_trace      = 1 ; 
   our $objModel          = {} ; 
   our $appConfig         = {} ; 


   #
	# -----------------------------------------------------------------------------
   # produce something like this
   #   <div id="app">
   #     <ul>
   #       <div v-for="monthly_issue in monthly_issues">
   #			<div>
   #				<span> id : </span> {{ monthly_issue.id }} </br>
   #				<span> name : </span> {{ monthly_issue.name }} </br>
   #			</div>
   #       </div>
   #     </ul>
   #   </div>
	# -----------------------------------------------------------------------------
   sub doBuild {
      my $self =     shift ; 

      my $hs_headers = $objModel->get('hs_headers');
      my $db         = $objModel->get('postgres_db_name' ) ; 
      my $table      = $objModel->get('table_name');
      my $single_item = $table ; 
      $single_item   =~ s/^(.*)s$/$1/g ; 

      unless ( $table eq "$single_item" . 's' ) {
        $single_item = "single_" . "$table" ; 
      }

      my $control = '' ; 
      $control .= 
      '<div id="app_list_labels">
        <ul>
          <div v-for="' . $single_item . ' in ' . $table . '">
   			<li>' ; 
               foreach my $col_num ( sort ( keys %{$hs_headers} )) {
                  my $col = $hs_headers->{ $col_num }->{ 'attname' }; 
                  $control .= '<span> ' . $col . ' : </span> {{ ' . $single_item . '.' . $col . ' }} </br>' ; 
               } 
      $control .= '
   			</li>
          </div>
        </ul>
      </div>'
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
