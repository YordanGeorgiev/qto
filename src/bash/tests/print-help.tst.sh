#!/bin/bash
#------------------------------------------------------------------------------
# Purpose:
# Test all possible ways to call the 'print-help' action.
#------------------------------------------------------------------------------

# 1. Test using the main framework --help flag
echo "--- Test 1: ./run --help ---"
./run --help

# 2. Test using the main framework -h flag
echo "--- Test 2: ./run -h ---"
./run -h

# 3. Test using the explicit action name
echo "--- Test 3: ./run -a do_print_help ---"
./run -a do_print_help

# 4. Test using the hyphenated action name
echo "--- Test 4: ./run -a print-help ---"
./run -a print-help
# run-bsh ::: v3.7.0
