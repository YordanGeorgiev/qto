# src/bash/qto/funcs/increase-date.test.sh

doTestIncreaseDate() {
  set -eu
  sleep "$sleep_interval"
  run -a increase-date
  test $exit_code -ne 0 && return
}
