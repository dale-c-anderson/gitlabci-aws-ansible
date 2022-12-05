# gitlabci-aws-ansible
AWS + Ansible command line tools in a container image.

Originally built for use in GitLab CI jobs.


## Using the image locally

This works fine locally if you don't care to install Ansible. Here's how:

```bash
cd /path/to/repo/where/your/playbook/is

docker run --rm -it \
   -v "$(pwd)":/root \
   -w /root \
   -v $HOME/.ssh:/root/.ssh:ro \
   -e SSH_AUTH_SOCK=/ssh-agent \
   -v ${SSH_AUTH_SOCK}:/ssh-agent \
   -e ANSIBLE_REMOTE_USER=$(whoami) \
   dandersonacro/gitlabci-aws-ansible:latest \
   ansible-playbook playbooks/my-book.yml -i inventories/staging --limit 'foobar*' --check
```
* Line 4 mounts your current dir to `/root` inside the container.
* Line 5 sets the working dir in the container to `/root`, which because of the mount, should hook up to your playbooks
* Lines 6 through 8 connect your SSH agent (you have private keys loaded into an agent, right??) to the container
* Line 9 tells Ansible to use your local username for connections to remote hosts. If omitted, Ansible will try and connect to remote hosts `root`. Adjust this to something else if needed.
* Line 10 is the image to run. If anything is missing from this image, submit a pull request here.
* Everything on line 11 is what you’d normally execute to run a playbook if you had installed Ansible locally.
