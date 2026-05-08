#!/bin/bash
#------------------------------------------------------------------------------
# Purpose:
# Test Execution Lifecycle Hooks (PRE/POST).
#------------------------------------------------------------------------------

# 1. Test successful action with hooks
echo "--- Test 1: Successful action with hooks ---"
./run -a test-hooks

# 2. Test failed action with hooks (POST should still run)
echo "--- Test 2: Failed action with hooks (POST should still run) ---"
FAIL_ACTION=true ./run -a test-hooks
# run-bsh ::: v3.7.0
