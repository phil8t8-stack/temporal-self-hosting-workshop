#!/usr/bin/env bash
set -euo pipefail

# Start the k3d cluster
if k3d cluster list | grep -q '^dev\s'; then
  echo "k3d cluster 'dev' already exists"
  k3d cluster start dev
else
  # Map host ports -> cluster nodeports
  k3d cluster create dev \
    -p "8080:30080@server:0" \
    -p "7233:30233@server:0" \
    -p "3000:30000@server:0" \
    --wait --timeout 120s

  # Generate the kubeconfig for the cluster
  k3d kubeconfig get dev > /workspaces/.kube/dev.yaml

  helm repo add bitnami https://charts.bitnami.com/bitnami
  echo "Installing PostgreSQL via Helm chart..."
  helm install postgresql bitnami/postgresql --version 18.1.2 \
      -f .devcontainer/postgres-values.yaml \
      --wait --timeout 5m

  # Add the Temporal Helm repository
  helm repo add temporalio https://temporalio.github.io/helm-charts

  if [[ ! -d /workspaces/.temporal ]]; then
    mkdir -p /workspaces/.temporal
    chmod 777 /workspaces/.temporal
  fi

  helm template temporal temporalio/temporal --version 0.68.1 \
      -f .devcontainer/temporal-values.yaml > /workspaces/.temporal/manifest.yaml

  # Install Temporal using Helm
  echo "Installing Temporal via Helm chart..."
  helm install temporal temporalio/temporal --version 0.68.1 \
      -f .devcontainer/temporal-values.yaml \
      --wait --timeout 5m
fi
