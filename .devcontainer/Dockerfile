# Locked base per docs/PLANNING.md (devcontainers/cpp 3.x, Ubuntu 26.04).
FROM mcr.microsoft.com/devcontainers/cpp:3-ubuntu26.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends python3-venv \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*
