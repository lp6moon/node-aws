FROM nikolaik/python-nodejs:python3.13-nodejs22

WORKDIR /root

ARG EB_VERSION=3.20.3

# install virtualenv
RUN pip3 install --no-cache-dir virtualenv

# install aws-cli 2
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip -sSLo awscliv2.zip &&\
    unzip -qq awscliv2.zip &&\
    rm -rf awscliv2.zip &&\
    ./aws/install &&\
    aws --version

# install eb-cli
ENV PATH="/root/.ebcli-virtual-env/executables:$PATH"
RUN git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git &&\
    python ./aws-elastic-beanstalk-cli-setup/scripts/ebcli_installer.py --version ${EB_VERSION} &&\
    rm -rf ./aws-elastic-beanstalk-cli-setup &&\
    eb --version
