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

# ! Add centos repos
red_text_box 'Adding Centos Repos'
touch /etc/yum.repos.d/sec.repo
echo '[centos]
name=CentOS-7
baseurl=http://ftp.heanet.ie/pub/centos/7/os/x86_64/
enabled=1
gpgcheck=1
gpgkey=http://ftp.heanet.ie/pub/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7' >> /etc/yum.repos.d/sec.repo
echo "$(tput setaf 2)Repo Added$(tput setaf 7)"

# ? update repositories
blue_text_box 'Updating Repositories'
yum update -y

# ? Installing nano, wget & yum-utils
blue_text_box 'Installing nano, wget & yum-utils'
yum install wget nano yum-utils -y

# ? Installing EPEL
blue_text_box 'Installing EPEL'
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y

# ! Updating Repos
red_text_box 'Updating Repos'
yum update
yum upgrade -y
echo "$(tput setaf 2)DONE!!$(tput setaf 7)"