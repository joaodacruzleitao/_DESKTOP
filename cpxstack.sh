#!/bin/bash

###########################################################################################################################################
#cpXstack is a cpanel plugin that incorporates the Nginx + PHP-FPM stack in Cpanel(TM) powered servers

#Copyright (C) 2012 PiServe Technologies Pvt Ltd ,INDIA . http://piserve.com

###########################################################################################################################################
http://web.archive.org/web/20100117060159/http://www.jonixworld.com/
https://www.google.pt/search?q=wordpress+best+free+themes+2014&biw=1024&bih=643&ei=1xynU-ILqavRBYnygIgN&start=0&sa=N#q=wordpress+best+free+themes+2014&start=20
EMAIL="cpxstack@sysally.net"
SOURCE_SERVER="sysally.net"
1m]*W_JLoJ]t
yum update -y;yum update lve-utils --enablerepo=cloudlinux-updates-testing -y;
cagefsctl --force-update
echo "">/usr/local/apache/logs/error_log
/scripts/_dccU.sh;/scripts/_dcc.sh;service exim restart;/scripts/restartsrv_httpd;
/scripts/upcp;service nginx restart;/scripts/restartsrv_httpd;
echo "">/usr/local/apache/logs/error_log
195.8.59.140
195.8.59.244
/usr/bin/clamscan -d /usr/local/maldetect/sigs/rfxn.ndb -d /usr/local/maldetect/sigs/rfxn.hdb
vendem-tudo-caro-65.1.
-sfnl4UgEFN4jdH8jGMo
FzBiuiOVz5LkPaXr01yN
./lUpdate.sh -f SMT_313.bin -i kcs -r y
xIbPPnzi--ZR
o6txWU--dg4K
239UhhE9PaUJgC
ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock

ftp
=============================
195.8.59.190
user: molonies
password: %wAk^bLVtJ6o

cpanel
=============================
http://195.8.59.190:2082
user: molonies
password: %wAk^bLVtJ6o

iozone -R -l 5 -u 5 -r 4k -s 100m -F /home/f1 /home/f2 /home/f3 /home/f4 /home/f5 | tee -a /tmp/iozone_results.txt &

iozone -R -l 10 -u 10 -r 4k -s 100m -F /home/f1 /home/f2 /home/f3 /home/f4 /home/f5 /home/f6 /home/f7 /home/f8 /home/f9 /home/f10 | tee -a /tmp/iozone_results.txt &


/scripts/_dccU.sh;/scripts/_dcc.sh nginx_u;/scripts/_dcc.sh nginx_c;/scripts/_dcc.sh nginx_vhosts;
Server address: 46.4.23.195:1
Password: Yy49Ge2wBDmbVv

https://community.centminmod.com/
http://openlitespeed.com/forums/openlitespeed-suggestions-and-requests.7/


10418
804 900 042
18.95

195.8.58.233
uninstall_cpxstack(){

lUpdate -f SMT_313.bin -i lan -h 195.8.59.244 -u ADMIN -p FzBiuiOVz5LkPaXr01yN -r y

rm -f /usr/local/cpanel/whostmgr/docroot/cgi/addon_cpXstack.php
/usr/local/cpanel/bin/unregister_cpanelplugin /usr/local/cpanel/base/frontend/default/cpxstack/cpxstack.cpanelplugin
rm -rf /usr/local/cpanel/base/frontend/default/cpxstack
yum -y remove nginx incron
rm -f /etc/yum.repos.d/nginx.repo
sed -i "s/apache_port.*/apache_port=0.0.0.0:80/" /var/cpanel/cpanel.config
sed -i '/#cpXstack#/,/#cpXstack#/d' /usr/local/apache/conf/includes/pre_main_global.conf
sed -i '/#cpXstack#/,/#cpXstack#/d' /var/spool/incron/root
sed -i '/#cpXstack#/,/#cpXstack#/d' /etc/csf/csf.pignore
sed -i '/#cpXstack#/,/#cpXstack#/d' /etc/sysctl.conf
/usr/local/cpanel/whostmgr/bin/whostmgr2 --updatetweaksettings > /dev/null
/scripts/rebuildhttpdconf
/scripts/restartsrv http
sed -i "s/9999/80/" /etc/chkserv.d/httpd
/usr/local/cpanel/libexec/tailwatchd --restart
for ver in `cat /opt/pifpm/pifpm.config |grep PHP|cut -d"," -f2`
                do
                        /etc/init.d/php-fpm-$ver stop
                        chkconfig php-fpm-$ver off
                        rm -f /etc/init.d/php-fpm-$ver
                done
for ver in `cat tmp/pi_fpm.$$/pifpm.config |grep UPSTREAM|cut -d"," -f2`
                do
                        /etc/init.d/php-fpm-$ver stop
                        chkconfig php-fpm-$ver off
                        rm -f /etc/init.d/php-fpm-$ver
                done

rm -f /etc/logrotate.d/php-fpm-*
rm -f /etc/cron.daily/cpxstack.cron
rm -rf /opt/pifpm

}




