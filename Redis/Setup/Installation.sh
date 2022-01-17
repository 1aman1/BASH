
#!/bin/bash
yum groupinstall "Development Tools" -y

##download package and unzip
wget -c http://download.redis.io/redis-stable.tar.gz
tar -xvzf redis-stable.tar.gz
cd redis-stable

##source the code
make
make install

##create necessary directories to use further - copy configs in respective locations
mkdir -p /var/redisM/ /var/redisS/ /etc/redismaster/ /etc/redisslave/
find /etc/redisslave/ /etc/redismaster/ -maxdepth 0 -exec cp /root/redis-stable/redis.conf {} \;

##substitutes config with respect to master conf
sed -i -e "s/^pidfile \/var\/run\/redis_6379.pid/pidfile \/var\/run\/redisM.pid/" -e "s/^# supervised auto$/supervised systemd/" -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/redisM\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile \"\"$/logfile \/var\/log\/redisM.log/" /etc/redismaster/redis.conf

##substitutes config with respect to slave conf
sed -i -e "s/port 6379/port  6679/" -e "s/^pidfile \/var\/run\/redis_6379.pid/pidfile \/var\/run\/redisS.pid/" -e "s/^# supervised auto$/supervised systemd/" -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/redisS\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile \"\"$/logfile \/var\/log\/redisS.log/" /etc/redisslave/redis.conf


## for creating master & slave service files
cat << EOF > /etc/systemd/system/redismaster.service
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=root
Group=root
ExecStart=/usr/local/bin/redis-server /etc/redismaster/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always
Type=forking

[Install]
WantedBy=multi-user.target
EOF

cat << EOF > /etc/systemd/system/redisslave.service
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=root
Group=root
ExecStart=/usr/local/bin/redis-server /etc/redisslave/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always
Type=forking

[Install]
WantedBy=multi-user.target
EOF

##safe steps
systemctl daemon-reload
systemctl enable redisslave
systemctl enable redismaster
echo -e "\e[1;31m services need to be manually started via systemctl  \e[0m"
echo " then connect by -- /usr/local/bin/redis-cli -c -p 6379 OR 6679"
echo "---1/1---"
