FROM python:2.7
ENV PYTHONUNBUFFERED 1
RUN apt-get update
RUN apt-get -y autoremove
RUN apt-get -y dist-upgrade
RUN apt-get install -y swig libssl-dev dpkg-dev netcat gettext
RUN pip install -U pip
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install --no-cache-dir -Ur requirements.txt
