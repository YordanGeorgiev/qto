package IssueTracker::App::IO::In::CnrUrlParams ; 
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
   use Data::Printer ; 


   use parent 'IssueTracker::App::Utils::OO::SetGetable' ; 
   use parent 'IssueTracker::App::Utils::OO::AutoLoadable' ;

sub doSetCreateUrlParams {

   my $self          = shift ; 
   my $objModel      = ${ shift @_ } ; 
   my $perl_hash     = shift ; 
   my $ret           = 0 ; 
   my $msg           = '' ; 

   $objModel->set('create.web-action.id' , $perl_hash->{'id'} ) ; 
   
   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 

}

sub doSetUpdateUrlParams {

   my $self          = shift ; 
   my $objModel      = ${ shift @_ } ; 
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
   my $objModel      = ${ shift @_ } ; 
   my $perl_hash     = shift ; 
   my $ret           = 0 ; 
   my $msg           = '' ; 

   $objModel->set('delete.web-action.id' , $perl_hash->{'id'} ) ; 

   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 

}

sub doSetWith {

   my $self          = shift ; 
   my $objModel      = ${ shift @_ } ; 
   my $query_params  = shift ; 
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

   return unless $with_params ; 

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

      # debug rint "from CnrUrlParams.pm 47 \@with_cols : @with_cols \n" ; 
      # debug rint "from CnrUrlParams.pm 47 \@with_ops : @with_ops \n" ; 
      # debug rint "from CnrUrlParams.pm 47 \@with_vals : @with_vals \n" ; 

      $objModel->set('select.web-action.with-cols' , \@with_cols ) ; 
      $objModel->set('select.web-action.with-ops' , \@with_ops ) ; 
      $objModel->set('select.web-action.with-vals' , \@with_vals ) ; 
   
      $query_params->remove('with') ; 
      $query_params->remove('where') ; 
   }

   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 
}

