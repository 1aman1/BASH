# CassandraDB

Cassandra requires java, python & epel, perform these as well if not already installed.

- amazon-linux-extras install -y epel
- yum install -y  java-1.8.0
- yum install -y pip

Install.sh will help in getting required CassandraDB installation.
Follow customInstall.sh also if service needs to be relocated to a different directory other than /var/ .


# Config file

Edit these keys if you need.

- listen_address
- rpc_address
- broadcast_rpc_address
