package IssueTracker::App::IO::In::CnrUrlPrms ; 
	use strict; use warnings; use diagnostics ; 

	my $VERSION = '1.0.0';

	require Exporter;
	our @ISA = qw(Exporter IssueTracker::App::Utils::OO::SetGetable IssueTracker::App::Utils::OO::AutoLoadable) ;
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
	use File::Path qw(make_path) ;
	use IO::File;
	use File::Find;
	use Fcntl qw( :flock );
	use File::Path ; 
   use Mojo::Parameters ; 
   use Scalar::Util::Numeric qw(isint);
   use Scalar::Util qw /looks_like_number/ ; 
   use Data::Printer ; 
   use IssueTracker::App::Mdl::Model ; 

   
   use parent 'IssueTracker::App::Utils::OO::SetGetable' ; 
   use parent 'IssueTracker::App::Utils::OO::AutoLoadable' ;

   our $query_params = () ; 
   our $objModel     = {} ; 
   our $appConfig    = {} ; 

sub doSetCreateUrlParams {

   my $self          = shift ; 
   my $perl_hash     = shift ; 
   my $ret           = 0 ; 
   my $msg           = '' ; 

   $objModel->set('create.web-action.id' , $perl_hash->{'id'} ) ; 
   
   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 

}

sub doSetUpdateUrlParams {

   my $self          = shift ; 
   my $perl_hash     = shift ; 
   my $ret           = 0 ; 
   my $msg           = '' ; 

   $objModel->set('update.web-action.col_name' , $perl_hash->{'attribute'} ) ; 
   $objModel->set('update.web-action.id' , $perl_hash->{'id'} ) ; 
   $objModel->set('update.web-action.col_value' , $perl_hash->{'cnt'} ) ; 
   
   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 

}

sub doSetDeleteUrlParams {

   my $self          = shift ; 
   my $perl_hash     = shift ; 
   my $ret           = 0 ; 
   my $msg           = '' ; 

   $objModel->set('delete.web-action.id' , $perl_hash->{'id'} ) ; 

   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 

}

sub doSetWith {

   my $self          = shift ; 
   my $with_params   = {} ; 
   my $ret           = 1 ; 
   my $msg           = '' ; 

   my $ops = {
       'eq' => '='
     , 'ne' => '<>'
     , 'gt' => '>'
     , 'lt' => '<'
     , 'ge' => '>='
     , 'le' => '<='
     , 'like' => 'like'
   };

   $with_params   = $query_params->every_param('with') ; 
   # or where because of the sql gurus around there ...
   $with_params   = $query_params->every_param('where') if ( @$with_params < 1 ) ;
   return ( 0 , "") unless $with_params ; 

   my ( @with_cols , @with_ops , @with_vals ) = () ; 

   foreach my $with ( @$with_params ) {

      if ( $with =~ m/(.*?)[-](.*?)[-](.*)/g ) {
         push @with_cols , $1 ; 
         #if ( $3 =~ m/(.*?)%(.*?)/g ) { perl bug ?! each second is different ??? ...
         if ( index($3, '%') != -1 ) {
            push @with_ops , 'like' ; 
            push @with_vals , $3 ; 
         } else {
            unless ( exists ( $${ops{$2}}) ) {
               $msg = " error for undefined operator \"$2\" in url syntax. Use one of the following : " ; 
               $msg .= join("," , keys %$ops);
               $msg .= " a valid syntax could be : with=prio-eq-1 " ; 
               $ret = 400 ; 
               return ( $ret , $msg ) ; 
            }
            push @with_ops , $ops->{$2} ; 
            push @with_vals , $3 ; 
         }
      }

      #debug rint "from CnrUrlPrms.pm 47 \@with_cols : @with_cols \n" ; 
      #debug rint "from CnrUrlPrms.pm 47 \@with_ops : @with_ops \n" ; 
      #debug rint "from CnrUrlPrms.pm 47 \@with_vals : @with_vals \n" ; 

      $objModel->set('select.web-action.with-cols' , \@with_cols ) ; 
      $objModel->set('select.web-action.with-ops' , \@with_ops ) ; 
      $objModel->set('select.web-action.with-vals' , \@with_vals ) ; 
   
      $query_params->remove('with') ; 
      $query_params->remove('where') ; 
   }

   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 
}

