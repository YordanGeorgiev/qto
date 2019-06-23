#!/bin/bash

# start install perl modules
wget - http://cpanmin.us | perl - --self-upgrade

# src: http://stackoverflow.com/a/13090364/65706src: 
# echo y|cpan
# echo o conf prerequisites_policy follow | cpan
# echo o conf commit | cpan

#bash -c "sudo -s 'curl -L cpanmin.us | perl - Mojolicious'"
# cpan Mojolicious
sudo perl -MCPAN -e 'install URL::Encode'
sudo perl -MCPAN -e 'install Carp::Always'
sudo perl -MCPAN -e 'install Data::Printer'
sudo perl -MCPAN -e 'install Term::Prompt'
sudo perl -MCPAN -e 'install Excel::Writer::XLSX'
sudo perl -MCPAN -e 'install Spreadsheet::ParseExcel'
sudo perl -MCPAN -e 'install Spreadsheet::XLSX'
sudo perl -MCPAN -e 'install DBD::Pg'
sudo perl -MCPAN -e 'install Tie::Hash::DBD'
sudo perl -MCPAN -e 'install Text::CSV_XS'
sudo perl -MCPAN -e 'install File::Copy::Recursive'
sudo perl -MCPAN -e 'install Test::Trap'
sudo perl -MCPAN -e 'install Test::Most'
sudo perl -MCPAN -e 'install Tie::Hash::DBD'
sudo perl -MCPAN -e 'install Scalar::Util::Numeric'
sudo perl -MCPAN -e 'install IPC::System::Simple'
sudo perl -MCPAN -e 'install Mojo::Pg'
sudo perl -MCPAN -e 'install Mojolicious::Plugin::BasicAuthPlus'
sudo perl -MCPAN -e 'install Mojolicious::Plugin::StaticCache'
sudo perl -MCPAN -e 'install Mojolicious::Plugin::RenderFile'
sudo perl -MCPAN -e 'install Mojolicious::Plugin::Authentication'
sudo perl -MCPAN -e 'install Mojo::JWT'
sudo perl -MCPAN -e 'install Selenium::Remote::Driver'
sudo perl -MCPAN -e 'install Authen::Passphrase::BlowfishCrypt'
sudo perl -MCPAN -e 'install Net::Google::DataAPI::Auth::OAuth2'
sudo perl -MCPAN -e 'CPAN::Shell->force(qw( install Net::Google::DataAPI::Auth::OAuth2));'
sudo perl -MCPAN -e 'install Net::Google::Spreadsheets::V4'
sudo perl -MCPAN -e 'install Net::Google::Spreadsheets;'
# stop install perl modules

