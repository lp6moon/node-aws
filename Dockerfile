FROM nikolaik/python-nodejs:python3.12-nodejs24

WORKDIR /root

ARG EB_VERSION=3.27.2

# install missing dependencies
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update &&\
    apt-get install -y --no-install-recommends \
        groff \
        less

# install aws-cli 2
RUN AWS_CLI_ARCH="$(dpkg --print-architecture)" &&\
    case "$AWS_CLI_ARCH" in \
        amd64) AWS_CLI_ARCH=x86_64 ;; \
        arm64) AWS_CLI_ARCH=aarch64 ;; \
        *) echo "Unsupported architecture: $AWS_CLI_ARCH" >&2; exit 1 ;; \
    esac &&\
    curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_CLI_ARCH}.zip" -sSLo awscliv2.zip &&\
    unzip -qq awscliv2.zip &&\
    ./aws/install &&\
    rm -rf aws awscliv2.zip &&\
    aws --version

# install eb-cli
ENV PATH="/root/.ebcli-virtual-env/executables:$PATH"
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git &&\
    python ./aws-elastic-beanstalk-cli-setup/scripts/ebcli_installer.py --version ${EB_VERSION} &&\
    rm -rf ./aws-elastic-beanstalk-cli-setup &&\
    eb --version
