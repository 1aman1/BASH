#!/bin/bash
 
## making bind IPs to ::0/0, enable cluster mode.
sed -i -e "s/^bind 127.0.0.1 -::1$/bind 0.0.0.0/" -e "s/^# cluster-enabled yes$/cluster-enabled yes/" /etc/redis6379/redis.conf
sed -i -e "s/^bind 127.0.0.1 -::1$/bind 0.0.0.0/" -e "s/^# cluster-enabled yes$/cluster-enabled yes/" /etc/redis6779/redis.conf
 
systemctl restart redis6379
systemctl restart redis6779

