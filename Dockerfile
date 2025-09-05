# Use a base image that is the latest stable Debian release, Trixie
FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive
# Set environment variables for the cross-compilation toolchain
ENV ARCH=arm64
ENV CROSS_COMPILE=aarch64-linux-gnu-

# Install essential build tools and dependencies
RUN apt-get update && apt-get install -y \
    git \
    make \
    gcc-aarch64-linux-gnu \
    bc \
    bison \
    flex \
    libssl-dev \
    libncurses-dev \
    xz-utils \
    wget \
    patch \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /build

# The rest of the kernel build process will be performed in a separate script
# or by the user running commands in the container.
