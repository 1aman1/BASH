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

####################################################
#A STANDALONE MONGO is DONE TILL HERE.
####################################################
# FOR A CLUSTER, KEEP REFERRING FURTHER...
####################################################

####################################################
#mongodb1.service
####################################################

cat << EOF > /etc/systemd/system/mongodb1.service
[Unit]
Description=MongoDB Database Server
After=network.target
[Service]
User=root
Group=root
ExecStart=/usr/bin/mongod --config /etc/mongodb1.conf
PIDFile=/var/run/mongodb1/mongodb1.pid
[Install]
WantedBy=multi-user.target
EOF

##
chown mongod:mongod /etc/systemd/system/mongodb1.service
chmod 755 /etc/systemd/system/mongodb1.service

## copy a config and make it usable for mongod[1,2,3...N]
cp /etc/mongod.confBACKUP /etc/mongodb1.conf
chown mongod:mongod /etc/mongodb1.conf


sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/mongodb1.conf
sed -i -e "s/27017/27018/" /etc/mongodb1.conf

mkdir -p /data/log1/mongodb
chown -R mongod:mongod /data/log1
sed -i -e "s/var\/log/data\/log1/" /etc/mongodb1.conf

mkdir -p /data/db1
chown -R mongod:mongod /data/db1
sed -i -e "s/var\/lib\/mongo/data\/db1/" /etc/mongodb1.conf

mkdir -p /var/run/mongodb1
chown -R mongod:mongod /var/run/mongodb1
sed -i -e "s/run\/mongodb\/mongod.pid/run\/mongodb1\/mongodb1.pid/" /etc/mongodb1.conf
rm -rf /var/run/mongodb1/mongodb1.pid


systemctl daemon-reload
systemctl enable mongodb1.service
systemctl start mongodb1.service
systemctl status mongodb1.service


####################################################
#mongodb2.service
####################################################

cat << EOF > /etc/systemd/system/mongodb2.service
[Unit]
Description=MongoDB Database Server
After=network.target
[Service]
User=root
Group=root
ExecStart=/usr/bin/mongod --config /etc/mongodb2.conf
PIDFile=/var/run/mongodb2/mongodb2.pid
[Install]
WantedBy=multi-user.target
EOF

##
chown mongod:mongod /etc/systemd/system/mongodb2.service
chmod 755 /etc/systemd/system/mongodb2.service

## copy a config and make it usable for mongod[1,2,3...N]
cp /etc/mongod.confBACKUP /etc/mongodb2.conf
chown mongod:mongod /etc/mongodb2.conf


sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/mongodb2.conf
sed -i -e "s/27017/27019/" /etc/mongodb2.conf

mkdir -p /data/log2/mongodb
chown -R mongod:mongod /data/log2
sed -i -e "s/var\/log/data\/log2/" /etc/mongodb2.conf

mkdir -p /data/db2
chown -R mongod:mongod /data/db2
sed -i -e "s/var\/lib\/mongo/data\/db2/" /etc/mongodb2.conf

mkdir -p /var/run/mongodb2
chown -R mongod:mongod /var/run/mongodb2
sed -i -e "s/run\/mongodb\/mongod.pid/run\/mongodb2\/mongodb2.pid/" /etc/mongodb2.conf
rm -rf /var/run/mongodb2/mongodb2.pid


systemctl daemon-reload
systemctl enable mongodb2.service
systemctl start mongodb2.service
systemctl status mongodb2.service
