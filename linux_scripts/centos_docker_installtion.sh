#!/bin/bash
if [ `whoami` != "root" ]; then
	echo "Must Be root!!!"
	exit
fi

yum -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io
yum -y install docker-ce-`yum list docker-ce --showduplicates | sort -r | grep docker | head -n 1 | awk '{print $2}'`
systemctl enable docker
systemctl start docker

echo "complete."
