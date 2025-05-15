Docker OpenWrt Build Environment
================================

Build [OpenWrt](https://openwrt.org/) images in a Docker container.
This is sometimes necessary when building OpenWrt on the host system fails, e.g. when some dependency is too new.
The docker image is based on Debian 12 (Bookworm).

Build tested:

- OpenWrt Master
- Openwrt-24.10.0


Prerequisites
-------------

* Docker or Podman installed
* Linux host

You can use pre-built image from this ghcr.io repo, or build it yourself.

### Build using Docker

```shell
docker build -t owrt-builder:latest .
```

### Build using Podman

Simple:
```shell
podman build -t owrt-builder:latest .
```

Using Quadlet (a podman's systemd integration):
```shell
mkdir -p ~/.config/containers/systemd
cp ./owrt-builder.build ~/.config/containers/systemd
edit ~/.config/containers/systemd/owrt-builder.build  # ensure you have correct file path
systemctl daemon-reload --user
```

> [!NOTE]
> Podman require absolute pathes.
> Personally I still keep all OpenWRT things in `~/build/LEDE`.


Usage GNU/Linux
---------------

### Using Docker

Create a build folder and link it into a new docker container:

```shell
mkdir ~/mybuildws
docker run --rm --name owrt-builder -v ~/mybuildws:/home/user/ws -it owrt-builder:latest /bin/bash
```

### Using Podman

A simple container could be made similar to docker, just replace command to `podman run ...`.
But that means you have to remember all that long list of options, so I prefer to use Quadlet:

```shell
mkdir -p ~/.config/containers/systemd
cp ./owrt-builder.container ~/.config/containers/systemd
edit ~/.config/containers/systemd/owrt-builder.container  # ensure you have correct file path
systemctl daemon-reload --user
systemctl --user start owrt-builder.service
podman exec -ti owrt-builder bash
```

> [!NOTE]
> I mount additionally `.gitconfig`, `.ssh`, `.config` to be able to push directly from the container.
> In addition I use rootless container, with the same user id and --userns=keep-id, to have everything the same as on my main system.

### Build

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

## Other Projects

Other, but very similar projects:

* Original source: https://github.com/mwarning/docker-openwrt-build-env
* [openwrt-docker](https://github.com/openwrt/docker) Official Docker containers to build OpenWrt!
* [openwrt-imagebuilder-action](https://github.com/izer-xyz/openwrt-imagebuilder-action)
* [docker-openwrt-buildroot](https://github.com/noonien/docker-openwrt-buildroot)
* [openwrt-docker-toolchain](https://github.com/mchsk/openwrt-docker-toolchain)
