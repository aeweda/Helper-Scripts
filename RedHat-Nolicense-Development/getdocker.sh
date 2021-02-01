#!/bin/bash

#?###################################################################################################
#?                                                                                                  #
#?                                      Output Helper Methods                                       #
#?                                                                                                  #
#?###################################################################################################

trap "exit" INT

function blue_text_box()
{
  echo " "
  local s="$*"
  tput setaf 3
  echo " -${s//?/-}-
| ${s//?/ } |
| $(tput setaf 4)$s$(tput setaf 3) |
| ${s//?/ } |
 -${s//?/-}-"
  tput sgr 0
  echo " "
}

function red_text_box()
{
  echo " "
  local s="$*"
  tput setaf 3
  echo " -${s//?/-}-
| ${s//?/ } |
| $(tput setaf 1)$s$(tput setaf 3) |
| ${s//?/ } |
 -${s//?/-}-"
  tput sgr 0
  echo " "
}

function green_text_box()
{
  echo " "
  local s="$*"
  tput setaf 3
  echo " -${s//?/-}-
| ${s//?/ } |
| $(tput setaf 2)$s$(tput setaf 3) |
| ${s//?/ } |
 -${s//?/-}-"
  tput sgr 0
  echo " "
}

#!###################################################################################################
#!                                                                                                  #
#!                                       Script Start                                               #
#!                                                                                                  #
#!###################################################################################################

# ! Add docker repo
red_text_box 'Adding Docker Repo'
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echo "$(tput setaf 2)Repo Added$(tput setaf 7)"

# ? Replace Faulty Repo URL
blue_text_box 'Replace Faulty Repo URL'
sed -i 's/$releasever/7/g' /etc/yum.repos.d/docker-ce.repo
echo "$(tput setaf 2)Replaced With 7$(tput setaf 7)"

# ? Download Docker Dependencies
blue_text_box 'Download Docker Dependencies'
wget http://mirror.centos.org/centos/7/extras/x86_64/Packages/fuse-overlayfs-0.7.2-6.el7_8.x86_64.rpm
wget http://mirror.centos.org/centos/7/extras/x86_64/Packages/slirp4netns-0.4.3-4.el7_8.x86_64.rpm
wget http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.119.2-1.911c772.el7_8.noarch.rpm

# ! Install Docker Dependencies
sudo yum install fuse-overlayfs-0.7.2-6.el7_8.x86_64.rpm slirp4netns-0.4.3-4.el7_8.x86_64.rpm container-selinux-2.119.2-1.911c772.el7_8.noarch.rpm -y

# ? Delete Excess Files
blue_text_box 'Deleting Excess Files'
rm -rf slirp4netns-0.4.3-4.el7_8.x86_64.rpm
rm -rf fuse-overlayfs-0.7.2-6.el7_8.x86_64.rpm
rm -rf container-selinux-2.119.2-1.911c772.el7_8.noarch.rpm
echo "$(tput setaf 2)Excess Files Deleted$(tput setaf 7)"

# ! Installing Docker
red_text_box 'Installing Docker'
yum install docker-ce docker-ce-cli containerd.io -y

# ! Starting & Enabling Docker
blue_text_box 'Enabling & Starting Docker'
sudo systemctl enable docker
sudo systemctl start docker

echo "$(tput setaf 2)DONE!!$(tput setaf 7)"