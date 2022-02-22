FROM python:3.8.3-alpine


ARG ENV
ARG UID
ARG GID
ARG PRODUCT
ARG TGT_ORG

ENV PRODUCT=$PRODUCT
ENV TGT_ORG=$TGT_ORG
ENV APPUSR=appusr
ENV APPGRP=appgrp
ENV PS1="`date \"+%F %T\"` \u@\h  \w \n\n  "
ENV PRODUCT_DIR="/opt/$PRODUCT"
ENV EDITOR="vim"
ENV ENV=$ENV
ENV TERM="xterm-256color"

VOLUME $PRODUCT_DIR

# START ::: install bins
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    bash binutils vim perl jq wget \
    curl zip unzip busybox-extras \
    su-exec sudo shadow net-tools \
    build-base gcc openssl-dev git \
    libmagic ttf-freefont make jq \
    python3-dev jpeg-dev zlib-dev

# STOP ::: install bins

RUN pip install wheel

# START ::: Enable host to container edit of proj code on ubuntu and mac.
RUN test -z $(getent group $GID | cut -d: -f1) || \
        groupmod -g $((GID+1000)) $(getent group $GID | cut -d: -f1)

RUN set -x ; addgroup -g "$GID" -S "$APPGRP" && \
  adduser \
  --disabled-password \
  -g "$GID" \
  -D \
  -s "/bin/bash" \
  -h "/home/$APPUSR" \
  -u "$UID" \
  -G "$APPGRP" "$APPUSR" && exit 0 ; exit 1

RUN echo "$APPUSR ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "export PS1=\"$PS1\"" >> /home/$APPUSR/.bashrc

USER $APPUSR
ENV USER=$APPUSR
ENV GROUP=$APPGRP

# STOP  ::: enable host to container edit of proj code on ubuntu and mac.

ADD --chown=$APPUSR:$APPGRP "." "/home/$APPUSR$PRODUCT_DIR"

# stop ::: adding OS APPUSER and APPGROUP


USER $APPUSR
WORKDIR $PRODUCT_DIR


# install awscli
RUN pip3 install --upgrade pip \
      && pip3 install --no-cache-dir awscli \
      && sudo rm -rf /var/cache/apk/* \
      && sudo apk add aws-cli \
      && aws --version

# add project folder
ADD --chown=$APPUSR:$APPGRP "." /home/$APPUSR$PRODUCT_DIR

# but use the proj root dir to write the code on and interact
WORKDIR $PRODUCT_DIR

CMD exec /bin/bash -c "/home/$APPUSR/$PRODUCT_DIR/src/bash/run/docker-init-devops.sh"
