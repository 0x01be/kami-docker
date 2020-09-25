FROM 0x01be/coq as coq
FROM 0x01be/bsc as bsc

FROM alpine as builder

COPY --from=coq /opt/ /opt/
COPY --from=bsc /opt/bsc/ /opt/bsc/

ENV PATH $PATH:/opt/ocaml/bin/:/opt/opam/bin/:/opt/coq/bin/:/opt/bsc/bin/

RUN apk add --no-cache --virtual kami-build-dependencies \
    git \
    build-base

ENV KAMI_REVISION rv32i
RUN git clone --depth 1 --branch ${KAMI_REVISION} https://github.com/mit-plv/kami.git /kami

WORKDIR /kami

RUN make
RUN make install

