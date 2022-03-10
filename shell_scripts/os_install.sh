#!/bin/bash -x
#
# update the git repo
# check the machine
# build a customized boot ISO
# install on the target machine

cd /home/nick/summit_OD1226/
git pull

cd /home/nick/summit_OD1226/ansible_playbooks/iso_build
ansible-playbook main.yml
RC=$?
if [ $RC != 0 ]; then
  exit $RC;
fi;

cd /home/nick/summit_OD1226/ansible_playbooks/machine_check
ansible-playbook main.yml
RC=$?
if [ $RC != 0 ]; then
  exit $RC;
fi;

cp /home/nick/summit_OD1226/ansible_playbooks/iso_build/form.yml \
   /home/nick/summit_OD1226/ansible_playbooks/iso_install

cd /home/nick/summit_OD1226/ansible_playbooks/iso_install
ansible-playbook main.yml
RC=$?
if [ $RC != 0 ]; then
  exit $RC;
fi;

echo "watch the console"

