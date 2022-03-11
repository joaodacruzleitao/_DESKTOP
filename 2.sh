#!/usr/bin/env bash

# GEOIP INSTALL CENTOS 6
# ======================================
cd /root || exit
wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
rpm -ivh rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
yum install geoip-devel geoip -y

# GEOIP CLOUDLINUX
# ======================================
cd /root || exit
yum install geoip-devel -y

chattr +i /usr/local/maldetect/antivirus.pl

tmpfs                   /var/cache/nginx/cache  tmpfs   size=512M,nr_inodes=10k,mode=0777 0 0

   ps -ylC httpd | awk '{x += $8;y += 1} END {print "Apache Memory Usage (MB): "x/1024; print "Average Proccess Size (MB): "x/((y-1)*1024)}'

mkdir -p /home/_src
cd /home/_src || exit
wget https://github.com/zend-dev/ZendOptimizerPlus/archive/master.zip
mv master ZenOptimizerPlus.zip
unzip ZenOptimizerPlus.zip
cd ZendOptimizerPlus-master || exit
/opt/alt/php54/usr/bin/phpize
./configure --with-php-config=/opt/alt/php54/usr/bin/php-config
make
cp /home/_src/ZendOptimizerPlus-master/modules/opcache.so /opt/alt/php54/usr/lib64/php/modules/
cd /home/_src || exit
rm -rf -- *

mkdir -p /home/_src
cd /home/_src || exit
wget https://github.com/zend-dev/ZendOptimizerPlus/archive/master.zip
mv master ZenOptimizerPlus.zip
unzip ZenOptimizerPlus.zip
cd ZendOptimizerPlus-master || exit
/opt/alt/php53/usr/bin/phpize
./configure --with-php-config=/opt/alt/php53/usr/bin/php-config
make
cp /home/_src/ZendOptimizerPlus-master/modules/opcache.so /opt/alt/php53/usr/lib64/php/modules/
cd /home/_src || exit
rm -rf -- *

mkdir -p /home/_src
cd /home/_src  || exit
wget https://github.com/zend-dev/ZendOptimizerPlus/archive/master.zip
mv master ZenOptimizerPlus.zip
unzip ZenOptimizerPlus.zip
cd ZendOptimizerPlus-master || exit
/opt/alt/php52/usr/bin/phpize
./configure --with-php-config=/opt/alt/php52/usr/bin/php-config
make
cp /home/_src/ZendOptimizerPlus-master/modules/opcache.so /opt/alt/php52/usr/lib64/php/modules/
cd /home/_src || exit
rm -rf -- *

find / -exec ls -la {} \; | awk '{ if ( $8==2003) printf $0"\n" }'

