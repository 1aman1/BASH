#!/bin/bash

# it requires java
yum install -y java-1.8.0
java -version

cat << EOF > /etc/yum.repos.d/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://downloads.apache.org/cassandra/redhat/40x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.apache.org/cassandra/KEYS
EOF

systemctl daemon-reload
yum install -y cassandra

# check if it installed properly
rpm -qi cassandra

cat << EOF > /etc/systemd/system/cassandra.service
[Unit]
Description=Apache Cassandra
After=network.target

[Service]
PIDFile=/var/run/cassandra/cassandra.pid
User=cassandra
Group=cassandra
ExecStart=/usr/sbin/cassandra -f -p /var/run/cassandra/cassandra.pid
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start cassandra
systemctl enable cassandra
systemctl status cassandra

# if cqlsh throws errors of python library uncomment these
#yum install -y pip
#pip install cqlsh
