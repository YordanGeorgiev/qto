# vim:set ft=dockerfile:
FROM ubuntu:18.04

ARG product_instance_dir
ENV product_instance_dir $product_instance_dir
ARG postgres_db_name 
ENV postgres_db_name $postgres_db_name
ARG postgres_db_useradmin='usrqtoadmin'
ENV postgres_db_useradmin_pw 'usrqtoadmin'
ARG host_host_name
ENV host_host_name $host_host_name

# obs !!! todo: parametrize qto-190616104728
RUN echo "root:root" | chpasswd
RUN echo 'export PS1="`date "+%F %T"` \u@\h  \w \\n\\n  "' >> /root/.bashrc

# install the most basic binaries
ARG TZ
ENV TZ $TZ
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 
RUN apt-get update && apt-get install -y wget curl sudo perl zip unzip gnupg2 gnupg1 git bash jq vim

WORKDIR /opt/
ADD . $product_instance_dir
WORKDIR $product_instance_dir
#   ^^^ todo:ysg replace with the git clone 

RUN chmod 755 src/bash/qto/install/docker/install-admin-utils.sh && \
    bash src/bash/qto/install/docker/install-admin-utils.sh
RUN chmod 755 src/bash/qto/install/docker/provision-os-users.sh && \
    bash src/bash/qto/install/docker/provision-os-users.sh
RUN chmod 755 src/bash/qto/install/docker/install-postgres.sh && \
    bash src/bash/qto/install/docker/install-postgres.sh

# add VOLUMEs to allow backup of config, logs and databases
# VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# set the default command to run when starting the container
RUN chmod 755 src/bash/qto/install/docker/install-perl-modules.sh && \
   bash src/bash/qto/install/docker/install-perl-modules.sh

RUN chown -R usrqtoadmin:grpqtoadmin "/opt/csitea" && \
    chmod 777 "/opt" && \
    chmod 755 "$product_instance_dir/src/bash/qto/bootstrap-qto-docker.sh"


USER usrqtoadmin
WORKDIR $product_instance_dir
RUN $product_instance_dir/src/bash/qto/bootstrap-qto-docker.sh

USER root
RUN rm -vr /opt/csitea && chmod 755 "/opt"

USER usrqtoadmin
WORKDIR $product_instance_dir

# CMD ["bash","-c","while true; do sleep 1; done;"]
CMD bash -c $product_instance_dir/src/bash/qto/install/docker/docker-entry-point.sh
