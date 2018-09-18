#!/bin/bash

testparm

echo -n "use follow itadmin credential: "
cat /security/dc01/itadmin

echo
echo "---> kerberos init"
echo
kinit itadmin

# to enable debug add -d 10
echo
echo "---> join domain"
echo
net ads join -U itadmin

echo
echo "---> restarting samba services"
echo
restart_samba

touch /root/initialized

while true; do

	echo "listing user, groups..."
	wbinfo -ug

	if [ "$?" == "0" ]; then break; fi

	sleep 1

done

#service supervisor start
