FROM node:18

WORKDIR /root

ARG EB_VERSION=0.2.0

# install pip3
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# install virtualenv
RUN pip3 install --no-cache-dir virtualenv

# install aws-cli 2
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip -sSLo awscliv2.zip \
    && unzip awscliv2.zip \
    && rm -rf awscliv2.zip \
    && ./aws/install \
    && aws --version

# install eb-cli
ENV PATH="/root/.ebcli-virtual-env/executables:$PATH"
RUN curl https://github.com/aws/aws-elastic-beanstalk-cli-setup/archive/refs/tags/v${EB_VERSION}.zip -sSLo eb-setup.zip \
    && unzip eb-setup.zip \
    && rm -rf eb-setup.zip \
    && mv ./aws-elastic-beanstalk-cli-setup-${EB_VERSION} ./eb-setup \
    && python3 ./eb-setup/scripts/ebcli_installer.py \
    && rm -rf ./eb-setup \
    && eb --version
