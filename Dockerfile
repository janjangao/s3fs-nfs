FROM efrecon/s3fs:1.95
LABEL maintainer="focussellingcute30years@gmail.com"

# --- nfs-server-alpine ---
RUN apk add --no-cache --update --verbose nfs-utils bash && \
    rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot && \
    mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery && \
    echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
    echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY nfsd.sh /usr/bin/nfsd.sh
RUN chmod +x /usr/bin/nfsd.sh
# --- nfs-server-alpine ---

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENV S3_URL=https://s3.amazonaws.com
ENV S3_ACCESS_KEY_ID=
ENV S3_SECRET_ACCESS_KEY=
ENV S3_BUCKET=
ENV SHARED_DIRECTORY $AWS_S3_MOUNT

ENTRYPOINT entrypoint.sh

EXPOSE 2049



