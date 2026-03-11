FROM ghcr.io/dale-c-anderson/gitlabci-awscli:v2026.03.11
LABEL maintainer="Dale Anderson (http://www.acromedia.com/)"
LABEL org.opencontainers.image.title="AWS CLI v2 + Ansible + Terraform"
LABEL org.opencontainers.image.description="For deploying and maintaining AWS infrastructure from Gitlab CI pipelines"
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
# ----------------
# Install pip and other dependencies
# ----------------
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3-pip \
    && rm -rfv /var/lib/apt/lists/*

# ----------------
# Install Ansible
# ----------------
RUN python3 -m pip install --break-system-packages ansible boto3 botocore 'botocore[crt]' \
 && mkdir -pv /etc/ansible/ \
 && echo 'localhost' > /etc/ansible/hosts \
 && python3 -m pip cache purge

# ----------------
# Install Terraform
# ----------------
ARG TERRAFORM_VERSION=1.14.7
RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip -qq terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && mv terraform /usr/local/bin/ \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# ----------------
# Default command: Display versions
# ----------------
CMD [ "/bin/bash", "-c", "(set -x && aws --version; ansible --version; terraform --version)" ]