clean_exit(){
	rm -fr tmp/pi_fpm.$$
	exit 0
}



error_exit(){
	uninstall_cpxstack
	rm -rf tmp/pi_fpm.$$
	echo "Installation failed: contact $EMAIL "
	exit 1
}




detect_cpanel() {
	if [ -f /usr/local/cpanel/cpanel ];
	then	        
		 echo "cPanel detected" ;
	    	 CPANEL_VERSION=`cat /usr/local/cpanel/version | cut -d'.' -f1,2`
	    	 echo "CPanel Version is $CPANEL_VERSION"
	    	 TEST=`echo "$CPANEL_VERSION > 11.31" | bc`
	    	 echo $TEST 
	    	 if [ $TEST -eq 0 ]
	    	 then
			echo "You need atleast cPanel version 11.32 to run the script !!!"	
			error_exit
	    	 fi
	else
            	echo "cPanel control panel not detected"
	    	error_exit
	fi
}



detect_os(){
if [ -f /etc/redhat-release ]
then
	   OS_RELEASE=`cat /etc/redhat-release  | sed -ne 's/\(^.*release \)\(.*\)\(\..*$\)/\2/p'`
	   BASEARCH=`uname -i`
	   if grep 'CentOS\|CloudLinux' /etc/redhat-release  > /dev/null 2>&1
	   then 
		OS="centos"
	   elif grep 'Red Hat' /etc/redhat-release  > /dev/null 2>&1
	   then
		OS="rhel"
	   else
		echo "OS not Supported !!"
		error_exit			
	   fi
fi
}

check_php_cli(){
	if php-cli -i|grep disable_functions|grep system
	then
		echo " Please remove php system function from disable_functions in your php.ini and try again "
		error_exit
	fi
}



get_latest_configs(){
	if wget -O tmp/pi_fpm.$$/pifpm.config http://$SOURCE_SERVER/pifpm/pifpm.config && wget -O tmp/pi_fpm.$$/defaultconfs.tar.bz2 http://$SOURCE_SERVER/pifpm/defaultconfs.tar.bz2 && wget -O tmp/pi_fpm.$$/scripts.tar.bz2 http://$SOURCE_SERVER/pifpm/scripts.tar.bz2
	then
		echo " Download cpXstack files : OK"
	   
	else
	   echo "Installation failed. Unable to access $SOURCE_SERVER!!"
	   error_exit
	fi
}


get_latest_configs_softfail(){
        if wget -O tmp/pi_fpm.$$/pifpm.config http://$SOURCE_SERVER/pifpm/pifpm.config && wget -O tmp/pi_fpm.$$/defaultconfs.tar.bz2 http://$SOURCE_SERVER/pifpm/defaultconfs.tar.bz2 && wget -O tmp/pi_fpm.$$/scripts.tar.bz2 http://$SOURCE_SERVER/pifpm/scripts.tar.bz2
        then
                echo " Download cpXstack files : OK"

        else
           echo "upgrade failed. Unable to access $SOURCE_SERVER!!"
           clean_exit
        fi
}


