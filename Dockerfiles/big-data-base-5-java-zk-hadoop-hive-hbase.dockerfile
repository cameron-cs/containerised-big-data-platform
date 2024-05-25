ARG BASE_IMAGE=big-data-base-4-java-zk-hadoop-hive
FROM $BASE_IMAGE

ENV HBASE_VERSION=1.4.8

# Install HBase
ADD assert/hbase-$HBASE_VERSION-bin.tar.gz /usr/local

RUN 	cd /usr/local	\
	&& rm -rf hbase-$HBASE_VERSION-bin.tar.gz	\
	&& cd hbase-$HBASE_VERSION	\
	&& mkdir zookeeper	\
	&& mkdir /var/hbase	\
	&& cat /dev/null > conf/regionservers	\
	&& echo "slave1" >> conf/regionservers	\
	&& echo "export JAVA_HOME=$JAVA_HOME" >> conf/hbase-env.sh	\
	&& echo "export CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib" >> conf/hbase-env.sh 
ENV HBASE_HOME=/usr/local/hbase-$HBASE_VERSION
ENV HBASE_CLASSPATH=$HBASE_HOME/conf
ENV HBASE_LOG_DIR=$HBASE_HOME/logs
ENV PATH $HBASE_HOME/bin:$PATH
COPY conf/hbase/hbase-site.xml /usr/local/hbase-$HBASE_VERSION/conf

ENTRYPOINT ["bash"]