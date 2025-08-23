# FROM gcc:12.5.0-bookworm AS builder

# RUN apt-get update && apt-get install -y \
#     syslinux \
#     isolinux \
#     mkisofs \
#     gcc-aarch64-linux-gnu

# ADD https://github.com/ipxe/ipxe.git /ipxe

# WORKDIR /ipxe/src

# RUN --mount=type=cache,target=/ipxe/src/bin-x86_64-efi \
#     --mount=type=cache,target=/ipxe/src/bin-arm64-efi \
#     make bin-x86_64-efi/ipxe.efi && \
#     make CROSS=aarch64-linux-gnu- bin-arm64-efi/ipxe.efi && \
#     mkdir -p /tmp/build-cache && \
#     cp bin-x86_64-efi/ipxe.efi /tmp/build-cache/ipxe-x86_64.efi && \
#     cp bin-arm64-efi/ipxe.efi /tmp/build-cache/ipxe-arm64.efi

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    tftpd-hpa

WORKDIR /srv/tftp

# COPY --from=builder /tmp/build-cache/ipxe-x86_64.efi /srv/tftp/
# COPY --from=builder /tmp/build-cache/ipxe-arm64.efi /srv/tftp/

ADD https://boot.ipxe.org/ipxe.efi /srv/tftp/x86_64.efi
ADD https://boot.ipxe.org/arm64-efi/ipxe.efi /srv/tftp/arm64.efi

RUN chown -R tftp:tftp /srv/tftp && \
    chmod -R 755 /srv/tftp

ENTRYPOINT [ "in.tftpd" ]
CMD ["--foreground"]
