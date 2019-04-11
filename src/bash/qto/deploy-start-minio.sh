#!/bin/bash

set -eu -o pipefail # fail on error , debug all lines

set -x 

# run as root
#[ "$USER" = "root" ] || exec sudo "$0" "$@"

doWgetMinioBins(){
	test -f /root/minio || wget -O /root/minio https://dl.minio.io/server/minio/release/linux-amd64/minio
	test -f /root/mc || wget -O /root/mc https://dl.minio.io/client/mc/release/linux-amd64/mc
   chmod 755 /root/minio
   chmod 755 /root/mc
   ls -la /root/minio
   ls -la /root/mc
}

echo "installing the must-have pre-requisites"
while read -r p ; do
   if [ "" == "`which $p`" ]; then 
      doWgetMinioBins
   fi
done < <(cat << "EOF01"
	grep
	lsof
	pgrep
	openssl
	minio
EOF01
)


export minio_data_dir='/tmp/minio-data'

# set credentials for the server
export MINIO_ACCESS_KEY='N9Z4W68XW0YM7P9MF6WG'
export MINIO_SECRET_KEY='R2g5sRfT1xou2xfaMoq+pQrLLIB8+erOVRhtNg2F'
export MINIO_REGION="local_region"

echo MINIO_ACCESS_KEY: $MINIO_ACCESS_KEY
echo MINIO_SECRET_KEY: $MINIO_SECRET_KEY
echo MINIO_REGION: $MINIO_REGION

mkdir -p ~/etc/ ; cat << "EOF02" > ~/etc/openssl.conf
[req]
distinguished_name = req_localhost
x509_extensions = v3_req
prompt = no

[req_localhost]
C = FI
ST = UU
L = Helsinki
O = Corp
OU = org
CN = localhost

[v3_req]
subjectAltName = @alt_names

[alt_names]
IP.1 = 127.0.0.1
EOF02

test $(pgrep minio|wc -l) -gt 0 && kill -9 $(pgrep minio) # kill if running

mkdir -p ~/.minio/certs/ ;
test -f ~/.minio/certs/private.key && rm -v ~/.minio/certs/private.key
openssl genrsa -out ~/.minio/certs/private.key 2048

test -f ~/.minio/certs/public.crt && rm -v ~/.minio/certs/public.crt
openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout ~/.minio/certs/private.key \
   -out ~/.minio/certs/public.crt -config ~/etc/openssl.conf

/root/minio server "$minio_data_dir" 2>&1 &  # and start the server

export CONFIG_S3_BUCKET_NAME='org-bucket'
export CONFIG_S3_ENDPOINT='https://127.0.0.1:9000'
export CONFIG_S3_ACCESS_KEY=$MINIO_ACCESS_KEY
export CONFIG_S3_SECRET_KEY=$MINIO_SECRET_KEY
export CONFIG_S3_REGION=$MINIO_REGION
export CONFIG_S3_DISABLE_SSL_CHECK='true'

echo CONFIG_S3_BUCKET_NAME: $CONFIG_S3_BUCKET_NAME
echo CONFIG_S3_ENDPOINT: $CONFIG_S3_ENDPOINT
echo CONFIG_S3_ACCESS_KEY: $CONFIG_S3_ACCESS_KEY
echo CONFIG_S3_SECRET_KEY: $CONFIG_S3_SECRET_KEY
echo CONFIG_S3_REGION: $CONFIG_S3_REGION
echo CONFIG_S3_DISABLE_SSL_CHECK: $CONFIG_S3_DISABLE_SSL_CHECK

export MINIO_HOST_ALIAS='minio_host_alias'
# register the host alias
/root/mc config host add $MINIO_HOST_ALIAS "$CONFIG_S3_ENDPOINT" "$CONFIG_S3_ACCESS_KEY" \
	"$CONFIG_S3_SECRET_KEY" --api S3v4

# create the bucket
/root/mc --insecure mb --region "$MINIO_REGION" "$MINIO_HOST_ALIAS/$CONFIG_S3_BUCKET_NAME"

# configure the policies on the bucket
/root/mc --insecure policy upload "$MINIO_HOST_ALIAS/$CONFIG_S3_BUCKET_NAME"
/root/mc --insecure policy download "$MINIO_HOST_ALIAS/$CONFIG_S3_BUCKET_NAME"
/root/mc --insecure policy public "$MINIO_HOST_ALIAS/$CONFIG_S3_BUCKET_NAME"
/root/mc --insecure policy list "$MINIO_HOST_ALIAS/$CONFIG_S3_BUCKET_NAME"

# ls the buckets in the host alias
/root/mc --insecure ls $MINIO_HOST_ALIAS

# copy the resource file ysg:todo add livy.conf to this script
/root/mc --insecure cp main/src/test/resources/livy/livy.conf $MINIO_HOST_ALIAS/$CONFIG_S3_BUCKET_NAME

# and verify it is there
/root/mc --insecure stat $MINIO_HOST_ALIAS/org-bucket/livy.conf

mkdir -p ~/.aws/s3cmd/ ; cat << EOF03 > ~/.aws/s3cmd/minio_local.s3cfg
  host_base = 127.0.0.1:9000
  host_bucket = org-bucket
  bucket_location = local_region
  use_https = True
  access_key =  N9Z4W68XW0YM7P9MF6WG
  secret_key = R2g5sRfT1xou2xfaMoq+pQrLLIB8+erOVRhtNg2F
  signature_v2 = False
EOF03

# run those manually
# test $(which s3cmd|wc -l) -gt 0 && \
#   s3cmd ls --no-check-certificate -r -c ~/.aws/s3cmd/minio_local.s3cfg
# "s3://$CONFIG_S3_BUCKET_NAME"

#AWS_ACCESS_KEY="$MINIO_ACCESS_KEY"
#AWS_SECRET_KEY="$MINIO_SECRET_KEY"
#aws s3 ls --region "$MINIO_REGION" --endpoint-url "$CONFIG_S3_ENDPOINT" --no-verify-ssl true


