# src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/mojo-hypnotoad-start.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStart(){

   doLog "DEBUG START doMojoHypnotoadStart"
   doMojoHypnotoadStop

   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='prd'

   # Action !!!
   hypnotoad  $product_instance_dir/src/perl/issue_tracker  &

   doLog "DEBUG STOP  doMojoHypnotoadStart"
}
# eof func doMojoHypnotoadStart


# eof file: src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh
