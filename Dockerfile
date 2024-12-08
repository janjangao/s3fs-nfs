FROM efrecon/s3fs:1.94
LABEL maintainer="focussellingcute30years@gmail.com"

# --- nfs-server-alpine ---
RUN apk add --no-cache --update --verbose nfs-utils bash                                                 && \
	rm -rf /var/cache/apk /tmp/* /sbin/halt /sbin/poweroff /sbin/reboot                                  && \
	mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery                                             && \
	echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
	echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY exports /etc/
COPY nfsd.sh /usr/bin/nfsd.sh
RUN chmod +x /usr/bin/nfsd.sh
# --- nfs-server-alpine ---

# --- s3fs-nfs ---
COPY bootstrap.sh /usr/bin/bootstrap.sh
RUN chmod +x /usr/bin/bootstrap.sh

ENV ACCESS_KEY_ID=
ENV SECRET_ACCESS_KEY= 
ENV URL=
ENV BUCKET= 
ENV MOUNT=
# --- s3fs-nfs ---

ENV SHARED_DIRECTORY $AWS_S3_MOUNT
ENV SYNC true

ENTRYPOINT [ "tini", "-g", "--", "bootstrap.sh" ]

EXPOSE 2049



