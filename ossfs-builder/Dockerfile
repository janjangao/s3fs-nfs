FROM alpine:latest
RUN echo -e "https://mirrors.ustc.edu.cn/alpine/latest-stable/main\nhttps://mirrors.ustc.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories && \
	apk update &&\
	apk --update add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev && \
	wget -qO- https://github.com/aliyun/ossfs/archive/master.tar.gz |tar xz          && \
	cd ossfs-master 																 && \
	./autogen.sh																	 && \
	./configure 																	 && \
	make																			 && \
	make install																	 && \
	rm -rf /var/cache/apk/* 

FROM alpine:latest
LABEL maintainer="hayond@qq.com"
ENV OSSFS_PATH=/ossfs
COPY /usr/local/bin/ossfs /usr/local/bin/ossfs
RUN mkdir /ossfs  																	&& \
	ossfs ${BUCKET} ${OSSFS_PATH} -ourl=${ENDPOINT_URL}



