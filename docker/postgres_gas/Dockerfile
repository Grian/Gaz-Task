FROM postgres:14.5
LABEL maintainer="none@none.ru>"

RUN echo "Europe/Moscow" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="ru_RU.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=ru_RU.UTF-8

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8
USER postgres
ADD ./01-create-tables.sh  /docker-entrypoint-initdb.d/
WORKDIR /var/data
