FROM fedora:42

LABEL org.opencontainers.image.description "OpenWRT build environment"

RUN true \
 && dnf update -y \
 && dnf install -y --setopt install_weak_deps=False --skip-broken \
    bash-completion bzip2 file gcc gcc-c++ git-core make ncurses-devel patch \
    rsync tar unzip wget which diffutils python3 python3-setuptools perl-base \
    perl-Data-Dumper perl-File-Compare perl-File-Copy perl-FindBin perl-open \
    perl-IPC-Cmd perl-JSON-PP perl-lib perl-Thread-Queue perl-Time-Piece \
    qemu-img qemu-tools curl zstd \
    vim tree most tig colordiff \
 && dnf clean all

RUN useradd -m user \
 && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

# set system wide dummy git config
RUN git config --system user.name "user" && git config --system user.email "user@example.com"

USER user
WORKDIR /home/user
