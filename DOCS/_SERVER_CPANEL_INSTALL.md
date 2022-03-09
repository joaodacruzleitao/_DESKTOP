## INSTALL CPANEL
1. PUTTY -> `mkdir -p /home/_src; cd /home/_src; wget http://layer2.cpanel.net/latest`
2. PUTTY -> `sh latest`
3. CPANEL -> Plugins -> Clamav Connector
4. WINSCP ->
```
yum install cagefs -y; /usr/sbin/cagefsctl --init;
cagefsctl --enable-all;
```
5. CPANEL -> "Change Root Password"
6. WINSCP -> Mudar a password
7. PASS -> Adicionar ao password portables a nova pass
8. WINSCP -> copiar D:\Armazem\Docs\HOCNET\_SERVIDORES_\_LINUX_\Varios\_SERVIDORES\_VPS_\_var_cpanel PARA /var/cpanel/
9. WINSCP -> copiar D:\Armazem\Docs\HOCNET\_SERVIDORES_\_LINUX_\Varios\_SERVIDORES\_VPS_\_etc\VPS----etc PARA /etc
10. WINSCP -> rebootar
11. CPANEL -> configurar "Basic cPanel & WHM Setup"
12. CPANEL -> verificar "Server Time"
13. CPANEL -> Tweak Settings -> Ligar "Enable optimizations for the C compiler"
14. CPANEL -> Editar "Update Preferences"
15. CPANEL -> "Configure Customer Contact"
16. CPANEL -> "Apache mod_userdir Tweak"
17. CPANEL -> "Compiler Access"
18. CPANEL -> "Configure Security Policies" -> "Password Strength Configuration"
19. CPANEL -> "PHP open_basedir Tweak"
20. CPANEL -> "Contact Manager"
21. CPANEL -> "Edit System Mail Preferences"
22. CPANEL -> "Apache Configuration" -> "Memory Usage Restrictions"
23. CPANEL -> "Apache Configuration" -> "Log Rotation"
24. CPANEL -> "Apache Configuration" -> "Piped Log Configuration"
25. CPANEL -> SERVIDOR VPS -> "Apache Configuration" -> "Global Configuration" -> 5, 5, 10, 256, 150, 1000, On, 2, 100, 5
26. CPANEL -> SERVIDOR NORMAL -> "Apache Configuration" -> "Global Configuration" -> 2, 20, 20, 2048, 2000, 1000, On, 2, 100, 5
27. CPANEL -> "cPanel Log Rotation Configuration"
28. CPANEL -> "Exim Configuration Manager"
29. CPANEL -> "FTP Server Configuration"
30. CPANEL -> "Mailserver Configuration"
31. CPANEL -> "Service Manager"
32. CPANEL -> "Remote Access Key"
33. PUTTY ->
```
wget -O /scripts/_dcc.config.sh --no-check-certificate https://dcc.hocnet.pt/_dcc/_dcc.config.sh;
wget -O /scripts/_dccU.sh --no-check-certificate https://dcc.hocnet.pt/_dcc/_dccU.sh;
```
33. PUTTY ->
```
chmod 400 /scripts/_dcc.config.sh;
chmod 700 /scripts/_dccU.sh; /scripts/_dccU.sh; /scripts/_dcc.sh;
```
34. PUTTY -> `d-; d- seg_maldet_i;`
35. PUTTY -> VERIFICAR O liblua.so
36. PUTTY -> `d- cloud_mg; cagefsctl --force-update;`
37. WINSCP -> copiar D:\Armazem\Docs\HOCNET\_SERVIDORES_\_LINUX_\Varios\_SERVIDORES\_VPS_\_etc\VPS----MARIADB--my.cnf PARA /etc
38. CPANEL -> Service Manager -> Ligar MYSQL
39. CPANEL -> EasyApache (Apache Update) -> Upload do Perfil de C:\Users\jonix\Downloads\2\CL_Apache_2410_EVENT___PHP_5436_FastCGI_eAccelerator.yaml
40. CPANEL -> EasyApache (Apache Update) -> BUILD "  CLoudLinux - Apache 2.4.10 EVENT + PHP 5.4.36 FastCGI eAccelerator"
41. WINSCP -> copiar D:\Armazem\Docs\HOCNET\_SERVIDORES_\_LINUX_\Varios\_SERVIDORES\_VPS_\_usr_local_lib PARA /usr/local/lib
42. PUTTY -> cagefsctl --force-update
43. PUTTY -> `d- seg_clamav_c`
CPANEL -> ModSecurity™ Configuration -> Only, Process, Process, Enabled, Geolocation Database : /usr/local/apache/conf/modsec_rules/GeoLiteCity.dat
44. CPANEL -> ModSecurity™ Configuration -> Project Honey Pot Http:BL API Key : wpkzioijpaym, 15000000, 15000000
45. CPANEL -> ModSecurity™ Vendors -> Add vendor -> https://waf.comodo.com/doc/meta_comodo_apache.yaml
46. PUTTY -> `d- sis_mq; d- sis_mm; d- sis_msm;`
47. CPANEL -> ModSecurity™ Tools -> Rules List -> Edit Rules :
```
#SecRequestBodyAccess On
#SecResponseBodyAccess On
SecResponseBodyLimit 546870851
SecRequestBodyLimit 2048576000
SecRequestBodyNoFilesLimit 2048576000
SecRequestBodyLimitAction ProcessPartial
SecResponseBodyLimitAction ProcessPartial
```
```
# ConfigServer ModSecurity whitelist file
## CENTOS 7 abre isto:
Include /etc/apache2/conf.d/modsec2.whitelist.conf
Include /usr/local/apache/conf/modsec2.whitelist.conf
#
# (800) Test for Virus/Malware
SecRequestBodyAccess On
SecRule FILES_TMPNAMES "@inspectFile /usr/local/maldetect/modsec.lua" \
  "phase:2,\
  id:'800',\
  t:none,\
  log,\
  auditlog,\
  deny,\
  msg:'COMODO WAF: VIRUS or MALWARE content was found in uploaded file'"
#
SecTmpDir /tmp
SecTmpSaveUploadedFiles On
#SecUploadKeepFiles On
SecHttpBlKey "wpkzioijpaym"
# (801) Test for Project HoneyPOT
SecRule TX:REAL_IP|REMOTE_ADDR "@rbl dnsbl.httpbl.org" \
  "id:'801',\
  chain,\
  phase:1,\
  t:none,\
  capture,\
  block,\
  msg:'COMODO WAF: HoneyPOT Project Match of Client IP',\
  logdata:'%{tx.httpbl_msg}',\
  setvar:tx.httpbl_msg=%{tx.0},\
  setvar:tx.ip_atacante=%{REMOTE_ADDR},\
  redirect:https://www.projecthoneypot.org/ip_%{tx.ip_atacante}"
  SecRule TX:0 "threat score (\d+)" \
    "chain,capture"
    SecRule TX:1 "@gt 20"
#
#(802) Jooma Exploit com_jce
#index.php?option=com_jce&task=plugin&plugin=imgmanager&file=imgmanager&method=form&cid=20&...
SecRule REQUEST_LINE "@contains index.php" "chain,phase:1,log,deny,id:802,t:none,t:urlDecodeUni,t:htmlEntityDecode,t:normalisePathWin,msg:'COMODO WAF: Joomla Exploits - com_jce attack'"
SecRule REQUEST_LINE "@contains POST " "chain"
SecRule REQUEST_LINE "@contains com_jce" "chain"
SecRule REQUEST_LINE "@contains task" "chain"
SecRule REQUEST_LINE "@contains plugin" "chain"
SecRule REQUEST_LINE "@contains imgmanager"
#
#(803) Jooma Exploit com_jce 2
# index.php?option=com_jce&task=plugin&plugin=imgmanager&file=imgmanager&method=form&cid=20&...
SecRule REQUEST_LINE "@contains index.php" "chain,phase:1,log,deny,id:803,t:none,t:urlDecodeUni,t:htmlEntityDecode,t:normalisePathWin,msg:'COMODO WAF: Joomla Exploits - com_jce attack 2'"
SecRule REQUEST_LINE "@contains POST " "chain"
SecRule REQUEST_LINE "@contains com__jce" "chain"
SecRule REQUEST_LINE "@contains task" "chain"
SecRule REQUEST_LINE "@contains plugin" "chain"
SecRule REQUEST_LINE "@contains imgmanager"
#
# (804) dvmessages attack
# dvmessages.php
SecRule REQUEST_LINE "@contains dvmessages.php" "phase:1,log,deny,id:804,t:none,t:urlDecodeUni,t:htmlEntityDecode,t:normalisePathWin,msg:'COMODO WAF: Joomla Exploits - com_jce attack'"
#
# (805) plugin_googlemap2_proxy attack
# plugin_googlemap2_proxy.php
# exemplo: 	http://quintadabarroca.com.pt/plugins/system/plugin_googlemap2_proxy.php?url=landof.tv
SecRule REQUEST_LINE "@contains plugin_googlemap2_proxy.php" "phase:1,log,deny,id:805,msg:'COMODO WAF: Joomla Exploits - plugin_googlemap2_proxy.php POST attack',t:none,t:urlDecodeUni,t:htmlEntityDecode,t:normalisePathWin"
```
49. PUTTY -> `d- nginx_i;`
50. PUTTY -> (instala o CSF e Muda a porta do SSH) -> d- sis_csf;
51. WINSCP -> desliga do WINSCP e muda na configuração do ssh para porta 2726 e torna a ligar
52. CPANEL -> "Background Process Killer"
53. CPANEL -> "FTP Server Configuration" -> desligar o anonymous
54. PUTTY -> Fazer este comandos todos:
```
echo '#!/bin/sh' > /etc/pureftpd-antivirus.sh;
echo '/usr/bin/clamdscan --remove --quiet --no-summary $1' >> /etc/pureftpd-antivirus.sh;
echo 'exit 0;' >> /etc/pureftpd-antivirus.sh;
chmod 755 /etc/pureftpd-antivirus.sh;
killall -9 pure-uploadscript;
/usr/sbin/pure-uploadscript -B -r /etc/pureftpd-antivirus.sh;
service pure-ftpd restart;
```
55. PUTTY -> `cagefsctl --force-update`
56. PUTTY -> `yum install lvemanager -y; yum groupinstall alt-php -y;`
57. CPANEL -> "CloudLinux LVE Manager"
58. WINSCP -> copiar D:\Armazem\Docs\HOCNET\_SERVIDORES_\_LINUX_\Varios\_CloudLinux_PHP_SELECTOR
59. WINSCP -> copiar D:\Armazem\Docs\HOCNET\_SERVIDORES_\_LINUX_\Varios\_SERVIDORES\_VPS_\_usr_local_apache_conf\pre_virtualhost_global.conf PARA /usr/local/apache/conf/includes
60. PUTTY -> `yum install liblsapi liblsapi-devel cpanel-mod-lsapi -y;`
61. PUTTY -> `/usr/bin/switch_mod_lsapi --setup;/usr/bin/switch_mod_lsapi --enable-global;`
62. PUTTY -> `d- nginx_cflare`
63. PUTTY -> `cagefsctl --force-update; service httpd restart;`
64. PUTTY -> `d- sis_ac; d- cp_hooks_o;`
65. PUTTY -> `cagefsctl --force-update; service httpd restart; d- sis_ac;`
