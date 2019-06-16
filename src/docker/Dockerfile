# vim:set ft=dockerfile:
FROM ubuntu:18.04

# obs !!! todo: parametrize qto-190616104728
RUN echo "root:root" | chpasswd
RUN echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' >> /root/.bashrc
# src: https://stackoverflow.com/a/28769950/65706

# install the most basic binaries
ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# a
RUN apt-get update && apt-get install -y wget curl sudo perl zip unzip gnupg2 gnupg1 git bash

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# add the PostgreSQL's repository
RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main"' \
   > /etc/apt/sources.list.d/pgdg.list

# add the most basic binaries
RUN apt-get clean && apt-get update
RUN apt-get install -f -y postgresql-server-dev-11 postgresql-client-11 postgresql-contrib-11
RUN apt-get clean && apt-get update

# ensure the postresql starts on boot 
RUN sudo update-rc.d postgresql enable

# add the required binaries
RUN apt-get install -y perl net-tools exuberant-ctags mutt curl wget libwww-curl-perl libtest-www-selenium-perl libdbd-pgsql libxml-atom-perl git vim libxml-atom-perl tar gzip graphviz python-selenium chromium-chromedriver python-selenium python-setuptools  python-dev  build-essential gpgsm nodejs lsof libssl-dev 
RUN apt-get clean && apt-get update

# -- start add the qto os level application user
RUN sudo groupadd -g "10001" "grpqtoadmin"
RUN sudo cat /etc/group | grep --color "grpqtoadmin"
RUN sudo useradd --uid "10001" --home-dir "/home/usrqtoadmin" --gid "10001" \
   --create-home --shell /bin/bash "usrqtoadmin"

# obs !! dummy password qto-190616104728
RUN echo usrqtoadmin:usrqtoadmin| chpasswd
RUN sudo cat /etc/passwd | grep --color "usrqtoadmin"
# add the usrqtoadmin to the sudoers 
RUN echo "usrqtoadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# -- stop add the qto os level application user

RUN mkdir -p /etc/postgresql/11/main/
RUN mkdir -p /var/lib/postgresql/11/main

RUN sudo chown -R postgres:postgres "/etc/postgresql"
RUN sudo chown -R postgres:postgres "/var/lib/postgresql"

USER postgres
RUN echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' >> /var/lib/postgresql/.bashrc

RUN /etc/init.d/postgresql start 

RUN echo "local   all             postgres                                peer" \
   >> /etc/postgresql/11/main/pg_hba.conf
RUN echo "local   all             all                                     peer" \
   >> /etc/postgresql/11/main/pg_hba.conf
RUN echo "host    all             all             127.0.0.1/32            md5" \
   >> /etc/postgresql/11/main/pg_hba.conf
RUN echo "host    all             all             ::1/128                 md5" \
   >> /etc/postgresql/11/main/pg_hba.conf
RUN echo "local   replication     postgres                                peer" \
   >> /etc/postgresql/11/main/pg_hba.conf
RUN echo "host    replication     postgres        127.0.0.1/32            md5" \
   >> /etc/postgresql/11/main/pg_hba.conf
RUN echo "host    replication     postgres        ::1/128                 md5" \
   >> /etc/postgresql/11/main/pg_hba.conf

RUN echo "data_directory = '/var/lib/postgresql/11/main'" \
   >> /etc/postgresql/11/main/postgresql.conf
RUN echo "hba_file = '/etc/postgresql/11/main/pg_hba.conf'" \
   >> /etc/postgresql/11/main/postgresql.conf
RUN echo "ident_file = '/etc/postgresql/11/main/pg_ident.conf'" \
   >> /etc/postgresql/11/main/postgresql.conf
RUN echo "external_pid_file = '/var/run/postgresql/11-main.pid'" \
   >> /etc/postgresql/11/main/postgresql.conf
RUN echo "listen_addresses='*'" \
   >> /etc/postgresql/11/main/postgresql.conf
RUN echo "port = 15432" \
   >> /etc/postgresql/11/main/postgresql.conf
RUN echo "max_connections = 100" \
   >> /etc/postgresql/11/main/postgresql.conf
RUN echo "unix_socket_directories = '/var/run/postgresql'" \
   >> /etc/postgresql/11/main/postgresql.conf

# add the uuid generation capability enabling extensions
RUN /etc/init.d/postgresql restart &&\
psql -c "CREATE USER usrqtoadmin WITH SUPERUSER PASSWORD 'usrqtoadmin';" &&\
psql -c "grant all privileges on database postgres to usrqtoadmin ;" &&\
createdb -O postgres postres && \
psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";' &&\
psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "pgcrypto";' &&\
psql template1 -c 'CREATE EXTENSION IF NOT EXISTS "dblink";' 

# expose the PostgreSQL port
EXPOSE 15432

# add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

RUN /etc/init.d/postgresql restart