function NGINXvhosts1b {
    #---------------------------------------
    # Função a ser usada na NGINXvhosts2b
    # e que serve para criar cada ficheiro
    # de configuração de um alojamento
    # recebendo como parametro o sub/dominio
    # SEM CACHE
    #---------------------------------------
    for DOMAIN in "$@"; do
        ROOT=$( grep documentroot </var/cpanel/userdata/"$USER"/"$DOMAIN" | awk '{print $2}')
        ALIASES=$( grep serveralias </var/cpanel/userdata/"$USER"/"$DOMAIN" | sed "s/serveralias: //g" | sed "s/www\.\*\.$DOMAIN//g")
        VHOSTFILE="/etc/nginx/vhosts/$DOMAIN"
        JONIX=$(
                 cat <<EOF
pagespeed LoadFromFileMatch "^https?://$DOMAIN/" "$ROOT/";
EOF
        )
        VARNISH=$(
                   cat <<EOF
pagespeed MapRewriteDomain $DOMAIN $DOMAIN:8081;
EOF
        )

        for DOMAIN2 in $ALIASES; do
            JONIX=$(
                     cat <<EOF
${JONIX}
   pagespeed LoadFromFileMatch "^https?://$DOMAIN2/" "$ROOT/";
EOF
            )
            VARNISH=$(
                       cat <<EOF
${VARNISH}
   pagespeed MapRewriteDomain $DOMAIN2 $DOMAIN2:8081;
EOF
            )
        done
        cat >"$VHOSTFILE"  <<EOF
upstream ${DOMAIN}_P {
    server ${IP}:8081;
    keepalive 8;
}

server {
   error_log /var/log/nginx/vhost-error_log warn;
   listen $IP:80;
   server_name $DOMAIN $ALIASES;
   access_log /usr/local/apache/domlogs/$DOMAIN bytes_log;
   access_log /usr/local/apache/domlogs/$DOMAIN combined;
   root $ROOT;

   ${VARNISH}
   ${JONIX}
   pagespeed LoadFromFileRuleMatch disallow .*;
   pagespeed LoadFromFileRuleMatch allow \.css$;
   pagespeed LoadFromFileRuleMatch allow \.jpe?g$;
   pagespeed LoadFromFileRuleMatch allow \.png$;
   pagespeed LoadFromFileRuleMatch allow \.js$;
   pagespeed LoadFromFileRuleMatch allow \.svg$;

   include _antihacker_.inc;

   #location ~ /hocnetclean(/.*) {
   #   proxy_cache_purge microcache $scheme$host$1$is_args$args;
   #}

   location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" {
      add_header "" "";
   }

   location ~ "^/ngx_pagespeed_static/" {
   }

   location ~ "^/ngx_pagespeed_beacon$" {
   }



   location ~* ^.+\.(flv)$ {
      expires 7d;
      flv;
      try_files \$uri \$uri/ @backend;
   }

   location ~* ^.+\.(3gp|wmv|avi|asf|asx|mpg|mpeg|mp4|pls|mp3|mid|wav|exe|zip|tar|rar|gz|tgz|bz2|uha|7z|doc|rtf|docx|xls|xlsx|pdf|iso)$ {
      expires 15m;
      try_files \$uri \$uri/ @backend;
   }
   location ~* ^.+\.(gif|jpg|jpeg|png|bmp|ico|swf)$ {
      expires 30d;
      try_files \$uri \$uri/ @backend;
   }
   location ~* ^.+\.(css)$ {
      expires 7d;
      try_files \$uri \$uri/ @backend;
   }
   location ~* ^.+\.(js)$ {
      expires 600s;
      try_files \$uri \$uri/ @backend;
   }
   location ~* ^.+\.(html|htm|txt|xml|rss)$ {
      expires 600s;
      try_files \$uri \$uri/ @backend;
   }

   location / {
      error_page 405 = @backend;
      include connection_limits.inc;
      proxy_pass http://${DOMAIN}_P;
      include cache.inc;
      include proxy.inc;
   }

   location @backend {
      internal;
      include connection_limits.inc;
      proxy_pass http://${DOMAIN}_P;
      include cache.inc;
      include proxy.inc;
   }
}
EOF
    done
}
#===============================================================================================================================
# Configuration file for varnish
#
# /etc/init.d/varnish expects the variable $DAEMON_OPTS to be set from this
# shell script fragment.
#
# !!!! DO NOT MAKE CHANGES TO THIS FILE !!!!

# Maximum number of open files (for ulimit -n)
NFILES=131072

# Locked shared memory (for ulimit -l)
# Default log size is 82MB + header
MEMLOCK=82000

# Maximum number of threads (for ulimit -u)
################ NPROCS="unlimited"

# Maximum size of corefile (for ulimit -c). Default in Fedora is 0
# DAEMON_COREFILE_LIMIT="unlimited"

# Set this to 1 to make init script reload try to switch vcl without restart.
# To make this work, you need to set the following variables
# explicit: VARNISH_VCL_CONF, VARNISH_ADMIN_LISTEN_ADDRESS,
# VARNISH_ADMIN_LISTEN_PORT, VARNISH_SECRET_FILE, or in short,
# use Alternative 3, Advanced configuration, below
RELOAD_VCL=1

# My Advanced configuration
# Main configuration file. You probably want to change it :)
VARNISH_VCL_CONF=/usr/local/varnish/etc/varnish/default.vcl

# Default address and port to bind to
# Blank address means all IPv4 and IPv6 interfaces, otherwise specify
# a host name, an IPv4 dotted quad, or an IPv6 address in brackets.
#VARNISH_LISTEN_ADDRESS=
VARNISH_LISTEN_PORT=8081

