#!/bin/bash

set -x

test -z ${PRODUCT:-} && PRODUCT=qto
test -z ${APPUSER:-} && APPUSER=appusr


trap : TERM INT; sleep infinity & wait
