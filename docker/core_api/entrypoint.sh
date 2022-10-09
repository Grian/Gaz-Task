#!/bin/bash

perl lib/App/S3.pm cb rais || echo ""
# minio.mc policy set public s3/rais # to be replaced with new command (see RAIS-9648)

if [[ "x${start_daemon}" == "xyes" ]]; then
    sudo install -o root -g root -m 0555 /var/www/script/cron/script_wrapper /usr/local/bin/task_starter
    sudo install -o nginx -g crontab -m 0600 /var/www/cron/rais /var/spool/cron/crontabs/nginx
    sudo /etc/init.d/cron start
    sudo /etc/init.d/hgtask start
fi

# NYTProfiler
# start=no,end,init
# file=/tmp/nytprof/nytp.out
#export NYTPROF=start=init:file=/tmp/nytprof/nytp.out

# STARMAN:
# -MCatalyst - preload the module before forking

# Для профилировки кода
# perl -d:NYTProf /var/www/script/rais_core_server.pl --fork --restart

# если нужно посмотреть sql запросы в консоли
# export DBIC_TRACE=1

# Без профилировки, чтобы быстрее стартовать
echo ""
echo "start_daemon='${start_daemon}'"
echo "DBIC_TRACE='${DBIC_TRACE}'"
echo "LOG_TO_STDOUT='${LOG_TO_STDOUT}'"
echo "CONFIG_DIR='${CONFIG_DIR}'"
echo ""
perl /var/www/script/rais_core_server.pl --fork --restart
