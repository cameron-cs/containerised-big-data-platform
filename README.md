# Containerised Big Data Platform

## Overview
This project provides a Big Data testing environment based on Docker. The platform includes several key components:

- Hadoop
- Zookeeper
- HBase
- Hive
- Spark
- Scala
- PostgreSQL

## Table of Contents
- [Software Assets](#software-assets)
- [Download Dependencies](#download-dependencies)
- [Prerequisites](#prerequisites)
- [Build the Docker Images](#build-the-docker-images)
- [Start the Services](#start-the-services)
- [Start from Zero](#start-from-zero)
- [Directory Structure](#directory-structure)
  - [Dockerfiles](#dockerfiles)
  - [Root Directory](#root-directory)
- [Configuration Files](#configuration-files)
- [Entrypoint Script](#entrypoint-script)
- [Notes](#notes)

## Software Assets
The following software versions are used in this project:
- Hadoop: `hadoop-2.8.5.tar.gz`
- Hive: `apache-hive-2.3.3-bin.tar.gz`
- HBase: `hbase-1.4.8-bin.tar.gz`
- Zookeeper: `zookeeper-3.4.10.tar.gz`
- Scala: `scala-2.12.7.tgz`
- JDK: `jdk-8u191-linux-x64.tar.gz`
- Spark: `spark-2.4.4-bin-hadoop2.7.tgz`
- PostgreSQL JDBC Driver: `postgresql-42.5.4.jar`

## Download Dependencies
To download all necessary dependencies, use the following command:
```bash
./download-from-open-repos.sh
```

## Prerequisites

Ensure that Docker and Docker Compose are installed on your environment.

## Build the Docker Images

Use the build.sh script to build the Docker images. You can build specific configurations or all available images. 

For example:

```bash
./build.sh big-data-base-4-java-zk-hadoop-hive
```

or 

```bash
./build.sh big-data-base-6-java-zk-hadoop-hive-hbase-spark
```

Available options:

- big-data-base-1-java

- big-data-base-2-java-zk

- big-data-base-3-java-zk-hadoop

- big-data-base-4-java-zk-hadoop-hive

- big-data-base-5-java-zk-hadoop-hive-hbase

- big-data-base-6-java-zk-hadoop-hive-hbase-spark

## Start the Services

To start the services, run:

```bash
docker-compose up
```

## Fresh start 

If you need to start fresh, removing old containers, use:

```bash
./initial_run.sh
```

## Directory Structure

### Dockerfiles

- big-data-base-1-java.dockerfile

- big-data-base-2-java-zk.dockerfile

- big-data-base-3-java-zk-hadoop.dockerfile

- big-data-base-4-java-zk-hadoop-hive.dockerfile

- big-data-base-5-java-zk-hadoop-hive-hbase.dockerfile

- big-data-base-6-java-zk-hadoop-hive-hbase-spark.dockerfile

- bigdata.dockerfile

### Root Directory

- build.sh: Script to build Docker images.

- docker-compose.yml: Docker Compose configuration file.

- download-from-open-repos.sh: Script to download necessary dependencies.

- hadoop-entrypoint.sh: Entrypoint script for Hadoop.

- initial_run.sh: Script to start from zero, removing old containers.

### Configuration Files

- conf/zookeeper/zoo.cfg: Zookeeper configuration file.

- conf/hive/hive-site.xml: Hive configuration file.

- conf/hbase/hbase-site.xml: HBase configuration file.

### Entrypoint Script

The `hadoop-entrypoint.sh` script handles the initialization and startup of Hadoop, HBase, Spark, and Hive services based on the role of the container (master or slave).

## Notes

- ensure all required dependencies are downloaded before building the images.

- the Docker images are built for the linux/amd64 platform.

- the PostgreSQL container is used to host the Hive Metastore.

