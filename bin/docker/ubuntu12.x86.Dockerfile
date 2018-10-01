FROM i386/ubuntu:12.04
MAINTAINER Maxim Suslov
LABEL vendor="Luxoft GmbH" \
      com.luxoft.version="0.1.0" \
      com.luxoft.release-date="2018-06-22"

# ignore the error:
# debconf: unable to initialize frontend: Dialog
#
# add-apt-repository is installed by python-software-properties
# git 1.7.9 needs upgrade
# https://launchpad.net/~git-core/+archive/ubuntu/ppa
#
# cmake 2.8.7 needs upgrade
# https://launchpad.net/~smspillaz/+archive/ubuntu/cmake-2.8.12
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python-software-properties \
        && \
    add-apt-repository -y ppa:git-core/ppa && \
    add-apt-repository -y ppa:smspillaz/cmake-2.8.12 && \
    apt-get update && \
    apt-get autoremove -y

RUN \
    # basic packages
    apt-get install -y --no-install-recommends \
        apt-utils \
        checkinstall \
        command-not-found \
        curl \
        dnsutils \
        dos2unix \
        file \
        iputils-ping \
        less \
        links \
        man \
        mc \
        net-tools \
        netbase \
        pkg-config \
        rsync \
        ssh \
        sudo \
        vim \
        vim-scripts \
        wget \
        zip unzip \
        # for X server testing
        # it is important to have `libgl1-mesa-dri` for X running
        # otherwise you will see the following errors or alike for `glxdemo`
        #   Error: couldn't get an RGB, Double-buffered visual
        xvfb \
        mesa-utils \
        libgl1-mesa-dri \
        # OpenVG support
        libopenvg1-mesa-dev \
        && \
    # development environment
    #   WARNING: The following packages cannot be authenticated!
    #   git-man git cmake-data cmake
    #   E: There are problems and -y was used without --force-yes
    #   --force-yes is deprecated and replace by --allow-unauthenticated and others
    apt-get install -y --no-install-recommends --allow-unauthenticated \
        cmake \
        git \
        && \
    apt-get install -y --no-install-recommends \
        build-essential \
        clang libclang-dev \
        gdb \
        libglew-dev \
        libwayland-dev \
        libx11-dev \
        && \
    # it requires gcc
    apt-get install -y --no-install-recommends \
        python-dev \
        python-pip \
        python-qt4 libicu48 \
        && \
    pip install pip psutil pep8 --upgrade -ihttps://pypi.python.org/simple/

# clean up APT when done
RUN echo 'debconf debconf/frontend select Dialog' | debconf-set-selections \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# create user without home
VOLUME /home/user
RUN groupadd -g 1000 user && \
    useradd -u 1000 -N -g user -s /bin/bash user && \
    # sudo package must be installed before to have `/etc/sudoers.d` created
    mkdir -p /etc/sudoers.d && \
    echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user
USER user
WORKDIR /home/user
