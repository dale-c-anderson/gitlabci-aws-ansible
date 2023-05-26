# ===============================================
# Ansible (+ AWS) CLI tools
# ===============================================
FROM dandersonacro/gitlabci-awscli:u22.04
MAINTAINER Dale Anderson (http://www.acromedia.com/)

# ----------------
# Get everything up to date
# ----------------
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
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

RUN python3 -m pip install ansible \
 && mkdir -pv /etc/ansible/ \
 && echo 'localhost' > /etc/ansible/hosts

# ----------------
# Default command: display Ansible version
# ----------------
CMD [ "ansible", "--version" ]
