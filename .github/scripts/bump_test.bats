#!/usr/bin/env bats

# Load assertion helpers
load 'bats_helper.sh'

setup() {
  # Absolute path to the directory where the current test file lives
  test_dir="$(cd "$(dirname "${BATS_TEST_FILENAME}")" && pwd)"

  tmpdir="$BATS_TMPDIR/fake_repo"
  mkdir -p "$tmpdir"

  # Copy bump.sh into the temp test repo
  cp "$test_dir/bump.sh" "$tmpdir/bump.sh"
  chmod +x "$tmpdir/bump.sh"

  cd "$tmpdir"
}

teardown() {
  rm -rf "$tmpdir"
}

@test "bump.sh updates quoted version" {
  echo 'VERSION = "1.2.3"' > VERSION
  run ./bump.sh 2.0.0
  assert_success
  run grep VERSION VERSION
  assert_output 'VERSION = "2.0.0"'
}

@test "bump.sh updates unquoted version" {
  echo 'VERSION = 1.2.3' > VERSION
  run ./bump.sh 2.0.0
  assert_success
  run grep VERSION VERSION
  assert_output 'VERSION = 2.0.0'
}

@test "bump.sh updates bare version line" {
  echo '1.2.3' > VERSION
  run ./bump.sh 2.0.0
  assert_success
  run cat VERSION
  assert_output '2.0.0'
}

@test "bump.sh rejects invalid version" {
  echo 'VERSION = "1.2.3"' > VERSION
  run ./bump.sh "v2.0"
  assert_failure
  assert_output --partial "Invalid version format"
}
