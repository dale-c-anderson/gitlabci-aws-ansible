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
RUN pip3 install ansible

# ----------------
# Install things to support ansible
# ----------------
RUN mkdir -pv /etc/ansible/
RUN echo 'localhost' > /etc/ansible/hosts

# ----------------
# Default command: display Ansible version
# ----------------
CMD [ "ansible", "--version" ]
