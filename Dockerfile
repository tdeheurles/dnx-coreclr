FROM          ubuntu:14.04.3
MAINTAINER 	  Thibault Deheurles <tdeheurles@gmail.com>
# Form sixeyed container (https://github.com/sixeyed/dockers)

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy main"                                  \
    | sudo tee /etc/apt/sources.list.d/mono-xamarin.list                                              && \
    echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main"                  \
    | sudo tee -a /etc/apt/sources.list.d/mono-xamarin.list                                           && \
    apt-get update -y                                                                                    \
        mono-complete                                                                                    \
        automake                                                                                         \
        libtool                                                                                          \
        unzip                                                                                            \
        libunwind8                                                                                       \
        libssl-dev                                                                                       \
        libcurl4-openssl-dev                                                                             \
        curl                                                                                           &&\
    curl -sSL https://github.com/libuv/libuv/archive/v1.4.2.tar.gz                                       \
    | sudo tar zxfv - -C /usr/local/src                                                                &&\
    cd /usr/local/src/libuv-1.4.2                                                                      &&\
    sh autogen.sh                                                                                      &&\
    ./configure                                                                                        &&\
    make                                                                                               &&\
    make install                                                                                       &&\
    rm -rf /usr/local/src/libuv-1.4.2                                                                  &&\
    cd  ~                                                                                              &&\
    ldconfig                                                                                           &&\
    curl -sSL https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.sh                           \
    | DNX_BRANCH=dev sh && source ~/.dnx/dnvm/dnvm.sh                                                  &&\
    mozroots --import --sync                                                                           &&\
    dnvm upgrade -u                                                                                    &&\
    dnvm install latest -r coreclr -u -p                                                               &&\
    apt-get autoremove

ENV PATH /root/.dnx/runtimes/dnx-coreclr-linux-x64.1.0.0-beta8-15618/bin:$PATH

CMD /bin/bash