USER usrqtoadmin
RUN echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' >> /home/usrqtoadmin/.bashrc
RUN export USER=usrqtoadmin
RUN mkdir -p /home/usrqtoadmin/opt
WORKDIR /home/usrqtoadmin/opt/
RUN git clone https://github.com/YordanGeorgiev/qto.git
WORKDIR /home/usrqtoadmin/opt/qto
# todo:ysg remove to use master
RUN git checkout v0.6.5
RUN bash src/bash/qto/bootstrap-qto.sh
WORKDIR /home/usrqtoadmin/opt/csitea/qto/qto.0.6.5.dev.usrqtoadmin
# RUN su - postgres -c '/etc/init.d/postgresql restart' &&\
#  bash src/bash/qto/qto.sh -a run-pgsql-scripts

# start install perl modules
RUN wget - http://cpanmin.us | perl - --self-upgrade

# src: http://stackoverflow.com/a/13090364/65706src: 
# RUN echo y|cpan
# RUN echo o conf prerequisites_policy follow | cpan
# RUN echo o conf commit | cpan

#RUN bash -c "sudo -s 'curl -L cpanmin.us | perl - Mojolicious'"
# RUN cpan Mojolicious
RUN sudo perl -MCPAN -e 'install URL::Encode'
RUN sudo perl -MCPAN -e 'install Carp::Always'
RUN sudo perl -MCPAN -e 'install Data::Printer'
RUN sudo perl -MCPAN -e 'install Term::Prompt'
RUN sudo perl -MCPAN -e 'install Excel::Writer::XLSX'
RUN sudo perl -MCPAN -e 'install Spreadsheet::ParseExcel'
RUN sudo perl -MCPAN -e 'install Spreadsheet::XLSX'
RUN sudo perl -MCPAN -e 'install DBD::Pg'
RUN sudo perl -MCPAN -e 'install Tie::Hash::DBD'
RUN sudo perl -MCPAN -e 'install Text::CSV_XS'
RUN sudo perl -MCPAN -e 'install File::Copy::Recursive'
RUN sudo perl -MCPAN -e 'install Test::Trap'
RUN sudo perl -MCPAN -e 'install Test::Most'
RUN sudo perl -MCPAN -e 'install Tie::Hash::DBD'
RUN sudo perl -MCPAN -e 'install Scalar::Util::Numeric'
RUN sudo perl -MCPAN -e 'install IPC::System::Simple'
RUN sudo perl -MCPAN -e 'install Mojo::Pg'
RUN sudo perl -MCPAN -e 'install Mojolicious::Plugin::BasicAuthPlus'
RUN sudo perl -MCPAN -e 'install Mojolicious::Plugin::StaticCache'
RUN sudo perl -MCPAN -e 'install Mojolicious::Plugin::RenderFile'
RUN sudo perl -MCPAN -e 'install Mojolicious::Plugin::Authentication'
RUN sudo perl -MCPAN -e 'install Mojo::JWT'
RUN sudo perl -MCPAN -e 'install Selenium::Remote::Driver'
RUN sudo perl -MCPAN -e 'install Authen::Passphrase::BlowfishCrypt'
RUN sudo perl -MCPAN -e 'install Net::Google::DataAPI::Auth::OAuth2'
RUN sudo perl -MCPAN -e 'CPAN::Shell->force(qw( install Net::Google::DataAPI::Auth::OAuth2));'
RUN sudo perl -MCPAN -e 'install Net::Google::Spreadsheets::V4'
RUN sudo perl -MCPAN -e 'install Net::Google::Spreadsheets;'
# stop install perl modules

WORKDIR /home/usrqtoadmin/opt/csitea/qto/qto.0.6.5.dev.usrqtoadmin
RUN cat lib/bash/funcs/parse-cnf-env-vars.sh >> /home/usrqtoadmin/.bashrc

# fetch the latest qto data dump
RUN wget 'https://s3-eu-west-1.amazonaws.com/qto.fi/prd_qto.latest.insrt.dmp.sql' -O dat/prd_qto.latest.insrt.dmp.sql

RUN bash src/bash/qto/qto.sh -a check-perl-syntax

RUN echo 'docker run -d --name qto-container-01 -p 127.0.0.1:15432:15432 -p 127.0.0.1:3001:3001 --restart=unless-stopped qto-image'
RUN echo 'to attach to the the running container run:'
RUN echo 'docker exec -it qto-container-01 /bin/bash'

# set the default command to run when starting the container
USER root
RUN sudo chown -R postgres:postgres "/etc/postgresql"
RUN sudo chown -R postgres:postgres "/var/lib/postgresql"

USER postgres
RUN echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' >> /var/lib/postgresql/.bashrc
CMD ["/usr/lib/postgresql/11/bin/postgres", "-D", "/var/lib/postgresql/11/main", "-c", "config_file=/etc/postgresql/11/main/postgresql.conf"]
