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
# ----------------
RUN apt-get install -yqq software-properties-common
RUN apt-get install -yqq sshpass openssh-client
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN pip3 install ansible==2.9.*

# ----------------
# Install things to support ansible
# ----------------
RUN mkdir -pv /etc/ansible/
RUN echo 'localhost' > /etc/ansible/hosts

# ----------------
# Default command: display Ansible version
# ----------------
CMD [ "ansible", "--version" ]
