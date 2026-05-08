#!/bin/bash
#------------------------------------------------------------------------------
# Purpose:
# Test Decentralized Argument Parsing hooks (_args).
#------------------------------------------------------------------------------

# Ensure we are in project root
cd "$(dirname "$0")/../../.." || exit 1

echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo " Testing Decentralized Argument Parsing"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

# 1. Test standard Helper Parsing
# File: src/bash/run/test-named-args.func.sh
# Logic: do_parse_args "$@"
echo ""
echo "--- Case 1: standard Helper (--name, --force) ---"
./run -a test-named-args --name "standard User" --force

# 2. Test Custom getopts Parsing
# File: src/bash/run/test-custom-args.func.sh
# Logic: custom getopts loop
echo ""
echo "--- Case 2: Custom getopts (-n, -f) ---"
./run -a test-custom-args -n "Custom User" -f

# 3. Test Argument Persistence (Ensure _args hook exports to main action)
echo ""
echo "--- Case 3: Verify required arg validation via _args hook ---"
./run -a test-named-args --name "Validator"
# run-bsh ::: v3.7.0
