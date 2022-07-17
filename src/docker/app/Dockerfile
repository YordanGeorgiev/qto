FROM alpine
# based on alpine-perl of: https://github.com/krumeich

ARG ENV
ARG UID
ARG GID
ARG PRODUCT
ARG ORG

ENV PRODUCT=$PRODUCT
ENV ORG=$ORG
ENV APPUSR=appusr
ENV APPGRP=appgrp
ENV PS1='`date "+%F %T"` \u@\h  \w \n\n  '
ENV PRODUCT_DIR="/opt/$PRODUCT"
ENV EDITOR="vim"
ENV ENV=$ENV

VOLUME $PRODUCT_DIR


# install OS utils
RUN apk update && apk upgrade && apk add --no-cache \
    bash binutils vim jq wget curl zip unzip busybox-extras su-exec sudo shadow

# install backend-utils
RUN apk update && apk upgrade && apk add --no-cache \
    build-base gcc openssl-dev libmagic ttf-freefont


# start ::: adding OS APPUSR and APPGRP
RUN test -z $(getent group $GID | cut -d: -f1) || \
        groupmod -g $((GID+1000)) $(getent group $GID | cut -d: -f1)

# create a APPGRP and APPUSR
RUN set -x ; addgroup -g "$GID" -S "$APPGRP" && \
  adduser \
  --disabled-password \
  -g "$GID" \
  -D \
  -s "/bin/bash" \
  -h "/home/$APPUSR" \
  -u "$UID" \
  -G "$APPGRP" "$APPUSR" && exit 0 ; exit 1

RUN echo "$APPUSR ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "export PS1=\"$PS1\"" >> /home/$APPUSR/.bashrc

# stop ::: adding OS APPUSR and APPGRP

## alpine curl and wget aren't fully compatible, so we install them
## here. gnupg is needed for Module::Signature.
RUN apk update && apk upgrade && apk add curl tar make gcc build-base wget gnupg

RUN mkdir -p /usr/src/perl

WORKDIR /usr/src/perl

## from perl; `true make test_harness` because 3 tests fail
## some flags from http://git.alpinelinux.org/cgit/aports/tree/main/perl/APKBUILD?id=19b23f225d6e4f25330e13144c7bf6c01e624656
RUN curl -SLO https://www.cpan.org/src/5.0/perl-5.32.0.tar.gz \
    && echo 'ddecb3117c016418b19ed3a8827e4b521b47d6bb *perl-5.32.0.tar.gz' | sha1sum -c - \
    && tar --strip-components=1 -xzf perl-5.32.0.tar.gz -C /usr/src/perl \
    && rm perl-5.32.0.tar.gz \
    && ./Configure -des \
        -Duse64bitall \
        -Dcccdlflags='-fPIC' \
        -Dcccdlflags='-fPIC' \
        -Dccdlflags='-rdynamic' \
        -Dlocincpth=' ' \
        -Duselargefiles \
        -Dusethreads \
        -Duseshrplib \
        -Dd_semctl_semun \
        -Dusenm \
    && make libperl.so \
    && make -j$(nproc) \
    && TEST_JOBS=$(nproc) make test_harness \
    && make install \
    && curl -LO https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm \
    && chmod +x cpanm \
    && ./cpanm App::cpanminus \
    && rm -fr ./cpanm /root/.cpanm /usr/src/perl

## from tianon/perl
ENV PERL_CPANM_OPT --verbose --mirror https://cpan.metacpan.org --mirror-only
RUN cpanm Digest::SHA Module::Signature && rm -rf ~/.cpanm
ENV PERL_CPANM_OPT $PERL_CPANM_OPT --verify



ADD --chown=$APPUSR:$APPGRP "." /home/$APPUSR$PRODUCT_DIR
# switch to the app user
USER $APPUSR


# stop ::: adding OS APPUSR and APPGRP

# Note: using $APPUSR/$PRODUCT_DIR will result in /home/appusr//opt/product/r
#                                   ~~~^^^~~~
# RUN SUB_COMPONENT=tpl-gen bash /home/$APPUSR$PRODUCT_DIR/run -a do_check_install_py_modules

WORKDIR $PRODUCT_DIR

CMD exec /bin/bash -c /home/$APPUSR$PRODUCT_DIR/src/bash/run/docker-init-app.sh

