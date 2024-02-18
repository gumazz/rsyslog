#!/bin/bash
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime
systemctl restart chronyd
systemctl status chronyd
date
yum install epel-release -y
yum install nginx  -y
systemctl restart nginx
systemctl status nginx
sed -i 's/error_log \/var\/log\/nginx\/error.log;/error_log \/var\/log\/nginx\/error.log; \nerror_log syslog:server=192.168.50.15:514,tag=nginx_error;/' /etc/nginx/nginx.conf
sed -i 's/access_log  \/var\/log\/nginx\/access.log  main;/access_log syslog:server=192.168.50.15:514,tag=nginx_access,severity=info combined;/' /etc/nginx/nginx.conf
nginx -t
systemctl restart nginx
echo "-w /etc/nginx/nginx.conf -p wa -k nginx_conf
-w /etc/nginx/default.d/ -p wa -k nginx_conf" >> /etc/audit/rules.d/audit.rules
service auditd restart
ausearch -f /etc/nginx/nginx.conf
yum -y install audispd-plugins
sed -i 's/name_format = NONE/name_format = HOSTNAME/' /etc/audit/auditd.conf
sed -i 's/active = no/active = yes/' /etc/audisp/plugins.d/au-remote.conf
sed -i 's/remote_server =/remote_server = 192.168.50.15/' /etc/audisp/audisp-remote.conf
service auditd restart
