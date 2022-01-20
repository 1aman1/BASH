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
service cassandra stop
service cassandra status
mkdir /CUSTOMLOCATION
cd /CUSTOMLOCATION
mkdir -p cassandra/db/
mkdir -p cassandra/logs/
chown -R cassandra:cassandra cassandra
mv -f /var/lib/cassandra /CUSTOMLOCATION/cassandra/db/
cd /var/lib/
ln -s /CUSTOMLOCATION/cassandra/db/cassandra .
chown -R cassandra:cassandra cassandra
mv -f /var/log/cassandra /CUSTOMLOCATION/cassandra/logs/
cd /var/log/
ln -s /CUSTOMLOCATION/cassandra/logs/cassandra .
chown -R cassandra:cassandra cassandra
service cassandra status
service cassandra start
service cassandra status
chkconfig cassandra on