# Telnet admin interface listen address and port
VARNISH_ADMIN_LISTEN_ADDRESS=127.0.0.1
VARNISH_ADMIN_LISTEN_PORT=6082
#
# # Shared secret file for admin interface
VARNISH_SECRET_FILE=/etc/varnish/secret

# Cache file location
VARNISH_STORAGE_FILE=/usr/local/varnish/var/varnish/varnish_storage.bin

# Cache file size: in bytes, optionally using k / M / G / T suffix,
# or in percentage of available disk space using the &#37; suffix.
VARNISH_STORAGE_SIZE=1G

# Backend storage specification
#VARNISH_STORAGE="malloc,${VARNISH_STORAGE_SIZE}"
#VARNISH_STORAGE="file,${VARNISH_STORAGE_FILE},${VARNISH_STORAGE_SIZE}"
VARNISH_STORAGE="persistent,${VARNISH_STORAGE_FILE},${VARNISH_STORAGE_SIZE}"

# Default TTL used when the backend does not specify one
VARNISH_TTL=120

# Number of CPU cores
######## VARNISH_THREADS_POOLS=2

# The minimum number of worker threads to start
VARNISH_MIN_THREADS=50

# The Maximum number of worker threads to start
VARNISH_MAX_THREADS=1000

# Idle timeout for worker threads
VARNISH_THREAD_TIMEOUT=120

# Idle timeout for worker threads
######## VARNISH_THREAD_ADD_DELAY=2

# The Client Timeout
######## VARNISH_VARNISH_CLIENT_TIMEOUT=25

# lru_internval
#VARNISH_LRU_INTERVAL=20

# SESSION LINGER
#50/100/150
#120
######## VARNISH_SESSION_LINGER=50/100/150

# DAEMON_OPTS is used by the init script.  If you add or remove options, make
# sure you update this section, too.
DAEMON_OPTS="-a ${VARNISH_LISTEN_ADDRESS}:${VARNISH_LISTEN_PORT} \
             -f ${VARNISH_VCL_CONF} \
             -T ${VARNISH_ADMIN_LISTEN_ADDRESS}:${VARNISH_ADMIN_LISTEN_PORT} \
             -t ${VARNISH_TTL} \
             -w ${VARNISH_MIN_THREADS},${VARNISH_MAX_THREADS},${VARNISH_THREAD_TIMEOUT} \
             -u varnish -g varnish \
             -S ${VARNISH_SECRET_FILE} \
             -s ${VARNISH_STORAGE}"

#DAEMON_OPTS="-a ${VARNISH_LISTEN_ADDRESS}:${VARNISH_LISTEN_PORT} \
#             -f ${VARNISH_VCL_CONF} \
#             -T ${VARNISH_ADMIN_LISTEN_ADDRESS}:${VARNISH_ADMIN_LISTEN_PORT} \
#             -t ${VARNISH_TTL} \
#             -u varnish -g varnish \
#             -s ${VARNISH_STORAGE} \
#             -p http_req_hdr_len=10240 \
#             -p http_resp_hdr_len=65536 \
#             -p sess_workspace=262144 \
#             -p http_gzip_support=on \
#             -p thread_pool_min=${VARNISH_THREADS_MIN} \
#             -p thread_pool_max=${VARNISH_THREADS_MAX} \
#             -p thread_pools=${VARNISH_THREADS_POOLS} \
#             -p thread_pool_add_delay=${VARNISH_THREAD_ADD_DELAY} \
#             -p cli_timeout=${VARNISH_CLIENT_TIMEOUT} \
#             -p lru_interval=${VARNISH_LRU_INTERVAL} \
#             -p session_linger=${VARNISH_SESSION_LINGER}"

#===============================================================================================================================
#! /bin/sh
#
# varnish Control the Varnish Cache
#
# chkconfig: - 90 10
# description: Varnish is a high-perfomance HTTP accelerator
# processname: varnishd
# config: /etc/sysconfig/varnish
# pidfile: /var/run/varnishd.pid

