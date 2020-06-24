#------------------------------------------------------------------------------
# usage example:
# source $PRODUCT_INSTANCE_DIR/lib/bash/funcs/flush-screen.sh
# do_flush_screen
#
# if you have sourced $PRODUCT_INSTANCE_DIR/lib/bash/funcs/export-json-section-vars.sh before,
# then this function is also imported, so sourcing again is not necessary
#------------------------------------------------------------------------------
do_flush_screen(){
	printf "\033[2J";printf "\033[0;0H"
}