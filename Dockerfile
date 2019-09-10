FROM sonatype/nexus3:3.15.2

MAINTAINER "xing.jiudong@trans-cosmos.com.cn"

USER root

ENV APT_PLUGIN_VERSION 1.0.8
ENV NEXUS_VERSION 3.15.2-01

ENV CONF /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/${NEXUS_VERSION}/nexus-core-feature-${NEXUS_VERSION}-features.xml
ENV PLUGIN_PATH ${NEXUS_HOME}/system/net/staticsnow/nexus-repository-apt/${APT_PLUGIN_VERSION}

RUN mkdir -p ${PLUGIN_PATH}
 
COPY plugins/* ${PLUGIN_PATH}/
COPY conf/* /tmp/
RUN chown nexus:nexus ${PLUGIN_PATH}/*

RUN sed -i '/<details>org.sonatype.nexus.assemblies:nexus-core-feature/r /tmp/apt_version.conf' ${CONF} && \
    sed -i '/xmlns=/r /tmp/apt_name.conf' ${CONF}

VOLUME ${NEXUS_HOME}
USER nexus
