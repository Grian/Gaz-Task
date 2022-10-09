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

ENV POSTGRES_DB=hg_stand_finhub
ENV POSTGRES_PASSWORD=qazwiox
ENV POSTGRES_USER=rais

ADD --chown=postgres http://minio.test.rais.d-net.pro/sql/qa/010_addusers.sql.gz /docker-entrypoint-initdb.d
ADD --chown=postgres http://minio.test.rais.d-net.pro/sql/qa/300_struct.sql.gz /docker-entrypoint-initdb.d
ADD http://minio.test.rais.d-net.pro/sql/qa/350_data.tar.gz /tmp/350.tgz

RUN mkdir -p /var/data && tar -xf /tmp/350.tgz -C /var/data
RUN tail -n +50 /var/data/restore.sql | sed 's|\$\$PATH\$\$|/var/data|g' > /docker-entrypoint-initdb.d/350_restore.sql

USER postgres
WORKDIR /var/data
