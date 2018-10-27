# src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/mojo-hypnotoad-start.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStart(){

        doMojoHypnotoadStop

        doLog "DEBUG START doMojoHypnotoadStart"


   export MOJO_MODE="$env_type"
   test -z "$MOJO_MODE" && export MOJO_MODE='prd'


        # Action !!!
   cd src/perl/issue_tracker/script
   hypnotoad  issue_tracker  &
   cd $product_instance_dir

        doLog "DEBUG STOP  doMojoHypnotoadStart"
}
# eof func doMojoHypnotoadStart


# eof file: src/bash/issue-tracker/funcs/mojo-hypnotoad-start.func.sh
