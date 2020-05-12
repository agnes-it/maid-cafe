FROM python:3.7
ENV PYTHONUNBUFFERED 1
RUN apt-get update
RUN apt-get -y autoremove
RUN apt-get -y dist-upgrade
RUN apt-get install -y swig libssl-dev dpkg-dev netcat gettext
RUN pip install -U pip
RUN pip install pipenv
RUN mkdir /code
WORKDIR /code
COPY Pipfile /code/
COPY Pipfile.lock /code/
RUN pipenv install --system --deploy --ignore-pipfile
