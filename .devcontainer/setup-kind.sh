#!/usr/bin/env bash
set -euo pipefail
# Install kind
if ! command -v kind >/dev/null 2>&1; then
  ARCH=$(uname -m)
  case "$ARCH" in
    x86_64) KIND_ARCH=amd64 ;;
    aarch64|arm64) KIND_ARCH=arm64 ;;
    *) echo "Unsupported arch: $ARCH" >&2; exit 1 ;;
  esac
  VERSION=${KIND_VERSION:-v0.23.0}
  curl -fsSL -o /usr/local/bin/kind "https://kind.sigs.k8s.io/dl/${VERSION}/kind-linux-${KIND_ARCH}"
  chmod +x /usr/local/bin/kind
fi
mkdir -p /workspaces/.kube

.devcontainer/start-kind.sh