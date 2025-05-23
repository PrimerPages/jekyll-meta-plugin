#!/usr/bin/env bats

# Load assertion helpers
load 'bats_helper.sh'

setup() {
    test_dir="$(cd "$(dirname "${BATS_TEST_FILENAME}")" && pwd)"

    tmpdir="$BATS_TMPDIR/fake_repo"
    mkdir -p "$tmpdir"
    cp "$test_dir/get_version.sh" "$tmpdir/get_version.sh"
    chmod +x "$tmpdir/get_version.sh"

    cd "$tmpdir"
}

teardown() {
    rm -rf "$tmpdir"
}

@test "extracts version from standard quoted line" {
    echo 'VERSION = "1.2.3"' >VERSION
    run ./get_version.sh
    assert_success
    assert_output "1.2.3"
}

@test "extracts version from single-quoted line" {
    echo "VERSION = '4.5.6'" >VERSION
    run ./get_version.sh
    assert_success
    assert_output "4.5.6"
}

@test "fails if version file is missing" {
    rm -f VERSION
    run ./get_version.sh
    assert_failure
    assert_output --partial "Version file not found"
}

@test "fails if version number is missing" {
    echo 'VERSION = something_else' >VERSION
    run ./get_version.sh
    assert_failure
    assert_output --partial "Could not extract version"
}
