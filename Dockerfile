FROM ubuntu:20.04

RUN apt-get update

# Install tzdata to avoid selection timezone by interactive
# https://qiita.com/yagince/items/deba267f789604643bab
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata

# build-essential contents:
#   https://packages.ubuntu.com/en/focal/build-essential
RUN apt-get install -y \
    # For basic cpp env
    build-essential cmake \
    # For cpplint
    locales-all python3 python3-pip \
    # For coverage
    lcov gcovr \
    # For SonarQube & codecov.io
    git curl wget \
    # For WebSocket
    libuv1-dev libssl-dev libz-dev

# Install cpplint
RUN pip3 install cpplint

# Build WebSocket Lib
RUN git clone https://github.com/uWebSockets/uWebSockets && \
    cd uWebSockets && \
    git checkout e94b6e1 && \
    mkdir build && cd build && cmake .. && make && make install

