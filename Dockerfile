FROM alpine:latest
RUN echo -e "https://mirrors.ustc.edu.cn/alpine/latest-stable/main\nhttps://mirrors.ustc.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories && \
	apk --update --no-cache add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev && \
	wget -qO- https://github.com/aliyun/ossfs/archive/master.tar.gz |tar xz          			&& \
	cd ossfs-master 																 			&& \
	./autogen.sh										     									&& \
	./configure 																	 			&& \
	make																						&& \
	make install			 																	

FROM erichough/nfs-server:latest
LABEL maintainer="hayond@qq.com"
ENV OSSFS_PATH=/ossfs
COPY --from=0 /usr/local/bin/ossfs /usr/local/bin/ossfs
RUN echo -e "https://mirrors.ustc.edu.cn/alpine/latest-stable/main\nhttps://mirrors.ustc.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories && \
	apk --update --no-cache add fuse curl libxml2 libstdc++                 && \
	mkdir /ossfs  															