sub doValidateAndSetWith {

   my $self          = shift ; 
   my $with_params   = {} ; 
   my $ret           = 1 ; 
   my $msg           = '' ; 
   my $isValid       = 0 ; 

   my $ops = {
       'eq' => '='
     , 'ne' => '<>'
     , 'gt' => '>'
     , 'lt' => '<'
     , 'ge' => '>='
     , 'le' => '<='
     , 'like' => 'like'
   };

   $with_params   = $query_params->every_param('with') ; 
   # or where because of the sql gurus around there ...
   $with_params   = $query_params->every_param('where') if ( @$with_params < 1 ) ;

   unless ( defined ( $with_params ) ) {
      $isValid = 1 ; 
      return $isValid ; 
   }

   my ( @with_cols , @with_ops , @with_vals ) = () ; 

   foreach my $with ( @$with_params ) {

      if ( $with =~ m/(.*?)[-](.*?)[-](.*)/g ) {
         push @with_cols , $1 ; 
         #if ( $3 =~ m/(.*?)%(.*?)/g ) { perl bug ?! each second is different ??? ...
         if ( index($3, '%') != -1 ) {
            push @with_ops , 'like' ; 
            push @with_vals , $3 ; 
         } else {
            unless ( exists ( $${ops{$2}}) ) {
               $msg = " error for undefined operator \"$2\" in url syntax. Use one of the following : " ; 
               $msg .= join("," , keys %$ops);
               $msg .= " a valid syntax could be : with=prio-eq-1 " ; 
               $self->set('http_code',400);
               $self->set('msg',$msg);
               return $isValid ; 
            }
            push @with_ops , $ops->{$2} ; 
            push @with_vals , $3 ; 
         }
      }

      #debug rint "from CnrUrlPrms.pm 47 \@with_cols : @with_cols \n" ; 
      #debug rint "from CnrUrlPrms.pm 47 \@with_ops : @with_ops \n" ; 
      #debug rint "from CnrUrlPrms.pm 47 \@with_vals : @with_vals \n" ; 

      $objModel->set('select.web-action.with-cols' , \@with_cols ) ; 
      $objModel->set('select.web-action.with-ops' , \@with_ops ) ; 
      $objModel->set('select.web-action.with-vals' , \@with_vals ) ; 
   
      $query_params->remove('with') ; 
      $query_params->remove('where') ; 
   }

   $isValid = 1 ; 
   $ret = 0 ; $msg = '' ; 
   $self->set('http_code',200);
   $self->set('msg','');

   return $isValid ;  
}

