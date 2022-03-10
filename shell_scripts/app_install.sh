#!/bin/bash -x

# see /home/nick/.ssh/config
cp /dev/null /home/nick/.ssh/known_hosts

cd /home/nick/summit_OD1226/ansible_playbooks/target1_configure/
git pull

ansible-playbook main.yml
RC=$?
if [ $RC != 0 ]; then
  exit $RC;
fi;

