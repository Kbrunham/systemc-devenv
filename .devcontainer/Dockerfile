# Locked base per docs/PLANNING.md (devcontainers/cpp, Ubuntu 24.04).
FROM mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends python3-venv \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*
