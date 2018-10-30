FROM sonatype/nexus3:3.14.0

MAINTAINER "xing.jiudong@trans-cosmos.com.cn"

USER root

ENV APT_PLUGIN_VERSION 1.0.8
ENV NEXUS_VERSION 3.14.0-04
ENV CONF /opt/sonatype/nexus/system/org/sonatype/nexus/assemblies/nexus-core-feature/${NEXUS_VERSION}/nexus-core-feature-${NEXUS_VERSION}-features.xml

RUN mkdir -p ${NEXUS_HOME}/system/net/staticsnow/nexus-repository-apt/${APT_PLUGIN_VERSION}
 
COPY plugins/nexus-repository-apt-${APT_PLUGIN_VERSION}.jar ${NEXUS_HOME}/system/net/staticsnow/nexus-repository-apt/${APT_PLUGIN_VERSION}/
COPY ./conf/* /tmp/
RUN chown nexus:nexus ${NEXUS_HOME}/system/net/staticsnow/nexus-repository-apt/${APT_PLUGIN_VERSION}/nexus-repository-apt-${APT_PLUGIN_VERSION}.jar

RUN sed -i '/<details>org.sonatype.nexus.assemblies:nexus-core-feature/r /tmp/apt_version.conf' ${CONF} && \
    sed -i '/xmlns=/r /tmp/apt_name.conf' ${CONF}

VOLUME ${NEXUS_HOME}
USER nexus
