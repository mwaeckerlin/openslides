FROM mwaeckerlin/base
RUN apk add --no-cache --purge --clean-protected -u python3 python3-dev gcc libc-dev
RUN pip3 install --compile --root /openslides openslides openslides-protocol

FROM mwaeckerlin/base
ENV CONTAINER                   "openslides"
RUN apk add --no-cache --purge --clean-protected -u python3
COPY --from=0 /openslides/usr /usr

USER ${RUN_USER}
WORKDIR ${RUN_HOME}

EXPOSE 8000
VOLUME ${RUN_HOME}
