#!/bin/bash
#------------------------------------------------------------------------------
# Purpose:
# Discover and execute all action test scripts (*.tst.sh) in the tests directory.
#------------------------------------------------------------------------------

# Resolve paths
TEST_DIR=$(cd "$(dirname "$0")" && pwd)
PROJ_ROOT=$(cd "$TEST_DIR/../../.." && pwd)

echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo " Framework Test Runner"
echo " Searching for tests in: $TEST_DIR"
echo " Project Root:          $PROJ_ROOT"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

# Always run from project root so ./run paths work correctly
cd "$PROJ_ROOT" || { echo "FATAL: Could not cd to $PROJ_ROOT"; exit 1; }

# Count tests
test_files=("$TEST_DIR"/*.tst.sh)
total_tests=${#test_files[@]}

if [[ $total_tests -eq 0 ]]; then
  echo "No test scripts (*.tst.sh) found."
  exit 0
fi

echo "Found $total_tests test(s). Starting execution..."

for tst_script in "${test_files[@]}"; do
  [[ -e "$tst_script" ]] || continue
  tst_name=$(basename "$tst_script")
  
  echo ""
  echo "╔════════════════════════════════════════════════════════════════════════"
  echo "║ EXECUTING: $tst_name"
  echo "╚════════════════════════════════════════════════════════════════════════"
  
  # Execute the test script
  # We use 'bash' explicitly to ensure it runs in a new process
  bash "$tst_script"
  
  echo "─────────────────────────────────────────────────────────────────────────"
  echo "║ COMPLETED: $tst_name"
  echo "─────────────────────────────────────────────────────────────────────────"
done

echo ""
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo " All $total_tests tests have been executed."
echo " Check the output above for any failures."
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
# run-bsh ::: v3.7.0
