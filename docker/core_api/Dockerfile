FROM registry.id-network.ru/hypergraph/catalyst:3.2-dev
LABEL maintainer="Dmitry Chernenko <d.chernenko@id-network.ru>"

RUN echo 'nginx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mc carton net-tools telnet wget iputils-ping htop atop \
vim joe less perltidy libterm-readline-gnu-perl libexpat1-dev libzip-dev libssl-dev libpq-dev strace lsof && \
echo '&parse_options("HistFile=$ENV{HOME}/.perldb_history");' >> /root/.perldb
#libterm-readline-perl-perl

USER root
WORKDIR /var/www

ARG coreapi_config=rais_core_api
ADD --chown=nginx ${coreapi_config}.yaml /spool/rais_core_api.yaml
ADD --chown=nginx rais_daemon.yaml /spool/rais_daemon.yaml
ADD hgtask /etc/init.d/hgtask


ADD entrypoint.sh /

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
