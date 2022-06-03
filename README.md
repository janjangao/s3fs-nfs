# s3fs-nfs

make oss to nfs server, can be used for aliyun oss

### run
```docker run -d --privileged -e ACCESS_KEY_ID=access_key_id -e SECRET_ACCESS_KEY=secret_access_key -e BUCKET=bucket -e URL=url -p 2049:2049 hayond/s3fs-nfs```


