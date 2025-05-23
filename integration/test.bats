#!/usr/bin/env bats

# Load assertion helpers
load '../.github/scripts/bats_helper.sh'

run_test_for_site() {
  local site="$1"
  local expected_version="$2"

  pushd "$site" >/dev/null

  run bundle install
  assert_success "Could not install bundle"

  run bundle exec jekyll build
  assert_success "Could not build Jekyll site"
  assert_output_contains "done in"

  run grep "Jekyll Version:" _site/index.html
  assert_output_contains "Jekyll Version: $expected_version"

  popd >/dev/null
}

@test "github-pages builds and outputs 3.10.0" {
  run_test_for_site "$BATS_TEST_DIRNAME/github-pages" "3.10.0"
}

@test "jekyll-version builds and outputs $JEKYLL_VERSION" {
  run_test_for_site "$BATS_TEST_DIRNAME/jekyll-version" "$JEKYLL_VERSION"
}
