FROM mwaeckerlin/base
RUN apk add --no-cache --purge --clean-protected -u python3 python3-dev gcc libc-dev libffi-dev openssl-dev
RUN pip3 install --upgrade pip
RUN pip install --compile --root /openslides openslides openslides-protocol

FROM mwaeckerlin/base
ENV CONTAINERNAME              "openslides"
RUN apk add --no-cache --purge --clean-protected -u python3
COPY --from=0 /openslides/usr /usr

USER ${RUN_USER}
WORKDIR ${RUN_HOME}

EXPOSE 8000
VOLUME ${RUN_HOME}
