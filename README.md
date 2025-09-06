Cross-compiling a Real-time Kernel for Raspberry Pi with Docker
This guide provides a Docker-based workflow for cross-compiling a real-time (RT) Linux kernel for the Raspberry Pi. This approach uses the Trixie Debian base to ensure a clean, isolated, and reproducible build environment on any system that supports Docker.

Prerequisites
Docker: Ensure Docker is installed on your machine.

Source Files: Have your kernel source code and the PREEMPT_RT patch file in the same directory as the Dockerfile.

1. Build the Docker Image
First, you need to build the Docker image from the provided Dockerfile. This will create a container with all the necessary cross-compilation tools.

```Bash
docker build -t rpi-rt-kernel-builder
```

The -t flag tags the image with a name (rpi-rt-kernel-builder) for easy reference.


2. Run the Container and Compile the Kernel
Run the container in an interactive mode and mount your current directory as the build environment. This allows the container to access your kernel source and save the output.

```Bash
docker run --rm -it -v "$(pwd)":/build antnic/arm64-cross /bin/bash
```
Once inside the container's shell, follow these steps to compile and package the kernel.

a. Clone the Kernel Source

Use a recent stable branch, for example rpi-6.6.y.

```Bash
git clone --depth=1 --branch rpi-6.12.y https://github.com/raspberrypi/linux.git
cd linux
```

b. Apply the Real-time Patch

Download a matching patch from kernel.org and apply it.

```Bash
wget https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/patch-6.12.43-rt12.patch.gz
gunzip patch-6.12.43-rt12.patch.gz
patch -p1 < patch-6.12.43-rt12.patch
```

c. Configure the Kernel

Configure the kernel for your Raspberry Pi model and enable real-time features.

```Bash
make bcm2711_defconfig
./scripts/config --file .config --enable PREEMPT_RT_FULL
```

d. Build the Debian Package

This command will compile the kernel and create .deb packages in the parent directory.

```Bash
make -j$(nproc) deb-pkg
```

3. Install the Kernel on the Raspberry Pi
After the make deb-pkg command completes, you can exit the container. The linux-image-*.deb and linux-headers-*.deb files will be in your local directory.

Copy the .deb files to your Raspberry Pi via scp or a USB drive.

Install the packages on the Pi using dpkg.

```Bash
sudo dpkg -i linux-image-*.deb linux-headers-*.deb
```

Reboot to use the new kernel.







https://dev.to/behainguyen/raspberry-pi-4b-natively-build-a-64-bit-fully-preemptible-kernel-real-time-with-desktop-1afj