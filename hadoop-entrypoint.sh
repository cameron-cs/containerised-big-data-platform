#!/bin/bash

startHadoop(){
  echo "N" | /usr/local/hadoop-2.8.5/sbin/start-all.sh
}

startHbase(){
  ${HBASE_HOME}/bin/start-hbase.sh
}

startSpark(){
  /usr/local/spark-2.4.4-bin-hadoop2.7/sbin/start-all.sh
}

startHive(){
  nohup ${HIVE_HOME}/bin/hive --skiphbasecp --service hiveserver2 2>&1 >> /opt/hive-server2.log &
  nohup ${HIVE_HOME}/bin/hive --skiphbasecp --service metastore 2>&1 >> /opt/hive-metastore.log &
}

main(){
  /usr/sbin/sshd
  sleep 5
  echo "${ZK_ID}" >${ZOOKEEPER_HOME}/data/myid
  zkServer.sh start
  sleep 10

  echo "=====TRY TO START ROLE=${ROLE}======"


  
  if [ "${ROLE}" == "master" ]
  then
    if [ ! -f /opt/first_start ]; then
      echo "=====Initialisation Hadoop [Master]====="
      touch /opt/first_start
      echo "=====Formatting HDFS====="
      hdfs namenode -format
      echo "=====Init Postgres schema ====="
      schematool  -initSchema -dbType postgres
      sleep 10
      echo "===== Starting Hadoop====="
      startHadoop
      sleep 10
      echo "===== Starting HBase====="
      startHbase
      sleep 10
      echo "===== Starting Spark====="
      startSpark
      sleep 10
      echo "===== Start Hive====="
      startHive
    else
      sleep 10
      echo "===== Starting Hadoop====="
      startHadoop
      sleep 10
      echo "===== Starting HBase====="
      startHbase
      sleep 10
      echo "===== Starting Spark====="
      startSpark
      sleep 10
      echo "===== Start Hive====="
      startHive
    fi		
  fi

    if [ "${ROLE}" == "slave" ]
  then
      sleep 90
      echo "===== Starting Hadoop====="
      startHadoop
      sleep 10
      echo "===== Starting HBase====="
      startHbase
      sleep 10
      echo "===== Starting Spark====="
      startSpark
      sleep 10
      echo "===== Start Hive====="
      startHive
    fi	
}

main
