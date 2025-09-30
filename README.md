# s3fs-nfs
[Github Link](https://github.com/janjangao/s3fs-nfs)

A simple way to share OSS as NFS server.

## Overview
Due to OSS specify system, container may need more privileges to start, you can simply put `--privileged`, or add those precise parameters
- `-device /dev/fuse`
- `--cap-add SYS_ADMIN`
- `--security-opt apparmor:unconfined`

### Docker
```
docker run -d \
  --name s3fs-nfs \
  --device /dev/fuse \
  --cap-add SYS_ADMIN \
  --security-opt apparmor:unconfined \
  -e S3_ACCESS_KEY_ID=access_key_id \
  -e S3_SECRET_ACCESS_KEY=secret_access_key \
  -e S3_BUCKET=cdn-bucket \
  -e S3_BUCKET=https://oss-cn-zhangjiakou-internal.aliyuncs.com \
  -p 2049:2049 \
  -v /storage:/storage \
  -v /media:/storage/media \
  --restart unless-stopped \
  janjangao/nfs-server-alpine
```

#### Compose
```
services:
  s3fs-nfs:
    image: janjangao/s3fs-nfs
    container_name: s3fs-nfs
    devices:
      - /dev/fuse
    cap_add:
      - SYS_ADMIN
    security_opt:
      - apparmor:unconfined
    environment:
      S3_ACCESS_KEY_ID: "access_key_id"
      S3_SECRET_ACCESS_KEY: "secret_access_key"
      S3_BUCKET: "cdn-bucket"
      S3_URL: "https://oss-cn-zhangjiakou-internal.aliyuncs.com"
    ports:
      - "2049:2049"
    restart: unless-stopped

```

Since it is also a normal nfs-server, so other options also support, check details [https://github.com/sjiveson/nfs-server-alpine](https://github.com/janjangao/nfs-server-alpine)

