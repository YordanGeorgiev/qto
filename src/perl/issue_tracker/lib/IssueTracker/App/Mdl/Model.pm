use strict ; use warnings ; 
package IssueTracker::App::Mdl::Model ; 

	my $VERSION = '1.1.0';    #doc at the end

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
   our $hsr2            = {} ; # this is the hash ref of hash refs 
   our $mhsr2           = {} ; # and this is the meta hash ref of hash refs 
   our $objLogger       = {} ; 


   sub doGetTablesColumnList {
      my $self          = shift ; 
      my $appConfig     = shift ; 
      my $db            = shift ; 
      my $table         = shift ; 
      my $mhr2          = {} ; 
      my $c             = 1 ; 
      my $ret           = 1 ; 
      my $msg           = 'error while doGetTablesColumnList' ; 
      my $cols = $appConfig->{ "$db" . '.meta' } ; 


      foreach my $key ( keys %$cols ) {
         my $row = $cols->{ $key } ; 
         next unless $table eq $row->{ 'table_name' } ; 
         $mhr2->{ $c } = $row ;
      }
      
      $ret = 0 ; 
      $msg = '' ; 
      return ( $ret , $msg , $mhr2 );  

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

   # 
	# -----------------------------------------------------------------------------
	# merge a hash ref to the model's hash ref
   # src: https://stackoverflow.com/a/1242125/65706
	# -----------------------------------------------------------------------------
   sub addHsr {
      my $self = shift ; 
      my $row  = shift ; 

      # debug p $hsr2 ; 
      @{$hsr2}{keys %$row} = values %$row;
      # debug print "STOP addHsr after \n" ; 

      # debug p $hsr2 ; 
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

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {

		my $class      = shift;    # Class name is in the first parameter
		$appConfig     = ${ shift @_ } || { 'foo' => 'bar' ,} ; 
		my $hsr2          = shift @_  || $hsr2 ; 
		$mhsr2          = shift @_  || $mhsr2 ; 

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
           , hsr2 => $hsr2
           , mhsr2 => $mhsr2
      );

	   $objLogger 			= 'IssueTracker::App::Utils::Logger'->new( \$appConfig ) ;

      return $self ; 
	}	
	#eof sub doInitialize



1;


__END__

=head1 NAME

Model

=head1 SYNOPSIS

use Model ; 


=head1 DESCRIPTION
the main model of the application : 
passed between the readers, writers and the converters
basically perl hash ref of hash refs with specific MUST-HAVE keys - uuid or id

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 
