FROM node:12

WORKDIR /root

# install aws-cli 2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN aws --version

# install eb-cli
RUN git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
RUN ./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer
ENV PATH="/root/.pyenv/versions/3.7.2/bin:/root/.ebcli-virtual-env/executables:$PATH"
RUN eb --version
