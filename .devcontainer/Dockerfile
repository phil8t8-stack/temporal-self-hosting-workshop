FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    ca-certificates \
    curl \
    gnupg

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces/install

RUN mkdir -p /workspaces/.kube \
    && chmod 777 /workspaces/.kube
RUN mkdir -p /workspaces/.temporal \
    && chmod 777 /workspaces/.temporal

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Install k3d
RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

# Install Temporal CLI
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl tar && rm -rf /var/lib/apt/lists/* \
 && curl -fsSL "https://temporal.download/cli/archive/latest?platform=linux&arch=arm64" \
 | tar -xz -C /usr/local/bin temporal \
 && chmod +x /usr/local/bin/temporal