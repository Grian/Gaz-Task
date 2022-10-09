FROM registry.id-network.ru/hypergraph/postgres:14
LABEL maintainer="Dmitry Chernenko <d.chernenko@id-network.ru>"

RUN echo "Europe/Moscow" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="ru_RU.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=ru_RU.UTF-8

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

ADD --chown=postgres addusers.sql.gz /docker-entrypoint-initdb.d
#ADD --chown=postgres http://minio.test.rais.d-net.pro/sql/qa/010_addusers.sql.gz /docker-entrypoint-initdb.d
#ADD --chown=postgres http://minio.test.rais.d-net.pro/sql/qa/030_struct.sql.gz /docker-entrypoint-initdb.d
#ADD http://minio.test.rais.d-net.pro/sql/qa/050_data.tar.gz /tmp/data.tar.gz

#RUN mkdir -p /var/data/1 && tar -xf /tmp/data.tar.gz -C /var/data/1
#RUN tail -n +50 /var/data/1/restore.sql | sed 's|\$\$PATH\$\$|/var/data/1|g' > /docker-entrypoint-initdb.d/099_restore.sql

ARG coreapi_branch=stable
#ADD --chown=postgres http://minio.test.rais.d-net.pro/sql/patches/300_${coreapi_branch}.sql.gz /docker-entrypoint-initdb.d

RUN apt-get update && apt-get install -y make cpanminus
RUN cpanm --quiet --notest Text::Unaccent::PurePerl

USER postgres
WORKDIR /var/data
