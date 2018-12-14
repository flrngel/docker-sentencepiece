FROM alpine:3.5

RUN set -x \
    && apk update \
    && apk --no-cache add \
        libstdc++ \
        protobuf \
    && apk --no-cache add --virtual .builddeps \
        autoconf \
        automake \
        build-base \
        git \
        libtool \
        protobuf-dev \ 
    && git clone  https://github.com/google/sentencepiece \
    && cd sentencepiece \
    && mkdir bubild \
    && cd build \
    && cmake .. \
    && make -j $(nproc) \
    && make install \
    && ldconfig -v \
    ## cleanup
    && make clean \
    && apk del .builddeps

WORKDIR  /sentencepiece
