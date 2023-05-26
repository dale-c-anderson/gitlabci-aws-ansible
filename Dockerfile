# ===============================================
# AWS CLI v2 + Ansible + Terraform
# For deploying and maintaining AWS infrastructure from Gitlab CI pipelines
# ===============================================
FROM dandersonacro/gitlabci-awscli:latest
MAINTAINER Dale Anderson (http://www.acromedia.com/)

# ----------------
# Get everything up to date
# ----------------
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
        python3-pip \
        locales \
        software-properties-common \
        sshpass \
        openssh-client \
        rsync \
    && rm -rfv /var/lib/apt/lists/*

# ----------------
# Install Ansible
# ----------------
RUN python3 -m pip install ansible \
 && mkdir -pv /etc/ansible/ \
 && echo 'localhost' > /etc/ansible/hosts

# ----------------
# Install Terraform
# ----------------
RUN wget --quiet https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip \
  && unzip -qq terraform_1.4.6_linux_amd64.zip \
  && mv terraform /usr/local/bin/ \
  && rm terraform_1.4.6_linux_amd64.zip

# ----------------
# Default command: Display versions
# ----------------
CMD [ "/bin/bash", "-c", "(set -x && aws --version; ansible --version; terraform --version)" ]
