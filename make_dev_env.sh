#!/bin/bash

YELLOW='\033[0;33m'
NC='\033[0m' # No colour

if [ `whoami` != "root" ]
then
	printf "${YELLOW}Need to be root${NC}\n"
	exit 1
fi

# Install Terminator
dnf -y install terminator
printf "${YELLOW}terminator installed${NC}\n"

# Install Chrome (TODO put config file in ~/.config)
dnf -y install fedora-workstation-repositories
dnf -y config-manager --set-enabled google-chrome
dnf -y install google-chrome-stable
printf "${YELLOW}chrome installed${NC}\n"

# Install i3 (TODO put config file in ~/.config)
dnf -y install i3 i3status dmenu i3lock xbacklight feh conky
dnf -y install xautolock
printf "${YELLOW}i3 installed${NC}\n"

# Install vim
dnf -y install vim
printf "${YELLOW}vim installed${NC}\n"

# Install tldr
dnf -y install tldr
printf "${YELLOW}tldr installed${NC}\n"

# Install pycharm
# TODO work out how to do the initial download from the command line
# tar -xzf pycharm-professional-2018.3.4.tar.gz -C /opt/
# before the next step, config needs to be in the right place!!!!!
# /opt/pycharm-2018.3.4/bin/pycharm.sh
# printf "${YELLOW}pycharm installed${NC}\n"

# install ipython
dnf install -y ipython
dnf install -y ipython3
printf "${YELLOW}ipython installed${NC}\n"

# enable sshd
systemctl enable sshd.service
printf "${YELLOW}sshd enabled${NC}\n"

# setup nfs
dnf -y install nfs-utils
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --reload
## will also need to add the following line to /etc/exports
# /home/				<host_to_share_to>(rw,insecure,sync,fsid=root)
## then run:
# exportfs -ra
# systemctl start nfs-server
# systemctl enable nfs-server
# chmod a+r ~/<directory to be mounted>
# chmod a+r ~


printf "${YELLOW}nfs-utils installed and enabled${NC}\n"

# Reboot to make changes take effect
# reboot
