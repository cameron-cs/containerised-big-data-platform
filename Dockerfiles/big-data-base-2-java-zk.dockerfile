ARG BASE_IMAGE=big-data-base-1-java
FROM $BASE_IMAGE

ENV ZOO_VERSION=3.4.10

# Install Zookeeper
ADD assert/zookeeper-${ZOO_VERSION}.tar.gz /usr/local
RUN cd /usr/local \
	&& cd zookeeper-$ZOO_VERSION	\
	&& mkdir data	\
	&& mkdir log	

COPY conf/zookeeper/zoo.cfg /usr/local/zookeeper-$ZOO_VERSION/conf
ENV ZOOKEEPER_HOME=/usr/local/zookeeper-$ZOO_VERSION
ENV PATH $ZOOKEEPER_HOME/bin:$PATH

ENTRYPOINT ["bash"]