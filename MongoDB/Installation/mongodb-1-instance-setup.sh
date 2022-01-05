#!/bin/bash
##  the file is intentionally cluttered but it should  be easy to follow.

yum erase -y $(rpm -qa | grep mongodb-org)
systemctl daemon-reload

##  VERSION 3.6 BLOCK

cat << EOF > /etc/yum.repos.d/mongodb-org-3.6.repo
[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
EOF

## VERSION 3.6 BLOCK ENDS HERE

## VERSION 4.4 BLOCK

#cat << EOF >/etc/yum.repos.d/mongodb-org-3.6.repo
#[mongodb-org-4.4]
#name=MongoDB Repository
#baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.4/x86_64/
#gpgcheck=1
#enabled=1
#gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
#EOF
## VERSION 4.4 BLOCK ENDS HERE

systemctl daemon-reload
yum install -y mongodb-org

cp /etc/mongod.conf /etc/mongod.confBACKUP


sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/mongod.conf
sed -i -e "s/27017/27017/" /etc/mongod.conf

mkdir -p /data/log/mongodb
chown -R mongod:mongod /data/log
sed -i -e "s/var\/log/data\/log/" /etc/mongod.conf

mkdir -p /data/db
chown -R mongod:mongod /data/db
sed -i -e "s/var\/lib\/mongo/data\/db/" /etc/mongod.conf

mkdir -p /var/run/mongodb
chown -R mongod:mongod /var/run/mongodb
sed -i -e "s/run\/mongodb\/mongod.pid/run\/mongodb\/mongod.pid/" /etc/mongod.conf
rm -rf /var/run/mongodb/mongod.pid

systemctl enable mongod
systemctl start mongod
systemctl status mongod
