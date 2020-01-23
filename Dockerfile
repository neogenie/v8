ARG UBUNTU_VERSION=18.04

FROM ubuntu:$UBUNTU_VERSION as builder

ENV GCC_VERSION 9
ENV BUILD_DIR /tmp/build

RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && apt-get upgrade -y && apt-get install -y  \
    build-essential \
    gcc-${GCC_VERSION} \
    git \
    g++-${GCC_VERSION} \
    curl \
    python \
    pkg-config && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 60 --slave /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} && \
    update-alternatives --config gcc && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir ${BUILD_DIR}

#v8
RUN cd ${BUILD_DIR} && \
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git && \
    export PATH=$PATH:${BUILD_DIR}/depot_tools && \
    git clone git://github.com/ninja-build/ninja.git && cd ninja && \
    git checkout release && \
    ./configure.py --bootstrap && \
    cp ninja /usr/sbin/ && \
    cd .. && \
    fetch v8 && \
    cd v8 && \
    tools/dev/v8gen.py -vv x64.release.sample && \
    ninja -C out.gn/x64.release.sample v8_monolith && \
    cp out.gn/x64.release.sample/obj/*.a /usr/lib/ && \
    cp -r include/* /usr/include/

FROM ubuntu:$UBUNTU_VERSION as library
ENV BUILD_DIR /tmp/build
COPY --from=builder ${BUILD_DIR}/v8/out.gn/x64.release.sample/obj/*.a /usr/lib/
COPY --from=builder ${BUILD_DIR}/v8/include/* /usr/include/
