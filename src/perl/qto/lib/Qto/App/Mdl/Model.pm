use strict ; use warnings ; 
package Qto::App::Mdl::Model ; 

my $VERSION = '1.2.0';    

require Exporter;
our @ISA = qw(Exporter Qto::App::Utils::OO::SetGetable Qto::App::Utils::OO::AutoLoadable) ;
our $AUTOLOAD =();
our $ModuleDebug = 0 ; 
use AutoLoader;

use Carp qw /cluck confess shortmess croak carp/ ; 
use Data::Printer ; 

use parent 'Qto::App::Utils::OO::SetGetable' ;
use parent 'Qto::App::Utils::OO::AutoLoadable' ;

our $config       = {} ; 
our $objLogger       = {} ; 


   sub doGetTableMeta {

      my $self          = shift ; 
      my $config     = shift ; 
      my $db            = shift ; 
      my $table         = shift ; 
      my $msg           = shift || 'error in the ' . $db . '.' . $table . ' model ';

      my $mhr2          = {} ; 
      my $c             = 0 ; 
      my $ret           = 1 ; 
      my $cols = $config->{ "$db" . '.meta' } ; 
      my @hides = split(/,/,$self->get('select.web-action.hide')) if ( defined $self->get('select.web-action.hide') );


      foreach my $key ( keys %$cols ) {
         my $row = $cols->{ $key } ; 
         next if ( defined $self->get('select.web-action.hide') 
                   && grep ( /^$row->{ 'attribute_name' }$/, @hides )) ;
         next unless $table eq $row->{ 'table_name' } ; 
         $mhr2->{ $c } = $row ;
         $c++ ; 
      }
      
      $ret = 0 ; 
      $msg = '' ; 
      return ( $ret , $msg , $mhr2 , $c);  
   }
  

   sub doGetItemsDefaultPickCols {

      my $self          = shift ; 
      my $config     = shift ; 
      my $db            = shift ; 
      my $table         = shift ; 
      my $msg           = shift || 'error in the ' . $db . '.' . $table . ' model ';

      my $mhr2          = {} ; 
      my @cols          = () ; 
      my $ret           = 1 ; 
      my $to_order_by   = 'attribute_number' ; 

      ( $ret , $msg , $mhr2 ) = $self->doGetTableMeta ( $config , $db , $table );
      return ( $ret , $msg , undef ) unless $ret == 0 ; 

      foreach my $key ( sort { $mhr2->{$a}->{ $to_order_by } <=> $mhr2->{$b}->{ $to_order_by } } keys %$mhr2 ) {
         my $row = $mhr2->{ $key } ; 
         next if ( defined $row->{ 'skip_in_list'} && $row->{ 'skip_in_list'} == 1 ) ; 
         next if ( $row->{ 'attribute_name' } eq 'guid' or $row->{ 'attribute_name' } eq 'id' );
         push ( @cols , $row->{ 'attribute_name' } );
      }
      $ret = 0 ; 
      $msg = '' ; 
      return ( $ret , $msg , \@cols);  
   }


   sub doChkIfColumnExists {

      my $self          = shift ; 
      my $db            = shift || $self->get('postgres_db_name');
      my $table         = shift || $self->get('table_name');
      my $col           = shift ; 
   
      my $cols = $config->{ "$db" . '.meta' } ; 
      foreach my $key ( keys %$cols ) {
         my $row = $cols->{ $key } ; 
         next unless $table eq $row->{ 'table_name' } ; 
         return 1 if $row->{ 'attribute_name' } eq $col; 
      }
      return 0 ; 
   }
  

   sub doSetDbTablesList {

      my $self       = shift ; 
      my $db         = shift ; 
      my %tables     = () ;
      my @tbls       = () ;
   
      my $cols = $config->{ "$db" . '.meta' } ; 
      foreach my $key ( keys %$cols ) {
         my $row = $cols->{ $key } ; 
         my $table = $row->{ 'table_name' } ; 
         $tables{ $table } = $table ; 
      }
      @tbls = keys %tables ; 

      $config->{"$db" . '.meta.tables-list'} = \@tbls ; 
   }


   sub doReplaceTokenInKeys {
      my $self          = shift ; 
      my $to_srch       = shift ; 
      my $to_repl       = shift ; 

		foreach my $key ( keys %$self ) {
         my $new_key = $key ; 
         $new_key =~ s/$to_srch/$to_repl/g ; 
         $self->{ $new_key } = $self->{ $key } ; 
		}
   }


sub new {

   my $class      = shift ;    
   $config     = ${ shift @_ } || croak 'undef passed for config !!!' ; 
   my $self       = {}; bless( $self, $class );    
   $self          = $self->doInit(@_) ; 
   return $self;
}  
	
   
   sub doInit {

      my $self    = shift ; 
      my $db      = shift ; 
      my $table   = shift ; 

      %$self = (
             config => $config
      );
      
      $self->set('postgres_db_name' , $db )  if defined $db ; 
      $self->set('table_name' , $table )     if defined $table ; 
	   $objLogger 			= 'Qto::App::Utils::Logger'->new( \$config ) ;

      return $self ; 
	}	



1;


__END__

=head1 NAME

Model

=head1 SYNOPSIS

use Model ; 


=head1 DESCRIPTION
The main model of the application - passed between the readers, writers and the converters 
for the lifetime of a single web or shell action. 
The model is not a stash !!!

=head2 EXPORT


=head1 SEE ALSO



=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 
