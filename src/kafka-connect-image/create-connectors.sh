#!/bin/sh

sleep 5;
curl -X POST -H "Content-Type: application/json" --data '{ "name": "quickstart-jdbc-source", "config": { "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max": 1, "connection.url": "jdbc:mysql://app-mysql.mysql.svc.cluster.local:3306/connect_test?user=root&password=confluent", "mode": "incrementing", "incrementing.column.name": "id", "timestamp.column.name": "modified", "topic.prefix": "quickstart-jdbc-", "poll.interval.ms": 1000 } }' app-kafka-connect.kafka-connect.svc.cluster.local:28083/connectors;
sleep 5;
curl -X POST -H "Content-Type: application/json" --data '{"name": "quickstart-avro-file-sink", "config": {"connector.class":"org.apache.kafka.connect.file.FileStreamSinkConnector", "tasks.max":"1", "topics":"quickstart-jdbc-test", "file": "/tmp/jdbc-output.txt"}}' http://app-kafka-connect.kafka-connect.svc.cluster.local:28083/connectors;
