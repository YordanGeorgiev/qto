# src/bash/qto/funcs/mojo-hypnotoad-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/mojo-hypnotoad-start.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStart(){

        doMojoHypnotoadStop

        doLog "DEBUG START doMojoHypnotoadStart"


   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='prd'


   cd src/perl/qto/script
   hypnotoad  qto  &
   cd $product_instance_dir

        doLog "DEBUG STOP  doMojoHypnotoadStart"
}
# eof func doMojoHypnotoadStart


# eof file: src/bash/qto/funcs/mojo-hypnotoad-start.func.sh
