#!/bin/bash

mkdir -p ./assert
curl https://archive.apache.org/dist/hive/hive-2.3.3/apache-hive-2.3.3-bin.tar.gz -o ./assert/apache-hive-2.3.3-bin.tar.gz
curl https://archive.apache.org/dist/hadoop/core/hadoop-2.8.5/hadoop-2.8.5.tar.gz -o ./assert/hadoop-2.8.5.tar.gz
curl https://archive.apache.org/dist/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz -o ./assert/spark-2.4.4-bin-hadoop2.7.tgz
curl https://archive.apache.org/dist/hbase/1.4.8/hbase-1.4.8-bin.tar.gz -o ./assert/hbase-1.4.8-bin.tar.gz
curl https://archive.apache.org/dist/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz -o ./assert/zookeeper-3.4.10.tar.gz
curl https://downloads.lightbend.com/scala/2.12.7/scala-2.12.7.tgz -o ./assert/scala-2.12.7.tgz
curl https://jdbc.postgresql.org/download/postgresql-42.5.4.jar -o ./assert/postgresql-42.5.4.jar
curl https://repo.huaweicloud.com/java/jdk/8u191-b12/jdk-8u191-linux-x64.tar.gz -o ./assert/jdk-8u191-linux-x64.tar.gz
# curl https://archive.apache.org/dist/kafka/2.4.1/kafka_2.12-2.4.1.tgz -o ./assert/kafka_2.12-2.4.1.tgz