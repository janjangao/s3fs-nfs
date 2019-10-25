# ossfs-nfs

make aliyun oss to nfs server... but a butter way use oss in k8s is official [ALIYUN CSI](https://help.aliyun.com/document_detail/130911.htm)

### run
```docker run -e BUCKET=bucket -e ENDPOINT_URL=endpoint_url -e ACCESS_KEY=access_key -e ACCESS_SECRET=access_secret -p 2049:2049 -d hayond/ossfs-nfs```

