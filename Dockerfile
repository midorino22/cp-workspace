FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USER_NAME=cp
ARG USER_UID=1000
ARG USER_GID=1000

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

# Create non-root user for daily development.
RUN groupadd --gid "${USER_GID}" "${USER_NAME}" \
    && useradd --uid "${USER_UID}" --gid "${USER_GID}" -m -s /bin/bash "${USER_NAME}"

USER ${USER_NAME}
WORKDIR /workspace

# Install Rust toolchain for the non-root user.
ENV PATH="/home/${USER_NAME}/.cargo/bin:${PATH}"
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y --profile minimal --default-toolchain stable

CMD ["sleep", "infinity"]
