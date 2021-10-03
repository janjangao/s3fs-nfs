# ossfs-nfs

make aliyun oss to nfs server

### run
```docker run --privileged -v /lib/modules:/lib/modules:ro -e BUCKET=bucket -e ENDPOINT_URL=endpoint_url -e ACCESS_KEY=access_key -e ACCESS_SECRET=access_secret -p 2049:2049 -d hayond/ossfs-nfs```

