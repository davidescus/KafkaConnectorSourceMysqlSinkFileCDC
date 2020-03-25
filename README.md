# KafkaConnectorSourceMysqlSinkFileCDC
This is a demo, do not use it in production!!! (yet)  
You can find bellow the same infrastructure implemented on docker   
https://docs.confluent.io/5.0.0/installation/docker/docs/installation/connect-avro-jdbc.html

### Environment used for test
* Ubuntu 18.04
* Kubectl 1.17.4
* Kubernetes 1.17.3
* VirtualBox 6.1
* Minikube 1.8.2 

### What it does:
* Source records from MySql table ```test``` into Kafka
* Sink data from kafka into file

### How it works:
* clone project && go to ```src``` dir
* run:
```
kubectl apply -f mysql
kubectl apply -f zookeeper
kubectl apply -f kafka
kubectl apply -f kafka-connect
```
* wait till ```pod/job-kafka-connect...``` is Completed
* view results:
```
kubectl -n kafka-connect exec pod/app-kafka-connect-{generated_id} -c kafka-connect-app cat /tmp/jdbc-output.txt 
```
* create a new entry into ```connect_test.test``` table
```
kubectl -n mysql exec -it pod/mysql-{generated_id} bash
mysql -u root -p
confluent
use connect_test;
INSERT INTO test (name, email, department) VALUES ('I-like-kubernetes', 'name@domain.com', 'engineering');
``` 
* entry that you just created must be visible by viewing results again

### TODO:
* Use kubernetes secrets for password management
* Use persistent volumes for Zookeeper, Kafka and MySql
* Implement cluster mode for Zookeeper and Kafka



