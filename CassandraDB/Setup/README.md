# CassandraDB

Cassandra requires java and epel, take these as well if not already installed.

- amazon-linux-extras install -y epel
- yum install -y  java-1.8.0

use Install.sh to get straight forward cassandra installation or for a custom location of db/log use customInstall.sh .

# Config file

Edit these keys if you need.

- listen_address
- rpc_address
- broadcast_rpc_address
