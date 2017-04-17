FROM sgtsquiggs/alpine:3.4
MAINTAINER sgtsquiggs

ENV SABNZBD_VERSION="2.0.0"

RUN \
# install packages
    apk add --no-cache \
        git \
        p7zip \
        python \
        py-pip \
        py-cffi \
        py-cryptography \
        unrar \
        unzip &&\
    apk add --no-cache \
        --virtual=build-dependencies \
        autoconf \
        automake \
        curl \
        g++ \
        gcc \
        make \
        python-dev \
        tar &&\

# install par2cmdline
    mkdir -p \
        /tmp/par2cmdline &&\
    latest_tag=$(curl -sX GET "https://api.github.com/repos/Parchive/par2cmdline/releases/latest" \
        | awk '/tag_name/{print $4;exit}' FS='[""]') &&\
    curl -o \
        /tmp/par2cmdline.src.tar.gz -L \
        https://github.com/Parchive/par2cmdline/archive/$latest_tag.tar.gz &&\
    tar xf /tmp/par2cmdline.src.tar.gz \
        -C /tmp/par2cmdline \
        --strip-components=1 &&\
    cd /tmp/par2cmdline &&\
    aclocal &&\
    automake --add-missing &&\
    autoconf &&\
    ./configure &&\
    make install &&\

# install sabnzbd
    mkdir -p \
        /app/sabnzbd &&\
    latest_tag=$(curl -sX GET "https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest" \
        | awk '/tag_name/{print $4;exit}' FS='[""]') &&\
    curl -o \
        /tmp/SABnzbd.src.tar.gz -L \
        https://github.com/sabnzbd/sabnzbd/releases/download/$latest_tag/SABnzbd-$latest_tag-src.tar.gz &&\
    tar xf /tmp/SABnzbd.src.tar.gz \
        -C /app/sabnzbd \
        --strip-components=1 &&\
    pip install \
        cheetah \
        sabyenc &&\
    python -OO /app/sabnzbd/SABnzbd.py --help &&\

# clean up
    apk del build-dependencies &&\
    rm -rf \
        /tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads /incomplete-downloads
EXPOSE 8080
