#syntax=docker/dockerfile:1.2
FROM debian@sha256:fac2c0fd33e88dfd3bc88a872cfb78dcb167e74af6162d31724df69e482f886c as base

FROM base

# hadolint ignore=DL3008,DL3009
RUN --mount=type=tmpfs,target=/var/lib/apt/lists \
    --mount=type=tmpfs,target=/var/cache/apt \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install \
        --yes \
        --no-install-recommends \
        ca-certificates \
        netcat-openbsd \
        curl \
        bind9-host \
        wireguard-tools \
        procps \
        util-linux \
        jq \
        grep \
        gawk \
        libcap2-bin \
        iproute2 \
        socat \
        natpmpc \
        openresolv \
        iputils-ping \
        htop

COPY --chown=root:root --chmod=0755 protonwire /usr/bin/protonwire

RUN ln -s /usr/bin/protonwire /usr/bin/protonvpn

ENTRYPOINT [ "/usr/bin/protonwire" ]

CMD [ "connect", "--service" ]
