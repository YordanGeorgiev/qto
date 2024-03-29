#!/bin/bash

do_alpine_chk_install_perl_modules(){
   cd $PRODUCT_DIR
   modules="$(cat bin/cnf/perl/qto-app-perl-modules.lst)"

   while read -r module ; do
      use_modules="${use_modules:-} use $module ; "
   done < <(echo "$modules");

   set -x
   perl -e "$use_modules" || {
      echo "deploying modules. This WILL take couple of min, but ONLY ONCE !!!"
      curl -L http://cpanmin.us | sudo perl - --self-upgrade -l ~/perl5 App::cpanminus \
         && sudo chown -R $APPUSR:$APPGRP ~/.cpanm && sudo chown -R $APPUSR:$APPGRP ~/perl5
      ~/perl5/bin/cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
      curl -L cpanmin.us | perl - Mojolicious
      test "$(grep -c 'Mlocal::lib' ~/.bashrc|xargs)" -eq 0 && \
         echo 'eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' >> ~/.bashrc
    while read -r module ; do cpanm_modules="${cpanm_modules:-} $module " ; done < <(echo "$modules")

  #cpanm --force --local-lib=~/perl5 'Net::Google::DataAPI' # does not install otherwise !!!
    # probably not needed as all google related modules are out of the setup ^^^
  cmd="cpanm --local-lib=~/perl5 $modules"
  $cmd

  # nasty workaround for the "Moo complainings" in the Net::Google::DataAPI::Oauth2 module
  find ~ -type f -name OAuth2.pm -exec perl -pi -e \
    "s/use Any::Moose;/no warnings 'deprecated'; use Any::Moose; use warnings 'deprecated';/g" {} \;
  }

  set +x
  # create the symlink to the hypnotoad
  export tgt_path=$HOME/perl5/bin/hypnotoad
  export link_path=/usr/local/sbin/hypnotoad
  sudo mkdir -p `dirname $link_path`
  sudo test -L $link_path && unlink $link_path
  sudo ln -s $tgt_path $link_path
  ls -la $link_path;


  export exit_code=0
}
