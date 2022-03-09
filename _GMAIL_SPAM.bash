# NFS INSTALL CENTOS 6
# ==================================
# 195.8.59.121:/mnt/vol_raid10/volraid10/VPS/v1-103             /home/1backups          nfs     defaults 0 0
# ---
yum install nfs-utils nfs-utils-lib
service rpcbind start
chkconfig rpcbind on
mount /home/1backups
# TESTE:
touch /home/1backups/1.txt

hdparm -Tt --direct /dev/nvme0n1

ip route | while read p; do ip route change $p initcwnd 10 initrwnd 10; done
echo "noop" > /sys/block/vda/queue/scheduler
echo "noop" > /sys/block/vdb/queue/scheduler
echo "noop" > /sys/block/vdc/queue/scheduler
echo "noop" > /sys/block/vdd/queue/scheduler
echo "noop" > /sys/block/vde/queue/scheduler

echo "deadline" > /sys/block/vda/queue/scheduler
echo "deadline" > /sys/block/vdb/queue/scheduler
echo "deadline" > /sys/block/vdc/queue/scheduler
echo "deadline" > /sys/block/vdd/queue/scheduler
echo "deadline" > /sys/block/vde/queue/scheduler

echo "noop" > /sys/block/sda/queue/scheduler

Default: 1 | 1
echo "2" /sys/block/vda/queue/rq_affinity
echo "0"/sys/block/vda/queue/add_random
echo "2" /sys/block/vdb/queue/rq_affinity
echo "0"/sys/block/vdb/queue/add_random
echo "2" /sys/block/vdc/queue/rq_affinity
echo "0"/sys/block/vdc/queue/add_random

yum install mod_proctitle --enablerepo=cloudlinux-updates-testing
yum update lvemanager --enablerepo=cloudlinux-updates-testing
yum update lve-stats --enablerepo=cloudlinux-updates-testing

/usr/local/cpanel/bin/apache_conf_distiller --update
/usr/local/cpanel/bin/build_apache_conf

sed -r 's/latin1/utf8/g' dump.sql > dump_utf.sql
iconv -f ISO-8859-1 -t UTF-8 dump_utf.sql > dump_utf_fixed.sql

iconv -f ISO-8859-1 -t UTF-8 template_mais..html > template_mais.html

find . -type f -name '*.html' -exec bash -c 'iconv -f iso-8859-1 -t utf-8 "{}" > "{}"1; mv "{}"1 "{}"' \;
find . -type f -name '*.php' -exec bash -c 'iconv -f iso-8859-1 -t utf-8 "{}" > "{}"1; mv "{}"1 "{}"' \;

find . -type f -name '*.html' -exec bash -c 'iconv -f utf-8 -t iso-8859-1 "{}" > "{}"1; mv "{}"1 "{}"' \;
find . -type f -name '*.php' -exec bash -c 'iconv -f utf-8 -t iso-8859-1 "{}" > "{}"1; mv "{}"1 "{}"' \;

find . -type f -name 'ferias_familia.php' -exec bash -c 'iconv -f iso-8859-1 -t utf-8 "{}" > "{}"1; mv "{}"1 "{}"' \;

find . -type f -name 'ferias_familia.php' -exec bash -c 'iconv -f utf-8 -t iso-8859-1 "{}" > "{}"1; mv "{}"1 "{}"' \;

find . -type f -empty -delete
a1r9wix.00-

TOPAZ KEY
819171-170202-934328-386493-979638
