FROM mwaeckerlin/base
ENV VERSION                     "2.3"
ENV SOURCE                      "https://files.openslides.org/releases/${VERSION}/openslides-${VERSION}.tar.gz"
RUN apk add --no-cache --purge --clean-protected -u python3 python3-dev gcc libc-dev
WORKDIR /tmp
RUN wget -qO- $SOURCE | tar xz
WORKDIR /tmp/openslides-${VERSION}
RUN python3 setup.py install

FROM mwaeckerlin/base
ENV PYTHONVER                   "3.6"
ENV OPENSLIDES_USER_DATA_PATH   "/data"
ENV CONTAINER                   "openslides"
RUN apk add --no-cache --purge --clean-protected -u python3
COPY --from=0 /usr/bin/openslides /usr/bin/openslides
COPY --from=0 /usr/lib/python${PYTHONVER} /usr/lib/python${PYTHONVER}

USER ${RUN_USER}
WORKDIR ${OPENSLIDES_USER_DATA_PATH}

EXPOSE 8000
VOLUME $OPENSLIDES_USER_DATA_PATH