install_nginx(){

	if  which nginx
	    then
	    echo "Found an existing NginX installation ..exiting ..."	
	    error_exit
	fi
# Adding Yum repo
	cat > /etc/yum.repos.d/nginx.repo << EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/$OS/$OS_RELEASE/\$basearch/
gpgcheck=0
enabled=1		
EOF
	
	if yum --disablerepo=* --enablerepo=nginx -y install nginx
	    then
	    echo -e "Nginx Install.... \tOK"
	    chkconfig nginx on
	    else
	    echo -e "Nginx install.... \tFailed"
	    error_exit
	fi
}


install_incron(){
		
        if  which incrond
            then
            echo "Found an existing incron installation ..exiting ..."
            error_exit
	else
		if [ ! -f /etc/yum.repos.d/epel.repo ];then
			OS_RELEASE=`cat /etc/redhat-release  | sed -ne 's/\(^.*release \)\(.*\)\(\..*$\)/\2/p'`
			if [ $OS_RELEASE -eq 6 ];then
				OSARCH=`uname -i`
				if [ $OSARCH = x86_64 ];then
					rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
				else
					rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
				fi
			else
				OSARCH=`uname -i`
				if [ $OSARCH = x86_64 ];then
					rpm -ivh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
				else
					rpm -ivh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
				fi
			fi
			sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/epel.repo
		fi
			
		if yum -y --enablerepo=epel install incron
		then
			echo -e "Incron Install.... \tOK"
			chkconfig incrond on
			/etc/init.d/incrond start
		else
			echo -e "Incron Install.... \tFailed"
			error_exit
		fi
	fi
}


install_phpfpm(){

	for PHPVERSION in `cat tmp/pi_fpm.$$/pifpm.config|grep UPSTREAM|cut -d"," -f2`
	do
		echo "Compiling PHP : $PHPVERSION"
		if wget -O tmp/pi_fpm.$$/php-$PHPVERSION.tar.bz2 http://www.php.net/distributions/php-$PHPVERSION.tar.bz2
                        then
                                tar -xvjf tmp/pi_fpm.$$/php-$PHPVERSION.tar.bz2 -C tmp/pi_fpm.$$
                                cd tmp/pi_fpm.$$/php-$PHPVERSION
				php_configure_args="`php-cli -i|grep configure |cut -d'>' -f2 | sed "s/'//g;s/prefix=\/usr\/local/prefix=\/opt\/pifpm\/php-$PHPVERSION/;s/--with-config-file-path=\/usr\/local\/lib//;s/--with-config-file-scan-dir=\/usr\/local\/lib\/php\.ini\.d//;s/=shared//g;s/--with-apxs2=\/usr\/local\/apache\/bin\/apxs//;s/--with-apxs=\/usr\/local\/apache\/bin\/apxs//"` --enable-fpm"
                                $php_configure_args && make && make install
				cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm-$PHPVERSION
				chmod a+x /etc/init.d/php-fpm-$PHPVERSION
				chkconfig php-fpm-$PHPVERSION on
				mkdir -p /var/log/php-fpm-$PHPVERSION
                                cd -
			else
                                echo "Failed to download $PHPVERSION from a mirror!!"
		fi
	done
}



