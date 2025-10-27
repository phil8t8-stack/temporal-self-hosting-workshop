#!/usr/bin/env bash
set -euo pipefail
CLUSTER_NAME=${KIND_CLUSTER_NAME:-dev}
if ! kind get clusters | grep -qx "$CLUSTER_NAME"; then
  kind create cluster --name "$CLUSTER_NAME" --config .devcontainer/kind-config.yaml
fi
# Write kubeconfig to the workspace so both the container and your host can use it
kind get kubeconfig --name "$CLUSTER_NAME" > /workspaces/.kube/dev-kind.yaml