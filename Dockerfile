ARG MURMUR_VERSION=1.3.0
FROM alpine as setup
ARG MURMUR_VERSION

WORKDIR /tmp

ADD https://mumble.info/snapshot/murmur-static_x86-${MURMUR_VERSION}.tar.bz2 murmur-static_x86-${MURMUR_VERSION}.tar.bz2

RUN tar -xvf murmur-static_x86-${MURMUR_VERSION}.tar.bz2

RUN mkdir /murmur && chown nobody:nobody /murmur

FROM scratch
ARG MURMUR_VERSION

COPY --from=setup /etc/passwd /etc/group /etc/
USER nobody

COPY --chown=nobody:nobody --from=setup /murmur /murmur

WORKDIR /murmur

COPY --chown=nobody:nobody --from=setup /tmp/murmur-static_x86-${MURMUR_VERSION}/murmur.x86 murmur
COPY --chown=nobody:nobody --from=setup /tmp/murmur-static_x86-${MURMUR_VERSION}/murmur.ini murmur.ini

ENTRYPOINT [ "/murmur/murmur", "-ini", "murmur.ini", "-fg"]