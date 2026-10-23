#!/usr/bin/env bash
set -euo pipefail

# Reassemble individually base64-encoded parts in lexical order.
# Run from the root of a checked-out OPS repository, on Linux.
mkdir -p /tmp/ops-cyber-range
tmp=$(mktemp /tmp/ops-cyber-range.XXXXXX.tar.xz)
trap 'rm -f "$tmp"' EXIT
for part in bundle/archive.0{0,1,2,3}.b64; do
  test -s "$part" || { echo "Missing $part"; exit 1; }
  base64 -d "$part" >> "$tmp"
done

expected='82d79de71987242d195ec80960115bbccc3a8728fd62206a37004b14f9cc5bb7'
actual=$(sha256sum "$tmp" | awk '{print $1}')
if [[ "$actual" != "$expected" ]]; then
  echo "Archive integrity check failed: $actual" >&2
  exit 1
fi

echo "Verified archive SHA256: $actual"
tar -xJf "$tmp"
echo "Extracted OPS-cyber-range/ successfully."
echo "Read OPS-cyber-range/README.md and configure secrets before starting services."
