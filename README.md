# s3fs-nfs

make oss to nfs server, can be used for aliyun oss

### run
```docker run -d --privileged -e AWS_S3_ACCESS_KEY_ID=access_key_id -e AWS_S3_SECRET_ACCESS_KEY=secret_access_key -e BUCKET=cdn-bucket -e URL=https://oss-cn-zhangjiakou-internal.aliyuncs.com -p 2049:2049 janjangao/s3fs-nfs```


