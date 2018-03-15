FROM mwaeckerlin/ubuntu-base
MAINTAINER mwaeckerlin

ENV OPENSLIDES_USER_DATA_PATH "/data"

#RUN apt-get update && apt-get install -y build-essential python3 python3-dev python3-pip python3-venv
##RUN ln $(which pip3) /usr/bin/pip
#RUN mkdir /openslides
#WORKDIR /openslides
#RUN python3 -m venv .virtualenv
#RUN . .virtualenv/bin/activate && pip3 install --upgrade setuptools pip && pip install openslides
#CMD . .virtualenv/bin/activate && openslides

RUN apt-get update && apt-get install -y python3 python3-setuptools python3-dev gcc sudo
ENV VERSION "2.1.1"
ENV SOURCE "https://files.openslides.org/releases/${VERSION}/openslides-${VERSION}.tar.gz"
RUN wget -qOopenslides-${VERSION}.tar.gz $SOURCE
RUN tar xf openslides-${VERSION}.tar.gz
WORKDIR openslides-${VERSION}
RUN python3 setup.py install

# bugfix for https://github.com/OpenSlides/OpenSlides/issues/3574#issuecomment-364559454
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install 'daphne<2'

RUN adduser --system --disabled-login --disabled-password --home $OPENSLIDES_USER_DATA_PATH openslides
WORKDIR $OPENSLIDES_USER_DATA_PATH

EXPOSE 8000
VOLUME $OPENSLIDES_USER_DATA_PATH
