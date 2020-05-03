use strict ; use warnings ; 

use Carp ; 
use Getopt::Long;
use Test::More ; 
use Data::Printer ; 
use Test::Mojo ; 
use JSON::Parse 'json_file_to_perl';
use FindBin; 
BEGIN { 
   unshift @INC, "$FindBin::Bin/../../../../../../lib" ;
}

use Qto::App::Utils::Initiator ; 
use Qto::App::IO::In::RdrDirs ; 

my $tm                     = 'the tst msg' ; 
my $objInitiator 		      = 'Qto::App::Utils::Initiator'->new();	
my $config                 = $objInitiator->get('AppConfig');
$config                    = json_file_to_perl ($objInitiator->doResolveConfFile());
$config->{'env'}->{'run'}->{'ProductInstanceDir'} = $objInitiator->doResolveProductInstanceDir(-1);

my $ProductInstanceDir = $config->{'env'}->{'run'}->{'ProductInstanceDir'} ;

   $tm = "the root bare file/dir names of the public dir should index.html poc dat lib themes";
   my $objRdrDirs = 'Qto::App::IO::In::RdrDirs'->new (); 
	my $arrDirs = $objRdrDirs->doFindMaxDepth( "$ProductInstanceDir/src/perl/qto/public", 1) ; 

   foreach my $dir (@{$arrDirs}) {
      $dir =~ s/(.*)[\\|\/](.*?)/$2/g;
   }
  
   my @root_bare_names = ( 'dat', 'index.html', 'lib', 'poc', 'themes');
   ok ( @root_bare_names == @{$arrDirs} , $tm ) ; 

done_testing();

1;
