#!/bin/bash
set -euo pipefail

VERSION_FILE="VERSION"

if [[ ! -f "$VERSION_FILE" ]]; then
  echo "Version file not found: $VERSION_FILE"
  exit 1
fi

version=$(grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' "$VERSION_FILE" | head -n 1 || true )

if [[ -z "$version" ]]; then
  echo "Could not extract version"
  exit 1
fi

echo "$version"
