package Qto::App::Cnvr::CnrDbName ; 

use strict ; use warnings ; 

use Exporter qw(import);
 
our @EXPORT = qw(toPlainName toEnvName );

sub toEnvName {
   my $db                  = shift ; 
   my $appConfig           = shift ; 
   my @env_prefixes        = ( 'dev_' , 'tst_' , 'qas_' , 'prd_' );
 
   my $db_prefix           = substr($db,0,4);
   unless ( grep ( /^$db_prefix$/, @env_prefixes)) {
      $db = $appConfig->{ 'ProductType' } . '_' . $db ; 
   } 
   return $db ;
}
  
sub toPlainName {
   my $db                  = shift ; 
   $db =~ s/^|dev_|tst_|qas_|prd_|//g;
   return $db ;
}

1;

__END__

=head1 NAME

CnrDbName

=head1 SYNOPSIS

use CnrDbName ; 


=head1 DESCRIPTION
provide util functions for dbname conversions
=head2 EXPORT


=head1 SEE ALSO

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 


=cut 

