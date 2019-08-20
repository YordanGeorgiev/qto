package Qto::App::UI::Controls::WtrListLabels ; 

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

   use Qto::App::Utils::Logger ; 
   use Qto::App::Utils::Timer ; 

   our $module_trace      = 1 ; 
   our $objModel          = {} ; 
   our $config         = {} ; 


   #
	# -----------------------------------------------------------------------------
   # produce something like this
   #   <div id="app">
   #       <div v-for="monthly_issue in monthly_issues">
   #				<span> id : </span> {{ monthly_issue.id }} </br>
   #				<span> name : </span> {{ monthly_issue.name }} </br>
   #       </div>
   #   </div>
	# -----------------------------------------------------------------------------
   sub doBuild {
      my $self =     shift ; 

      my $hs_headers = $objModel->get('hs_headers');
      my $db         = $objModel->get('postgres_db_name' ) ; 
      my $table      = $objModel->get('table_name');
      my $to_hide    = $objModel->get('list.web-action.hide');
      my @hides      = split ( ',' , $to_hide ) if defined ( $to_hide ) ; 
      my @picks      = () ;  
      my $cols       = {}  ;
      my $ret        = 1 ; 
      my $msg        = 'unknown error occured in list labels !'; 


		my $to_picks   = $objModel->get('list.web-action.pick') ; 
      
      if ( defined ( $to_picks ) ) {
         @picks      = split ( ',' , $to_picks ); 
      } else {
         ( $ret , $msg , $cols) = $objModel->doGetItemsDefaultPickCols( $config , $db , $table ) ;
         return ( $ret , $msg , '' ) unless $ret == 0 ; 
         @picks      = @$cols ;
      }

      my $single_item = $table ; 
      $single_item   =~ s/^(.*)s$/$1/g ; 

      unless ( $table eq "$single_item" . 's' ) {
        $single_item = "single_" . "$table" ; # a really rare case ...
      }


      my $control = '' ; 
      $control .= 
      '<div id="app_list_labels">
          <div id="vfor_cols" v-for="' . $single_item . ' in ' . $table . '">
   			' ; 
            foreach my $col ( @picks) {
               $control .= '<div class="lbl_row">' ; 
               $control .= '<div class="lbl_lft" ><b>' . $col . ': </b> </div>' ; 
               $control .= '<div class="lbl_rgt" tabindex="0">' ; 
               $control .= '{{ ' . $single_item . '.' . $col . ' }} ';  
               $control .= '</div>' ; 
               $control .= '</div>';
            }
            $control .= '<div class="div_spacer2"></div>' ; 
      $control .= '
          </div>
      </div>'
   ;


   return ( 0 , "" , $control ) ; 
   }


   #
	# -----------------------------------------------------------------------------
	# hide the attribute's values to hide per row in the hash ref of hash refs 
	# -----------------------------------------------------------------------------
   sub doHideHidables {

      my $self       = shift ; 
      my $row        = shift ; 
      my $to_hide    = shift ; 
      my $msg        = shift ; 

      my $ret        = 1 ; 

      if ( defined ( $to_hide ) ) {
         my @hides = split ( ',' , $to_hide ) ; 
         foreach my $hidable ( @hides ) {
           unless ( exists $row->{$hidable} ) {
               $msg = "the $hidable column does not exist" ; 
            return ( $ret , $msg ) ; 
           }
           delete $row->{$hidable} ;  
         }
      }
      $ret = 0 ; 
      return ( $ret , $msg , $row )  ; 
   }

   #
	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $invocant 			= shift ;    
		$config     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
      # might be class or object, but in both cases invocant
		my $class = ref ( $invocant ) || $invocant ; 

		my $self = {};        # Anonymous hash reference holds instance attributes
		bless( $self, $class );    # Say: $self is a $class
      $self = $self->doInitialize() ; 

		return $self;
	}  
	
   #
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
   sub doInitialize {
      my $self = shift ; 

      %$self = (
           config => $config
      );
      return $self ; 
	}	
	#eof sub doInitialize
   


1;


__END__
