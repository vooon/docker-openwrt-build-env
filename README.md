# Docker OpenWrt Build Environment

Build [OpenWrt](https://openwrt.org/) images in a Docker container.
This is sometimes necessary when building OpenWrt on the host system fails, e.g. when some dependency is too new.
The docker image is based on Debian 12 (Bookworm).

Build tested:

- OpenWrt Master
- Openwrt-24.10.0

A smaller container based on Alpine Linux is available in the alpine branch. But it does not build the old LEDE images.

## Prerequisites

* Docker installed
* running Docker daemon
* build Docker image:

```shell
git clone https://github.com/mwarning/docker-openwrt-builder.git
cd docker-openwrt-builder
docker build -t openwrt_builder .
```

Now the docker image is available. These steps only need to be done once.

## Usage GNU/Linux

Create a build folder and link it into a new docker container:
```shell
mkdir ~/mybuild
docker run -v ~/mybuild:/home/user -it openwrt_builder /bin/bash
```

In the container console, enter:
```shell
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make -j4
```

After the build, the images will be inside `~/mybuild/openwrt/bin/target/`.

At this point you can proceed with the same commands of the Linux usage:

## Other Projects

Other, but very similar projects:

* Original source: https://github.com/mwarning/docker-openwrt-build-env
* [openwrt-docker](https://github.com/openwrt/docker) Official Docker containers to build OpenWrt!
* [openwrt-imagebuilder-action](https://github.com/izer-xyz/openwrt-imagebuilder-action)
* [docker-openwrt-buildroot](https://github.com/noonien/docker-openwrt-buildroot)
* [openwrt-docker-toolchain](https://github.com/mchsk/openwrt-docker-toolchain)
