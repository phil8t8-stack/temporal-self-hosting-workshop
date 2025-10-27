FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG TARGETARCH

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl gnupg tar \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces/install

RUN mkdir -p /workspaces/.kube \
    && chmod 777 /workspaces/.kube
RUN mkdir -p /workspaces/.temporal \
    && chmod 777 /workspaces/.temporal

RUN curl -fsSL -o /usr/local/bin/kubectl \
      "https://dl.k8s.io/release/$(curl -fsSL https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" \
 && chmod +x /usr/local/bin/kubectl

# Install k3d
RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

RUN curl -fsSL "https://temporal.download/cli/archive/latest?platform=linux&arch=${TARGETARCH}" \
    | tar -xz -C /usr/local/bin temporal \
    && chmod +x /usr/local/bin/temporal
