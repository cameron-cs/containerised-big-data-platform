ARG BASE_IMAGE=big-data-base-5-java-zk-hadoop-hive-hbase
FROM $BASE_IMAGE

ENV SPARK_VERSION=2.4.4-bin-hadoop2.7
ENV SCALA_VERSION=2.12.7
ENV HIVE_VERSION=2.3.3
ENV HBASE_VERSION=1.4.8

ENV METRIC_SCORE_VER=2.2.0


# Spark
ADD assert/spark-$SPARK_VERSION.tgz   /usr/local
ADD assert/scala-$SCALA_VERSION.tgz 	/usr/local

RUN cd /usr/local	\
	&& rm -rf spark-$SPARK_VERSION.tgz	\
	&& rm -rf scala-$SCALA_VERSION.tgz \
	&& cd spark-$SPARK_VERSION	\
	&& echo "slave1" >> conf/slaves	\
	&& echo "export SCALA_HOME=/usr/local/scala-$SCALA_VERSION" >> conf/spark-env.sh	\
	&& echo "export JAVA_HOME=$JAVA_HOME" >> conf/spark-env.sh	\
	&& echo "export HADOOP_HOME=$HADOOP_HOME" >> conf/spark-env.sh	\
	&& echo "export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop" >> conf/spark-env.sh	\
	&& echo "SPARK_MASTER_IP=master" >> conf/spark-env.sh	\
	&& echo "SPARK_LOCAL_DIRS=/usr/local/spark-$SPARK_VERSION" >> conf/spark-env.sh	\
	&& echo "SPARK_DRIVER_MEMORY=1G" >> conf/spark-env.sh \
	&& cp /usr/local/apache-hive-$HIVE_VERSION-bin/conf/hive-site.xml conf/

COPY assert/postgresql-42.5.4.jar /usr/local/spark-$SPARK_VERSION/jars


RUN cp /usr/local/apache-hive-$HIVE_VERSION-bin/lib/hive-hbase-handler-$HIVE_VERSION.jar /usr/local/hbase-$HBASE_VERSION/lib	\
    && cp /usr/local/apache-hive-$HIVE_VERSION-bin/lib/hive-hbase-handler-$HIVE_VERSION.jar /usr/local/spark-$SPARK_VERSION/jars	\
	&& cp /usr/local/apache-hive-$HIVE_VERSION-bin/lib/metrics-core-$METRIC_SCORE_VER.jar /usr/local/spark-$SPARK_VERSION/jars  \
	&& cp -r /usr/local/hbase-$HBASE_VERSION/lib/hbase-metrics* /usr/local/spark-$SPARK_VERSION/jars  \
	&& cp /usr/local/hbase-$HBASE_VERSION/lib/hbase-hadoop2-compat-$HBASE_VERSION.jar /usr/local/spark-$SPARK_VERSION/jars  \
	&& cp /usr/local/hbase-$HBASE_VERSION/lib/hbase-hadoop-compat-$HBASE_VERSION.jar /usr/local/spark-$SPARK_VERSION/jars  \
	&& cp /usr/local/hbase-$HBASE_VERSION/lib/hbase-protocol-$HBASE_VERSION.jar /usr/local/spark-$SPARK_VERSION/jars  \
	&& cp /usr/local/hbase-$HBASE_VERSION/lib/hbase-common-$HBASE_VERSION.jar /usr/local/spark-$SPARK_VERSION/jars  \
	&& cp /usr/local/hbase-$HBASE_VERSION/lib/hbase-server-$HBASE_VERSION.jar /usr/local/spark-$SPARK_VERSION/jars  \
	&& cp /usr/local/hbase-$HBASE_VERSION/lib/hbase-client-$HBASE_VERSION.jar /usr/local/spark-$SPARK_VERSION/jars 


ENTRYPOINT ["bash"]