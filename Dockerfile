FROM mwaeckerlin/base
#ENV VERSION                     "2.3"
#ENV SOURCE                      "https://files.openslides.org/releases/${VERSION}/openslides-${VERSION}.tar.gz"
RUN apk add --no-cache --purge --clean-protected -u python3 python3-dev gcc libc-dev
RUN pip3 install --compile --root /openslides openslides openslides-protocol
#WORKDIR /tmp
#RUN wget -qO- $SOURCE | tar xz
#WORKDIR /tmp/openslides-${VERSION}
#RUN python3 setup.py install

FROM mwaeckerlin/base
#ENV PYTHONVER                   "3.6"
ENV CONTAINER                   "openslides"
RUN apk add --no-cache --purge --clean-protected -u python3
COPY --from=0 /openslides/usr /usr

USER ${RUN_USER}
WORKDIR ${RUN_HOME}

EXPOSE 8000
VOLUME ${RUN_HOME}
