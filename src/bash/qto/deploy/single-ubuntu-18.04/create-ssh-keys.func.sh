#!/bin/bash

do_create_ssh_keys(){


   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PRODUCT_DIR/cnf/env/$ENV.env.json"
   source $PRODUCT_DIR/lib/bash/funcs/export-json-section-vars.sh
   do_export_json_section_vars $PROJ_CONF_FILE '.env.aws'

   which expect || sudo apt-get update && sudo apt-get install -y expect


   for ENV in `echo dev tst prd`; do
      jwt_private_key_file=~/.ssh/qto.$ENV.jwtRS256.key
      jwt_public_key_file=~/.ssh/qto.$ENV.jwtRS256.key.pub
      echo << EOF_USING
      creating and using the following private and public key files for the Guardian's JWT's :
      $jwt_private_key_file
      $jwt_public_key_file
EOF_USING

      test -f $jwt_private_key_file || ssh-keygen -t rsa -b 4096 -m PEM -f $jwt_private_key_file -N ''
      test -f $jwt_public_key_file && rm -v $jwt_public_key_file
      openssl rsa -in $jwt_private_key_file -pubout -outform PEM -out $jwt_public_key_file
   done;



   private_ssh_key_fpath_no_env=$(echo $private_ssh_key_fpath|rev|cut -c 5-|rev)
   private_ssh_key_fpath_no_env=$(eval echo $private_ssh_key_fpath_no_env)


   for ENV in `echo dev tst prd`; do
      test -f $private_ssh_key_fpath_no_env'.'$ENV || {
         ssh-keygen -q -t rsa -b 4096 -N '' -f $private_ssh_key_fpath_no_env.$ENV <<< ""$'\n'"y" 2>&1 >/dev/null
      }
   done

}
