#!/bin/bash
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime
systemctl restart chronyd
yum install rsyslog -y
sed -i 's/#\$ModLoad imudp/\$ModLoad imudp/' /etc/rsyslog.conf
sed -i 's/#\$ModLoad imtcp/\$ModLoad imtcp/' /etc/rsyslog.conf
sed -i 's/#\$UDPServerRun 514/\$UDPServerRun 514/' /etc/rsyslog.conf
sed -i 's/#\$InputTCPServerRun 514/\$InputTCPServerRun 514/' /etc/rsyslog.conf
echo '#Add remote logs
$template RemoteLogs,"/var/log/rsyslog/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?RemoteLogs
& ~' >>/etc/rsyslog.conf
systemctl restart rsyslog
ss -tln|grep 514
sed -i 's/##tcp_listen_port = 60/tcp_listen_port = 60/' /etc/audit/auditd.conf
service auditd restart
