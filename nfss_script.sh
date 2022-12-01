#!/bin/sh
yum install -y nfs-utils
systemctl enable firewalld.service --now
firewall-cmd --permanent --add-service="nfs3"
firewall-cmd --permanent --add-service="rpc-bind"
firewall-cmd --permanent --add-service="mountd"
firewall-cmd --reload
systemctl enable nfs --now
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload
echo "/srv/share 192.168.50.11/32(rw,sync,root_squash)" >> /etc/exports
exportfs -r
