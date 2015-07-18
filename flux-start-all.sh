#!/bin/bash

service ssh start
service cassandra start
service elasticsearch start
service apache2 start

nohup zookeeper-server-start ~/pipeline/config/kafka/zookeeper.properties &
nohup kafka-server-start ~/pipeline/config/kafka/server.properties &
nohup schema-registry-start ~/pipeline/config/schema-registry/schema-registry.properties &
nohup kafka-rest-start ~/pipeline/config/kafka-rest/kafka-rest.properties &

nohup ~/incubator-zeppelin/bin/zeppelin-daemon.sh --config ~/pipeline/config/zeppelin start &
nohup ~/spark-1.4.0-bin-hadoop2.6/sbin/start-master.sh --webui-port 6060 &
nohup ~/spark-1.4.0-bin-hadoop2.6/sbin/start-slave.sh --webui-port 6061 spark://$HOSTNAME:7077 &
nohup ~/spark-1.4.0-bin-hadoop2.6/sbin/start-thriftserver.sh &