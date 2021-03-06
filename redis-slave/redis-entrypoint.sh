#!/bin/sh

MASTER_IP=`getent hosts ${MASTER_HOST} | awk '{ print $1 }'`
MYIP=`getent hosts ${HOST} | awk '{ print $1 }'`

sed -i "s/\$MYIP/$MYIP/g" /redis/redis.conf
sed -i "s/\$PORT0/$PORT0/g" /redis/redis.conf

exec docker-entrypoint.sh redis-server /redis/redis.conf --slaveof ${MASTER_IP} ${MASTER_PORT}