lang en_GB
keyboard uk
timezone Europe/London --isUtc
rootpw $2b$10$wWxwoHdWNKyP6.QWCyQmEuuZ/YYFfPO4j2UnlutsGKZ5HX/kHqI0y --iscrypted
#platform x86_64
reboot
text
url --url=http://repo1.lab.example.com//rhel6-repo
bootloader --append="rhgb quiet crashkernel=auto"
zerombr
clearpart --all --initlabel
autopart
auth --passalgo=sha512 --useshadow
selinux --enforcing
firewall --enabled --http --ssh
skipx
firstboot --disable
%packages
@base
%end

