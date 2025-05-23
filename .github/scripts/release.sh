#!/bin/bash
set -euo pipefail

# === CONFIG ===
RUBYGEMS_HOST="https://rubygems.org"
GEMSPEC_FILE=""

# === Functions ===

# Automatically detect the only .gemspec file in the current directory
detect_gemspec_file() {
  local count
  count=$(find . -maxdepth 1 -name '*.gemspec' | wc -l)

  if [[ "$count" -ne 1 ]]; then
    echo "Expected exactly one .gemspec file in the root directory, found $count."
    exit 1
  fi

  GEMSPEC_FILE=$(find . -maxdepth 1 -name '*.gemspec' | head -n1)
  echo "Detected gemspec: $GEMSPEC_FILE"
}

# Load environment variables from .env if available
load_env_file() {
  local env_file=".env"
  if [[ -f "$env_file" ]]; then
    echo "Loading environment variables from $env_file..."
    set -a
    source "$env_file"
    set +a
  fi
}

# Extract the gem name from the gemspec
get_gem_name() {
  ruby -e 'spec = eval(File.read(ARGV[0])); puts spec.name' "$1"
}

# Ensure RUBYGEMS_API_KEY is set
setup_rubygems_credentials() {
  if [[ -z "${RUBYGEMS_API_KEY:-}" ]]; then
    echo "RUBYGEMS_API_KEY environment variable is not set."
    exit 1
  fi

  mkdir -p ~/.gem
  echo -e "---\n:rubygems_api_key: $RUBYGEMS_API_KEY" > ~/.gem/credentials
  chmod 0600 ~/.gem/credentials

  # Cleanup credentials file on exit
  trap 'rm -f ~/.gem/credentials' EXIT
  echo "Ruby gem credentials set up"
}

# Build the gem and return the file name
build_gem() {
  local gemspec_file="$1"

  if [[ ! -f "$gemspec_file" ]]; then
    echo "Gemspec file '$gemspec_file' not found."
    exit 1
  fi

  local gem_file
  gem_file=$(gem build "$gemspec_file" | awk '/File:/ { print $2 }')

  if [[ -z "$gem_file" || ! -f "$gem_file" ]]; then
    echo "Failed to build gem. Check your gemspec."
    exit 1
  fi

  echo "$gem_file"
}

# Upload the gem to RubyGems unless it's a dry run
upload_gem() {
  local gem_file="$1"
  local gem_name

  gem_name=$(get_gem_name "$gem_file")

  echo "Released $gem_file to $RUBYGEMS_HOST/gems/$gem_name"
  echo "Publishing $gem_file to RubyGems..."
  gem push "$gem_file" --host "$RUBYGEMS_HOST"
  echo "Released $gem_file to $RUBYGEMS_HOST/gems/$gem_name"
}

# === Main ===

dry_run=false

if [[ "$#" -eq 1 ]]; then
  if [[ "$1" == "--dry-run" ]]; then
    dry_run=true
  else
    echo "Unknown argument: $1"
    echo "Usage: $0 [--dry-run]"
    exit 1
  fi
elif [[ "$#" -gt 1 ]]; then
  echo "Too many arguments."
  echo "Usage: $0 [--dry-run]"
  exit 1
fi

# Check for DRY_RUN in environment (only if not already set by CLI)
if [[ "$dry_run" == "false" && "${DRY_RUN:-}" == "true" ]]; then
  dry_run=true
fi

echo "Starting release for $GEMSPEC_FILE"

load_env_file
if [[ "$dry_run" == true ]]; then
  echo "[DRY RUN] Skipping credential setup"
else
  setup_rubygems_credentials
fi

detect_gemspec_file
gem_file=$(build_gem "$GEMSPEC_FILE")
echo "Generated gem file: $gem_file"

if [[ "$dry_run" == true ]]; then
  echo "[DRY RUN] Skipping gem push for $gem_file"
else
  upload_gem "$gem_file" "$dry_run"
fi
