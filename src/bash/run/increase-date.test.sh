# src/bash/qto/funcs/increase-date.test.sh

doTestIncreaseDate() {
  set -eu
  sleep "$sleep_interval"
  run -a increase-date
  test $_rc -ne 0 && return
}
