#!/bin/bash

TO_BUILD='
big-data-base-1-java
big-data-base-2-java-zk
big-data-base-3-java-zk-hadoop
big-data-base-4-java-zk-hadoop-hive
big-data-base-5-java-zk-hadoop-hive-hbase
big-data-base-6-java-zk-hadoop-hive-hbase-spark
'

# Set the last one image for build and run

# Check if the argument is set
if [ -n "$1" ]; then
  # The argument is set, so fulfill the condition
  echo "The argument is set to $1"
  THE_LAST_ONE=$1
else
  # The argument was not set, so do nothing
  echo "The argument is not set."
  # by defalut we build all images
  THE_LAST_ONE=big-data-base-6-java-zk-hadoop-hive-hbase-spark
fi

for i in $TO_BUILD; do

    echo "Build $i"
    docker build --platform linux/amd64 -f Dockerfiles/$i.dockerfile -t $i:latest .
    export LAST_BASE_IMAGE=$i

    if [[ $i == $THE_LAST_ONE ]]; then
        break
    fi
done

docker build --platform linux/amd64 --build-arg "BASE_IMAGE=$LAST_BASE_IMAGE:latest" -f Dockerfiles/bigdata.dockerfile -t bigdata-plat .
