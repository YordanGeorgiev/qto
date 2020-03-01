# ---------------------------------------------------------
# create a new <<env-type>> from this product instance
# bash src/bash/qto/qto.sh -a cp-to-env=dev -f met/.dev.qto
# bash src/bash/qto/qto.sh -a cp-to-env=tst -f src/bash/qto/qto.sh
# bash src/bash/qto/qto.sh -a cp-to-env=prd -f met/.dev.qto
# ---------------------------------------------------------
doCpToEnv(){
   tgt_env="${1:-}"
   prefix='cp-to-env='
   tgt_env=${tgt_env#$prefix}

	tgt_environment_name=$(echo $environment_name | perl -ne "s/$ENV_TYPE/$tgt_env/g;print")
	tgt_PRODUCT_INSTANCE_DIR=$product_dir/$tgt_environment_name

   # do ALWAYS open the met/<<current-env>> when calling this func !!!
   for env in `echo dev tst prd`; do cp -v met/.$ENV_TYPE.qto met/.$env.qto ; done ;
   for env in `echo dev tst prd`; do cp -v met/.$ENV_TYPE.qto $tgt_PRODUCT_INSTANCE_DIR/met/.$env.qto ; done ;
	test "$tgt_env" == "$env_type" && return

   relative_fpath=$(dirname "${file}")
   tgt_file=$tgt_PRODUCT_INSTANCE_DIR/$file
   mkdir -p $(dirname $tgt_file)
   cp -v $file $tgt_file
}
