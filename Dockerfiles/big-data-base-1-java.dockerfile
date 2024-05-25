FROM centos:centos7.9.2009

# Install JDK
ADD assert/jdk-8u191-linux-x64.tar.gz /usr/local
ENV JAVA_HOME=/usr/local/jdk1.8.0_191
ENV PATH $JAVA_HOME/bin:$PATH

ENTRYPOINT ["bash"]