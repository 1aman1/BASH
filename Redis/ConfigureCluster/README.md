# Redis Guide

- This script enables cluster configuration in the redis instances.

- Then restarts the services to take effect.

- To create cluster on 3 nodes with 2 redis instances, run the redis installation setup on total 3 nodes followed by below cluster forming command.

- /usr/local/bin/redis-cli -p 6379 --cluster create IP1:6379 IP2:6379 IP3:6379 IP2:6779 IP3:6779 IP1:6779 --cluster-replicas 1.
