package Qto::App::UI::Controls::WtrLeftMenu ; 

   use strict ; use warnings ; use utf8 ; 
   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
	use Data::Printer ; 
	use Carp qw(croak carp);
   use Data::Printer ; 

   our $module_trace      = 1 ; 
   our $objModel          = {} ; 
   our $config            = {} ; 


   #
	# -----------------------------------------------------------------------------
   # produce the dynamic version of the left menu as in the poc file
   # src/perl/qto/public/poc/css-tree/03/index.html
	# -----------------------------------------------------------------------------
   sub doBuild {
      my $self       = shift ; 
      my $db         = shift ; 
      my $hsr2       = shift ; 

      my $ret        = 1 ; 
      my $msg        = 'unknown error occured during the left menu generation!'; 

      my $prev_lvl   = 0  ; # the previous level
      my $curr_lvl   = 0  ; # the current level
      my $control = '' ; 
      $hsr2->map(
         sub {
            my $row = $_ ; 
            $curr_lvl = $row->{'level'}; 

            if ( $_->{'type'} eq 'folder') {
               $control .= doCloseFolderLink($_) if ( $prev_lvl != 0 && $prev_lvl > $_->{'level'} );
               $control .= doOpenFolderLink($_);
            } elsif ( $_->{'type'} eq 'doc') {
               $control .= doDocLink($db , $_);
            } else {
               $control .= '' ;
            }

            $prev_lvl = $_->{'level'}; 
         }
      );

   return ( 0 , "" , $control ) ; 
   }
  

   sub doOpenFolderLink {

      my $row        = shift ; 
      my $id         = $row->{'id'};
      return '' if $id eq 0 ; 

      my $name       = $row->{'name'};
      my $title      = $row->{'title'};
      $title         = $name unless ( defined $title ) ;
      my $ctrlid     = 'lck' . '-' . $name . '-' . $id ;  # the check ctrl id of the left menu
=pod
and this is how the static output should look like
     <li>
       <label for="menu-1"><a href="#">menu-1</a></label>
       <input tabindex="1" type="checkbox" checked id="menu-1" />
       <ol>
         <li>
           <label for="menu-1-1"><a href="#">menu-1-1</a></label>
           <input tabindex="1" type="checkbox" id="menu-1-1" />
           <ol>
             <li>
               <label for="menu-1-1-1"><a href="#">menu-1-1-1</a></label>
               <input type="checkbox" id="menu-1-1-1" />
             </li>
             <li class="file"><a href="">menu-1-1-2</a></li>
             <li class="file"><a href="">menu-1-1-3</a></li>
           </ol> 
         </li>
         <li class="file"><a href="">menu-1-2</a></li>
         <li class="file"><a href="">menu-1-3</a></li>
       </ol>
     </li>
=cut

      return  '
      <li>
       <label for="' . $ctrlid . '"><a class="cls_fa" href="#">' . $title . '</a></label>
       <input tabindex="1" type="checkbox" checked id="' . $ctrlid . '" />
       <ol><li>
      ' ; 
   }


   sub doCloseFolderLink {
      my $row        = shift ; 
      my $id         = $row->{'id'};
      return '' if $id eq 0 ; 
      return '</ol></li>' . "\n" ; # todo:ysg remove new line
   }
   
   sub doDocLink {
      my $db         = shift ; 
      my $row        = shift ; 
      
      my $cnf        = $config->{'env'}->{'app'} ; 
      my $id         = $row->{'id'};
      my $port       = $cnf->{'port'} ;
      $port          = $cnf->{'https_port'} if $cnf->{'ht_protocol'} eq 'https';
      my $base_url   = $cnf->{'ht_protocol'} . '://' . $cnf->{'web_host'} . ':' . $port ; 
      $base_url      = $base_url . '/' . $db ; 
      my $url        = $base_url . '/' . $row->{'url'} ;
      my $title      = $row->{'title'};
      my $name       = $row->{'name'};
      
      return '<li class="file"><a class="cls_da" href="' . $url . '">' . $title . '</a></li>' ; 
   }
   
   
   sub doCloseDocLink {
      my $self = shift ; 
      my $row  = shift ; 
   }


	sub new {
		my $invocant   = shift ;    
		$config        = ${ shift @_ } || croak "undef config passed !!!" ; 
		$objModel      = ${ shift @_ } || croak 'missing objModel !!!' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {};  bless( $self, $class );
      $self          = $self->doInit() ; 
		return $self;
	}  

	
   sub doInit {
      my $self = shift ; 

      %$self = (
           config => $config
      );
      return $self ; 
	}	
   

1;
__END__
