#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)

echo "--------------------------- GANTI PASSWORD  AKUN SSH ---------------------------"

	echo "            DEVELOPED BY YUSUF ARDIANSYAH n ELANG OVERDOSIS            "
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
	read -p "Isikan password baru akun [$username]: " password
	read -p "Konfirmasi password baru akun [$username]: " password1
	echo ""
	if [[ $password = $password1 ]]; then
		echo $username:$password | chpasswd
		echo "Penggantian password akun [$username] Sukses"
		echo ""
		echo "-----------------------------------"
		echo "Data Login:"
		echo "-----------------------------------"
		echo "Host/IP: $MYIP"
		echo "Dropbear Port: 443, 110, 109"
		echo "OpenSSH Port: 22, 143"
		echo "Squid Proxy: 80, 8080, 3128"
		echo "OpenVPN Config: http://$MYIP:81/client.ovpn"
		echo "Username: $username"
		echo "Password: $password"
		#echo "Valid s/d: $(date -d "$AKTIF days" +"%d-%m-%Y")"
		echo "-----------------------------------"
	else
		echo "Penggantian password akun [$username] Gagal"
		echo "[Password baru] & [Konfirmasi Password Baru] tidak cocok, silahkan ulangi lagi!"
	fi
else
	echo "Username [$username] belum terdaftar!"
	exit 1
fi