sub doSetQueryUrlParams {

   my $self          = shift ; 
   my $Controller    = shift || 'unknown' ; 
   my $controller    = lc ( $Controller ) ; 
   my $ret           = 0 ; 
   my $msg           = '' ; 
   my $qry           = $query_params->param('for') ; 

   if ( !defined ( $qry ) or $qry eq "" ) {
      $msg = "nothing to search for, the for url parameter is undefined the $controller route" ; 
      $ret = 400 ; 
   } else {
      $objModel->set($controller . '.web-action.for' , $qry );
      $query_params->remove('for') ; 
      $ret = 0 ; 
   }
   # start pg-size
   my $page_size = $query_params->param('pg-size') || 7 ; 
   $msg = "the page size must a positive number, but pg-size of " . $page_size . " was requested !!!" ; 
   unless ( isint $page_size ) {
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   if ( $page_size < 0 ) {
      $msg = "the page size must a positive number, but pg-size of " . $page_size . " was requested !!!" ; 
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   $msg = '' ; 
   $objModel->set('query.web-action.pg-size' , $query_params->param('pg-size') );
   $query_params->remove('pg-size') ; 

   # $self->doSetList() ; start pg-num
   my $page_num = $query_params->param('pg-num') || 1 ; 
   $msg = "the page num must a positive number, but pg-num of " . $page_num . " was requested !!!" ; 
   unless ( isint $page_num ) {
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   if ( $page_num < 0 ) {
      $msg = "the page number must a positive number, but pg-num of " . $page_num . " was requested !!!" ; 
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   $msg = '' ; 
   $objModel->set('query.web-action.pg-num' , $query_params->param('pg-num') );
   $query_params->remove('pg-num') ; 
   # stop pg-num
   return ( $ret , $msg ) ; 
}

sub doValidateAndSetFltrs {
   my $self          = shift ; 
   my $isValid       = 0 ; 
   $objModel->set('select.web-action.fltr-by' , $query_params->every_param('fltr-by') ) ; 
   $query_params->remove('fltr-by') ; 
   $objModel->set('select.web-action.fltr-val' , $query_params->every_param('fltr-val') ) ; 
   $query_params->remove('fltr-val') ; 
   $isValid = 1 ; 
   return $isValid ; 
}

sub doValidateAndSetLikes {
   my $self          = shift ; 
   my $isValid       = 0 ; 
   $objModel->set('select.web-action.like-by' , $query_params->every_param('like-by') ) ; 
   $query_params->remove('like-by') ; 
   $objModel->set('select.web-action.like-val' , $query_params->every_param('like-val') ) ; 
   $query_params->remove('like-val') ; 
   $isValid = 1 ; 
   return $isValid ; 
}

sub doValidateAndSetPicks {
   my $self          = shift ; 
   my $isValid       = 0 ; 
   my $picks = $query_params->param('pick') ; 
   if ( defined ( $picks ) ) {
      $picks = 'id,' . $picks unless ($picks =~ m/id,/) ;
   }
   $objModel->set('select.web-action.pick' , $picks ); 
   $query_params->remove('pick') ; 
   $isValid = 1 ; 
   return $isValid ; 
}

sub doValidateAndSetHides {
   my $self          = shift ; 
   my $isValid       = 0 ; 
   $objModel->set('select.web-action.hide' , $query_params->param('hide') );
   $query_params->remove('hide') ; 
   $isValid = 1 ; 
   return $isValid ; 
}

sub doValidateAndSetOrderAscendings{
   my $self          = shift ; 
   my $isValid       = 0 ; 
   $objModel->set('select.web-action.oa' , $query_params->param('oa') );
   $query_params->remove('oa') ; 
   $isValid = 1 ; 
   return $isValid ; 
}

sub doValidateAndSetOrderDescendings{
   my $self          = shift ; 
   my $isValid       = 0 ; 
   $objModel->set('select.web-action.od' , $query_params->param('od') );
   $query_params->remove('od') ; 
   $isValid = 1 ; 
   return $isValid ; 
}

sub doValidateAndSetPageNum {
   my $self          = shift ; 
   my $isValid       = 0 ; 
   my $page_num = $query_params->param('pg-num') || 1 ; 
   my $msg = "the page num must a positive number, but pg-num of " . $page_num . " was requested !!!" ; 
   unless ( isint $page_num ) {
      $self->set('http_code' , 400 ) ; 
      $self->set('msg' , $msg ) ; 
      return $isValid ; 
      
   }
   if ( $page_num < 0 ) {
      $msg = "the page number must a positive number, but pg-num of " . $page_num . " was requested !!!" ; 
      $self->set('http_code' , 400 ) ; 
      $self->set('msg' , $msg ) ; 
      return $isValid ; 
   }
   $msg = '' ; 
   $objModel->set('select.web-action.pg-num' , $page_num );
   $query_params->remove('pg-num') ; 
   $isValid = 1 ; 
   return $isValid ; 
}

sub doValidateAndSetPageSize {
   my $self          = shift ; 
   my $isValid       = 0 ; 
   
   # start pg-size
   my $page_size = $query_params->param('pg-size') || 7 ; 
   my $msg = "the page size must a positive number, but pg-size of " . $page_size . " was requested !!!" ; 
   unless ( isint ($page_size) ) {
      my $ret = 400 ; 
      $self->set('msg' , $msg );
      $self->set('http_code' , $ret );
      return $isValid ; 
   }
   if ( $page_size < 0 ) {
      $msg = "the page size must a positive number, but pg-size of " . $page_size . " was requested !!!" ; 
      my $ret = 400 ; 
      $self->set('msg' , $msg );
      $self->set('http_code' , $ret );
      return $isValid ; 
   }
   $msg = '' ; 
   
   $objModel->set('select.web-action.pg-size' , $page_size );
   $query_params->remove('pg-size') ; 
   $isValid = 1 ; 
   return $isValid ; 
}

sub doValidateAndSetSelect {
   my $self          = shift ; 
   
   return 
         $self->doValidateAndSetWith()
      && $self->doValidateAndSetFltrs()
      && $self->doValidateAndSetLikes()
      && $self->doValidateAndSetPicks()
      && $self->doValidateAndSetHides()
      && $self->doValidateAndSetOrderAscendings()
      && $self->doValidateAndSetOrderDescendings()
      && $self->doValidateAndSetPageSize()
      && $self->doValidateAndSetPageNum()
   ;

}


sub doValidateAndSetBranchId {

   my $self          = shift ; 
   my $ret           = 1 ; 
   my $isValid       = 0 ;
   my $msg           = '' ; 
   my $http_code     = 400 ; 
   my $bid           = $query_params->param('bid') || 0 ; 
   
   unless ( looks_like_number $bid ) {
      $msg = 'the branch-id bid url parameter should be a whole number' ; 
      $http_code = 400 ; 
   } else {
      $isValid = 1 ; 
      $http_code = 200 ; 
      $objModel->set('view.web-action.bid' , $query_params->param('bid') );
      $query_params->remove('bid') ; 
   }
   
   $self->set('http_code'  , $http_code );
   $self->set('msg'  , $msg );
   return $isValid ;
}


sub doValidateAndSetSeq {

   my $self          = shift ; 
   my $ret           = 1 ; 
   my $isValid       = 0 ;
   my $msg           = '' ; 
   my $http_code     = 400 ; 
   my $seq           = $query_params->param('seq') ;
   
   if ( defined $seq && !looks_like_number $query_params->param('seq') ) {
      $msg = 'the seq ( aka sequence ) url parameter should be a whole number' ; 
      $http_code = 400 ; 
      return ( $ret , $msg , $http_code )
   } else {
      $isValid = 1 ; 
      $http_code = 200 ; 
      $objModel->set('hselect.web-action.seq' , $query_params->param('seq') );
      $query_params->remove('seq') ; 
   }
   
   $self->set('http_code'  , $http_code );
   $self->set('msg'  , $msg );
   return $isValid ;
}


sub doValidateAndSetHSelect {
   my $self          = shift ; 
   return $self->doValidateAndSetBranchId() && $self->doValidateAndSetSeq() 
      && $self->doValidateAndSetWith();
}


sub doSetView {

   my $self          = shift ; 
   my $ret           = 1 ; 
   my $http_code     = 200 ;
   my $msg           = '' ; 
   my $bid           = $query_params->param('bid') || 0 ; 
   my $seq           = $query_params->param('seq') ; 

   unless ( looks_like_number $bid ) {
      $msg = 'the branch-id bid url parameter should be a whole number' ; 
      $http_code = 400 ; 
      return ( $http_code , $msg ) 
   }
   
   if ( defined $seq && !looks_like_number $query_params->param('seq') ) {
      $msg = 'the seq ( aka sequence ) url parameter should be a whole number' ; 
      $http_code = 400 ; 
      return ( $http_code , $msg ) 
   }

   $objModel->set('view.web-action.bid' , $query_params->param('bid') );
   $query_params->remove('bid') ; 
   
   $objModel->set('hselect.web-action.seq' , $query_params->param('seq') );
   $query_params->remove('seq') ; 
   
   $ret = 200 ; $msg = '' ; 
   return ($ret , $msg );
}
   
	sub new {
		my $invocant   = shift ;    
		$appConfig     = ${ shift @_ } || croak 'appConfig not passed in RdrPostgresDb !!!' ; 
		$objModel      = ${ shift @_ } || croak 'objModel not passed in RdrPostgresDb !!!' ; 
      $query_params  = shift || croak 'no query params passed !!!' ; 
		my $class      = ref ( $invocant ) || $invocant ; 
		my $self       = {} ; bless( $self, $class );    # Say: $self is a $class
		return $self;
	}  

1;

__END__


=head1 NAME

CnrUrlPrms

=head1 SYNOPSIS 

   use IssueTracker::App::IO::In::CnrUrlPrms ; 
   my $objCnrUrlPrms = 
      'IssueTracker::App::IO::In::CnrUrlPrms'->new(\$appConfig , \$objModel , $self->req->query_params);

  

=head1 DESCRIPTION

responsible for setting the parsed url params into the objModel

=head2 EXPORT


=head1 SEE ALSO


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 COPYRIGHT MOR LICENSE

Copyright (C) 2018 Yordan Georgiev

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

