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

# ! Add Mysql Repo
red_text_box 'Adding Mysql Repo'
rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm
rm -rf /etc/yum.repos.d/mysql-community*
touch /etc/yum.repos.d/mysql-community.repo
echo '[mysql80-community]
name=MySQL 8.0 Community Server
baseurl=http://repo.mysql.com/yum/mysql-8.0-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql-connectors-community]
name=MySQL Connectors Community
baseurl=http://repo.mysql.com/yum/mysql-connectors-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql-tools-community]
name=MySQL Tools Community
baseurl=http://repo.mysql.com/yum/mysql-tools-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql' >> /etc/yum.repos.d/mysql-community.repo


echo "$(tput setaf 2)Repository Added$(tput setaf 7)"

# ? Update yum repos
blue_text_box 'Updating Mysql Repos'
yum update -y

# ! Installing MYSQL-Community-Server
red_text_box 'Installing Mysql Community Server'
yum install mysql-community-server -y

# ? Enabling & Starting MYSQL
systemctl enable mysqld
systemctl start mysqld

# ! Return Temporary MYSQL Password
sudo grep 'temporary password' /var/log/mysqld.log

echo "$(tput setaf 2)Please use mysql_secure_installation Command to configure mysql$(tput setaf 7)"