### BEGIN INIT INFO
# Provides: varnish
# Required-Start: $network $local_fs $remote_fs
# Required-Stop: $network $local_fs $remote_fs
# Default-Start:
# Default-Stop:
# Should-Start: $syslog
# Short-Description: start and stop varnishd
# Description: Varnish is a high-perfomance HTTP accelerator
### END INIT INFO
ulimit -t unlimited &>/dev/null
ulimit -f unlimited &>/dev/null
ulimit -d unlimited &>/dev/null
ulimit -s unlimited &>/dev/null
ulimit -m unlimited &>/dev/null
ulimit -c unlimited &>/dev/null
ulimit -n unlimited &>/dev/null
ulimit -v unlimited &>/dev/null

# Source function library.
source "/etc/init.d/functions"

retval=0
pidfile=/usr/local/varnish/var/run/varnish.pid

exec="/usr/local/varnish/sbin/varnishd"
reload_exec="/usr/local/varnish/bin/varnish_reload_vcl"
prog="varnishd"
config="/etc/sysconfig/varnish"
lockfile="/var/lock/subsys/varnish"

# Include varnish defaults
[ -e /etc/sysconfig/varnish ] && source "/etc/sysconfig/varnish"

start() {

    if [ ! -x $exec ]; then
        echo $exec not found
        exit 5
    fi

    if [ ! -f $config ]; then
        echo $config not found
        exit 6
    fi
    echo -n "Starting Varnish Cache: "

    # Open files (usually 1024, which is way too small for varnish)
    ulimit -n ${NFILES:-131072}

    # Varnish wants to lock shared memory log in memory.
    ulimit -l ${MEMLOCK:-82000}

        # $DAEMON_OPTS is set in /etc/sysconfig/varnish. At least, one
        # has to set up a backend, or /tmp will be used, which is a bad idea.
    if [ "$DAEMON_OPTS" = "" ]; then
        echo '$DAEMON_OPTS empty.'
        echo -n "Please put configuration options in $config"
        return 6
    else
        # Varnish always gives output on STDOUT
        daemon --pidfile $pidfile $exec -P $pidfile "$DAEMON_OPTS" >/dev/null 2>&1
        retval=$?
        if [ $retval -eq 0 ]; then
            touch $lockfile
            echo_success
            echo
        else
            echo_failure
            echo
        fi
        return $retval
    fi
}

stop() {
    echo -n "Stopping Varnish Cache: "
    killproc -p $pidfile $prog
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
}

restart() {
    stop
    start
}

reload() {
    if [ "$RELOAD_VCL" = "1" ]; then
        $reload_exec
    else
        force_reload
    fi
}

force_reload() {
    restart
}

rh_status() {
    status -p $pidfile $prog
}

rh_status_q() {
    rh_status >/dev/null 2>&1
}

configtest() {
    if [ -f "$VARNISH_VCL_CONF" ]; then
        $exec -f "$VARNISH_VCL_CONF" -C -n /tmp >/dev/null  && echo "Syntax ok"
    else
        echo "VARNISH_VCL_CONF is  unset or does not point to a file"
    fi
}

# See how we were called.
case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart)
        $1
        ;;
    reload)
        rh_status_q || exit 7
        $1
        ;;
    force-reload)
        force_reload
        ;;
    status)
        rh_status
        ;;
    condrestart | try-restart)
        rh_status_q || exit 0
        restart
        ;;
    configtest)
        configtest
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload}"

        exit 2
        ;;
esac

exit $?

/usr/local/varnish/sbin/varnishd -f /usr/local/varnish/etc/varnish/default.vcl -s malloc,128M -T 127.0.0.1:2000  -a 0.0.0.0:8080 -d
   ${VARNISH}
   ${JONIX}
   pagespeed LoadFromFileRuleMatch disallow .*
   pagespeed LoadFromFileRuleMatch allow \.css$
   pagespeed LoadFromFileRuleMatch allow \.jpe?g$
   pagespeed LoadFromFileRuleMatch allow \.png$
   pagespeed LoadFromFileRuleMatch allow \.js$
   pagespeed LoadFromFileRuleMatch allow \.svg$
