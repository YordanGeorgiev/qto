use strict ; use warnings ; 
package IssueTracker::App::Mdl::Model ; 

	my $VERSION = '1.2.0';    

	require Exporter;
	our @ISA = qw(Exporter IssueTracker::App::Utils::OO::SetGetable IssueTracker::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	our $ModuleDebug = 0 ; 
	use AutoLoader;

	use Carp qw /cluck confess shortmess croak carp/ ; 
   use Data::Printer ; 

   use parent 'IssueTracker::App::Utils::OO::SetGetable' ;
   use parent 'IssueTracker::App::Utils::OO::AutoLoadable' ;

   our $appConfig       = {} ; 
   our $hsr2            = {} ; # the data - a hash ref of hash refs 
   our $msr2            = {} ; # the metadata - ditto
   our $objLogger       = {} ; 


   sub doGetTableMeta {

      my $self          = shift ; 
      my $appConfig     = shift ; 
      my $db            = shift ; 
      my $table         = shift ; 
      my $msg           = shift || 'error in the ' . $db . '.' . $table . ' model ';

      my $mhr2          = {} ; 
      my $c             = 0 ; 
      my $ret           = 1 ; 
      my $cols = $appConfig->{ "$db" . '.meta' } ; 
      my @hides = split(/,/,$self->get('select.web-action.hide'));


      foreach my $key ( keys %$cols ) {
         my $row = $cols->{ $key } ; 
         next if ( grep ( /^$row->{ 'attribute_name' }$/, @hides )) ;
         next unless $table eq $row->{ 'table_name' } ; 
         $mhr2->{ $c } = $row ;
         $c++ ; 
      }
      
      $ret = 0 ; 
      $msg = '' ; 
      return ( $ret , $msg , $mhr2 , $c);  
   }
   
   sub doGetTableColumnList {

      my $self          = shift ; 
      my $appConfig     = shift ; 
      my $db            = shift ; 
      my $table         = shift ; 
      my $msg           = shift || 'error in the ' . $db . '.' . $table . ' model ';

      my $mhr2          = {} ; 
      my @cols          = () ; 
      my $ret           = 1 ; 
      my $to_order_by   = 'attribute_number' ; 

      ( $ret , $msg , $mhr2 ) = $self->doGetTableMeta ( $appConfig , $db , $table );
      return ( $ret , $msg , undef ) unless $ret == 0 ; 

      #my $to_hides   = $self->get('list.web-action.hide') ; 
      #my @hides      = split ( ',' , $to_hides ) if defined ( $to_hides ) ; 

      #debug p $mhr2 ; 
      foreach my $key ( sort { $mhr2->{$a}->{ $to_order_by } <=> $mhr2->{$b}->{ $to_order_by } } keys %$mhr2 ) {
         my $row = $mhr2->{ $key } ; 
         next if ( defined $row->{ 'skip_in_list'} && $row->{ 'skip_in_list'} == 1 ) ; 
         next if ( $row->{ 'attribute_name' } eq 'guid' or $row->{ 'attribute_name' } eq 'id' );
         push ( @cols , $row->{ 'attribute_name' } );
      }
      # debug print "START Model.pm : \@cols : "  ;
      # debug foreach my $col ( @cols ) { print "col: $col \n"; } ;  
      # debug print "STOP  Model.pm : \@cols : "  ;
      $ret = 0 ; 
      $msg = '' ; 
      return ( $ret , $msg , \@cols);  
   }


   sub doChkIfColumnExists {

      my $self          = shift ; 
      my $db            = shift ; 
      my $table         = shift ; 
      my $col           = shift ; 
   
      my $cols = $appConfig->{ "$db" . '.meta' } ; 
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
   
      my $cols = $appConfig->{ "$db" . '.meta' } ; 
      foreach my $key ( keys %$cols ) {
         my $row = $cols->{ $key } ; 
         my $table = $row->{ 'table_name' } ; 
         $tables{ $table } = $table ; 
      }
      @tbls = keys %tables ; 
      $appConfig->{"$db" . '.meta.tables-list'} = \@tbls ; 
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
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		my $hsr2       = shift @_  || $hsr2 ; 
		$msr2         = shift @_  || $msr2 ; 

		my $self       = {}; bless( $self, $class );    
      $self          = $self->doInitialize() ; 
		return $self;
	}  
	
   
   sub doInitialize {

      my $self = shift ; 

      %$self = (
             appConfig => $appConfig
           , hsr2 => $hsr2
           , msr2 => $msr2
      );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

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
