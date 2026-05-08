#!/bin/bash
#------------------------------------------------------------------------------
# Purpose:
# Test all possible ways to call the 'help-with' action.
#------------------------------------------------------------------------------

# 1. Test with the long action name (environment variable way)
echo "--- Test 1: SRCH=log ./run -a do_help_with ---"
SRCH=log ./run -a do_help_with

# 2. Test with the short action name (hyphenated)
echo "--- Test 2: SRCH=config ./run -a help-with ---"
SRCH=config ./run -a help-with

# 3. Test with a non-existent term
echo "--- Test 3: SRCH=nonexistent ./run -a help-with ---"
SRCH=nonexistent ./run -a help-with

# 4. Test without the SRCH variable (should fail)
echo "--- Test 4: ./run -a help-with (no SRCH) ---"
./run -a help-with
# run-bsh ::: v3.7.0
