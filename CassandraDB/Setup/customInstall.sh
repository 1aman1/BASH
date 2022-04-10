#!/bin/bash

# stop operation
systemctl stop cassandra
systemctl status cassandra

cd /ANOTHERDIRECTORY
mkdir -p cassandra/db/
mkdir -p cassandra/logs/
chown -R cassandra:cassandra cassandra

mv -f /var/lib/cassandra /ANOTHERDIRECTORY/cassandra/db/
cd /var/lib/
ln -s /ANOTHERDIRECTORY/cassandra/db/cassandra .
chown -R cassandra:cassandra cassandra

mv -f /var/log/cassandra /ANOTHERDIRECTORY/cassandra/logs/
cd /var/log/
ln -s /ANOTHERDIRECTORY/cassandra/logs/cassandra .
chown -R cassandra:cassandra cassandra

# resume operation
systemctl start cassandra
systemctl status cassandra
