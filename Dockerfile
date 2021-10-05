FROM efrecon/s3fs
LABEL maintainer="hayond@qq.com"
RUN apk add --no-cache --update --verbose nfs-utils bash mailcap                                         && \
	rm -rf /var/cache/apk /sbin/halt /sbin/poweroff /sbin/reboot                                         && \
	mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery                                             && \
	echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
	echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab  

COPY s3fs.sh /usr/bin/s3fs.sh
COPY nfsd.sh /usr/bin/nfsd.sh
COPY exports /etc/
COPY .bashrc /root/.bashrc

ENV ACCESS_KEY_ID=
ENV SECRET_ACCESS_KEY=
ENV BUCKET=
ENV URL=https://s3.amazonaws.com
ENV MOUNT=/opt/s3fs/bucket
ENV AUTHFILE=

ENV SHARED_DIRECTORY $MOUNT
ENV SYNC true

ENTRYPOINT s3fs.sh;nfsd.sh

EXPOSE 2049



