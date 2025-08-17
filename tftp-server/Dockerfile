FROM gcc:12.5.0-bookworm



FROM debian:bookworm-slim

ARG UID
ARG GID

RUN apt-get update && apt-get install -y \
    tftpd-hpa \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/lib/tftpboot

RUN wget -q https://boot.ipxe.org/undionly.kpxe && \
    wget -q https://boot.ipxe.org/ipxe.pxe && \
    wget -q https://boot.ipxe.org/undionly.kkpxe

COPY ./boot.ipxe /var/lib/tftpboot/

ENV TFTP_USERNAME=tftp
ENV TFTP_DIRECTORY=/var/lib/tftpboot
ENV TFTP_ADDRESS=0.0.0.0:69
ENV TFTP_PERMISSIVE=""

RUN groupadd tftp --gid ${GID} && \
    useradd tftp --uid ${UID} --gid ${GID} \
    --system \
    --no-create-home \
    --shell /bin/false

RUN chown -R tftp:tftp /var/lib/tftpboot && \
    chmod -R 755 /var/lib/tftpboot

# ヘルスチェック
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD netstat -ulpn | grep :69 || exit 1

# TFTPサーバを起動
CMD ["in.tftpd", "--foreground", "--user", "tftp", "--address", "0.0.0.0:69", "--secure", "/var/lib/tftpboot"]
