#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)

echo "-------------------------------- HAPUS AKUN SSH --------------------------------"

	echo "          DEVELOPED BY YUSUF ARDIANSYAH AND ELANG OVERDOSIS            "
echo ""

# begin of user-list
echo "-----------------------------------"
echo "USERNAME              EXP DATE     "
echo "-----------------------------------"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo "-----------------------------------"
echo ""
# end of user-list

read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p "Apakah Anda benar-benar ingin menghapus akun [$username] [y/n]: " -e -i y REMOVE
	if [[ "$REMOVE" = 'y' ]]; then
		passwd -l $username
		userdel $username
		echo ""
		echo "Akun [$username] berhasil dihapus!"
	else
		echo ""
		echo "Penghapusan akun [$username] dibatalkan!"
	fi
else
	echo "Username [$username] belum terdaftar!"
	exit 1
fi


