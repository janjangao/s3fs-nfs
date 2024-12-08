FROM efrecon/s3fs:1.94
LABEL maintainer="focussellingcute30years@gmail.com"

# --- nfs-server-alpine ---
RUN apk add --no-cache --update --verbose nfs-utils bash                                                 && \
	rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot                                    && \
	mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery                                             && \
	echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
	echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY exports /etc/
COPY nfsd.sh /usr/bin/nfsd.sh

RUN chmod +x /usr/bin/nfsd.sh
# --- nfs-server-alpine ---

ENV SHARED_DIRECTORY $AWS_S3_MOUNT
ENV SYNC true

ENTRYPOINT docker-entrypoint.sh;nfsd.sh

EXPOSE 2049



