ARG BASE_IMAGE=big-data-base-2-java-zk
FROM $BASE_IMAGE

ENV HADOOP_VERSION=2.8.5

# Install Hadoop Cluster
# https://hadoop.apache.org/docs/r$HIVE_VERSION/hadoop-project-dist/hadoop-common/ClusterSetup.html
ADD assert/hadoop-$HADOOP_VERSION.tar.gz /usr/local
ENV HADOOP_HOME=/usr/local/hadoop-$HADOOP_VERSION
ENV PATH $HADOOP_HOME/bin:$PATH
ENV HADOOP_PREFIX=$HADOOP_HOME
RUN cd $HADOOP_HOME	\
	&& mkdir tmp \
	&& mkdir -p dfs/name \
	&& mkdir -p dfs/data \	
	&& echo "export JAVA_HOME=$JAVA_HOME" >> etc/hadoop/hadoop-env.sh \
	&& echo "export HADOOP_PREFIX=$HADOOP_PREFIX" >> etc/hadoop/hadoop-env.sh \
	&& echo "export JAVA_HOME=$JAVA_HOME" >> etc/hadoop/yarn-env.sh \
	&& echo "slave1" >> etc/hadoop/slaves	\
	&& rpm --rebuilddb	\
	&& yum install -y initscripts \
	&& yum -y install which	\
	&& yum -y install openssh-server \
	&& echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
	&& yum -y install openssh-clients \
	&& /usr/sbin/sshd-keygen -A \
	&& mkdir /root/.ssh \
	&& ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa \
	&& cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys \
	&& echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config \
	&& echo "    StrictHostKeyChecking=no" >> /etc/ssh/ssh_config \
	&& chmod 600 /root/.ssh/authorized_keys 

COPY conf/hadoop/core-site.xml $HADOOP_HOME/etc/hadoop
COPY conf/hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop
COPY conf/hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop
COPY conf/hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop


ENTRYPOINT ["bash"]