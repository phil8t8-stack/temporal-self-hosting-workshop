#!/usr/bin/env bash
set -euo pipefail

# Start the k3d cluster
if [[ "$(k3d cluster list)" == *"dev"* ]]; then
    k3d cluster start dev
else
    # k3d cluster create dev -p "0:80@loadbalancer" -p "0:443@loadbalancer"
    k3d cluster create dev -p "8080:30080@server:0" -p "7233:30233@server:0"
fi

# Generate the kubeconfig for the cluster
k3d kubeconfig get dev > /workspaces/.kube/dev.yaml

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install postgresql bitnami/postgresql --version 18.1.2 \
    -f .devcontainer/postgres-values.yaml

# Add the Temporal Helm repository
helm repo add temporalio https://temporalio.github.io/helm-charts

mkdir -p /workspaces/.temporal \
    && chmod 777 /workspaces/.temporal

helm template temporal temporalio/temporal --version 0.68.1 \
    -f .devcontainer/temporal-values.yaml > /workspaces/.temporal/manifest.yaml

# Install Temporal using Helm
helm install temporal temporalio/temporal --version 0.68.1 \
    -f .devcontainer/temporal-values.yaml \
    --wait --timeout 5m
