# src/bash/qto/funcs/increase-date.test.sh

doTestIncreaseDate(){
   set -eu
	sleep "$sleep_interval"
   bash src/bash/qto/qto.sh -a increase-date
   test $exit_code -ne 0 && return
}


