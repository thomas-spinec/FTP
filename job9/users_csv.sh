#!/bin/bash
cd /home/thomas/Documents/La_plateforme/git/FTP/job9

###############################################################
#création du groupe des admins qui leur permettra de ne pas être bloqué dans leur home contrairement aux utilisateurs normaux

sudo groupadd ftpadmin
sudo chmod 770 ftpadmin
###############################################################
cat users.csv | while read varligne
do
	password=`echo $varligne |cut -d ',' -f4`
	ftpuser=`echo $varligne |cut -d ',' -f2`
	ftpuser=`echo ${ftpuser,,}`
	role=`echo $varligne |cut -d ',' -f5`
	echo $role
	if [ $role = "Admin" ]
	then
		#création user
		echo "creation de l'utilisateur : $ftpuser"
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		sudo useradd -m -p "$pass" "$ftpuser"
		#changement de rôle
		echo "changement du role de : $ftpuser"
		sudo usermod -aG sudo $ftpuser
		#changement de groupe
		echo "changement de groupe"
		sudo adduser $ftpuser ftpadmin
	else 
		echo "creation de l'utilisateur : $ftpuser"
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
    		sudo useradd -m -p "$pass" "$ftpuser"
	fi
done < <(tail -n +2 users.csv)

