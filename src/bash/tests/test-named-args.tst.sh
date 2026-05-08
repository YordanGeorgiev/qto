#!/bin/bash
#------------------------------------------------------------------------------
# Purpose:
# Test Named Argument Support (--flag value).
#
# Each sub-test runs the action, then asserts the expected exit code and a
# distinctive output marker. Negative tests capture the FATAL/NOK output
# so a deliberate validation failure isn't visually confused with a real
# regression.
#------------------------------------------------------------------------------

pass=0
fail=0

assert() {
  # $1 = label, $2 = "ok"|"fail"
  if [[ "$2" == "ok" ]]; then
    echo " ✓ PASS :: $1"
    pass=$((pass + 1))
  else
    echo " ✗ FAIL :: $1"
    fail=$((fail + 1))
  fi
}

# 1. Value argument
echo "--- Test 1: Value argument (--name Yordan) ---"
out=$(./run -a test-named-args --name Yordan 2>&1)
rc=$?
if [[ $rc -eq 0 ]] && grep -q "Hello, Yordan!" <<<"$out" && grep -q "Force mode is DISABLED" <<<"$out"; then
  assert "Test 1: --name parsed, FORCE defaults off" ok
else
  echo "$out"
  assert "Test 1: --name parsed, FORCE defaults off (rc=$rc)" fail
fi

# 2. Boolean flag and value
echo "--- Test 2: Boolean flag and value (--name Yordan --force) ---"
out=$(./run -a test-named-args --name Yordan --force 2>&1)
rc=$?
if [[ $rc -eq 0 ]] && grep -q "Hello, Yordan!" <<<"$out" && grep -q "Force mode is ENABLED" <<<"$out"; then
  assert "Test 2: --name + boolean --force parsed" ok
else
  echo "$out"
  assert "Test 2: --name + boolean --force parsed (rc=$rc)" fail
fi

# 3. Missing required named argument (negative test — must fail)
echo "--- Test 3: Missing required named argument (expected to fail) ---"
out=$(./run -a test-named-args --force 2>&1)
rc=$?
if [[ $rc -ne 0 ]] && grep -q 'Required parameter NAME is not set' <<<"$out"; then
  assert "Test 3: missing NAME correctly rejected (rc=$rc)" ok
else
  echo "$out"
  assert "Test 3: missing NAME should have been rejected (rc=$rc)" fail
fi

# 4. Custom getopts parsing
echo "--- Test 4: Custom action parsing (getopts) ---"
out=$(./run -a test-custom-args -n "Custom User" -f 2>&1)
rc=$?
if [[ $rc -eq 0 ]] && grep -q "Custom Parse Result: Name=Custom User, Force=true" <<<"$out"; then
  assert "Test 4: custom getopts parsed -n / -f" ok
else
  echo "$out"
  assert "Test 4: custom getopts parsed -n / -f (rc=$rc)" fail
fi

echo "--- Summary: $pass passed, $fail failed ---"
[[ $fail -eq 0 ]]
# run-bsh ::: v3.8.2