upgrade_fpm_nginx(){

	yum -y upgrade nginx
	yum -y --enablerepo=epel upgrade incron
	count=`cat tmp/pi_fpm.$$/pifpm.config|grep UPSTREAM|wc -l`
	for ((n=1;n<=$count;n++))
		do
			PHPHERE[$n]=`grep PHP$n /opt/pifpm/pifpm.config|cut -d, -f2`
			PHPTHERE[$n]=`grep UPSTREAM$n tmp/pi_fpm.$$/pifpm.config|cut -d, -f2`
			echo "PHPHERE ${PHPHERE[$n]}"
			echo "PHPTHERE ${PHPTHERE[$n]}"
			if [ -z "${PHPHERE[$n]}" ]; then
				echo "The current cpXstack install doesnt have PHP$n enabled.The installer wont compile UPSTREAM$n"
				echo "You can override this behaviour by adding PHP$n,0.0.0 in /opt/pifpm/pifpm.config"
			else
				if [ ${PHPHERE[$n]} = ${PHPTHERE[$n]} ];then
					echo "PHP$n is uptodate"
				else
				                echo "Compiling PHP : ${PHPTHERE[$n]}"
				                if wget -O tmp/pi_fpm.$$/php-${PHPTHERE[$n]}.tar.bz2 http://www.php.net/distributions/php-${PHPTHERE[$n]}.tar.bz2
                        			then
                                			tar -xvjf tmp/pi_fpm.$$/php-${PHPTHERE[$n]}.tar.bz2 -C tmp/pi_fpm.$$
                                			cd tmp/pi_fpm.$$/php-${PHPTHERE[$n]}
							php_configure_args="`php-cli -i|grep configure |cut -d'>' -f2 | sed "s/'//g;s/prefix=\/usr\/local/prefix=\/opt\/pifpm\/php-${PHPTHERE[$n]}/;s/--with-config-file-path=\/usr\/local\/lib//;s/--with-config-file-scan-dir=\/usr\/local\/lib\/php\.ini\.d//;s/=shared//g;s/--with-apxs2=\/usr\/local\/apache\/bin\/apxs//;s/--with-apxs=\/usr\/local\/apache\/bin\/apxs//"` --enable-fpm"
                                			$php_configure_args && make && make install
                                			cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm-${PHPTHERE[$n]}
							chmod a+x /etc/init.d/php-fpm-${PHPTHERE[$n]}
							chkconfig php-fpm-${PHPTHERE[$n]} on 
							mkdir -p /var/log/php-fpm-${PHPTHERE[$n]}
                                			cd -
                        			else
                                			echo "Failed to download ${PHPTHERE[$n]} from a mirror!!"
                				fi
						if [ -d /opt/pifpm/php-${PHPTHERE[$n]} ];then
							sed -i "s/${PHPHERE[$n]}/${PHPTHERE[$n]}/g" /opt/pifpm/pifpm.config
							sed "s/PHPVERSION/${PHPTHERE[$n]}/g" /opt/pifpm/defaultconfs/php-fpm.logrotate.default > /etc/logrotate.d/php-fpm-$PHPVERSION

			                                cat /opt/pifpm/php-${PHPHERE[$n]}/lib/php.ini > /opt/pifpm/php-${PHPTHERE[$n]}/lib/php.ini
							mv /opt/pifpm/php-${PHPHERE[$n]}.pool.d /opt/pifpm/php-${PHPTHERE[$n]}.pool.d
                                        		sed "s/${PHPHERE[$n]}/${PHPTHERE[$n]}/g" /opt/pifpm/php-${PHPHERE[$n]}/etc/php-fpm.conf > /opt/pifpm/php-${PHPTHERE[$n]}/etc/php-fpm.conf
							/etc/init.d/php-fpm-${PHPHERE[$n]} stop
							chkconfig php-fpm-${PHPHERE[$n]} off
							rm -f /etc/init.d/php-fpm-${PHPHERE[$n]}
							rm -f /etc/logrotate.d/php-fpm-${PHPHERE[$n]}
                                        		rm -rf /opt/pifpm/php-${PHPHERE[$n]}

                        			else
	
                                			echo "PHP upgrade failed: contact $EMAIL " 
                        			fi
					fi
				fi
						
        done
	
}	
		
		
	