sub doSetQueryUrlParams {

   my $self          = shift ; 
   my $objModel      = ${ shift @_ } ; 
   my $query_params  = shift ; 
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
   # start page-size
   my $page_size = $query_params->param('page-size') || 7 ; 
   $msg = "the page size must a positive number, but page-size of " . $page_size . " was requested !!!" ; 
   unless ( isint $page_size ) {
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   if ( $page_size < 0 ) {
      $msg = "the page size must a positive number, but page-size of " . $page_size . " was requested !!!" ; 
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   $msg = '' ; 
   $objModel->set('query.web-action.page-size' , $query_params->param('page-size') );
   $query_params->remove('page-size') ; 

   # start page-num
   my $page_num = $query_params->param('page-num') || 1 ; 
   $msg = "the page num must a positive number, but page-num of " . $page_num . " was requested !!!" ; 
   unless ( isint $page_num ) {
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   if ( $page_num < 0 ) {
      $msg = "the page number must a positive number, but page-num of " . $page_num . " was requested !!!" ; 
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   $msg = '' ; 
   $objModel->set('query.web-action.page-num' , $query_params->param('page-num') );
   $query_params->remove('page-num') ; 
   # stop page-num
   return ( $ret , $msg ) ; 
}


sub doSetSelect {

   my $self          = shift ; 
   my $objModel      = ${ shift @_ } ; 
   my $query_params  = shift ; 
   my $ret           = 0 ; 
   my $msg           = '' ; 
   
   # p ($query_params->every_param('fltr-val'));

   $objModel->set('select.web-action.fltr-by' , $query_params->every_param('fltr-by') ) ; 
   $query_params->remove('fltr-by') ; 
   $objModel->set('select.web-action.fltr-val' , $query_params->every_param('fltr-val') ) ; 
   $query_params->remove('fltr-val') ; 
   $objModel->set('select.web-action.like-by' , $query_params->every_param('like-by') ) ; 
   $query_params->remove('like-by') ; 
   $objModel->set('select.web-action.like-val' , $query_params->every_param('like-val') ) ; 
   $query_params->remove('like-val') ; 
   my $picks = $query_params->param('pick') ; 
   if ( defined ( $picks ) ) {
      $picks = 'id,' . $picks unless ($picks =~ m/id,/) ;
   }
   $objModel->set('select.web-action.pick' , $picks ); 
   $query_params->remove('pick') ; 
   $objModel->set('select.web-action.hide' , $query_params->param('hide') );
   $query_params->remove('hide') ; 
   $objModel->set('select.web-action.oa' , $query_params->param('oa') );
   $query_params->remove('oa') ; 
   $objModel->set('select.web-action.od' , $query_params->param('od') );
   $query_params->remove('od') ; 

   # start page-size
   my $page_size = $query_params->param('page-size') || 7 ; 
   $msg = "the page size must a positive number, but page-size of " . $page_size . " was requested !!!" ; 
   unless ( isint $page_size ) {
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   if ( $page_size < 0 ) {
      $msg = "the page size must a positive number, but page-size of " . $page_size . " was requested !!!" ; 
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   $msg = '' ; 
   $objModel->set('select.web-action.page-size' , $query_params->param('page-size') );
   $query_params->remove('page-size') ; 

   # start page-num
   my $page_num = $query_params->param('page-num') || 1 ; 
   $msg = "the page num must a positive number, but page-num of " . $page_num . " was requested !!!" ; 
   unless ( isint $page_num ) {
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   if ( $page_num < 0 ) {
      $msg = "the page number must a positive number, but page-num of " . $page_num . " was requested !!!" ; 
      $ret = 400 ; 
      return ( $ret , $msg ) ; 
   }
   $msg = '' ; 
   $objModel->set('select.web-action.page-num' , $query_params->param('page-num') );
   $query_params->remove('page-num') ; 
   # stop page-num

   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 

}


sub doSetView {

   my $self          = shift ; 
   my $objModel      = ${ shift @_ } ; 
   my $query_params  = shift ; 
   my $ret           = 1 ; 
   my $msg           = '' ; 

   $objModel->set('view.web-action.bid' , $query_params->param('bid') );
   $query_params->remove('bid') ; 
   
   $objModel->set('view.web-action.seq' , $query_params->param('seq') );
   $query_params->remove('seq') ; 

   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 
}
   

sub doSetList {

   my $self          = shift ; 
   my $objModel      = ${ shift @_ } ; 
   my $query_params  = shift ; 
   my $ret           = 1 ; 
   my $msg           = '' ; 

   $objModel->set('list.web-action.fltr-by' , $query_params->every_param('fltr-by') ) ; 
   $objModel->set('list.web-action.fltr-val' , $query_params->every_param('fltr-val') ) ; 

   $objModel->set('list.web-action.like-by' , $query_params->every_param('like-by') ) ; 
   $objModel->set('list.web-action.like-val' , $query_params->every_param('like-val') ) ; 

   $objModel->set('list.web-action.pick' , $query_params->param('pick') );
   $objModel->set('list.web-action.hide' , $query_params->param('hide') );
   $objModel->set('select.web-action.oa' , $query_params->param('oa') );
   $query_params->remove('oa') ; 
   $objModel->set('select.web-action.od' , $query_params->param('od') );
   $query_params->remove('od') ; 
   $objModel->set('list.web-action.page-size' , $query_params->param('page-size') );
   $objModel->set('list.web-action.page-num' , $query_params->param('page-num') );

   $ret = 0 ; $msg = '' ; 
   return ( $ret , $msg ) ; 
}


sub new {
    my $class = shift;    # Class name is in the first parameter
    my $self = {};        # Anonymous hash reference holds instance attributes
    bless($self, $class); # Say: $self is a $class
    return $self;
}   

1;

__END__


=head1 NAME

CnrUrlParams

=head1 SYNOPSIS


use IssueTracker::App::IO::In::CnrUrlParams ; 

$objCnrUrlParams= 'IssueTracker::App::IO::In::CnrUrlParams'->new();
( $ret , $msg ) = $objCnrUrlParams->doSetSelect(\$objModel, $self->req->query_params );
( $ret , $msg ) = $objCnrUrlParams->doSetWith(\$objModel, $self->req->query_params );
( $ret , $msg ) = $objCnrUrlParams->doSetList(\$objModel, $self->req->query_params );
  

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

