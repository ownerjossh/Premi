#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)


echo "---------------------------- MEMBUAT AKUN  PPTP VPN ----------------------------"

	echo "          DEVELOPED BY YUSUF ARDIANSYAH AND ELANG OVERDOSIS            "
echo ""

read -p "Isikan username baru: " username
read -p "Isikan password akun [$username]: " password

echo "$username pptpd $password *" >> /etc/ppp/chap-secrets

echo ""
echo "-----------------------------------"
echo "Data Login PPTP VPN:"
echo "-----------------------------------"
echo "Host/IP: $MYIP"
echo "Username: $username"
echo "Password: $password"
echo "-----------------------------------"
