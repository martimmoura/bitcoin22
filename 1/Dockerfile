FROM debian as builder

WORKDIR /tmp

RUN apt-get update && apt-get install -y wget

#get pkg and checksums
RUN wget https://bitcoincore.org/bin/bitcoin-core-22.0/bitcoin-22.0.tar.gz
RUN wget https://bitcoincore.org/bin/bitcoin-core-22.0/SHA256SUMS
#run checksum, fails build if bad
RUN sha256sum -c SHA256SUMS --ignore-missing --status


ENTRYPOINT ["bash"]

FROM debian as final

COPY --from=builder /tmp
