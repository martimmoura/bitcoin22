FROM debian:sid-slim as builder

WORKDIR /tmp/btc22

RUN apt-get update && apt-get install -y wget

#get release and checksums
RUN wget https://bitcoincore.org/bin/bitcoin-core-22.0/bitcoin-22.0-x86_64-linux-gnu.tar.gz
RUN wget https://bitcoincore.org/bin/bitcoin-core-22.0/SHA256SUMS
#run checksum, fails build if bad
RUN sha256sum -c SHA256SUMS --ignore-missing --status
#extract
RUN tar -xvf bitcoin-22.0-x86_64-linux-gnu.tar.gz

FROM debian:sid-slim as final

ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" bitcoin \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" bitcoin

USER bitcoin
COPY --from=builder --chown=${UID}:${GID} /tmp/btc22/bitcoin-22.0 /app
WORKDIR /app
RUN mkdir data

ENTRYPOINT [ "/app/bin/bitcoind"]