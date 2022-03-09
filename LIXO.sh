#!/usr/bin/env bash
shopt -s nullglob

cd /var/cpanel/packages || exit
mv HL\ -\ Mega_jonix_testes HL_MEGA_TESTE
cd /var/cpanel/users || exit
replace "PLAN=HL - Mega_jonix_testes" "PLAN=HL_MEGA_TESTES" -- *
cd /var/cpanel/packages || exit
dir

find /home/prodigio/public_html/culturaonline.net/images/newsletter \( -name "*.html" \) -exec sed -i 's/<!--f1930e-->*f1930e-->//g' \{\} \;
sed ‘s/[echo "]*<iframe src=[\\]*.http:\/\/3bj.ru[^>]*>[\w]*<\/iframe>["]*//g’

mkdir /home/_src
cd /home/_src || exit
wget http://google-apps-wizard-cpanel-plugin.googlecode.com/files/gaw-2.0.tar
tar -xf gaw-2.0.tar
cd gaw-2.0 || exit
./gawinstall.sh
cd .. || exit
rm -Rfv gaw-2.0/ gaw-2.0.tar

mkdir /home/_src
cd /home/_src || exit
#CENTOS 5.X
wget http://fedora-epel.mirror.lstn.net/5/x86_64/epel-release-5-4.noarch.rpm
rpm -ivh epel-release-5-4.noarch.rpm
rm -f epel-release-5-4.noarch.rpm
#CENTOS 6.X
wget http://fedora-epel.mirror.lstn.net/6/x86_64/epel-release-6-7.noarch.rpm
rpm -ivh epel-release-6-7.noarch.rpm
#
wget http://savannah.nongnu.org/download/rdiff-backup/rdiff-backup-1.2.8.tar.gz
tar xzf rdiff-backup-1.2.8.tar.gz
cd rdiff-backup-1.2.8 || exit
python setup.py install --prefix=/usr/local
cd /home/_src || exit
rm -rf -- *

rsync --progress -rv -e "ssh -o Compression=no -l root -i /root/.ssh/b155" "195.8.59.101::b155s3/daily/pestanat.tar" "/backups/cpbackup/OLD/"

/scripts/pkgacct --allow-override --skiphomedir --nocompress --backup acsantos /backups/cpbackup/2feira
rsync --progress -avHlu /home/acsantos /backups/cpbackup/2feira/home
rdiff-backup -v5 --print-statistics /home/acsantos /backups/cpbackup/2feira/home/acsantos
rdiff-backup -r now /backups/cpbackup/2feira/home/acsantos /home/acsantos
rdiff-backup -v5 --print-statistics /home root@195.8.59.101::/mnt/vol_raid10/volraid10/linux/rufus1/home

rdiff-backup -r "2012-08-27" /backups/cpbackup/_home_backup/welovest/public_html /home/welovest/public_html

###############################
#LISTA AS DATAS DISPONIVEIS DOS BACKUPS DO CPANEL
ls -la --full-time /backups/cpbackup/ | grep -v "\.\." | grep -v "\.\/" | grep -v "_home_backup" | awk '{ print $6,"-",$9}' | sed 's/\(.*\)./\1/'
#
#LISTA AS DATAS DISPONIVEIS DO BACKUP
rdiff-backup -l /backups/cpbackup/_home_backup | awk '{if(NR>1)print}' | cut -f2 -d'.' | cut -f1 -d'T'
###############################

/usr/sbin/cpulimit -P /usr/local/bin/python -l 10 &
/usr/sbin/cpulimit -e ssh -l 30 &
rdiff-backup --exclude /home/.cpan --exclude /home/.cpanm --exclude /home/.cpcpan --exclude /home/.nginx --exclude /home/_src --exclude /home/cpeasyapache --exclude /home/cprestore --exclude /home/csf --exclude /home/installd -v5 --print-statistics /home root@195.8.59.101::/mnt/vol_raid10/volraid10/linux/rufus1/home
rdiff-backup --exclude /backups/cpbackup/diario/home -v5 --print-statistics /backups/cpbackup/diario root@195.8.59.101::/mnt/vol_raid10/volraid10/linux/rufus1/tar

for RUSERS in /var/cpanel/users/*; do
  /scripts/pkgacct --allow-override --skiphomedir --nocompress --backup "$RUSERS" /backups/cpbackup/diario
  rsync --progress -avHlu /home/"$RUSERS" /backups/cpbackup/diario/home/"$RUSERS"
done

/usr/local/cpanel/bin/register_hooks
