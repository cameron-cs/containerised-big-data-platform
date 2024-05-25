ARG BASE_IMAGE=big-data-base-3-java-zk-hadoop
FROM $BASE_IMAGE

ENV HIVE_VERSION=2.3.3
ENV LIB_ICU4J=4.8.1
ENV LIB_POSTGRESQL_VERSION=42.5.4

# Install Hive
ADD assert/apache-hive-$HIVE_VERSION-bin.tar.gz /usr/local
ENV HIVE_HOME=/usr/local/apache-hive-$HIVE_VERSION-bin
ENV PATH $HIVE_HOME/bin:$PATH
RUN 	cd /usr/local	\
	&& rm -rf apache-hive-$HIVE_VERSION-bin.tar.gz	\
	&& cd apache-hive-$HIVE_VERSION-bin	\
	&& mv lib/icu4j-$LIB_ICU4J.jar lib/icu4j-$LIB_ICU4J.jarold  \
	&& mkdir aux-lib	\
	&& echo "export HADOOP_HOME=$HADOOP_HOME" >> conf/hive-env.sh \
	&& echo "export HIVE_CONF_DIR=$HIVE_HOME/conf" >> conf/hive-env.sh \
	&& echo "export HIVE_AUX_JARS_PATH=$HIVE_HOME/aux-lib" >> conf/hive-env.sh

COPY conf/hive/hive-site.xml /usr/local/apache-hive-$HIVE_VERSION-bin/conf
COPY assert/postgresql-$LIB_POSTGRESQL_VERSION.jar /usr/local/apache-hive-$HIVE_VERSION-bin/lib

ENTRYPOINT ["bash"]