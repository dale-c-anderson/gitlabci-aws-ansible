# ===============================================
# Ansible (+ AWS) CLI tools
# ===============================================
FROM dandersonacro/gitlabci-awscli:latest
MAINTAINER Dale Anderson (http://www.acromedia.com/)

# ----------------
# Get everything up to date
# ----------------
RUN apt-get -qq update
RUN apt-get -yqq upgrade

# ----------------
# Install Ansible
# @TODO: Bring ansible up to date. Pinning at 2.10 for now so we can get rsync running.
# ----------------
RUN apt-get install -yq locales
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN apt-get install -yqq software-properties-common
RUN apt-get install -yqq sshpass openssh-client
RUN pip3 install ansible==2.10.*

# ----------------
# Install things to support ansible
# ----------------
RUN mkdir -pv /etc/ansible/
RUN echo 'localhost' > /etc/ansible/hosts
RUN apt-get install -yqq rsync

# ----------------
# Save some space
# ----------------
RUN rm -rfv /var/lib/apt/lists/*

# ----------------
# Default command: display Ansible version
# ----------------
CMD [ "ansible", "--version" ]
