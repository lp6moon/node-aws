# node-aws
![docker pulls](https://flat.badgen.net/docker/pulls/lp6moon/node-aws)  
Docker image with node v16, aws-cli v2, eb-cli

## mirrors for local build
```Dockerfile
ENV npm_config_registry=https://registry.npmmirror.com
RUN mkdir -p .pip && echo "[global]\
index-url = https://mirrors.aliyun.com/pypi/simple/\
[install]\
trusted-host=mirrors.aliyun.com" > .pip/pip.conf
RUN sed -i "s/[a-z]\+.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list
```
