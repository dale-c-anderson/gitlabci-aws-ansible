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
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt-get install -yqq ansible

# ----------------
# Install things to support ansible
# ----------------
RUN apt-get install -yqq sshpass openssh-client
RUN echo 'localhost' > /etc/ansible/hosts

# ----------------
# Default command: display Ansible version
# ----------------
CMD [ "ansible", "--version" ]
