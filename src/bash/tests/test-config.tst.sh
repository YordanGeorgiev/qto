#!/bin/bash
#------------------------------------------------------------------------------
# Purpose:
# Test all possible ways to call the 'test-config' action and verify priority.
#------------------------------------------------------------------------------

# 1. Test with existing lde environment and ysg user (should be user_val)
echo "--- Test 1: ENV=lde USER=ysg ./run -a test-config ---"
ENV=lde USER=ysg ./run -a test-config

# 2. Test with a different environment (should load different env vars if they existed)
echo "--- Test 2: ENV=other_env USER=ysg ./run -a test-config ---"
ENV=other_env USER=ysg ./run -a test-config

# 3. Test with no ENV or USER (should only load project.cnf)
echo "--- Test 3: ENV=none USER=none ./run -a test-config ---"
ENV=none USER=none ./run -a test-config

# 4. Test calling via hyphenated name
echo "--- Test 4: ./run -a test-config ---"
./run -a test-config
# run-bsh ::: v3.7.0
