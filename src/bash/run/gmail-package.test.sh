# src/bash/qto/funcs/gmail-package.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestGmailPackage comments ...
# ---------------------------------------------------------
do_test_gmail_package(){

   do_log "DEBUG START doTestGmailPackage"

   cat doc/txt/qto/tests/pckg/gmail-package.test.txt
   sleep "$sleep_interval"

   bash src/bash/qto/qto.sh -a create-full-package -a gmail-package
   sleep "$sleep_interval"
   source $PRODUCT_INSTANCE_DIR/lib/bash/funcs/flush-screen.sh
   do_flush_screen

   do_log "DEBUG STOP  doTestGmailPackage"
}
# eof func doTestGmailPackage


# eof file: src/bash/qto/funcs/gmail-package.test.sh
