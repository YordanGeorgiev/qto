# vim:set ft=dockerfile:

FROM ubuntu:16.04

# install the most basic binaries
RUN apt-get update && apt-get install -y wget curl sudo perl zip unzip

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# add the PostgreSQL's repository
RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"' \
   > /etc/apt/sources.list.d/pgdg.list

RUN apt-get clean
RUN apt-get update

RUN apt-get install -y postgresql-9.6 postgresql-client-9.6 postgresql-contrib-9.6
RUN apt-get clean
RUN apt-get update

# -- start add the qto os level application user
RUN sudo groupadd -g "10001" "grp_qto"
RUN sudo cat /etc/group | grep --color "grp_qto"
RUN sudo useradd --uid "10001" --home-dir "/home/usr_qto" --gid "10001" \
   --create-home --shell /bin/bash "usr_qto"
RUN echo usr_qto:usr_qto| chpasswd
RUN sudo cat /etc/passwd | grep --color "usr_qto"
# -- stop add the qto os level application user

RUN mkdir -p /etc/postgresql/9.6/main/
RUN mkdir -p /var/lib/postgresql/9.6/main
RUN sudo chown -R postgres:postgres "/etc/postgresql"
RUN sudo chown -R postgres:postgres "/var/lib/postgresql"

USER postgres
RUN /etc/init.d/postgresql start 

RUN echo "local   all             postgres                                peer" \
   >> /etc/postgresql/9.6/main/pg_hba.conf
RUN echo "local   all             all                                     peer" \
   >> /etc/postgresql/9.6/main/pg_hba.conf
RUN echo "host    all             all             127.0.0.1/32            md5" \
   >> /etc/postgresql/9.6/main/pg_hba.conf
RUN echo "host    all             all             ::1/128                 md5" \
   >> /etc/postgresql/9.6/main/pg_hba.conf
RUN echo "local   replication     postgres                                peer" \
   >> /etc/postgresql/9.6/main/pg_hba.conf
RUN echo "host    replication     postgres        127.0.0.1/32            md5" \
   >> /etc/postgresql/9.6/main/pg_hba.conf
RUN echo "host    replication     postgres        ::1/128                 md5" \
   >> /etc/postgresql/9.6/main/pg_hba.conf

RUN echo "data_directory = '/var/lib/postgresql/9.6/main'" \
   >> /etc/postgresql/9.6/main/postgresql.conf
RUN echo "hba_file = '/etc/postgresql/9.6/main/pg_hba.conf'" \
   >> /etc/postgresql/9.6/main/postgresql.conf
RUN echo "ident_file = '/etc/postgresql/9.6/main/pg_ident.conf'" \
   >> /etc/postgresql/9.6/main/postgresql.conf
RUN echo "external_pid_file = '/var/run/postgresql/9.6-main.pid'" \
   >> /etc/postgresql/9.6/main/postgresql.conf
RUN echo "listen_addresses='*'" \
   >> /etc/postgresql/9.6/main/postgresql.conf
RUN echo "port = 15432" \
   >> /etc/postgresql/9.6/main/postgresql.conf
RUN echo "max_connections = 100" \
   >> /etc/postgresql/9.6/main/postgresql.conf
RUN echo "unix_socket_directories = '/var/run/postgresql'" \
   >> /etc/postgresql/9.6/main/postgresql.conf

RUN /etc/init.d/postgresql restart &&\
psql -c "CREATE USER usr_qto WITH SUPERUSER PASSWORD 'usr_qto';" &&\
psql -c "grant all privileges on database postgres to usr_qto ;" &&\
createdb -O postgres postres

# expose the PostgreSQL port
EXPOSE 15432

# add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.6/bin/postgres", "-D", "/var/lib/postgresql/9.6/main", "-c", "config_file=/etc/postgresql/9.6/main/postgresql.conf"]
