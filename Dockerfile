FROM 0x01be/kami:build as build
FROM 0x01be/bsc:build as bsc

FROM alpine

COPY --from=build /opt/ /opt/
COPY --from=bsc /bsc/src/vendor/yices/v2.6/yices2-inst/lib/* /usr/lib/
COPY --from=bsc /bsc/src/vendor/stp/lib/* /usr/lib/

RUN apk add --no-cache --virtual kami-runtime-dependencies \
    tcl \
    bash \
    gmp \
    libstdc++

ENV PATH $PATH:/opt/ocaml/bin/:/opt/opam/bin/:/opt/coq/bin/:/opt/bsc/bin/

