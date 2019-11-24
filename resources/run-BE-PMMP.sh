#!/bin/sh

echo "Starting PMMP..." >&1

sh /minecraft/resources/setPerm.sh
sh /minecraft/resources/blockTCP.sh

sleep 1
PHARFILE="/minecraft/server/pmmp.phar"

if [ -e "/minecraft/bin/nonftp" ]; then
	rm -rf /minecraft/server/pmmp.phar
	cp /minecraft/resources/pmmp_*.phar /minecraft/server/pmmp.phar
	sh /minecraft/resources/pluginSync.sh
else
	echo "PMMP plugins are not synced..." >&1
fi
	
if [ -e ${PHARFILE} ]; then
	echo "Phar founded!" >&1
	RESULT=$(/minecraft/bin/bin/php7/bin/php /minecraft/resources/pharvalid.php PHARFILE)
	echo ${RESULT}
	if  [ "`echo ${RESULT} | grep hash`" ]; then
		echo "Phar is valid!" >&1
	else
		echo "Phar must be broken." >&2
		exit 1
	fi
elif [ -e ${PHARFILE}  ]; then
	echo "Phar founded!" >&1
else
	echo "Phar not found." >&2
	ls /minecraft/server
	exit 1
fi

rm -rf /minecraft/server/resource_packs
su -l ${SRVID} -c "cd /minecraft/server ; /minecraft/bin/bin/php7/bin/php \\
	-n \\
	-d \"open_basedir=/tmp:phar://:/minecraft/server\" \\
	-d \"disable_functions=_getppid,allow_url_fopen,allow_url_include,apache_child_terminate,apache_setenv,chgrp,chmod,chown,curl_exec,curl_multi_exec,define_syslog_variables,diskfreespace,dl,escapeshellarg,escapeshellcmd,eval,fp,fpaththru,fput,fsockopen,ftp_connect,ftp_exec,ftp_get,ftp_login,ftp_nb_fput,ftp_put,ftp_raw,ftp_rawlist,highlight_file,ignore_user_abord,inject_code,lchgrp,lchown,leak,link,listen,mail,mb_send_mail,mysql_pconnect,openlog,passthru,pcntl_exec,phpAds_XmlRpc,phpAds_remoteInfo,phpAds_xmlrpcDecode,phpAds_xmlrpcEncode,phpinfo,popen,posix,posix_ctermid,posix_getcwd,posix_getegid,posix_geteuid,posix_getgid,posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid,posix_getpwnam,posix_getpwuid,posix_getrlimit,posix_getsid,posix_getuid,posix_isatty,posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid,posix_setpgid,posix_setsid,posix_setuid,posix_times,posix_ttyname,posix_uname,proc_close,proc_get_status,proc_nice,proc_open,proc_terminate,putenv,show_source,source,syslog,system,tmpfile,virtual,xmlrpc_entity_decode,mysqli,mysqli_stmt,mysqli_result,mysqli_driver\" \\
	-d \"memory_limit=3G\" \\
	-d \"allow_url_fopen=0\" \\
	-d \"allow_url_include=0\" \\
	-d \"date.timezone=\"Asia/Tokyo\"\" \\
	-d \"phar.readonly=0\" \\
	-d \"phar.require_hash=1\" \\
	-d \"display_errors=1\" \\
	-d \"display_startup_errors=1\" \\
	-d \"default_charset=utf-8\" \\
	-d \"zend.assertions=-1\" \\
	-d \"display_startup_error=1\" \\
	-d \"default_charset=utf-8\" \\
	-d \"assert.exception=1\" \\
	-d \"error_reporting=0\" \\
	\"${PHARFILE}\" "
rm -rf /minecraft/server/resource_packs
