process_help_cmd_args () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
       -h|-help) usage; exit 1 ;;
    -v|-verbose) verbose=1 && shift ;;
      -d|-debug) debug=1 && addSbt "-debug" && shift ;;
              *) addResidual "$1" && shift ;;
    esac
  done
}


# src: https://certbot.eff.org/lets-encrypt/ubuntubionic-other
# the install is in the bootstrap
sudo certbot certonly --webroot

sudo openssl pkey -in /etc/letsencrypt/live/qto.fi/privkey.pem -out \
   /etc/letsencrypt/live/qto.fi/privkey.key

sudo openssl x509 -outform der -in /etc/letsencrypt/live/qto.fi/fullchain.pem -out \
   /etc/letsencrypt/live/qto.fi/fullchain.crt


