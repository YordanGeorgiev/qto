#!/usr/bin/env bash

export TERM=xterm

print_ok() {
    GREEN_COLOR="\033[0;32m"
    DEFAULT="\033[0m"
    echo -e "${GREEN_COLOR} ✔ [OK] ${1:-} ${DEFAULT}"
}

print_fail() {
    RED_COLOR="\033[0;31m"
    DEFAULT="\033[0m"
    echo -e "${RED_COLOR} ❌ [NOK] ${1:-}${DEFAULT}"
}
