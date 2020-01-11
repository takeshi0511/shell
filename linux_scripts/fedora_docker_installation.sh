#!/bin/bash
if [ `whoami` != "root" ]; then
	echo "Must Be root!!!"
	exit
fi

dnf remove docker*
dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf config-manager --set-enabled docker-ce-edge
dnf config-manager --set-enabled docker-ce-test
dnf config-manager --set-disabled docker-ce-edge
dnf -y install docker-ce-`dnf list docker-ce --showduplicates | sort -r | grep docker | head -n 1 | awk '{print $2}'`
systemctl start docker
systemctl enable docker

echo "complete."