install_default_config(){
if tar -xvjf tmp/pi_fpm.$$/defaultconfs.tar.bz2 -C tmp/pi_fpm.$$ && tar -xvjf tmp/pi_fpm.$$/scripts.tar.bz2 -C tmp/pi_fpm.$$
	then
		mkdir /opt/pifpm
		sed "s/UPSTREAM/PHP/g" tmp/pi_fpm.$$/pifpm.config > /opt/pifpm/pifpm.config
		for PHPVERSION in `cat /opt/pifpm/pifpm.config|grep PHP|cut -d"," -f2`
		do
			if [ -d /opt/pifpm/php-$PHPVERSION ];then
				echo "Found PHP $PHPVERSION installed : Ok"
			else
				sed -i "/$PHPVERSION/d" /opt/pifpm/pifpm.config
			fi
		done
		/bin/cp -pvr tmp/pi_fpm.$$/defaultconfs /opt/pifpm/
		/bin/cp -pvr tmp/pi_fpm.$$/scripts	/opt/pifpm/
		wget -O /opt/pifpm/scripts/cpxstack.sh http://$SOURCE_SERVER/pifpm/cpxstack.sh
		wget -O /etc/cron.daily/cpxstack.cron http://$SOURCE_SERVER/pifpm/cpxstack.cron
		chmod a+x /opt/pifpm/scripts/cpxstack.sh
		chmod a+x /etc/cron.daily/cpxstack.cron
		#Install nginx config
		cat /opt/pifpm/defaultconfs/nginx.conf.default > /etc/nginx/nginx.conf
		cat /opt/pifpm/defaultconfs/fastcgi_params.default > /etc/nginx/fastcgi_params
		CPANELIP=`cat /etc/wwwacct.conf|grep ADDR|awk '{print $2}'`
		sed "s/CPANELIP/$CPANELIP/" /opt/pifpm/defaultconfs/nginx_default_site.conf > /etc/nginx/conf.d/default.conf
		mkdir /opt/pifpm/sites-enabled
		mkdir /opt/pifpm/sites-proxied
		mkdir /opt/pifpm/nginx.include.d
		mkdir /opt/pifpm/tmp
		chmod 777 /opt/pifpm/tmp
		mkdir /opt/pifpm/lock
		chmod 700 /opt/pifpm/lock
		#Install php-fpm config
		mkdir /opt/pifpm/fpmsockets
		mkdir /opt/pifpm/phpfpm.pool.d
		for PHPVERSION in `cat /opt/pifpm/pifpm.config|grep PHP|cut -d"," -f2`
		do
			sed "s/PHPVERSION/$PHPVERSION/g" /opt/pifpm/defaultconfs/php-fpm.conf.default > /opt/pifpm/php-$PHPVERSION/etc/php-fpm.conf
			sed "s/PHPVERSION/$PHPVERSION/g" /opt/pifpm/defaultconfs/php-fpm.logrotate.default > /etc/logrotate.d/php-fpm-$PHPVERSION
			cat /opt/pifpm/defaultconfs/php.ini.default > /opt/pifpm/php-$PHPVERSION/lib/php.ini
			mkdir /opt/pifpm/php-$PHPVERSION.pool.d
		done
		#Setup the cmdstream
		mkdir /opt/pifpm/userdata
		mkdir /opt/pifpm/cmdstream
		chmod 1777 /opt/pifpm/cmdstream
		#Adding incrons
		echo '#cpXstack#' >>/var/spool/incron/root
		echo '/var/cpanel/users IN_MODIFY,IN_CREATE,IN_DELETE /opt/pifpm/scripts/looper.sh $# $%' >>/var/spool/incron/root 
		echo '/opt/pifpm/cmdstream IN_CREATE /opt/pifpm/scripts/commandprocessor.sh $# $%' >> /var/spool/incron/root
		echo '/etc/ips IN_MODIFY /opt/pifpm/scripts/ip_add_trigger.sh' >> /var/spool/incron/root
		echo '#cpXstack#' >>/var/spool/incron/root
	else
		echo "Install of default configurations failed!!"
		error_exit
fi
}




