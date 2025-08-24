FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    tftpd-hpa

# WORKDIR /srv/tftp

# ADD https://boot.ipxe.org/ipxe.efi /srv/tftp/ipxe-x86_64.efi
# ADD https://boot.ipxe.org/arm64-efi/ipxe.efi /srv/tftp/ipxe-arm64.efi

# RUN chown -R tftp:tftp /srv/tftp && \
#     chmod -R 755 /srv/tftp

ENTRYPOINT [ "in.tftpd" ]
CMD ["--foreground", "--verbose", "--address", "0.0.0.0:69", "--secure", "/srv/tftp/", "--user", "tftp"]
