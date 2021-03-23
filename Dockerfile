FROM openjdk:8-jre-alpine

ENV VERSION=2.17.7-M8
LABEL version=nl.clockwork.ebms.admin.version=$EBMS_VERSION

ENV EBMSPATH /ebms
ENV JDBCJAR=postgresql-42.2.14.jar
ENV PATH ${EBMSPATH}:$PATH

RUN addgroup -S ebms \
 && adduser -S ebms -G ebms \
 && mkdir -p ${EBMSPATH}/certs \
 && chmod -R 777 ${EBMSPATH} \
 && chown ebms:ebms ${EBMSPATH} \
 && wget https://jdbc.postgresql.org/download/${JDBCJAR} -O ${EBMSPATH}/${JDBCJAR}

WORKDIR $EBMSPATH

COPY ebms-admin-${VERSION}.jar ${EBMSPATH}
COPY log4j2.xml ${EBMSPATH}
COPY *.properties ${EBMSPATH}
COPY start.sh ${EBMSPATH}
COPY truststore.p12 ${EBMSPATH}/certs

RUN chmod a+x start.sh

EXPOSE 8080 8088

USER ebms

ENTRYPOINT [ "start.sh" ]
CMD ["-soap"]