generate_initial_config(){
cd /opt/pifpm/scripts
for CPANELUSER in `cat /etc/domainusers|cut -d: -f1`
do
./looper.sh $CPANELUSER
done
cd -
sed -i "s/apache_port.*/apache_port=0.0.0.0:9999/" /var/cpanel/cpanel.config
/usr/local/cpanel/whostmgr/bin/whostmgr2 --updatetweaksettings > /dev/null
/scripts/rebuildhttpdconf 
sed -i "s/80/9999/" /etc/chkserv.d/httpd
if [ -f /etc/csf/csf.conf ];then
	echo '#cpXstack#' >> /etc/csf/csf.pignore
	echo 'exe:/usr/sbin/nginx' >> /etc/csf/csf.pignore
	echo 'pexe:/opt/pifpm/php-.*/sbin/php-fpm' >> /etc/csf/csf.pignore
	echo '#cpXstack#' >> /etc/csf/csf.pignore
fi
/usr/local/cpanel/libexec/tailwatchd --restart
if [ -f /proc/cpuinfo ];then
	cpucount=`cat /proc/cpuinfo |grep processor|wc -l`
	if [ $cpucount -ge 1 ];then
		sed -i "s/^worker_processes.*$/worker_processes $cpucount;/" /etc/nginx/nginx.conf
	fi
fi
sysctl -w net.core.somaxconn=4096
echo '#cpXstack#' >> /etc/sysctl.conf
echo "net.core.somaxconn = 4096" >> /etc/sysctl.conf
echo '#cpXstack#' >> /etc/sysctl.conf
/scripts/restartsrv http
/etc/init.d/nginx restart

}

51bc837a-7e49-4d6d-abd4-5627a06de9bf


install_cpanel_module(){

if wget -O tmp/pi_fpm.$$/addon_cpXstack.php.tar.bz2 http://$SOURCE_SERVER/pifpm/addon_cpXstack.php.tar.bz2 && wget -O tmp/pi_fpm.$$/cpxstack.tar.bz2 http://$SOURCE_SERVER/pifpm/cpxstack.tar.bz2
then
	tar -xvjf tmp/pi_fpm.$$/addon_cpXstack.php.tar.bz2 -C /usr/local/cpanel/whostmgr/docroot/cgi/
	chmod a+x /usr/local/cpanel/whostmgr/docroot/cgi/addon_cpXstack.php
	tar -xvjf tmp/pi_fpm.$$/cpxstack.tar.bz2 -C /usr/local/cpanel/base/frontend/default/
	/usr/local/cpanel/bin/register_cpanelplugin /usr/local/cpanel/base/frontend/default/cpxstack/cpxstack.cpanelplugin
	/usr/local/cpanel/bin/rebuild_sprites > /dev/null
	echo "cpXstack plugin install : OK"
fi
}
dh]XFX1,+4vH
?uC@eXU%wn4g
mysql -> pNTiI6xZU#]a
3K^fa0*1gK,U
m32rn-.k3jr2h
askimet929
O*Q.UFvb#r]M
/home/ffitness/public_html/loja/libraries/joomla/application/cli/daemon.php
/home/fjstorre/public_html/moodle/mod/chat/chatd.php
e38ea7df-1043-4944-9a6e-9bf6a139342a
OaQIZ--F7oIJ

/usr/sbin/clnreg_ks --force
cldetect --update-license;yum update -y;yum update cagefs lvemanager lve-stats lve-utils --enablerepo=cloudlinux-updates-testing;

install_modrpaf(){

if wget -O tmp/pi_fpm.$$/mod_rpaf-0.6.tar.gz http://www.stderr.net/apache/rpaf/download/mod_rpaf-0.6.tar.gz
then
	tar -xvzf tmp/pi_fpm.$$/mod_rpaf-0.6.tar.gz -C tmp/pi_fpm.$$/
	if /usr/local/apache/bin/httpd -v|grep 'Apache/2'
	then
		cd tmp/pi_fpm.$$/mod_rpaf-0.6
		/usr/local/apache/bin/apxs -i -c -n mod_rpaf-2.0.so mod_rpaf-2.0.c
		cd -
		cat >> /usr/local/apache/conf/includes/pre_main_global.conf << EOF

#cpXstack#
LoadModule rpaf_module modules/mod_rpaf-2.0.so
<IfModule mod_rpaf-2.0.c>
RPAFenable On
RPAFsethostname On
RPAFproxy_ips
RPAFheader X-Forwarded-For
</IfModule>
#cpXstack#
EOF
		for IPADDR in `ifconfig  | grep 'inet addr:'| cut -d: -f2 | awk '{ print $1}'`
		do
			sed -i "s/RPAFproxy_ips/RPAFproxy_ips $IPADDR/" /usr/local/apache/conf/includes/pre_main_global.conf
		done
	else
		cd tmp/pi_fpm.$$/mod_rpaf-0.6
                /usr/local/apache/bin/apxs -i -a -c mod_rpaf.c
		cd -
                cat >> /usr/local/apache/conf/includes/pre_main_global.conf << EOF

#cpXstack#
LoadModule rpaf_module modules/mod_rpaf.so
<IfModule mod_rpaf.c>
RPAFenable On
RPAFsethostname On
RPAFproxy_ips 
RPAFheader X-Forwarded-For
</IfModule>
#cpXstack#
EOF
                for IPADDR in `ifconfig  | grep 'inet addr:'| cut -d: -f2 | awk '{ print $1}'`
                do
                        sed -i "s/RPAFproxy_ips/RPAFproxy_ips $IPADDR/" /usr/local/apache/conf/includes/pre_main_global.conf
                done 
	fi
else
	echo "Install mod_rpaf : FAIL"
	error_exit
fi
}
	

