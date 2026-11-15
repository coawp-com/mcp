#!/usr/bin/env bash
# downloads the pinned mcp-publisher release ($MCP_PUBLISHER_VERSION), checks its sigstore signature against the
# registry's own release workflow, and leaves ./mcp-publisher. needs cosign on the path
set -euo pipefail
os="$(uname -s | tr '[:upper:]' '[:lower:]')"
arch="$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')"
archive="mcp-publisher_${os}_${arch}.tar.gz"
base_url="https://github.com/modelcontextprotocol/registry/releases/download/${MCP_PUBLISHER_VERSION}"
curl --fail --location --silent --show-error --output "$archive" "$base_url/$archive"
curl --fail --location --silent --show-error --output "$archive.sigstore.json" "$base_url/$archive.sigstore.json"
cosign verify-blob \
  --bundle "$archive.sigstore.json" \
  --certificate-identity "https://github.com/modelcontextprotocol/registry/.github/workflows/release.yml@refs/tags/${MCP_PUBLISHER_VERSION}" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
  "$archive"
tar xzf "$archive" mcp-publisher
rm -f "$archive" "$archive.sigstore.json"
./mcp-publisher --version
