#!/bin/bash
cat << EOF > /etc/yum.repos.d/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://downloads.apache.org/cassandra/redhat/40x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.apache.org/cassandra/KEYS
EOF

yum install -y  cassandra
service cassandra start
service cassandra status
chkconfig cassandra on