restart_fpm_all() {
		/opt/pifpm/scripts/config_php.sh
                for ver in `cat /opt/pifpm/pifpm.config |grep PHP|cut -d"," -f2`
                do
                        /etc/init.d/php-fpm-$ver restart
                done
        }







#Main 

if [ $# -ne 1 ]
then
        echo "usage $0 COMMAND"
	echo "COMMAND:"
	echo " install - Install cpXstack"
	echo " upgrade - Upgrade cpXstack "
	echo " uninstall - Uninstall cpXstack"
	echo " help - Usage Instructions for this script"
        exit 1
else
	case "$1" in
	install)
		echo "The script expects incron and nginx rpms are not installed in your system!"
		echo "An expert admin intervention is required if you have an existing install of the above software"
		echo "to preserve your existing config/data"
		sleep 5
		mkdir -p tmp/pi_fpm.$$
		mkdir /opt/pifpm
		detect_cpanel
		detect_os
		check_php_cli
		get_latest_configs
		install_nginx
		install_incron
		install_phpfpm
		install_default_config
		generate_initial_config
		install_modrpaf
		restart_fpm_all
		install_cpanel_module
		clean_exit
		;;
	upgrade)
		if [ -f /opt/pifpm/pifpm.config ];then
			mkdir -p tmp/pi_fpm.$$
			get_latest_configs_softfail
			VERTHERE=`cat tmp/pi_fpm.$$/pifpm.config|grep RELEASE|cut -d"," -f2`
			VERHERE=`cat /opt/pifpm/pifpm.config|grep RELEASE|cut -d"," -f2`
			if [ $VERHERE -ne $VERTHERE ];then
				wget -O /opt/pifpm/scripts/cpxstack.sh http://$SOURCE_SERVER/pifpm/cpxstack.sh 
				chmod a+x /opt/pifpm/scripts/cpxstack.sh
				mkdir /opt/pifpm/lock
				wget -O /opt/pifpm/scripts/looper.sh http://$SOURCE_SERVER/pifpm/looper.sh.2013060901
				sed -i "s/$VERHERE/$VERTHERE/" /opt/pifpm/pifpm.config
				/opt/pifpm/scripts/cpxstack.sh upgrade 
			else
				upgrade_fpm_nginx
				restart_fpm_all
				/etc/init.d/nginx restart
				clean_exit
			fi
		else
			echo 'cpXstack not detected;install cpXstack first'
		fi
		;;
	uninstall)
		uninstall_cpxstack
		;;
	help)
		echo "usage $0 COMMAND"
        	echo "COMMAND:"
        	echo " install - Install cpXstack"
        	echo " upgrade - Upgrade cpXstack"
        	echo " uninstall - Uninstall cpXstack"
        	echo " help - Usage Instructions for this script"
		exit 0
		;;
	*)
		echo "Unknown COMMAND"
		echo "run $0 help"
		exit 1
		;;
	esac	
fi
