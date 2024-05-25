ARG BASE_IMAGE=bigdata-env:v1.0
FROM $BASE_IMAGE

COPY hadoop-entrypoint.sh /usr/bin/
RUN chmod a+x /usr/bin/hadoop-entrypoint.sh

ENTRYPOINT [ "sh", "-c", "./usr/bin/hadoop-entrypoint.sh; bash"]
