# kickstart file
# Kickstart user guide is here.
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/chap-kickstart-installations
# This tool creates a kickstart file. 
# https://access.redhat.com/labs/kickstartconfig/

# command section
# -----------------------------------

# install
# don't use graphical install
text
# Run the Setup Agent on first boot
firstboot --enable

# l10n (localization)
lang en_GB.UTF-8
timezone Europe/London --utc
keyboard --vckeymap=gb

# network
network  --bootproto=dhcp --device=eno1 --ipv6=auto --activate
network  --hostname=target1.lab.example.com

# licences and repos
# And have a look at the "subscription" section, in the post section below.
url --url=http://192.168.1.14/rhel7-repo
eula --agreed

# accounts
# root and nick, both with password "Password;1".
# The command "openssl passwd  -6 --salt SQXqGsYna84.3SL5" turns "Password;1" into this.
rootpw --iscrypted $6$SQXqGsYna84.3SL5$gJw6v23ZZ7WEITfBoZmyNDsIKeoqhS2Mwfk.KpCRloK7EfxlhL3MAlTCO33fr7QRfoG.GvBH1seWtQqz5v82q1
user --groups=wheel --name=nick --password=$6$G3GIlnUH.JqcrAQl$I.q7gGoT37tcNnrGiHkeUTBtr8AAuoM/yy3P3FuEpJaSun6clgR8GlvKIbqOTgqNe.fIBV6xZOPiWvsduhXeC/ --iscrypted --gecos="nick"

# storage
# The virtual machine has a 30GB disk.
# All these partitions must fit in that space.
ignoredisk --only-use=sda
# Partition clearing information
clearpart --all --initlabel
part /boot/efi --fstype="efi"   --ondisk=sda --size=600 --fsoptions="umask=0077,shortname=winnt"
part /boot     --fstype="xfs"   --ondisk=sda --size=1024
# 28GiB * 1024 = 28672MiB
part pv.03     --fstype="lvmpv" --ondisk=sda --size=28672
volgroup rhel pv.03
# 13GiB * 1024 = 13312MiB
logvol /     --fstype="xfs"  --size=13312  --name=root --vgname=rhel
logvol /var  --fstype="xfs"  --size=13312  --name=var  --vgname=rhel
logvol swap  --fstype="swap" --size=256    --name=swap --vgname=rhel

# applications and services
# Do not configure the X Window System
skipx
services --enabled="chronyd"
selinux --enforcing
firewall --enabled --http --ssh

# after installing the OS
# skip anaconda's prompt "Installation complete. Press ENTER to quit:"
reboot

# extra sections 
# -----------------------------------

%packages
# This is an environment group of packages.
# View the full list of groups to choose from by running this command.
#   dnf group list --hidden
@^minimal
# single package
kexec-tools
%end

%post --nochroot --erroronfail --log=/tmp/post.log
# view on console
iotty=`tty`
exec > $iotty 2> $iotty
#
cp /run/install/repo/my_scripts/phone_home.sh /mnt/sysimage/root/
echo "@reboot sleep 60 && /bin/bash /root/phone_home.sh" > /mnt/sysimage/var/spool/cron/root
#
%end

