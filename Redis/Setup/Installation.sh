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
mkdir -p /var/redis6379/ /var/redis6779/ /etc/redis6379/ /etc/redis6779/
find /etc/redis6779/ /etc/redis6379/ -maxdepth 0 -exec cp /root/redis-stable/redis.conf {} \;
 
##substitutes config with respect to redis6379 conf
sed -i -e "s/^pidfile \/var\/run\/redis_6379.pid/pidfile \/var\/run\/redis6379.pid/" -e "s/^# supervised auto$/supervised systemd/" -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/redis6379\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile \"\"$/logfile \/var\/log\/redis6379.log/" /etc/redis6379/redis.conf
 
##substitutes config with respect to redis6779 conf
sed -i -e "s/port 6379/port  6779/" -e "s/^pidfile \/var\/run\/redis_6379.pid/pidfile \/var\/run\/redis6779.pid/" -e "s/^# supervised auto$/supervised systemd/" -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/redis6779\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile \"\"$/logfile \/var\/log\/redis6779.log/" /etc/redis6779/redis.conf
 
 
## for creating redis6379 & redis6779 service files
cat << EOF > /etc/systemd/system/redis6379.service
[Unit]
Description=Redis In-Memory Data Store
After=network.target
 
[Service]
User=root
Group=root
ExecStart=/usr/local/bin/redis-server /etc/redis6379/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always
Type=forking
 
[Install]
WantedBy=multi-user.target
EOF
 
cat << EOF > /etc/systemd/system/redis6779.service
[Unit]
Description=Redis In-Memory Data Store
After=network.target
 
[Service]
User=root
Group=root
ExecStart=/usr/local/bin/redis-server /etc/redis6779/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always
Type=forking
 
[Install]
WantedBy=multi-user.target
EOF
 
##safe steps
systemctl daemon-reload
systemctl enable redis6779
systemctl enable redis6379
echo "services need to be manually started ---verify via--- /usr/local/bin/redis-cli -c -p 6379 OR 6779"
echo "---1/1---"
