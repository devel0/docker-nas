#!/bin/bash

source /etc/environment

# nothing for others
umask 0007

host_ip=172.19.0.14

if [ ! -e /root/.initialized0 ]; then
	if [ -e /security/nas/root ]; then
		echo "set ssh service"
		sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

		echo "setup root pass"
		echo "root:`cat /security/nas/root`" | chpasswd
	fi

	rm -f /etc/samba/smb.conf
	echo "creating symlink /etc/samba/smb.conf"
        ln -s ../../dk/smb.conf /etc/samba

	echo "creating symlink /etc/init.d/samba"
	ln -s ../../dk/samba /etc/init.d

	echo "copying krb5.conf in /etc"
	cp -f /dk/krb5.conf /etc

	echo
	echo "---> setup /etc/hosts [BEFORE]"
	cat /etc/hosts
	echo "---> setup /etc/hosts [AFTER]"
	cat /etc/hosts | grep -v nas > /tmp/t ; cat /tmp/t > /etc/hosts
	echo "$host_ip nas.my.local nas" >> /etc/hosts
	cat /etc/hosts

	echo
	echo "---> bind [BEFORE]"
	netstat -tpln

	if [ ! -e /nas/my ]; then mkdir /nas/my; fi
	if [ ! -e /nas/my/HQ ]; then mkdir /nas/my/HQ; fi

	touch /root/.initialized0
fi

cp -f /dk/resolv.conf /etc
#touch /root/docker-fs

# start services
service rsyslog start
service cron start
if [ -e /root/initialized ]; then service supervisor start; fi
service ntp start
service ssh start

if [ -e /root/initialized ]; then
	echo "restarting samba"
	restart_samba
fi

echo
echo
echo "===> SERVER READY <==="
echo
echo "press ctrl+c to stop docker logs and return to shell"
echo
echo "- dk-exec nas to enter container"
echo "- /dk/first_setup.sh to initialize dc member"
echo "======================"
echo

for i in log.nmbd  log.smbd  log.wb-BUILTIN  log.wb-NAS  log.wb-MY  log.winbindd  log.winbindd-dc-connect  log.winbindd-idmap; do
	touch /var/log/samba/$i
done

tail -f /var/log/samba/*
