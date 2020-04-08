do_provision_ssh_keys(){

   doExportJsonSectionVars $PRODUCT_DIR/cnf/env/$ENV_TYPE.env.json '.env.db'
   which expect || sudo apt-get update && sudo apt-get install -y expect

   # if the ssh key does not exist create it ...
   # the perl code for building the private key file path is :
   # my $private_key_fpath   = $ENV{"HOME"} . '/.ssh/id_rsa.qto.' . $env_type ; 
   prv_key_fpath=$HOME/.ssh/id_rsa.qto.$ENV_TYPE
   test -f $prv_key_fpath || {
   expect <<- EOF_EXPECT
      set timeout -1
      spawn ssh-keygen -t rsa -b 4096 -C $AdminEmail -f $prv_key_fpath
      expect "Enter passphrase (empty for no passphrase): "
      send -- "\r"
		expect "Enter same passphrase again: "
      send -- "\r"
      expect eof
EOF_EXPECT

      echo created the fillowing private key file : $prv_key_fpath
   }

   for env_type in `echo dev tst prd`; do 
      jwt_private_key_file=~/.ssh/qto.$env_type.jwtRS256.key
      jwt_public_key_file=~/.ssh/qto.$env_type.jwtRS256.key.pub
      echo << EOF_USING
      creating and using the following private and public key files for the Guardian's JWT's :
      $jwt_private_key_file
      $jwt_public_key_file
EOF_USING
      
      test -f $jwt_private_key_file || ssh-keygen -t rsa -b 4096 -m PEM -f $jwt_private_key_file
      test -f $jwt_public_key_file && rm -v $jwt_public_key_file
      openssl rsa -in $jwt_private_key_file -pubout -outform PEM -out $jwt_public_key_file
   done;

}
