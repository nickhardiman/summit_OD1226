# For more information, see
# https://support.hpe.com/hpesc/public/docDisplay?docId=a00018323en_us
# HPE iLO 5 Scripting and Command Line Guide

#set USER and PASS
source ./account
BMC=192.168.1.245

ssh $USER@$BMC vm cdrom insert http://192.168.1.14/rhel-server-6.10-x86_64-boot.iso
ssh $USER@$BMC vm cdrom set boot_once
ssh $USER@$BMC vm cdrom set connect
ssh $USER@$BMC power reset

