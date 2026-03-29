FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG APPUSER=root

# Base packages for competitive programming development.
# Add future tools by extending this apt install block.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        build-essential \
        ca-certificates \
        clang \
        cmake \
        curl \
        gdb \
        git \
        pkg-config \
        python3 \
        python3-pip \
        python3-venv \
        unzip \
    && rm -rf /var/lib/apt/lists/*

USER root
WORKDIR /workspace

# Expose selected app user as env for tools/scripts.
ENV APPUSER=${APPUSER}

# Install Rust toolchain for root user.
ENV PATH="/root/.cargo/bin:${PATH}"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --profile minimal --default-toolchain stable

CMD ["sleep", "infinity"]
