# ossfs-nfs

make aliyun oss to nfs server... but a better way use oss in k8s is official [ALIYUN CSI](https://help.aliyun.com/document_detail/134761.html)

### run
```docker run --cap-add SYS_ADMIN -e BUCKET=bucket -e ENDPOINT_URL=endpoint_url -e ACCESS_KEY=access_key -e ACCESS_SECRET=access_secret -p 2049:2049 -d hayond/ossfs-nfs```

