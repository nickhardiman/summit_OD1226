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
cp /home/nick/summit_OD1226/ansible_playbooks/iso_build/form.yml .
ansible-playbook main.yml
RC=$?
if [ $RC != 0 ]; then
  exit $RC;
fi;

cd /home/nick/summit_OD1226/ansible_playbooks/iso_install
cp /home/nick/summit_OD1226/ansible_playbooks/iso_build/form.yml .
ansible-playbook main.yml
RC=$?
if [ $RC != 0 ]; then
  exit $RC;
fi;

echo "watch the console"

